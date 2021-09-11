ESX = nil
local vehicles = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Citizen.CreateThread(function()
    Wait(1000)
    vehicles = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM vehicles', {})
    for k,v in pairs(Config.Customs) do
        MysqlGarage(Config.Mysql,'execute','INSERT IGNORE  INTO renzu_customs (shop) VALUES (@shop)', {
            ['@shop']   = k,
        })
    end
end)

function MysqlGarage(plugin,type,query,var)
    if type == 'fetchAll' and plugin == 'mysql-async' then
        local result = MySQL.Sync.fetchAll(query, var)
        return result
    end
    if type == 'execute' and plugin == 'mysql-async' then
        MySQL.Sync.execute(query,var) 
    end
    if type == 'execute' and plugin == 'ghmattisql' then
        exports['ghmattimysql']:execute(query, var)
    end
    if type == 'fetchAll' and plugin == 'ghmattisql' then
        local data = nil
        exports.ghmattimysql:execute(query, var, function(result)
            data = result
        end)
        while data == nil do Wait(0) end
        return data
    end
end

ESX.RegisterServerCallback('renzu_customs:getinventory', function (source, cb, id, share)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    if share then
        identifier = share.owner
    end
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT inventory FROM renzu_customs WHERE shop = @shop', {
        ['@shop'] = id
    })
    local inventory = false
    if json.decode(result[1].inventory) then
        inventory = json.decode(result[1].inventory)
    end
    cb(inventory)
end)

ESX.RegisterServerCallback('renzu_customs:itemavailable', function (source, cb, id, item, share)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    if share then
        identifier = share.owner
    end
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT inventory FROM renzu_customs WHERE shop = @shop', {
        ['@shop'] = id
    })
    local inventory = false
    if json.decode(result[1].inventory) then
        inventory = json.decode(result[1].inventory)
        if inventory[item] ~= nil and inventory[item] > 0 then
            inventory[item] = inventory[item] - 1
            MysqlGarage(Config.Mysql,'execute','UPDATE renzu_customs SET inventory = @inventory WHERE shop = @shop', {
                ['@inventory'] = json.encode(inventory),
                ['@shop'] = id,
            })
            cb(true)
        else
            cb(false)
        end
    else
        cb(false)
    end
end)

RegisterServerEvent('renzu_customs:storemod')
AddEventHandler('renzu_customs:storemod', function(id,mod,lvl,newprop,share,save,savepartsonly)
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    if share then
        identifier = share.owner
    end
    local success = true
    local vehicles = nil
    local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT inventory FROM renzu_customs WHERE shop = @shop', {
        ['@shop'] = id
    })
    local inventory = json.decode(result[1].inventory)
    if not save then
        local modname = mod.name..'-'..lvl
        if inventory[modname] == nil then
            inventory[modname] = 1
        else
            inventory[modname] = inventory[modname] + 1
        end
    end
    MysqlGarage(Config.Mysql,'execute','UPDATE renzu_customs SET inventory = @inventory WHERE shop = @shop', {
        ['@inventory'] = json.encode(inventory),
        ['@shop'] = id,
    })
    TriggerClientEvent('renzu_notify:Notify', src, 'success','Garage', 'You Successfully store the parts ('..mod.name..')')
end)

local default_routing = {}
local current_routing = {}

function Jobmoney(job)
    local value = -1
    local job = job
    local count = 0
    CreateThread(function()
        value = exports.renzu_jobs:JobMoney(job).money
    end)
    while value == -1 and count < 150 do count = count + 1 Wait(0) end
    return value
end

ESX.RegisterServerCallback('renzu_customs:pay', function (source, cb, t,shop)
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local identifier = xPlayer.identifier
    local prop = t.prop
    local cost = t.cost
    local jobmoney = 0
    if not Config.JobPermissionAll and xPlayer.getMoney() >= t.cost or Config.JobPermissionAll and Config.Customs[shop].job == xPlayer.job.name and Jobmoney(xPlayer.job.name) >= t.cost then
        local result = MysqlGarage(Config.Mysql,'fetchAll','SELECT * FROM owned_vehicles WHERE UPPER(plate) = @plate', {
            ['@plate'] = prop.plate:upper()
        })
        if result[1] then
            MysqlGarage(Config.Mysql,'execute','UPDATE owned_vehicles SET `vehicle` = @vehicle WHERE UPPER(plate) = @plate', {
                ['@vehicle'] = json.encode(prop),
                ['@plate'] = prop.plate:upper()
            })
            xPlayer.removeMoney(cost)
            TriggerClientEvent('renzu_notify:Notify', src, 'success','Customs', 'Payment Success - Upgrade has been Installed')
            if Config.UseRenzu_jobs and not Config.JobPermissionAll then
                addmoney = exports.renzu_jobs:addMoney(tonumber(t.cost),Config.Customs[shop].job,source,'money',true)
            elseif Config.UseRenzu_jobs and Config.JobPermissionAll and Config.Customs[shop].job == xPlayer.job.name then
                removemoney = exports.renzu_jobs:removeMoney(tonumber(t.cost),Config.Customs[shop].job,source,'money',true)
            end
            cb(true)
        else
            TriggerClientEvent('renzu_notify:Notify', src, 'error','Customs', 'Vehicle is not Owned')
            cb(false)
        end
    else
        TriggerClientEvent('renzu_notify:Notify', src, 'error','Customs', 'Not Enough Money Cabron')
        cb(false)
    end
end)

ESX.RegisterServerCallback('renzu_customs:repair', function (source, cb, shop)
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    local jobmoney = 0
    if xPlayer.getMoney() >= Config.RepairCost then
        if Config.UseRenzu_jobs and Config.Customs[shop].job ~= xPlayer.job.name then -- job permission access is free repair
            addmoney = exports.renzu_jobs:addMoney(tonumber(Config.RepairCost),Config.Customs[shop].job,source,'money',true)
        end
        if Config.Customs[shop].job ~= xPlayer.job.name then
            xPlayer.removeMoney(Config.RepairCost)
        end
        cb(true)
    else
        cb(false)
    end
end)

ESX.RegisterServerCallback('renzu_customs:getmoney', function (source, cb, t)
    local src = source  
    local xPlayer = ESX.GetPlayerFromId(src)
    cb(xPlayer.getMoney())
end)

function GetVehicleNetWorkIdByPlate(plate)
    for k,v in ipairs(GetAllVehicles()) do
        if GetVehicleNumberPlateText(v) == plate then
            return NetworkGetNetworkIdFromEntity(v)
        end
    end
end

local customengine = {}
RegisterServerEvent('renzu_customs:custom_engine')
AddEventHandler('renzu_customs:custom_engine', function(netid,plate,model)
    customengine[plate] = model
    if model == 'Default' then customengine[plate] = nil end
    TriggerClientEvent('renzu_customs:receivenetworkid',-1,GetVehicleNetWorkIdByPlate(plate),model)
    SetResourceKvp('engine',json.encode(customengine))
end)

local customturbo = {}
RegisterServerEvent('renzu_customs:custom_turbo')
AddEventHandler('renzu_customs:custom_turbo', function(plate,turbo)
    customturbo[plate] = turbo
    if turbo == 'Default' then customturbo[plate] = nil end
    TriggerClientEvent('renzu_customs:receiveturboupgrade',-1,customturbo)
    SetResourceKvp('turbo',json.encode(customturbo))
end)

local customtire = {}
RegisterServerEvent('renzu_customs:custom_tire')
AddEventHandler('renzu_customs:custom_tire', function(plate,tire)
    customtire[plate] = tire
    if tire == 'Default' then customtire[plate] = nil end
    TriggerClientEvent('renzu_customs:custom_tire',-1,customtire,GetVehicleNetWorkIdByPlate(plate),tire)
    SetResourceKvp('tire',json.encode(customtire))
end)

RegisterServerEvent('renzu_customs:soundsync')
AddEventHandler('renzu_customs:soundsync', function(table)
    TriggerClientEvent('renzu_customs:soundsync',-1,table)
end)

RegisterServerEvent('renzu_customs:loaded')
AddEventHandler('renzu_customs:loaded', function()
    local source = source
    TriggerClientEvent('renzu_customs:receivedata',source,customturbo,customengine,vehicles)
end)