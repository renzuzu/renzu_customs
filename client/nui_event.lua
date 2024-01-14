RegisterNUICallback('XenonMod', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetVehicleLights(vehicle,2)
    ToggleVehicleMod(vehicle,22,data.index)
    SetVehicleXenonLightsColour(vehicle,0)
    cb(true)
end)

RegisterNUICallback('SetXenonColor', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetVehicleXenonLightsColor(vehicle,data.index)
    cb(true)
end)

RegisterNUICallback('SetBulletProofTires', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetVehicleTyresCanBurst(vehicle,false)
    cb(true)
end)

RegisterNUICallback('SetSmokeColor', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    ToggleVehicleMod(vehicle,20,true)
	SetVehicleTyreSmokeColor(vehicle,data.r,data.g,data.b)
    cb(true)
end)

RegisterNUICallback('SetDrift', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetDriftTyresEnabled(vehicle,not GetDriftTyresEnabled(vehicle))
    SetReduceDriftVehicleSuspension(vehicle,not GetDriftTyresEnabled(vehicle))
    cb(true)
end)

RegisterNUICallback('repair', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    TriggerServerCallback_("renzu_customs:repair",function(ret)
        if ret then
            if Config.UseProgressBar then
                if Config.PorgressBarType == "ox" then
                    repair = lib.progressCircle({
                        duration = 25000,
                        position = 'bottom',
                        useWhileDead = false,
                    })
                else
                    repair = exports.renzu_progressbar:CreateProgressBar(25,'<i class="fas fa-tools"></i>')
                end
            end
            SetVehicleFixed(vehicle)
            SetVehicleDirtLevel(vehicle,0.0)
            SetVehicleBodyHealth(vehicle,1000.0)
            SetVehicleEngineHealth(vehicle,1000.0)
            SetVehiclePetrolTankHealth(vehicle,1000.0)
            for k,v in pairs(oldprop) do
                if k == 'bodyHealth' or k == 'engineHealth' then
                    oldprop[k] = 1000.0
                end
            end
            cb(true)
        else
            SendNotification('error','Customs', 'Not enough money cabron $'..Config.RepairCost..' Required')
            cb(false)
        end
    end,currentprivate)
end)

RegisterNUICallback('SetCustomTire', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local bool = not IsToggleModOn(vehicle,23)
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    local mod = GetVehicleMod(vehicle,23)
    SetVehicleMod(vehicle,23,mod,bool)
    cb(true)
end)

RegisterNUICallback('GetPaint', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleModKit(vehicle,0)
	local primary,secondary = GetVehicleColours(vehicle)
    cb({primary,secondary})
end)

RegisterNUICallback('SetPaint', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleModKit(vehicle,0)
	local primary,secondary = GetVehicleColours(vehicle)
	if data.type == "Primary Color" and data.option ~= 'Pearlescent' and data.option ~= 'Chameleon' then
		ClearVehicleCustomPrimaryColour(vehicle)
		SetVehicleColours(vehicle,data.index,secondary)
    elseif data.type == "Primary Color" and data.option == 'Pearlescent' and data.option ~= 'Chameleon' then
        local pearlcent,wheel = GetVehicleExtraColours(vehicle)
        SetVehicleExtraColours(vehicle,data.index,wheel)
	elseif data.type == "Secondary Color" and data.option ~= 'Pearlescent' and data.option ~= 'Chameleon' then
		ClearVehicleCustomSecondaryColour(vehicle)
		SetVehicleColours(vehicle,primary,data.index)
    elseif data.type == "Primary Color" and data.option == 'Chameleon' and data.option ~= 'Pearlescent' then
        ClearVehicleCustomSecondaryColour(vehicle)
        ClearVehicleCustomPrimaryColour(vehicle)
        SetVehicleColours(vehicle, data.index, data.index)
	end
    cb(true)
end)

RegisterNUICallback('SetCustomColor', function(data)
    local r,g,b = data.r,data.g,data.b
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleModKit(vehicle,0)
	local primary,secondary = GetVehicleColours(vehicle)
	if data.type == "Primary Color" then
        SetVehicleCustomPrimaryColour(vehicle,r,g,b)
	elseif data.type == "Secondary Color" then
		SetVehicleCustomSecondaryColour(vehicle,r,g,b)
	end
end)

RegisterNUICallback('SelectModIndex', function(data, cb)
    if data.index == 99 or data.index == nil then return end
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if Config.VehicleMod[data.index].action ~= nil then
        if Config.VehicleMod[data.index].action == 'openhood' then
            SetVehicleDoorOpen(vehicle,4,false,false)
        end
    end
    if not IsCamActive(gameplaycam) then
        SetCamActive(gameplaycam, false)
        EnableGameplayCam(false)
    end
    if not IsCamActive(cam) then
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
        CreateModCam()
        ControlCam('front',-2.5,0.1,1.3)
    else
        CreateModCam()
        SetCamActive(cam, true)
        ControlCam('front',-2.5,0.1,1.3)
    end
    BoneCamera(Config.VehicleMod[data.index].bone,0.0,0.0,0.0)
    if Config.VehicleMod[data.index].camera ~= nil then
        local v = Config.VehicleMod[data.index].camera
        ControlCam(v.val,v.x,v.y,v.z)
    else
        control = nil
    end
    cb(GetVehicleMod(vehicle,data.index))
end)

RegisterNUICallback('ToggleCamera', function(data, cb)
    RenderScriptCams(false, true, 500, true, true)
    DestroyCam(cam, true)
    DestroyCam(gameplaycam, true)
    ClearFocus()
    SetNuiFocusKeepInput(true)
    while true do
        if IsControlPressed(0,38) then
            SetCamCoord(cam,GetGameplayCamCoords())
            SetCamRot(cam, GetGameplayCamRot(2), 2)
            RenderScriptCams( 0, 1, 1000, 0, 0)
            SetCamActive(gameplaycam, true)
            EnableGameplayCam(true)
            SetCamActive(cam, false)
            break
        end
        Wait(0)
    end
    SetNuiFocusKeepInput(false)
    cb(true)
end)

RegisterNUICallback('ToggleTurbo', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    ToggleVehicleMod(vehicle,18,data.index)
    cb(true)
end)

RegisterNUICallback('ChangePlate', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleNumberPlateTextIndex(vehicle,data.index)
    cb(true)
end)

RegisterNUICallback('isNeonLights', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    cb(IsVehicleNeonLightEnabled(vehicle,0))
end)

RegisterNUICallback('SetNeonState', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    for i = 0, 3 do
        SetVehicleNeonLightEnabled(vehicle,i,data.index)
    end
    cb(true)
end)

RegisterNUICallback('SetNeonColor', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleNeonLightsColour(vehicle,data.r,data.g,data.b)
    cb(true)
end)

RegisterNUICallback('SetWindowTint', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    SetVehicleWindowTint(vehicle,data.index)
    cb(true)
end)

RegisterNUICallback('GetModData', function(v, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId()) ~= 0 and GetVehiclePedIsIn(PlayerPedId()) or GetVehiclePedIsIn(PlayerPedId(),true)
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    local wheel = GetVehicleWheelType(vehicle),
    SetVehicleWheelType(vehicle,v.wheeltype)
    Wait(0)
    local livery = false
    local max = GetNumVehicleMods(vehicle, tonumber(v.index)) + 1
    if GetVehicleClass(vehicle) == 8 and v.index == 24 then -- temp fix for motorcycles
        max = 73
    end
    if GetVehicleClass(vehicle) == 8 and v.index == 23 and v.wheeltype ~= 6 then
        max = 1
    end
    if v.index == 48 and max <= 1 then
        max = GetVehicleLiveryCount(vehicle) + 1
        livery = true
    end
    local list = {}
    if max > 0 then
        for i = 0, max do
            local i = tonumber(i)
            if livery and i >= 1 then
                list[i] = GetLabelText(GetLiveryName(vehicle,i-1))
            elseif GetLabelText(GetModTextLabel(vehicle, v.index, i-1)) ~= 'NULL' and i >= 1 then
                list[i] = GetLabelText(GetModTextLabel(vehicle, v.index, i-1))
            elseif i >= 1 then
                list[i] = Config.VehicleMod[v.index].name.." Lvl "..i
            else
                list[i] = 'Default'
            end
        end
    end
    local data = {mod = list, max = max}
    SetVehicleWheelType(vehicle,wheel)
    cb(data)
end)

RegisterNUICallback('Close', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetVehicleProp(vehicle, oldprop)
    DisplayHud(true)
    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)  
    RenderScriptCams(false, true, 500, true, true)
    --SetCamActive(cam, false)
    --RenderScriptCams( 0, 1, 1000, 0, 0)
	--SetCamActive(gameplaycam, false)
	--SetCamActive(cam, false)
    DestroyCam(cam, true)
    DestroyCam(gameplaycam, true)
    ClearFocus()
    SetNuiFocus(false,false)
    SendNUIMessage({
        type = "custom",
        custom = custom,
        show = false,
    })
    inmark = false
    FreezeEntityPosition(vehicle,false)
    TriggerServerEvent('renzu_customs:leaveshop')
end)

RegisterNUICallback('closedoor', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    for i = 0, 5 do
        SetVehicleDoorShut(vehicle, i, false) -- will close all doors from 0-5
    end
    cb(true)
end)

RegisterNUICallback('pay', function(data, cb)
    local t = {
        prop = GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId())),
        cost = data.cost
    }
    TriggerServerCallback_("renzu_customs:pay",function(cb)
        if cb then
            DisplayHud(true)
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)  
            RenderScriptCams(false, true, 500, true, true)
            --SetCamActive(cam, false)
            --RenderScriptCams( 0, 1, 1000, 0, 0)
            --SetCamActive(gameplaycam, false)
            --SetCamActive(cam, false)
            DestroyCam(cam, true)
            DestroyCam(gameplaycam, true)
            SendNUIMessage({
                type = "custom",
                custom = custom,
                show = false,
            })
            inmark = false
            FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()),false)
            TriggerServerEvent('renzu_customs:leaveshop')
        else
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if vehicle == 0 then
                vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
            end
            SetVehicleProp(vehicle, oldprop)
            DisplayHud(true)
            SetNuiFocus(false, false)
            SetNuiFocusKeepInput(false)  
            RenderScriptCams(false, true, 500, true, true)
            --SetCamActive(cam, false)
            --RenderScriptCams( 0, 1, 1000, 0, 0)
            --SetCamActive(gameplaycam, false)
            --SetCamActive(cam, false)
            DestroyCam(cam, true)
            DestroyCam(gameplaycam, true)
            SendNUIMessage({
                type = "custom",
                custom = custom,
                show = false,
            })
            inmark = false
            FreezeEntityPosition(vehicle,false)
            TriggerServerEvent('renzu_customs:leaveshop')
        end
    end,t,currentprivate,GetVehicleClass(vehicle))
end)

RegisterNUICallback('Reset', function(data, cb)
    if control == nil or control ~= 'front' then
        if not IsCamActive(gameplaycam) then
            SetCamActive(gameplaycam, false)
            EnableGameplayCam(false)
        end
        if not IsCamActive(cam) then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",true,2)
            CreateModCam()
            ControlCam('front',-2.5,0.1,1.3)
        else
            CreateModCam()
            SetCamActive(cam, true)
            ControlCam('front',-2.5,0.1,1.3)
        end
    end
end)

RegisterNUICallback('CustomPaint', function(data, cb)
    Config.Pilox['custom'] = {data.r,data.g,data.b}
    cb(true)
end)

RegisterNUICallback('CustomPaintDone', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    custompaint = true
    SetNuiFocus(false,false)
    cb(true)
end)

RegisterNUICallback('GetMod', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    local mod = GetVehicleMod(vehicle,data.index)
    cb(mod)
end)

RegisterNUICallback('SetMod', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    if data.wheeltype ~= nil then
        SetVehicleWheelType(vehicle,data.wheeltype)
    end
    if data.index == 48 and GetVehicleLiveryCount(vehicle) > 0 then
        SetVehicleLivery(vehicle,tonumber(data.lvl) - 1)
    else
        SetVehicleMod(vehicle, tonumber(data.index), tonumber(data.lvl) - 1, false)
    end
    if data.index == 14 then
        local count = 500
        while count > 1 do
            SetControlNormal(0,86,1.0)
            Wait(1)
            count = count - 1
        end
        StartVehicleHorn(vehicle, 4000, "HELDDOWN", true)
    end
    cb(true)
end)

RegisterNUICallback('SetWheelColor', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    local pearlcent,wheel = GetVehicleExtraColours(vehicle)
	SetVehicleExtraColours(vehicle,pearlcent,data.index)
    cb(true)
end)

RegisterNUICallback('SetExtra', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    if IsVehicleExtraTurnedOn(vehicle,tonumber(data.index)) then
        SetVehicleExtra(vehicle,tonumber(data.index),1)
    else
        SetVehicleExtra(vehicle,tonumber(data.index),0)
    end
    cb(true)
end)

RegisterNUICallback('SetCustomEngine', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    if not GetHandlingfromModel(GetEntityModel(vehicle),vehicle) then
        addCustomHandling(vehicle)
    end
    SetVehicleEngine(vehicle,data.engine)
    cb(true)
end)

RegisterNUICallback('SetCustomTurbo', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetVehicleTurbo(vehicle,data.turbo)
    cb(true)
end)

RegisterNUICallback('SetCustomTireType', function(data, cb)
    local vehicle = GetVehiclePedIsIn(PlayerPedId())
    if vehicle == 0 then
        vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    end
    SetVehicleTireType(vehicle,data.tire)
    cb(true)
end)