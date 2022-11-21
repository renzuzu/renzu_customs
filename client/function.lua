function GetVehicleValue(modelhash)
    local hash = modelhash
    local value = 0
    for k,v in pairs(Config.VehicleValueList) do
        if hash == GetHashKey(v.model) then
            value = v.value
            break
        end
    end
    return tonumber(value)
end

function ShopPermmision(shop,type)
    local type = type
    local shop = shop
    if PlayerData.job == nil then return false end
    if Config.Customs[shop].min_grade == nil then
        Config.Customs[shop].min_grade = Config.DefaultJobGradePermmission
    end
    local perms = Config.Customs[shop] ~= nil and Config.Customs[shop].job == PlayerData.job.name and PlayerData.job.grade >= Config.Customs[shop].min_grade
    if type ~= nil then
        perms = Config.Customs[shop] ~= nil and Config.Customs[shop].job == PlayerData.job.name and Config.Customs[shop] ~= nil and Config.Customs[shop][type] ~= nil and PlayerData.job.grade >= Config.Customs[shop][type].grade
    end
    if type == nil then
        for k,v in pairs(Config.VehicleMod) do
            hasperm = Config.JobPermissionAll and PlayerData ~= nil and v.job_grade ~= nil and v.job_grade[PlayerData.job.name] ~= nil and PlayerData.job.grade >= v.job_grade[PlayerData.job.name]
            or Config.JobPermissionAll and v.job_grade ~= nil and v.job_grade['all'] ~= nil
            if hasperm then perms = true break end
        end
    end
    return perms
end

exports('GetVehicleValue', function(modelhash)
    return GetVehicleValue(modelhash)
end)

function GetPerformanceStats(vehicle)
    local data = {}
    data.brakes = GetVehicleModelMaxBraking(vehicle)
    local handling1 = GetVehicleModelMaxBraking(vehicle)
    local handling2 = GetVehicleModelMaxBrakingMaxMods(vehicle)
    local handling3 = GetVehicleModelMaxTraction(vehicle)
    data.handling = (handling1+handling2) * handling3
    return data
end

local floating = false
local floatcount = 0
function ShowFloatingHelpNotification(m, coords)
    AddTextEntry('FloatingHelpNotifications'..m, m)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('FloatingHelpNotifications'..m)
    EndTextCommandDisplayHelp(2, 0, 0, -1)
end

function SetVehicleProp(vehicle, props)
    -- https://github.com/esx-framework/es_extended/tree/v1-final COPYRIGHT
    if DoesEntityExist(vehicle) then
		local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleModKit(vehicle, 0)
		if props.sound then ForceVehicleEngineAudio(vehicle, props.sound) end
		if props.plate then SetVehicleNumberPlateText(vehicle, props.plate) end
		if props.plateIndex then SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex) end
		if props.bodyHealth then SetVehicleBodyHealth(vehicle, props.bodyHealth + 0.0) end
		if props.engineHealth then SetVehicleEngineHealth(vehicle, props.engineHealth + 0.0) end
		if props.tankHealth then SetVehiclePetrolTankHealth(vehicle, props.tankHealth + 0.0) end
		if props.dirtLevel then SetVehicleDirtLevel(vehicle, props.dirtLevel + 0.0) end
		if props.rgb then SetVehicleCustomPrimaryColour(vehicle, props.rgb[1], props.rgb[2], props.rgb[3]) end
		if props.rgb2 then SetVehicleCustomSecondaryColour(vehicle, props.rgb2[1], props.rgb2[2], props.rgb2[3]) end
		if props.color1 then SetVehicleColours(vehicle, props.color1, colorSecondary) end
		if props.color2 then SetVehicleColours(vehicle, props.color1 or colorPrimary, props.color2) end
		if props.pearlescentColor then SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor) end
		if props.wheelColor then SetVehicleExtraColours(vehicle, props.pearlescentColor or pearlescentColor, props.wheelColor) end
		if props.wheels then SetVehicleWheelType(vehicle, props.wheels) end
		if props.windowTint then SetVehicleWindowTint(vehicle, props.windowTint) end

		if props.neonEnabled then
			SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
			SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
			SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
			SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
		end

		if props.extras then
			for extraId,enabled in pairs(props.extras) do
				if enabled then
					SetVehicleExtra(vehicle, tonumber(extraId), 0)
				else
					SetVehicleExtra(vehicle, tonumber(extraId), 1)
				end
			end
		end

		if props.neonColor then SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3]) end
		if props.xenonColor then SetVehicleXenonLightsColour(vehicle, props.xenonColor) end
		if props.modSmokeEnabled then ToggleVehicleMod(vehicle, 20, true) else ToggleVehicleMod(vehicle, 20, false) end
		if props.tyreSmokeColor then SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3]) end
		if props.modSpoilers then SetVehicleMod(vehicle, 0, props.modSpoilers, false) end
		if props.modFrontBumper then SetVehicleMod(vehicle, 1, props.modFrontBumper, false) end
		if props.modRearBumper then SetVehicleMod(vehicle, 2, props.modRearBumper, false) end
		if props.modSideSkirt then SetVehicleMod(vehicle, 3, props.modSideSkirt, false) end
		if props.modExhaust then SetVehicleMod(vehicle, 4, props.modExhaust, false) end
		if props.modFrame then SetVehicleMod(vehicle, 5, props.modFrame, false) end
		if props.modGrille then SetVehicleMod(vehicle, 6, props.modGrille, false) end
		if props.modHood then SetVehicleMod(vehicle, 7, props.modHood, false) end
		if props.modFender then SetVehicleMod(vehicle, 8, props.modFender, false) end
		if props.modRightFender then SetVehicleMod(vehicle, 9, props.modRightFender, false) end
		if props.modRoof then SetVehicleMod(vehicle, 10, props.modRoof, false) end
		if props.modEngine then SetVehicleMod(vehicle, 11, props.modEngine, false) end
		if props.modBrakes then SetVehicleMod(vehicle, 12, props.modBrakes, false) end
		if props.modTransmission then SetVehicleMod(vehicle, 13, props.modTransmission, false) end
		if props.modHorns then SetVehicleMod(vehicle, 14, props.modHorns, false) end
		if props.modSuspension then SetVehicleMod(vehicle, 15, props.modSuspension, false) end
		if props.modArmor then SetVehicleMod(vehicle, 16, props.modArmor, false) end
		if props.modTurbo then ToggleVehicleMod(vehicle,  18, props.modTurbo) else ToggleVehicleMod(vehicle,  18, false) end
		if props.modXenon then ToggleVehicleMod(vehicle,  22, props.modXenon) else ToggleVehicleMod(vehicle,  22, false) end
		if props.modFrontWheels then SetVehicleMod(vehicle, 23, props.modFrontWheels, false) end
		if props.modBackWheels then SetVehicleMod(vehicle, 24, props.modBackWheels, false) end
		if props.modPlateHolder then SetVehicleMod(vehicle, 25, props.modPlateHolder, false) end
		if props.modVanityPlate then SetVehicleMod(vehicle, 26, props.modVanityPlate, false) end
		if props.modTrimA then SetVehicleMod(vehicle, 27, props.modTrimA, false) end
		if props.modOrnaments then SetVehicleMod(vehicle, 28, props.modOrnaments, false) end
		if props.modDashboard then SetVehicleMod(vehicle, 29, props.modDashboard, false) end
		if props.modDial then SetVehicleMod(vehicle, 30, props.modDial, false) end
		if props.modDoorSpeaker then SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false) end
		if props.modSeats then SetVehicleMod(vehicle, 32, props.modSeats, false) end
		if props.modSteeringWheel then SetVehicleMod(vehicle, 33, props.modSteeringWheel, false) end
		if props.modShifterLeavers then SetVehicleMod(vehicle, 34, props.modShifterLeavers, false) end
		if props.modAPlate then SetVehicleMod(vehicle, 35, props.modAPlate, false) end
		if props.modSpeakers then SetVehicleMod(vehicle, 36, props.modSpeakers, false) end
		if props.modTrunk then SetVehicleMod(vehicle, 37, props.modTrunk, false) end
		if props.modHydrolic then SetVehicleMod(vehicle, 38, props.modHydrolic, false) end
		if props.modEngineBlock then SetVehicleMod(vehicle, 39, props.modEngineBlock, false) end
		if props.modAirFilter then SetVehicleMod(vehicle, 40, props.modAirFilter, false) end
		if props.modStruts then SetVehicleMod(vehicle, 41, props.modStruts, false) end
		if props.modArchCover then SetVehicleMod(vehicle, 42, props.modArchCover, false) end
		if props.modAerials then SetVehicleMod(vehicle, 43, props.modAerials, false) end
		if props.modTrimB then SetVehicleMod(vehicle, 44, props.modTrimB, false) end
		if props.modTank then SetVehicleMod(vehicle, 45, props.modTank, false) end
		if props.modWindows then SetVehicleMod(vehicle, 46, props.modWindows, false) end
		if props.modLivery then
			SetVehicleMod(vehicle, 48, props.modLivery, false)
			SetVehicleLivery(vehicle, props.modLivery)
		end
        if props.fuelLevel then SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0) if DecorGetFloat(vehicle,'_FUEL_LEVEL') then DecorSetFloat(vehicle,'_FUEL_LEVEL',props.fuelLevel + 0.0) end end
        if props.custom_turbo and Config.UseCustomTurboUpgrade then SetVehicleTurbo(vehicle, props.custom_turbo) end
        if props.custom_engine and Config.UseCustomEngineUpgrade then SetVehicleEngine(vehicle, props.custom_engine) end
        if props.custom_tire and Config.UseCustomTireUpgrade then SetVehicleTireType(vehicle, props.custom_tire) end
        if props.drift_tire ~= nil and GetGameBuildNumber() >= 2372 then SetDriftTyresEnabled(vehicle,props.drift_tire or false) end --if this is buggy i will removed this but i think not
	end
end

function GetVehicleTurbo(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    return customturbo[plate] or 'Default'
end

function SetVehicleTurbo(vehicle, turbo)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('renzu_customs:custom_turbo',GetVehicleNumberPlateText(vehicle),turbo)
end

function SetVehicleEngine(vehicle, engine)
    local netid = NetworkGetNetworkIdFromEntity(vehicle)
    TriggerServerEvent('renzu_customs:custom_engine',netid, GetVehicleNumberPlateText(vehicle), engine)
end

function GetVehicleEngine(vehicle)
    for k,v in pairs(netids) do
        if NetworkDoesEntityExistWithNetworkId(k) and IsEntityAVehicle(NetworkGetEntityFromNetworkId(k)) and NetworkGetEntityFromNetworkId(k) == vehicle then
            return v -- return custom vehicle engine name
        end
    end
    return 'Default'
end

function GetVehicleTireType(vehicle)
    local plate = GetVehicleNumberPlateText(vehicle)
    return customtire[plate] or 'Default'
end

function SetVehicleTireType(vehicle, tire)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('renzu_customs:custom_tire',GetVehicleNumberPlateText(vehicle),tire)
end

exports('GetVehicleEngine', function(vehicle)
    return GetVehicleEngine(vehicle)
end)

exports('SetVehicleEngine', function(vehicle, engine)
    return SetVehicleEngine(vehicle, engine)
end)

exports('SetVehicleTurbo', function(vehicle, turbo)
    return SetVehicleTurbo(vehicle, turbo)
end)

exports('GetVehicleTurbo', function(vehicle)
    return GetVehicleTurbo(vehicle)
end)

function GetVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        -- https://github.com/esx-framework/es_extended/tree/v1-final COPYRIGHT
        if DoesEntityExist(vehicle) then
            local colorPrimary, colorSecondary = GetVehicleColours(vehicle)
            local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
            local extras = {}
            for extraId=0, 12 do
                if DoesExtraExist(vehicle, extraId) then
                    local state = IsVehicleExtraTurnedOn(vehicle, extraId) == 1
                    extras[tostring(extraId)] = state
                end
            end
            local plate = GetVehicleNumberPlateText(vehicle)
            if not Config.PlateSpace then
                plate = string.gsub(tostring(GetVehicleNumberPlateText(vehicle)), '^%s*(.-)%s*$', '%1')
            end
            local modlivery = GetVehicleLivery(vehicle)
            if modlivery == -1 or GetVehicleMod(vehicle, 48) ~= -1 then
                modlivery = GetVehicleMod(vehicle, 48)
            end
            return {
                drift_tire        = GetDriftTyresEnabled(vehicle) or false,
                custom_tire       = GetVehicleTireType(vehicle),
                custom_turbo      = GetVehicleTurbo(vehicle),
                custom_engine     = GetVehicleEngine(vehicle),
                model             = GetEntityModel(vehicle),
                plate             = plate,
                plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

                bodyHealth        = MathRound(GetVehicleBodyHealth(vehicle), 1),
                engineHealth      = MathRound(GetVehicleEngineHealth(vehicle), 1),
                tankHealth        = MathRound(GetVehiclePetrolTankHealth(vehicle), 1),

                fuelLevel         = MathRound(GetVehicleFuelLevel(vehicle), 1),
                dirtLevel         = MathRound(GetVehicleDirtLevel(vehicle), 1),
                color1            = colorPrimary,
                color2            = colorSecondary,
                rgb				  = table.pack(GetVehicleCustomPrimaryColour(vehicle)),
                rgb2				  = table.pack(GetVehicleCustomSecondaryColour(vehicle)),
                pearlescentColor  = pearlescentColor,
                wheelColor        = wheelColor,

                wheels            = GetVehicleWheelType(vehicle),
                windowTint        = GetVehicleWindowTint(vehicle),
                xenonColor        = GetVehicleXenonLightsColour(vehicle),

                neonEnabled       = {
                    IsVehicleNeonLightEnabled(vehicle, 0),
                    IsVehicleNeonLightEnabled(vehicle, 1),
                    IsVehicleNeonLightEnabled(vehicle, 2),
                    IsVehicleNeonLightEnabled(vehicle, 3)
                },

                neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
                extras            = extras,
                tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

                modSpoilers       = GetVehicleMod(vehicle, 0),
                modFrontBumper    = GetVehicleMod(vehicle, 1),
                modRearBumper     = GetVehicleMod(vehicle, 2),
                modSideSkirt      = GetVehicleMod(vehicle, 3),
                modExhaust        = GetVehicleMod(vehicle, 4),
                modFrame          = GetVehicleMod(vehicle, 5),
                modGrille         = GetVehicleMod(vehicle, 6),
                modHood           = GetVehicleMod(vehicle, 7),
                modFender         = GetVehicleMod(vehicle, 8),
                modRightFender    = GetVehicleMod(vehicle, 9),
                modRoof           = GetVehicleMod(vehicle, 10),

                modEngine         = GetVehicleMod(vehicle, 11),
                modBrakes         = GetVehicleMod(vehicle, 12),
                modTransmission   = GetVehicleMod(vehicle, 13),
                modHorns          = GetVehicleMod(vehicle, 14),
                modSuspension     = GetVehicleMod(vehicle, 15),
                modArmor          = GetVehicleMod(vehicle, 16),

                modTurbo          = IsToggleModOn(vehicle, 18),
                modSmokeEnabled   = IsToggleModOn(vehicle, 20),
                modXenon          = IsToggleModOn(vehicle, 22),

                modFrontWheels    = GetVehicleMod(vehicle, 23),
                modBackWheels     = GetVehicleMod(vehicle, 24),

                modPlateHolder    = GetVehicleMod(vehicle, 25),
                modVanityPlate    = GetVehicleMod(vehicle, 26),
                modTrimA          = GetVehicleMod(vehicle, 27),
                modOrnaments      = GetVehicleMod(vehicle, 28),
                modDashboard      = GetVehicleMod(vehicle, 29),
                modDial           = GetVehicleMod(vehicle, 30),
                modDoorSpeaker    = GetVehicleMod(vehicle, 31),
                modSeats          = GetVehicleMod(vehicle, 32),
                modSteeringWheel  = GetVehicleMod(vehicle, 33),
                modShifterLeavers = GetVehicleMod(vehicle, 34),
                modAPlate         = GetVehicleMod(vehicle, 35),
                modSpeakers       = GetVehicleMod(vehicle, 36),
                modTrunk          = GetVehicleMod(vehicle, 37),
                modHydrolic       = GetVehicleMod(vehicle, 38),
                modEngineBlock    = GetVehicleMod(vehicle, 39),
                modAirFilter      = GetVehicleMod(vehicle, 40),
                modStruts         = GetVehicleMod(vehicle, 41),
                modArchCover      = GetVehicleMod(vehicle, 42),
                modAerials        = GetVehicleMod(vehicle, 43),
                modTrimB          = GetVehicleMod(vehicle, 44),
                modTank           = GetVehicleMod(vehicle, 45),
                modWindows        = GetVehicleMod(vehicle, 46),
                modLivery         = modlivery
            }
        else
            return
        end
    end
end

exports('SetVehicleProp', function(vehicle,props)
    return SetVehicleProp(vehicle,props)
end)

exports('GetVehicleProperties', function(vehicle)
    return GetVehicleProperties(vehicle)
end)

function GetVehicleUpgrades(vehicle)
    local stats = {}
    props = GetVehicleProperties(vehicle)
    stats.engine = props.modEngine+1
    stats.brakes = props.modBrakes+1
    stats.transmission = props.modTransmission+1
    stats.suspension = props.modSuspension+1
    if props.modTurbo == 1 then
        stats.turbo = 1
    elseif props.modTurbo == false then
        stats.turbo = 0
    end
    return stats
end

function GetVehicleStats(vehicle)
    local data = {}
    data.acceleration = GetVehicleModelAcceleration(GetEntityModel(vehicle))
    data.brakes = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fBrakeForce')
    local fInitialDriveMaxFlatVel = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fInitialDriveMaxFlatVel')
    data.topspeed = math.ceil(fInitialDriveMaxFlatVel * 1.3)
    local fTractionBiasFront = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionBiasFront')
    local fTractionCurveMax = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMax')
    local fTractionCurveMin = GetVehicleHandlingFloat(vehicle, 'CHandlingData', 'fTractionCurveMin')
    data.handling = (fTractionBiasFront + fTractionCurveMax * fTractionCurveMin)
    return data
end

function classlist(class)
    if class == '0' then
        name = 'Compacts'
    elseif class == '1' then
        name = 'Sedans'
    elseif class == '2' then
        name = 'SUV'
    elseif class == '3' then
        name = 'Coupes'
    elseif class == '4' then
        name = 'Muscle'
    elseif class == '5' then
        name = 'Sports Classic'
    elseif class == '6' then
        name = 'Sports'
    elseif class == '7' then
        name = 'Super'
    elseif class == '8' then
        name = 'Motorcycles'
    elseif class == '9' then
        name = 'Offroad'
    elseif class == '10' then
        name = 'Industrial'
    elseif class == '11' then
        name = 'Utility'
    elseif class == '12' then
        name = 'Vans'
    elseif class == '13' then
        name = 'Cycles'
    elseif class == '14' then
        name = 'Boats'
    elseif class == '15' then
        name = 'Helicopters'
    elseif class == '16' then
        name = 'Planes'
    elseif class == '17' then
        name = 'Service'
    elseif class == '18' then
        name = 'Emergency'
    elseif class == '19' then
        name = 'Military'
    elseif class == '20' then
        name = 'Commercial'
    elseif class == '21' then
        name = 'Trains'
    else
        name = 'CAR'
    end
    return name
end

function GetVehicleClassnamemodel(vehicle)
    local class = tostring(GetVehicleClassFromName(vehicle))
    return classlist(class)
end

function GetVehicleClassname(vehicle)
    local class = tostring(GetVehicleClass(vehicle))
    return classlist(class)
end

function GetAllVehicleFromPool()
    local list = {}
    for k,vehicle in pairs(GetGamePool('CVehicle')) do
        table.insert(list, vehicle)
    end
    return list
end

local vhealth = 1000

function SetVehicleStatus(curVehicle)
    myvehlife = GetVehicleEngineHealth(curVehicle)
    if myvehlife < 600 then
        SetVehicleDoorBroken(curVehicle, 0, true)
        SetVehicleDoorBroken(curVehicle, 1, true)
    end
    if myvehlife < 500 then
        SetVehicleDoorBroken(curVehicle, 3, true)
        SetVehicleDoorBroken(curVehicle, 4, true)
        SmashVehicleWindow(curVehicle, 0)
        SmashVehicleWindow(curVehicle, 1)
        SmashVehicleWindow(curVehicle, 2)
        SmashVehicleWindow(curVehicle, 3)
        SmashVehicleWindow(curVehicle, 4)
        SmashVehicleWindow(curVehicle, 7)
    end
    if myvehlife < 400 then
        SetVehicleDoorBroken(curVehicle, 4, true)
        SetVehicleDoorBroken(curVehicle, 5, true)
        SmashVehicleWindow(curVehicle, 8)
        DetachVehicleWindscreen(curVehicle)
        SmashVehicleWindow(curVehicle, 0)
        SetVehicleEnveffScale(curVehicle, 1.0)
        SetVehicleDirtLevel(curVehicle,15.0)
    else
    --SetVehicleDirtLevel(curVehicle,0.0)
    end
    if myvehlife < 300 then
        SetVehicleDoorBroken(curVehicle, 0, true)
        DetachVehicleWindscreen(curVehicle)
        SetVehicleReduceGrip(curVehicle, true)
        SetVehicleReduceTraction(curVehicle, true)
    else
        SetVehicleReduceGrip(curVehicle, false)
        SetVehicleReduceTraction(curVehicle, false)
    end
    if myvehlife < 200 then
        SetVehicleDoorBroken(curVehicle, 0, true)
    end
end

function ReqAndDelete(object, detach)
	if DoesEntityExist(object) then
		NetworkRequestControlOfEntity(object)
		local attempt = 0
		while not NetworkHasControlOfEntity(object) and attempt < 100 and DoesEntityExist(object) do
			NetworkRequestControlOfEntity(object)
			Citizen.Wait(1)
			attempt = attempt + 1
		end
        DetachEntity(object,true,false)
		SetEntityCollision(object, false, false)
		SetEntityAlpha(object, 0.0, true)
		SetEntityAsMissionEntity(object, true, true)
		SetEntityAsNoLongerNeeded(object)
		DeleteEntity(object)
        if DoesEntityExist(object) then
            SetEntityCoords(object,0.0,0.0,0.0)
        end
	end
end

function GetNearestVehicleinPool(coords)
    local data = {}
    data.dist = -1
    data.state = false
    for k,vehicle in pairs(GetGamePool('CVehicle')) do
        local vehcoords = GetEntityCoords(vehicle,false)
        local dist = #(coords-vehcoords)
        if data.dist == -1 or dist < data.dist then
            data.dist = dist
            data.vehicle = vehicle
            data.coords = vehcoords
            data.state = true
        end
    end
    return data
end

function GetClosestPlayer()
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(target, 0)
            local distance = #(targetCoords - plyCoords)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end

    return closestPlayer, closestDistance
end

function SprayParticles(ped,dict,n,vehicle,m)
    local dict = "scr_recartheft"
    local ped = PlayerPedId()
    local fwd = GetEntityForwardVector(ped)
    local coords = GetEntityCoords(ped) + fwd * 0.5 + vector3(0.0, 0.0, -0.5)

    RequestNamedPtfxAsset(dict)
    -- Wait for the particle dictionary to load.
    while not HasNamedPtfxAssetLoaded(dict) do
        Citizen.Wait(0)
    end
    local pointers = {}
    local color = Config.Pilox[n]
    local heading = GetEntityHeading(ped)
    UseParticleFxAssetNextCall(dict)
    SetParticleFxNonLoopedColour(color[1] / 255, color[2] / 255, color[3] / 255)
    SetParticleFxNonLoopedAlpha(1.0)
    local spray = StartNetworkedParticleFxNonLoopedAtCoord("scr_wheel_burnout", coords.x, coords.y, coords.z + 1.5, 0.0, 0.0, heading, 0.7, 0.0, 0.0, 0.0)
end

function DrawMarkerInput(vec,msg,event,server,name,var,u)
    if markers[name] == nil and not Config.usePopui or markers[name] == nil and Config.showmarker and Config.usePopui then
        markers[name] = true
        inmark = true
        CreateThread(function()
            cancel = false
            local ped = PlayerPedId()
            local coord = GetEntityCoords(ped)
            local invehicle = IsPedInAnyVehicle(PlayerPedId())
            local newcarrymode = carrymode
            local newcarrymod = carrymod
            while #(vec - coord) <= 15 and not cancel and inmark do
                Citizen.Wait(5)
                coord = GetEntityCoords(ped)
                if Config.showmarker then
                    DrawMarker(22, vec ,0,0,0,0,0,1.0,1.0,1.0,1.0,255, 255, 220,200,0,0,0,1)
                end
                if invehicle ~= IsPedInAnyVehicle(PlayerPedId()) or carrymode ~= newcarrymode or carrymod ~= newcarrymod then
                    inmark = false
                    markers[name] = nil
                end
                --print(#(vec - coord))
                if not Config.usePopui and #(vec - coord) < 1.5 then
                    ShowFloatingHelpNotification("Press [E] "..msg,vec)
                    if IsControlJustReleased(0,38) then
                        if not server then
                            if u then
                                TriggerEvent(event,table.unpack(var))
                            else
                                TriggerEvent(event,var)
                            end
                        else
                            TriggerServerEvent(event,var)
                        end
                        Wait(100)
                        while #(vec - coord) < 3 and not cancel and inmark do coord = GetEntityCoords(ped) Wait(100) end
                        markers[name] = nil
                        break
                    end
                end
            end
            markers[name] = nil
            return
        end)
    end
end

function PaintCar(n,vehicle)
    local ped = PlayerPedId()
    spraying = true
    custompaint = true
    if n == 'CUSTOM' then
        custompaint = false
        SendNUIMessage({
            custompaint = true,
        })
        SetNuiFocus(true,true)
        while not custompaint do Wait(100) end
    end
    local n = n:lower()
    CreateThread(function()
        local min = 255
        while spraying do
            local sleep = 3000
            min = min - (min/sleep) * 1000
            SprayParticles(ped,dict,n,vehicle,min)
            Wait(3000)
        end
    end)
    while not custompaint do Wait(100) end
    RemoveNamedPtfxAsset(dict)
    while ( not HasAnimDictLoaded( 'anim@amb@business@weed@weed_inspecting_lo_med_hi@' ) ) do
        RequestAnimDict( 'anim@amb@business@weed@weed_inspecting_lo_med_hi@' )
        Citizen.Wait( 1 )
    end
    TaskPlayAnim(ped, 'anim@amb@business@weed@weed_inspecting_lo_med_hi@', 'weed_spraybottle_stand_spraying_01_inspector', 1.0, 1.0, -1, 16, 0, 0, 0, 0 )
    local min = 255
    local r,g,b = table.unpack(Config.Pilox[n])
    local rd,gd,bd = 255,255,255
    TriggerServerEvent('renzu_customs:syncdel',NetworkGetNetworkIdFromEntity(spraycan))
    Wait(100)
    spraycan = CreateObject(GetHashKey('ng_proc_spraycan01b'),0.0, 0.0, 0.0,true, false, false)
    AttachEntityToEntity(spraycan, ped, GetPedBoneIndex(ped, 57005), 0.072, 0.041, -0.06,33.0, 38.0, 0.0, true, true, false, true, 1, true)
    SetModable(vehicle)
    while spraying do
        while rd ~= r or gd ~= g or bd ~= b do
            if rd ~= r then
                rd = rd - 1
            end
            if gd ~= g then
                gd = gd - 1
            end
            if bd ~= b then
                bd = bd - 1
            end
            SetVehicleCustomPrimaryColour(vehicle,rd,gd,bd)
            Wait(100)
        end
        spraying = false
        Wait(100)
    end
    spraying = false
    TriggerServerEvent('renzu_customs:syncdel',NetworkGetNetworkIdFromEntity(spraycan))
    ClearPedTasks(ped)
end

function SetModable(vehicle)
    local attempt = 0
    SetEntityAsMissionEntity(vehicle,true,true)
    NetworkRequestControlOfEntity(vehicle)
    while not NetworkHasControlOfEntity(vehicle) and attempt < 500 and DoesEntityExist(vehicle) do
        NetworkRequestControlOfEntity(vehicle)
        Citizen.Wait(0)
        attempt = attempt + 1
    end
    attempt = 0
    SetVehicleModKit(vehicle, 0)
    while GetVehicleModKit(vehicle) ~= 0 and DoesEntityExist(vehicle) and attempt < 40 do
        Wait(0)
        attempt = attempt + 1
        SetVehicleModKit(vehicle, 0)
    end
end

function CarryMod(dict,anim,prop,flag,hand,pos1,pos2,pos3,pos4,pos5,pos6)
	local ped = PlayerPedId()

	RequestModel(GetHashKey(prop))
	while not HasModelLoaded(GetHashKey(prop)) do
		Citizen.Wait(10)
	end

	if pos1 then
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,false,false)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),pos1,pos2,pos3,pos4,pos5,pos6,true,true,false,true,1,true)
	else
		LoadAnim(dict)
		TaskPlayAnim(ped,dict,anim,3.0,3.0,-1,flag,0,0,0,0)
		local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,0.0,-5.0)
		object = CreateObject(GetHashKey(prop),coords.x,coords.y,coords.z,true,false,false)
		SetEntityCollision(object,false,false)
		AttachEntityToEntity(object,ped,GetPedBoneIndex(ped,hand),0.0,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
	end
end

function LoadAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(10)
	end
end

function addCustomHandling(vehicle)
    if not vehiclehandling then return end
    table.insert(vehiclehandling, {
        VehicleModels = {[1] = GetEntityModel(vehicle)},
        ['DriveInertia'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fDriveInertia")),
        ['InitialDriveGears'] = tonumber(GetVehicleHandlingInt(vehicle , "CHandlingData","nInitialDriveGears")),
        ['InitialDriveForce'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fInitialDriveForce")),
        ['ClutchChangeRateScaleUpShift'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fClutchChangeRateScaleUpShift")),
        ['ClutchChangeRateScaleDownShift'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fClutchChangeRateScaleDownShift")),
        ['InitialDriveMaxFlatVel'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fInitialDriveMaxFlatVel")),
        ['Mass'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fMass")),
        --TIRE
        ['LowSpeedTractionLossMult'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fLowSpeedTractionLossMult")),
        ['TractionLossMult'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fTractionLossMult")),
        ['TractionCurveMin'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fTractionCurveMin")),
        ['TractionCurveMax'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fTractionCurveMax")),
        ['TractionCurveLateral'] = tonumber(GetVehicleHandlingFloat(vehicle , "CHandlingData","fTractionCurveLateral")),
    })
end

function GetHandlingfromModel(model,vehicle)
    if not vehiclehandling then return end
    local default = 'Default'
    local model = model
    if not tonumber(model) and model ~= 'Default' then
        model = GetHashKey(model)
    end
    if model == 'Default' then
        model = GetEntityModel(vehicle)
        default = GetEntityModel(vehicle)
    end
    for k,v in pairs(vehiclehandling) do
        if model ~= default and v.VehicleModels[1] ~= nil and tonumber(v.VehicleModels[1]) and v.VehicleModels[1] == model or model ~= default and v.VehicleModels[1] ~= nil and not tonumber(v.VehicleModels[1]) and GetHashKey(v.VehicleModels[1]:lower()) == model then
            local table = {
                ['fDriveInertia'] = tonumber(v.DriveInertia),
                ['nInitialDriveGears'] = tonumber(v.InitialDriveGears),
                ['fInitialDriveForce'] = tonumber(v.InitialDriveForce),
                ['fClutchChangeRateScaleUpShift'] = tonumber(v.ClutchChangeRateScaleUpShift),
                ['fClutchChangeRateScaleDownShift'] = tonumber(v.ClutchChangeRateScaleDownShift),
                ['fInitialDriveMaxFlatVel'] = tonumber(v.InitialDriveMaxFlatVel),
                ['fMass'] = tonumber(v.Mass),
                --TIRE
                ['fLowSpeedTractionLossMult'] = tonumber(v.LowSpeedTractionLossMult),
                ['fTractionLossMult'] = tonumber(v.TractionLossMult),
                ['fTractionCurveMin'] = tonumber(v.TractionCurveMin),
                ['fTractionCurveMax'] = tonumber(v.TractionCurveMax),
                ['fTractionCurveLateral'] = tonumber(v.TractionCurveLateral),
            }
            return table
        end
        --print(model , default, v.VehicleModels[1] ,model == default and v.VehicleModels[1] ~= nil and not tonumber(v.VehicleModels[1]) and GetHashKey(v.VehicleModels[1]:lower()) == GetEntityModel(vehicle))
        if model == default and v.VehicleModels[1] ~= nil and tonumber(v.VehicleModels[1]) and v.VehicleModels[1] == GetEntityModel(vehicle) or model == default and v.VehicleModels[1] ~= nil and not tonumber(v.VehicleModels[1]) and GetHashKey(v.VehicleModels[1]:lower()) == GetEntityModel(vehicle) then
            local table = {
                ['fDriveInertia'] = tonumber(v.DriveInertia),
                ['nInitialDriveGears'] = tonumber(v.InitialDriveGears),
                ['fInitialDriveForce'] = tonumber(v.InitialDriveForce),
                ['fClutchChangeRateScaleUpShift'] = tonumber(v.ClutchChangeRateScaleUpShift),
                ['fClutchChangeRateScaleDownShift'] = tonumber(v.ClutchChangeRateScaleDownShift),
                ['fInitialDriveMaxFlatVel'] = tonumber(v.InitialDriveMaxFlatVel),
                ['fMass'] = tonumber(v.Mass),
                --TIRE
                ['fLowSpeedTractionLossMult'] = tonumber(v.LowSpeedTractionLossMult),
                ['fTractionLossMult'] = tonumber(v.TractionLossMult),
                ['fTractionCurveMin'] = tonumber(v.TractionCurveMin),
                ['fTractionCurveMax'] = tonumber(v.TractionCurveMax),
                ['fTractionCurveLateral'] = tonumber(v.TractionCurveLateral),
            }
            return table
        end
    end
    return false
end

function SetVehicleHandlingSpec(vehicle,model)
    local handling = GetHandlingfromModel(model,vehicle)
    if not handling then return end
    local getcurrentvehicleweight = GetVehicleHandlingFloat(vehicle , "CHandlingData","fMass")
    local multiplier = 1.001
    multiplier = (handling['fMass'] / getcurrentvehicleweight)
    Wait(10)
    if tonumber(handling['nInitialDriveGears']) > GetVehicleHandlingInt(vehicle , "CHandlingData","nInitialDriveGears") then
        SetVehicleHighGear(vehicle ,tonumber(handling['nInitialDriveGears']) )
    end
    for k,v in pairs(handling) do
        local v = tonumber(v)
        local k = k
        if k == 'nInitialDriveGears' then
            gears = tonumber(v)
            if gears < 6 and tonumber(GetVehicleMod(vehicle ,13)) > 0 then
                gears = tonumber(v) + 1
            end
            SetVehicleHandlingInt(vehicle , "CHandlingData", "nInitialDriveGears", gears)
            SetVehicleHandlingField(vehicle, 'CHandlingData', "nInitialDriveGears", gears)
        elseif k == 'fDriveInertia' then
            if multiplier < 0.8 then
                m = 0.8
            else
                m = multiplier
            end
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fDriveInertia", tonumber(v) * m)
        elseif k == 'fInitialDriveForce' then
            SetVehicleHandlingFloat(vehicle , "CHandlingData", "fInitialDriveForce", tonumber(v) * multiplier)
        elseif k == 'fInitialDriveMaxFlatVel' then
            SetVehicleHandlingField(vehicle , "CHandlingData", "fInitialDriveMaxFlatVel", tonumber(v) * 1.0)
        elseif k ~= 'fMass' then
            SetVehicleHandlingFloat(vehicle , "CHandlingData", tostring(k), tonumber(v) * 1.0)
        end
    end
    SetVehicleEnginePowerMultiplier(vehicle , 1.0) -- needed if maxvel and inertia is change, weird.. this can be call once only to trick the bug, but this is a 1 sec loop it doesnt matter.
end

exports('SetVehicleHandlingSpec', function(vehicle,model)
    return SetVehicleHandlingSpec(vehicle,model)
end)

exports('GetHandlingfromModel', function(model,vehicle)
    return GetHandlingfromModel(model,vehicle)
end)

function ControlCam(val,x,y,z)
    control = val
	SetCamActive(cam, true)
	local entity = GetVehiclePedIsIn(PlayerPedId())
	local dimension = GetModelDimensions(GetEntityModel(entity))
	local l,w,h = dimension.y*-2, dimension.x*-2, dimension.z*-2
	SetCamCoord(cam, CamOption(val,x,y,z,entity,w,l,h))
	PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(entity, 0, 0, 0))
	RenderScriptCams( 1, 1, 1500, 0, 0)
end

function BoneCamera(bone)
    CreateModCam()
	SetCamActive(cam, true)
	local vehicle = GetVehiclePedIsIn(PlayerPedId())
    local boneindex = GetEntityBoneIndexByName(vehicle, bone)
    if boneindex == -1 and bone == 'wheel_rf' then
        bone = 'engine'
    end
	if bone ~= -1 then
		local offset = GetOffsetFromEntityGivenWorldCoords(vehicle, GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, bone)))
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(vehicle, offset.x + 1, offset.y + 1, offset.z +1))
		SetCamCoord(cam, x, y, z)
		PointCamAtCoord(cam,GetOffsetFromEntityInWorldCoords(vehicle, 0, offset.y, offset.z))
		RenderScriptCams( 1, 1, 1100, 0, 0)
	end
end

function numWithCommas(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,")
                                  :gsub(",(%-?)$","%1"):reverse()
end

function GetExtras()
    vehicle = GetVehiclePedIsIn(PlayerPedId())
    extras = {}
    for extraId=0, 12 do
        if DoesExtraExist(vehicle, extraId) then
            extras['Extra - '..tostring(extraId)..''] = tostring(extraId)
        end
    end
end

function CreateModCam()
    SetCamCoord(cam,GetGameplayCamCoords())
	SetCamRot(cam, GetGameplayCamRot(2), 2)
	RenderScriptCams( 0, 1, 1000, 0, 0)
	SetCamActive(gameplaycam, true)
	EnableGameplayCam(true)
	SetCamActive(cam, false)
end

function CamOption(val,x,y,z,entity,w,l,h)
    local view = {
        ['left'] = {-(w/2) + x, y, z},
        ['right'] = {(w/2) + x, y, z},
        ['front'] = {x, (l/2)+ y, z},
        ['front-top'] = {x, (l/2) + y,(h) + z},
        ['back'] = {x, -(l/2) + y,z},
        ['back-top'] = {x, -(l/2) + y,(h/2) + z},
        ['middle'] = {x, y, (h/2) + z},
    }
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(entity, table.unpack(view[val])))
    return x,y,z
end