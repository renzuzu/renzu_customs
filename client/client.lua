Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(100)
	end

	while PlayerData.job == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		PlayerData = ESX.GetPlayerData()
		Citizen.Wait(111)
	end

	PlayerData = ESX.GetPlayerData()
    Wait(2000)
    for k, v in pairs (Config.Customs) do
        local blip = AddBlipForCoord(v.shopcoord.x, v.shopcoord.y, v.shopcoord.z)
        SetBlipSprite (blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, v.Blips.scale)
        SetBlipColour (blip, v.Blips.color)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName("Mechanic Shop: "..k.."")
        EndTextCommandSetBlipName(blip)
    end
end)

CreateThread(function()
    Wait(500)
    while true do
        for k,v in pairs(Config.Customs) do
            local distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
            if distance < v.radius then
                TriggerEvent('renzu_customs:ingarage',v,k)
                while distance < v.radius do
                    distance = #(GetEntityCoords(PlayerPedId()) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
                    Wait(500)
                end
                TriggerEvent('renzu_popui:closeui')
            else
                insidegarage = false
            end
        end
        Wait(1000)
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
    if Config.UseCustomEngineUpgrade then
        nextgearhash = `SET_VEHICLE_NEXT_GEAR`
        setcurrentgearhash = `SET_VEHICLE_CURRENT_GEAR`
        local jsonf = LoadResourceFile("renzu_customs","handling.min.json")
        vehiclehandling = json.decode(jsonf)
        while true do
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if vehicle ~= 0 and not GetHandlingfromModel(GetEntityModel(vehicle)) then
                addCustomHandling(vehicle)
            end
            for net,model in pairs(netids) do
                if NetworkDoesEntityExistWithNetworkId(net) and IsEntityAVehicle(NetworkGetEntityFromNetworkId(net)) and saved[NetworkGetEntityFromNetworkId(net)] ~= model then
                    saved[NetworkGetEntityFromNetworkId(net)] = model
                    ForceVehicleEngineAudio(NetworkGetEntityFromNetworkId(net), model)
                end
                if NetworkDoesEntityExistWithNetworkId(net) and IsEntityAVehicle(NetworkGetEntityFromNetworkId(net)) and model ~= nil and model ~= 'Default' then
                    if NetworkDoesEntityExistWithNetworkId(net) then
                        SetVehicleHandlingSpec(NetworkGetEntityFromNetworkId(net),model)
                    end
                end
                if not NetworkDoesEntityExistWithNetworkId(net) then
                    saved[NetworkGetEntityFromNetworkId(net)] = nil
                    netids[net] = nil     
                end
            end
            Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    Wait(1000)
    if Config.UseCustomTireUpgrade then
        while true do
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if vehicle ~= 0 and not GetHandlingfromModel(GetEntityModel(vehicle)) then
                addCustomHandling(vehicle)
            end
            if vehicle ~= 0 then
                local plate = GetVehicleNumberPlateText(vehicle)
                if customtire[plate] and customtire ~= 'Default' then
                    local tire = Config.VehicleMod['custom_tires'].list[customtire[plate]]
                    local default = GetHandlingfromModel(GetEntityModel(vehicle))
                    SetVehicleHandlingFloat(vehicle , "CHandlingData", "fLowSpeedTractionLossMult", default.fLowSpeedTractionLossMult * tire.fLowSpeedTractionLossMult  + 0.0) -- self.start burnout less = traction
                    SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionLossMult", default.fTractionLossMult * tire.fTractionLossMult  + 0.0)  -- asphalt mud less = traction
                    SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionCurveMin", default.fTractionCurveMin * tire.fTractionCurveMin  + 0.0) -- accelaration grip
                    SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionCurveMax", default.fTractionCurveMax * tire.fTractionCurveMax  + 0.0) -- cornering grip
                    SetVehicleHandlingFloat(vehicle , "CHandlingData", "fTractionCurveLateral", default.fTractionCurveLateral * tire.fTractionCurveLateral  + 0.0) -- curve lateral grip
                end
            end
            Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    if Config.UseCustomTurboUpgrade then
        while true do
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if vehicle ~= 0 then
                local plate = GetVehicleNumberPlateText(vehicle)
                if customturbo[plate] then
                    local turbo = Config.VehicleMod['custom_turbo'].list[customturbo[plate]]
                    local default = {fDriveInertia = GetVehicleHandlingFloat(vehicle , "CHandlingData","fDriveInertia"), fInitialDriveForce = GetVehicleHandlingFloat(vehicle , "CHandlingData","fInitialDriveForce")}
                    ToggleVehicleMod(vehicle,18,true)
                    local sound = false
                    local soundofnitro = nil
                    local customized = false
                    local boost = 0
                    local oldgear = 1
                    local cd = 0
                    local rpm = GetVehicleCurrentRpm(vehicle)
                    local gear = GetVehicleCurrentGear(vehicle)
                    local maxvol = 0.4
                    while customturbo[plate] ~= nil and customturbo[plate] ~= 'Default' do

                        if sound and not IsControlPressed(1, 32) or IsControlPressed(1, 32) and rpm > 0.8 and oldgear ~= gear then
                            StopSound(soundofnitro)
                            ReleaseSoundId(soundofnitro)
                            sound = false
                            local table = {
                                ['file'] = customturbo[plate],
                                ['volume'] = maxvol * (boost / turbo.Power),
                                ['coord'] = GetEntityCoords(PlayerPedId())
                            }
                            if GetVehicleTurboPressure(vehicle) >= turbo.Power and cd >= 1000 and Config.useturbosound then
                                if Config.turbosoundSync then
                                    TriggerServerEvent('renzu_customs:soundsync',table)
                                else
                                    SendNUIMessage({
                                        type = "playsound",
                                        content = table
                                    })
                                end
                                cd = 0
                            end
                            --SetVehicleHandlingFloat(vehicle , "CHandlingData", "fDriveInertia", tonumber(default.fDriveInertia))
                            --SetVehicleHandlingFloat(vehicle , "CHandlingData", "fInitialDriveForce", tonumber(default.fInitialDriveForce))
                            boost = 0
                            oldgear = gear
                        end
                        if IsControlPressed(0, 32) then
                            if turbo.Torque > boost then
                                boost = boost + 0.01
                            end
                            cd = cd + 10
                            rpm = GetVehicleCurrentRpm(vehicle)
                            gear = GetVehicleCurrentGear(vehicle)
                            SetVehicleTurboPressure(vehicle , boost + turbo.Power * rpm)
                            if GetVehicleTurboPressure(vehicle) >= turbo.Power then
                                --print(GetVehicleTurboPressure(vehicle),(turbo.fDriveInertia * GetVehicleTurboPressure(vehicle)))
                                SetVehicleCheatPowerIncrease(vehicle,turbo.Power * GetVehicleTurboPressure(vehicle))
                                --SetVehicleHandlingFloat(vehicle , "CHandlingData", "fDriveInertia", tonumber(default.fDriveInertia) + (turbo.fDriveInertia * rpm))
                                --SetVehicleHandlingFloat(vehicle , "CHandlingData", "fInitialDriveForce", tonumber(default.fInitialDriveForce) + (turbo.fInitialDriveForce * rpm))
                            end
                            if not sound then
                                soundofnitro = PlaySoundFromEntity(GetSoundId(), "Flare", vehicle , "DLC_HEISTS_BIOLAB_FINALE_SOUNDS", 0, 0)
                                sound = true
                            end
                        else
                            boost = 0
                            vehicle = GetVehiclePedIsIn(PlayerPedId())
                            if customturbo[plate] == 'Default' then
                                break
                            end
                            turbo = Config.VehicleMod['custom_turbo'].list[customturbo[plate]]
                            if vehicle == 0 then
                                break
                            end
                            Wait(500)
                        end
                        Wait(7)
                        customized = true
                    end
                    if customized then
                        --SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),true) , "CHandlingData", "fDriveInertia", tonumber(default.fDriveInertia))
                        --SetVehicleHandlingFloat(GetVehiclePedIsIn(PlayerPedId(),true) , "CHandlingData", "fInitialDriveForce", tonumber(default.fInitialDriveForce))
                        Wait(1000)
                    end
                end
            end
            Wait(100)
        end
    end
end)