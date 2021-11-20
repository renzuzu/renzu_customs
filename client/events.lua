RegisterNetEvent('renzu_customs:ingarage')
AddEventHandler('renzu_customs:ingarage', function(garage,garage_id)
    currentprivate = garage_id
    local garage = garage
    insidegarage = true

    CreateThread(function()
        Wait(2000)
        local stats_show = nil
        while insidegarage do
            for k,v in pairs(Config.Customs) do
                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.paintmenu.coord.x,v.paintmenu.coord.y,v.paintmenu.coord.z))
                if Config.InteractiveFeature['paintmenu'] and distance < 30 and ShopPermmision(currentprivate,'paintmenu') and Config.showmarker then
                    DrawMarkerInput(vector3(v.paintmenu.coord.x,v.paintmenu.coord.y,v.paintmenu.coord.z),'Spray Paint Menu','renzu_customs:openpaintmenu',false,'spray_paint')
                end
                if Config.InteractiveFeature['paintmenu'] and distance < 3 and ShopPermmision(currentprivate,'paintmenu') and Config.usePopui then
                    local table = {
                        ['key'] = 'E', -- key
                        ['event'] = 'renzu_customs:openpaintmenu',
                        ['title'] = 'Press [E] Open Paint Menu',
                        ['server_event'] = false, -- server event or client
                        ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                        ['fa'] = '<i class="fas fa-garage"></i>',
                        ['invehicle_title'] = 'Press [E] Open Stock Room',
                        ['custom_arg'] = {k,v}, -- example: {1,2,3,4}
                    }
                    TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                    while distance < 3 do
                        distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.paintmenu.coord.x,v.paintmenu.coord.y,v.paintmenu.coord.z))
                        Wait(500)
                    end
                    TriggerEvent('renzu_popui:closeui')
                end
                if v.mod then
                    for k,v in pairs(v.mod) do
                        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.coord.x,v.coord.y,v.coord.z))
                        local invehicle = IsPedInAnyVehicle(PlayerPedId())
                        if Config.JobPermissionAll and ShopPermmision(currentprivate) or not Config.JobPermissionAll then
                            if distance < 30 and invehicle and Config.showmarker then
                                DrawMarkerInput(vector3(v.coord.x,v.coord.y,v.coord.z),'Upgrade Menu','renzu_customs:openmenu',false,'mod_'..k)
                            end
                            if distance < 3 and invehicle and Config.usePopui then
                                local table = {
                                    ['key'] = 'E', -- key
                                    ['event'] = 'renzu_customs:openmenu',
                                    ['title'] = 'Press [E] Upgrade Menu',
                                    ['server_event'] = false, -- server event or client
                                    ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                                    ['fa'] = '<i class="fas fa-garage"></i>',
                                    ['invehicle_title'] = 'Press [E] Upgrade Menu',
                                    ['custom_arg'] = {}, -- example: {1,2,3,4}
                                }
                                TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                                while distance < 3 and IsPedInAnyVehicle(PlayerPedId()) do
                                    distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.coord.x,v.coord.y,v.coord.z))
                                    Wait(500)
                                end
                                TriggerEvent('renzu_popui:closeui')
                            end
                        end
                    end
                end
                local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.stockroom.coord.x,v.stockroom.coord.y,v.stockroom.coord.z))
                if Config.InteractiveFeature['stockroom'] and distance < 30 and ShopPermmision(currentprivate,'stockroom') and Config.showmarker then
                    DrawMarkerInput(vector3(v.stockroom.coord.x,v.stockroom.coord.y,v.stockroom.coord.z),'Stock Room','renzu_customs:openstockroom',false,'stock_inventory',k)
                end
                if Config.InteractiveFeature['stockroom'] and distance < 3 and ShopPermmision(currentprivate,'stockroom') and Config.usePopui then
                    local table = {
                        ['key'] = 'E', -- key
                        ['event'] = 'renzu_customs:openstockroom',
                        ['title'] = 'Press [E] Open Stock Room',
                        ['server_event'] = false, -- server event or client
                        ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                        ['fa'] = '<i class="fas fa-garage"></i>',
                        ['invehicle_title'] = 'Press [E] Open Stock Room',
                        ['custom_arg'] = {k,v}, -- example: {1,2,3,4}
                    }
                    TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                    while distance < 3 do
                        distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.stockroom.coord.x,v.stockroom.coord.y,v.stockroom.coord.z))
                        Wait(500)
                    end
                    TriggerEvent('renzu_popui:closeui')
                end
            end
            local nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.000, 0, 70)
            if Config.InteractiveFeature['garage_inventory'] and nearveh ~= 0 and not carrymod and not spraying and ShopPermmision(currentprivate,'garage_inventory') then
                if stats_show == nil or stats_show ~= nearveh then
                    stats_show = nearveh
                    CreateThread(function()
                        while nearveh ~= 0 do
                            ShowFloatingHelpNotification('Press [E] to See Vehicle Parts', GetEntityCoords(nearveh)+vec3(0,0,1.0))
                            if IsControlPressed(0,38) then
                                TriggerEvent('renzu_customs:vehiclemod',nearveh)
                                Wait(100)
                                break
                            end
                            Wait(4)                            
                        end
                        return
                    end)
                    while nearveh ~= 0 do
                        nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 5.000, 0, 70)
                        Wait(200)
                    end
                end
            elseif stats_show ~= nil then
                stats_show = nil
            end
            local inv = garage.garage_inventory
            local inventorydis = #(GetEntityCoords(PlayerPedId()) - vector3(inv.coord.x,inv.coord.y,inv.coord.z))
            if Config.InteractiveFeature['garage_inventory'] and inventorydis < 10 and not carrymode and not carrymod and ShopPermmision(currentprivate,'garage_inventory') and Config.showmarker then
                DrawMarkerInput(vector3(inv.coord.x,inv.coord.y,inv.coord.z),'Parts Inventory','renzu_customs:openinventory',false,'parts_inventory',currentprivate)
            end
            if Config.InteractiveFeature['garage_inventory'] and inventorydis < 2 and not carrymode and not carrymod and ShopPermmision(currentprivate,'garage_inventory') and Config.usePopui then
                local table = {
                    ['key'] = 'E', -- key
                    ['event'] = 'renzu_customs:openinventory',
                    ['title'] = 'Press [E] Open Inventory',
                    ['server_event'] = false, -- server event or client
                    ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                    ['fa'] = '<i class="fas fa-car"></i>',
                    ['invehicle_title'] = 'Press [E] Open Inventory',
                    ['custom_arg'] = {currentprivate,activeshare}, -- example: {1,2,3,4}
                }
                TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                while inventorydis < 3 and not carrymode do
                    inventorydis = #(GetEntityCoords(PlayerPedId()) - vector3(inv.coord.x,inv.coord.y,inv.coord.z))
                    Wait(500)
                end
                TriggerEvent('renzu_popui:closeui')
            elseif Config.InteractiveFeature['garage_inventory'] and not carrymode and carrymod and inventorydis < 2 and ShopPermmision(currentprivate,'garage_inventory') then
                if inventorydis < 2 and ShopPermmision(currentprivate,'garage_inventory') and Config.showmarker then
                    DrawMarkerInput(vector3(inv.coord.x,inv.coord.y,inv.coord.z),'Press [E] Store','renzu_customs:storemod',false,'store_mod',{currentprivate,Config.VehicleMod[tostore[1]],tostore[2],false,false,true},true)
                end
                if Config.usePopui then
                    local table = {
                        ['key'] = 'E', -- key
                        ['event'] = 'renzu_customs:storemod',
                        ['title'] = 'Press [E] Store',
                        ['server_event'] = false, -- server event or client
                        ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                        ['fa'] = '<i class="fas fa-car"></i>',
                        ['invehicle_title'] = 'Press [E] Open Inventory',
                        --{index,lvl,k,nearveh,Config.VehicleMod[index]}
                        ['custom_arg'] = {currentprivate,Config.VehicleMod[tostore[1]],tostore[2],false,false,true}, -- example: {1,2,3,4}
                    }
                    TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                    while inventorydis < 3 and not carrymode and carrymod do
                        inventorydis = #(GetEntityCoords(PlayerPedId()) - vector3(inv.coord.x,inv.coord.y,inv.coord.z))
                        Wait(500)
                    end
                    TriggerEvent('renzu_popui:closeui')
                end
            end
            Wait(1000)
        end
    end)
end)

RegisterNetEvent('renzu_customs:openinventory')
AddEventHandler('renzu_customs:openinventory', function(current)
    local multimenu = {}
    local firstmenu = {}
    local openmenu = false
    TriggerServerCallback_("renzu_customs:getinventory",function(inventory)
        for k,v in pairs(inventory) do
            local k = tostring(k)
            local item = k:gsub("-", "")
            local mod = string.match(item,"[^%d]+")
            local lvl = item:gsub("%D+", "")
            for index,t in pairs(Config.VehicleMod) do
                if t.name:lower() == mod:lower() then
                    if multimenu[t.type:upper()] == nil then multimenu[t.type:upper()] = {} end
                    multimenu[t.type:upper()][k] = {
                        ['title'] = t.label:upper()..' : LVL '..lvl..' x'..v,
                        ['fa'] = '<i class="fad fa-question-square"></i>',
                        ['type'] = 'event', -- event / export
                        ['content'] = 'renzu_customs:getmod',
                        ['variables'] = {server = false, send_entity = false, onclickcloseui = true, custom_arg = {index,lvl,k}, arg_unpack = true},
                    }
                    openmenu = true
                end
            end
        end
        if openmenu then
            TriggerEvent('renzu_contextmenu:insertmulti',multimenu,"Vehicle Parts",false,"<i class='fad fa-inventory'></i> Mod Inventory")
            TriggerEvent('renzu_contextmenu:show')
        else
            TriggerEvent('renzu_notify:Notify', 'error','Customs', 'Inventory is Empty')
        end
    end,current,activeshare)
end)

RegisterNetEvent('renzu_customs:openstockroom')
AddEventHandler('renzu_customs:openstockroom', function(current)
    multimenu = {}
    local firstmenu = {}
    openmenu = false
    for k,vehicle in ipairs(GetGamePool('CVehicle')) do
        local vehicle = tonumber(vehicle)
        if IsVehicleStopped(vehicle) then
            if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicle)) < 100 then
                vehicleinarea[vehicle] = {}
                multimenu[vehicle] = {}
                SetModable(vehicle)
                local livery = false
                for k,v in pairs(Config.VehicleMod) do
                    vehicleinarea[vehicle][tonumber(v.index)] = GetNumVehicleMods(vehicle, tonumber(v.index))
                    local max = vehicleinarea[vehicle][v.index]
                    if k == 48 and max <= 0 then
                        max = GetVehicleLiveryCount(vehicle) + 1
                        livery = true
                    end
                    if max >= 0 then
                        if multimenu[vehicle][v.label] == nil then multimenu[vehicle][v.label] = {} end
                        for i = 0, max do
                            if livery and i > 0 then
                                label = GetLabelText(GetLiveryName(vehicle,i-1))
                            elseif GetLabelText(GetModTextLabel(vehicle, v.index, i-1)) ~= 'NULL' and i >= 1 then
                                label = GetLabelText(GetModTextLabel(vehicle, v.index, i-1))
                            elseif i >= 1 then
                                label = v.label.." Lvl "..i
                            else
                                label = 'Default'
                            end
                            openmenu = true
                            if multimenu[vehicle][v.label].main_fa == nil then
                                multimenu[vehicle][v.label].main_fa = '<img style="height: auto;margin-left: -20px;margin-top: -10px;position: relative;max-width: 35px;float: left;" src="https://cfx-nui-renzu_customs/html/img/'..k..'.svg">'
                            end
                            multimenu[vehicle][v.label][i] = {
                                ['title'] = label,
                                ['fa'] = '<i class="fad fa-car"></i>',
                                ['type'] = 'event', -- event / export
                                ['content'] = 'renzu_customs:getmodfromstockroom',
                                ['variables'] = {server = false, send_entity = false, onclickcloseui = true, custom_arg = {k,i,v.name,vehicle}, arg_unpack = true},
                            }
                        end
                    end
                end
            end
        end
    end
    local localmultimenu = {}
    for k,v in pairs(vehicleinarea) do
        name = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(k)))
        if localmultimenu[name] == nil then
            openmenu = true
            localmultimenu[name] = {}
            localmultimenu[name][k] = {
                ['title'] = 'Mod for '..name,
                ['fa'] = '<i class="fad fa-car"></i>',
                ['type'] = 'event', -- event / export
                ['content'] = 'renzu_customs:partlist',
                ['variables'] = {server = false, send_entity = false, onclickcloseui = true, custom_arg = {k}, arg_unpack = true},
            }
        end
    end
    if openmenu then
        TriggerEvent('renzu_contextmenu:insertmulti',localmultimenu,"Vehicle Parts",false,"<i class='fad fa-container-storage'></i> Stock Room")
        TriggerEvent('renzu_contextmenu:show')
    end
end)

RegisterNetEvent('renzu_customs:partlist')
AddEventHandler('renzu_customs:partlist', function(vehicle)
    local max
    local firstmenu = {}
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        SetModable(vehicle)
        if openmenu then
            TriggerEvent('renzu_contextmenu:insertmulti',multimenu[vehicle],"Vehicle Parts",false,"<i class='fas fa-cog'></i> Part List")
            Wait(100)
            TriggerEvent('renzu_contextmenu:show')
        end
    end
end)

RegisterNetEvent('renzu_customs:getmodfromstockroom')
AddEventHandler('renzu_customs:getmodfromstockroom', function(index,lvl,name,vehicle)
    carrymod = true
    local k = name..'-'..lvl
    CarryMod("anim@heists@box_carry@","idle",Config.VehicleMod[index].prop or 'hei_prop_heist_box',50,28422)
    tostore = {index,lvl,k,false,Config.VehicleMod[index]}
    while carrymod do
        local nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.000, 0, 70)
        newprop = GetVehicleProperties(nearveh)
        if nearveh ~= 0 then
            local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearveh))
            if dist < 9 then
                local table = {
                    ['key'] = 'E', -- key
                    ['event'] = 'renzu_customs:installmod',
                    ['title'] = 'Press [E] Install '..Config.VehicleMod[index].label..' Lvl '..lvl,
                    ['server_event'] = false, -- server event or client
                    ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                    ['fa'] = '<i class="fas fa-car"></i>',
                    ['custom_arg'] = {index,lvl,k,nearveh,Config.VehicleMod[index]}, -- example: {1,2,3,4}
                }
                TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                while dist < 9 do
                    newprop = GetVehicleProperties(nearveh)
                    nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.000, 0, 70)
                    dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearveh))
                    Wait(500)
                end
                TriggerEvent('renzu_popui:closeui')
            end
        end
        Wait(500)
    end
end)

RegisterNetEvent('renzu_customs:syncdel')
AddEventHandler('renzu_customs:syncdel', function(net)
    local ent = NetworkGetEntityFromNetworkId(net)
    print(ent)
    ReqAndDelete(ent)
end)

RegisterNetEvent('renzu_customs:storemod')
AddEventHandler('renzu_customs:storemod', function(current,mod,lvl,newprop,save,saveprop)
    carrymode = false
    carrymod = false
    TriggerServerEvent('renzu_customs:syncdel',NetworkGetNetworkIdFromEntity(object))
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('renzu_customs:storemod',current,mod,lvl,newprop,activeshare,save,saveprop)
end)

RegisterNetEvent('renzu_customs:installmod')
AddEventHandler('renzu_customs:installmod', function(index,lvl,k,vehicle,mod)
    local max = GetNumVehicleMods(vehicle, tonumber(index)) + 1
    if tonumber(lvl) <= max then
        carrymod = false
        SetModable(vehicle)
        SetVehicleMod(vehicle, tonumber(index), tonumber(lvl) -1, false)
        Wait(150)
        newprop = GetVehicleProperties(vehicle)
        TriggerServerEvent('renzu_customs:storemod',currentprivate,mod,lvl,newprop,activeshare,true)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('renzu_customs:syncdel',NetworkGetNetworkIdFromEntity(object))
    else
        TriggerEvent('renzu_notify:Notify', 'error','Garage', 'This Parts is not compatible with this vehicle')
    end
end)

RegisterNetEvent('renzu_customs:getmod')
AddEventHandler('renzu_customs:getmod', function(index,lvl,k)
    TriggerServerCallback_("renzu_customs:itemavailable",function(inventory)
        if inventory then
            carrymod = true
            CarryMod("anim@heists@box_carry@","idle",Config.VehicleMod[index].prop or 'hei_prop_heist_box',50,28422)
            tostore = {index,lvl,k,false,Config.VehicleMod[index]}
            while carrymod do
                local nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.000, 0, 70)
                newprop = GetVehicleProperties(nearveh)
                if nearveh ~= 0 then
                    local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearveh))
                    if dist < 9 then
                        local table = {
                            ['key'] = 'E', -- key
                            ['event'] = 'renzu_customs:installmod',
                            ['title'] = 'Press [E] Install '..Config.VehicleMod[index].label..' Lvl '..lvl,
                            ['server_event'] = false, -- server event or client
                            ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                            ['fa'] = '<i class="fas fa-car"></i>',
                            ['custom_arg'] = {index,lvl,k,nearveh,Config.VehicleMod[index]}, -- example: {1,2,3,4}
                        }
                        TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                        while dist < 9 do
                            newprop = GetVehicleProperties(nearveh)
                            nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.000, 0, 70)
                            dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearveh))
                            Wait(500)
                        end
                        TriggerEvent('renzu_popui:closeui')
                    end
                end
                Wait(500)
            end
        else
            TriggerEvent('renzu_notify:Notify', 'error','Garage', 'This Parts Does not exist')
        end
    end,currentprivate,k,activeshare)
end)

RegisterNetEvent('renzu_customs:removevehiclemod')
AddEventHandler('renzu_customs:removevehiclemod', function(mod,lvl,vehicle)
    if mod ~= nil and GetVehicleMod(vehicle,tonumber(mod.index)) + 1 >= lvl then
        CarryMod("anim@heists@box_carry@","idle",mod.prop or 'hei_prop_heist_box',50,28422)
        carrymode = true
        NetworkRequestControlOfEntity(vehicle)
		local attempt = 0
		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			NetworkRequestControlOfEntity(vehicle)
			Citizen.Wait(1)
			attempt = attempt + 1
		end
        SetVehicleMod(vehicle, tonumber(mod.index), -1, false)
        Wait(150)
        newprop = GetVehicleProperties(vehicle)
        while carrymode do
            newprop = GetVehicleProperties(vehicle)
            local vec = Config.Customs[currentprivate].garage_inventory
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(vec.coord.x,vec.coord.y,vec.coord.z))
            if distance < 3 and ShopPermmision(currentprivate,'garage_inventory') and Config.showmarker then
                DrawMarkerInput(vector3(vec.coord.x,vec.coord.y,vec.coord.z),'Press [E] Store','renzu_customs:storemod',false,'store_mod',{currentprivate,mod,lvl,newprop},true)
            end
            if Config.usePopui and ShopPermmision(currentprivate,'garage_inventory') then
                if distance < 3 then
                    local table = {
                        ['key'] = 'E', -- key
                        ['event'] = 'renzu_customs:storemod',
                        ['title'] = 'Press [E] Store '..mod.label,
                        ['server_event'] = false, -- server event or client
                        ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                        ['fa'] = '<i class="fas fa-car"></i>',
                        ['custom_arg'] = {currentprivate,mod,lvl,newprop}, -- example: {1,2,3,4}
                    }
                    TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                    while distance < 3 do
                        newprop = GetVehicleProperties(vehicle)
                        distance = #(GetEntityCoords(PlayerPedId()) - vector3(vec.coord.x,vec.coord.y,vec.coord.z))
                        Wait(500)
                    end
                    TriggerEvent('renzu_popui:closeui')
                end
            end
            Wait(500)
        end
    end
end)

RegisterNetEvent('renzu_customs:vehiclemod')
AddEventHandler('renzu_customs:vehiclemod', function(vehicle)
    if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) then
        local multimenu = {}
        local firstmenu = {}
        local openmenu = false
        for i = 0, 49 do
            local modType = i
            if Config.VehicleMod[i] ~= nil then
                local mod = Config.VehicleMod[i]
                if GetVehicleMod(vehicle,mod.index) + 1 > 0 then
                    if multimenu[mod.type:upper()] == nil then multimenu[mod.type:upper()] = {} end
                    multimenu[mod.type:upper()].main_fa = '<img style="height: auto;margin-left: -20px;margin-top: -10px;position: relative;max-width: 35px;float: left;" src="https://cfx-nui-renzu_customs/html/img/'..i..'.svg">'
                    multimenu[mod.type:upper()][mod.label:upper()..' '..GetVehicleMod(vehicle,i) + 1] = {
                        ['title'] = mod.label..' '..GetVehicleMod(vehicle,i) + 1,
                        ['fa'] = '<img style="height: auto;position: absolute;max-width: 30px;left:5%;top:25%;" src="https://cfx-nui-renzu_customs/html/img/'..i..'.svg">',
                        ['type'] = 'event', -- event / export
                        ['content'] = 'renzu_customs:removevehiclemod',
                        ['variables'] = {server = false, send_entity = false, onclickcloseui = true, custom_arg = {mod,GetVehicleMod(vehicle,mod.index) + 1,vehicle}, arg_unpack = true},
                    }
                    openmenu = true
                end
                --multimenu[mod.type:upper()] = firstmenu[mod.index]
            end
            -- max = GetNumVehicleMods(vehicle, modType) - 1
            -- SetVehicleMod(vehicle, tonumber(modType), tonumber(max), customWheels)
        end
        --ToggleVehicleMod(vehicle, 18, true) -- Turbo
        if openmenu then
            TriggerEvent('renzu_contextmenu:insertmulti',multimenu,"Vehicle Parts",false,"Vehicle Mods")
            TriggerEvent('renzu_contextmenu:show')
        else
            TriggerEvent('renzu_notify:Notify', 'error','Customs', 'Vehicle is Stock')
        end
    end
end)

RegisterNetEvent('renzu_customs:soundsync')
AddEventHandler('renzu_customs:soundsync', function(table)
    local volume = table['volume']
	local mycoord = GetEntityCoords(PlayerPedId())
	local distIs  = tonumber(string.format("%.1f", #(mycoord - table['coord'])))
	if (distIs <= 30) then
		distPerc = distIs / 30
		volume = (1-distPerc) * table['volume']
		local table = {
			['file'] = table['file'],
			['volume'] = volume
		}
		SendNUIMessage({
			type = "playsound",
			content = table
		})
	end
end)

RegisterNetEvent('renzu_customs:receivenetworkid')
AddEventHandler('renzu_customs:receivenetworkid', function(net,model)
    if net == nil then return end
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    local ent = NetworkGetEntityFromNetworkId(net)
    if model == 'Default' and ent ~= 0 and NetworkDoesEntityExistWithNetworkId(net) or model == nil and ent ~= 0 and NetworkDoesEntityExistWithNetworkId(net) then
        netids[net] = nil
        ForceVehicleEngineAudio(vehicle,'Default')
        SetVehicleHandlingSpec(NetworkGetEntityFromNetworkId(net),'Default')
    end
    if NetworkDoesEntityExistWithNetworkId(net) and model ~= nil and model ~= 'Default' then
        netids[net] = model
    end
end)

RegisterNetEvent('renzu_customs:receiveturboupgrade')
AddEventHandler('renzu_customs:receiveturboupgrade', function(turbos)
    customturbo = turbos
end)

RegisterNetEvent('renzu_customs:custom_tire')
AddEventHandler('renzu_customs:custom_tire', function(tires,net,tire)
    customtire = tires
    local vehicle = NetworkGetEntityFromNetworkId(net)
    if NetworkDoesEntityExistWithNetworkId(net) and tire == 'Default' and vehicle ~= 0 or NetworkDoesEntityExistWithNetworkId(net) and tire == nil and vehicle ~= 0 then
        Wait(2000)
        local default = GetHandlingfromModel(GetEntityModel(vehicle),vehicle)
        if default then
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fLowSpeedTractionLossMult", default.fLowSpeedTractionLossMult + 0.0) -- self.start burnout less = traction
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionLossMult", default.fTractionLossMult + 0.0)  -- asphalt mud less = traction
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionCurveMin", default.fTractionCurveMin + 0.0) -- accelaration grip
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionCurveMax", default.fTractionCurveMax + 0.0) -- cornering grip
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionCurveLateral", default.fTractionCurveLateral + 0.0) -- curve lateral grip
        end
    end
end)

RegisterNetEvent('renzu_customs:openmenu')
AddEventHandler('renzu_customs:openmenu', function()
    local custom = {}
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    oldprop = GetVehicleProperties(vehicle)
    for k,v in pairs(Config.Customs) do
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
        if distance < v.radius then
            TriggerServerCallback_("renzu_customs:getmoney",function(money)
                gameplaycam = GetRenderingCam()
                if not IsCamActive(cam) then
                    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
                    CreateModCam()
                    ControlCam('front',-2.5,0.1,1.3)
                else
                    CreateModCam()
                    SetCamActive(cam, true)
                    ControlCam('front',-2.5,0.1,1.3)
                end
                SetModable(vehicle) 
                local livery = false
                local vehicle_val = GetVehicleValue(GetEntityModel(vehicle)) * Config.VehicleValuePercent
                for k,v in pairs(Config.VehicleMod) do
                    if Config.JobPermissionAll and PlayerData ~= nil and v.job_grade ~= nil and v.job_grade[PlayerData.job.name] ~= nil and PlayerData.job.grade >= v.job_grade[PlayerData.job.name] 
                    or not Config.JobPermissionAll or Config.JobPermissionAll and v.job_grade ~= nil and v.job_grade['all'] ~= nil then
                        if custom[v.type:upper()] == nil then custom[v.type:upper()] = {} custom[v.type:upper()].index = k end
                        local max = GetNumVehicleMods(vehicle, tonumber(v.index)) + 1
                        if k == 48 and max <= 1 then
                            max = GetVehicleLiveryCount(vehicle) + 1
                            livery = true
                        end
                        if k == 'extra' then
                            v.extra()
                            v.list = extras
                        end
                        local list = {}
                        if Config.DoNotShowEmptyMods and max > 1 or not Config.DoNotShowEmptyMods and max > 0 or k == 'paint1' or k == 'paint2' or k == 'neon' or k == 'plate' or k == 'headlight' or k == 'window' or k == 18 or k == 'extra' or k == 'custom_engine' or k == 'custom_turbo' or k == 'custom_tires' then
                            local upgrades = 0
                            if max > 0 then
                                for i = 0, max do
                                    if livery and i >= 1 and GetLabelText(GetLiveryName(vehicle,i-1)) ~= 'NULL' then
                                        list[i] = GetLabelText(GetLiveryName(vehicle,i-1))
                                    elseif GetLabelText(GetModTextLabel(vehicle, v.index, i-1)) ~= 'NULL' and i >= 1 then
                                        list[i] = GetLabelText(GetModTextLabel(vehicle, v.index, i-1))
                                    elseif i >= 1 then
                                        list[i] = v.name.." Lvl "..i
                                    else
                                        list[i] = 'Default'
                                    end
                                    upgrades = i
                                end
                            end
                            local cost = v.cost + (vehicle_val / v.percent_cost) * 1.0
                            if not Config.VehicleValuetoFormula then
                                cost = v.cost
                            end
                            if Config.EnableDiscounts and PlayerData.job ~= nil and v.discount[PlayerData.job.name] ~= nil then
                                cost = cost * (1-tonumber(v.discount[PlayerData.job.name]))
                            elseif Config.EnableDiscounts and PlayerData.job ~= nil and Config.JobDiscounts[PlayerData.job.name] ~= nil then
                                cost = cost * (1-tonumber(Config.JobDiscounts[PlayerData.job.name]))
                            end
                            if Config.FreeUpgradeToClass[GetVehicleClass(vehicle)] then
                                cost = 0
                            end
                            custom[v.type:upper()][v.index] = {
                                label = v.label or nil, 
                                index = v.index, 
                                name = v.name, 
                                max = max or 0, 
                                cost = cost,
                                list = v.list or {}, 
                                type = v.type or 'cosmetic', 
                                mod = list or {}, 
                                action = v.action or false, 
                                multicostperlvl = v.multicostperlvl or false
                            }
                        end
                    end
                end
                local health = GetVehicleBodyHealth(vehicle)
                if Config.DisableRepair then
                    health = 1000
                end
                SendNUIMessage({
                    type = "custom",
                    custom = custom,
                    show = true,
                    money = numWithCommas(money),
                    vehicle_health = health,
                    shop = k,
                })
                FreezeEntityPosition(vehicle,true)
                SetNuiFocus(true,true)
            end, NetworkGetNetworkIdFromEntity(vehicle), oldprop)
        end
    end
end)

RegisterNetEvent('renzu_customs:restoremod')
AddEventHandler('renzu_customs:restoremod', function(net,prop)
    local ent = NetworkGetEntityFromNetworkId(net)
    SetModable(ent)
    SetVehicleProp(ent, prop)
    print('restoring mod')
end)

RegisterNetEvent('renzu_customs:paint')
AddEventHandler('renzu_customs:paint', function(color,spray)
    if not spray then
        spraying = true
        tospray = true
        local ped = PlayerPedId()
        spraycan = CreateObject(GetHashKey('ng_proc_spraycan01a'),0.0, 0.0, 0.0,true, false, false)
        AttachEntityToEntity(spraycan, ped, GetPedBoneIndex(ped, 57005), 0.072, 0.041, -0.06,33.0, 38.0, 0.0, true, true, false, true, 1, true)
        local nearveh = nil
        while tospray do
            nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.000, 0, 70)
            if nearveh ~= 0 then
                local dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearveh))
                if dist < 9 then
                    local table = {
                        ['key'] = 'E', -- key
                        ['event'] = 'renzu_customs:paint',
                        ['title'] = 'Press [E] Spray ('..color..') This Vehicle',
                        ['server_event'] = false, -- server event or client
                        ['unpack_arg'] = true, -- send args as unpack 1,2,3,4 order
                        ['fa'] = '<i class="fas fa-car"></i>',
                        ['custom_arg'] = {color,true}, -- example: {1,2,3,4}
                    }
                    TriggerEvent('renzu_popui:drawtextuiwithinput',table)
                    while tospray do
                        nearveh = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 2.000, 0, 70)
                        dist = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(nearveh))
                        Wait(500)
                    end
                    TriggerEvent('renzu_popui:closeui')
                end
            end
            Wait(500)
        end
        PaintCar(color,nearveh)
        TriggerServerEvent('renzu_customs:syncdel',NetworkGetNetworkIdFromEntity(spraycan))
    else
        tospray = false
    end
end)

RegisterNetEvent('renzu_customs:openpaintmenu')
AddEventHandler('renzu_customs:openpaintmenu', function(garage,garage_id)
    local localmultimenu = {}
    local openmenu = false
    for name,color in pairs(Config.Pilox) do
        local name = name:upper()
        if localmultimenu[name] == nil then
            openmenu = true
            localmultimenu[name] = {}
            localmultimenu[name][name] = {
                ['title'] = 'Color '..name:upper(),
                ['fa'] = '<i class="fad fa-car"></i>',
                ['type'] = 'event', -- event / export
                ['content'] = 'renzu_customs:paint',
                ['variables'] = {server = false, send_entity = false, onclickcloseui = true, custom_arg = {name}, arg_unpack = true},
            }
        end
    end
    if openmenu then
        TriggerEvent('renzu_contextmenu:insertmulti',localmultimenu,"Vehicle Parts",false,"<i class='fas fa-spray-can'></i> Spray Paints")
        TriggerEvent('renzu_contextmenu:show')
    end
end)

Playerloaded()

RegisterNetEvent('renzu_customs:receivedata')
AddEventHandler('renzu_customs:receivedata', function(turbo,engine,vehicleprice)
	netids = engine
    customturbo = turbo
    for k,v in pairs(vehicleprice) do
        table.insert(Config.VehicleValueList,{model = v.model, value = v.price})
    end
end)

SetJob()