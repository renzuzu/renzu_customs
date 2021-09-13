# renzu_customs
FIVEM - Advanced and Unique Mechanic Tuning
 # Native FEATURE
- Multiple Mechanic Shop (multi job)
- Multiple Mysql library supproted (mysql-async,ghmatti)
- Integrated with renzu_jobs (Mechanic Job Money and upgrade profit shares)
- Support almost all variation of upgrades (Mods, Extras, Liverys, Custom liveries, Paint, RGB Paints and more)
- Built in Vehicle Property Getter and Setter
- Built in Vehicle Repair in Menus
- Deluxe UI
- Support New DLC Tuner Wheels and Drift Tires!
- Many More!

# Optional Custom Feature
- Custom Vehicle Engine Upgrade/Swap (Configurable)
- Custom Turbo Upgrades 3 variation preconfig (RACING,SPORTS,STREET TURBINE) ( Power configurable, with custom BOV sound )
- Custom Vehicle Tires Upgrade DRAG,RACING,SPORTS,STREET (Traction can be configured in config)
# Unique Interaction Upgrade
- Install and Uninstall Vehicle Mods / Parts on the go. (can be seen in demos)
- Vehicle Parts Object will carry/show, if its supported in config (ex. spoiler prop)
- Builtin Inventory System to Store Vehicle Parts.
- Builtin Vehicle Stock Room to get the list of available parts for the vehicles
- Spray Pilox/Paint - Enable you to Manually Paint the vehicle using spray can ( can for now) (Custom RGB Color Supported, can be seen in demos)
# Sample Image:
![image](https://user-images.githubusercontent.com/82306584/133118433-baeaf6a7-1135-4b00-9221-842146b8de52.png)
![image](https://user-images.githubusercontent.com/82306584/132879340-e316f048-22d2-483f-8231-8c0d6fc18a83.png)
![image](https://user-images.githubusercontent.com/82306584/132879532-e440ce6f-4f51-4c65-9109-12018ae47abd.png)
![image](https://user-images.githubusercontent.com/82306584/132879623-8e477481-0e03-4245-86af-69484bafb9ec.png)




# VIDEO DEMO
- https://youtu.be/0qsGi3sDbgk (Main Demo)
- https://youtu.be/1qmDy0HbVcI (Custom Engine Upgrade Sample)
- https://youtu.be/-0Ee6NBQeQY (Custom Turbo Variation)
- https://youtu.be/gX6Dkvg7n7A (Extra Feature Interactive Upgrade)

# Important in config
```
Config.Mysql = 'mysql-async' -- "ghmattisql", "msyql-async"
Config.usePopui = false -- POPUI or Drawmarker Floating Text
Config.showmarker = true -- Drawmarker and FLoating Text
Config.job = 'mechanic' -- job permmision
Config.UseRenzu_jobs = true -- to have a profits for each upgrades
Config.PayoutShare = 0.5 -- 0.5 = 50% (how much profit share)
Config.DefaultProp = 'hei_prop_heist_box' -- default prop when carrying a parts

-- if you want CUSTOM ENGINE UPGRADE ,TURBO and TIRES make sure to true this all
Config.UseCustomTurboUpgrade = true -- use renzu_custom Turbo System -- enable disable custom turbo upgrade
Config.useturbosound = true -- use custom BOV Sound for each turbo
Config.turbosoundSync = true -- true = Server Sync Sound? or false = only the driver can hear it

Config.UseCustomEngineUpgrade = true -- enable disable custom engine upgrade
Config.UseCustomTireUpgrade = true -- enable disable custom tires upgrade

Config.RepairCost = 1500 -- repair cost
```

# Advanced Usage
- SetVehicleProp Exports (setter)
```
  exports.renzu_customs:SetVehicleProp(vehicle, props) = Save Current Vehicle Props (You need this in your current garage to save and restore custom upgrades (turbo,engine,tires)
```
- GetVehicleProperties Exports (getter)
```
  exports.renzu_customs:GetVehicleProperties(vehicle) -- return Current Vehicle Props Similar to ESX GAME VEHICLE PROPS (but this return custom upgrades)
```
- GetVehicleEngine Exports (getter)
```
  exports.renzu_customs:GetVehicleEngine(vehicle) = return current Vehicle Custom Engine
```
- GetVehicleTurbo Exports (getter)
```
  exports.renzu_customs:GetVehicleTurbo(vehicle) = return current Vehicle Turbo Upgrade
```
- SetVehicleTurbo Exports (setter)
```
  exports.renzu_customs:SetVehicleTurbo(vehicle, turbo) = Change Custom Vehicle Turbo Upgrade (entity, (Sports,Street,Racing,Default))
```

- SetVehicleEngine Exports (setter)
```
  exports.renzu_customs:SetVehicleEngine(vehicle, engine) = Change Custom Vehicle Engine Upgrade (entity, (adder,elegy,fmj,Default))
```

- SetVehicleHandlingSpec Exports (setter)
```
  exports.renzu_customs:SetVehicleHandlingSpec(vehicle,model) = Change Current Vehicle Handling (or Copy Other Vehicle Model Handling) (model can be hash or modelname)
```
- GetHandlingfromModel Exports (getter)
```
  exports.renzu_customs:GetHandlingfromModel(model,vehicle) = return the current Vehicle Model Specs
  
  example:
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
```

# Dependency
- ESX (V1 FInal, ESX Legacy) Tested
- QBCORE Framework
- POPUI https://github.com/renzuzu/renzu_popui (Optional) you can used native drawmarker and floating text (config)
- Contextmenu https://github.com/renzuzu/renzu_contextmenu (required in Interaction Menu and stock room , mod inventory)
- Notify https://github.com/renzuzu/renzu_notify (OPTIONAL) You can used other Notification system (edit it yoursel)
- Progressbar https://github.com/renzuzu/renzu_progressbar (OPTIONAL) 
- Renzu_Job https://github.com/renzuzu/renzu_jobs (OPTIONAL for Job money)
- Renzu Garage https://github.com/renzuzu/renzu_garage (OPTIONAL) - If you want the Custom Turbo ,Engine Tires are Saved in Vehicle Properties  / Can be Restored ?

# Disclaimer
- Script is as is, i wont support if you customized and broke it, i wont give a support if you have error because you are missing a important dependencies.
- Its important to install all depencies to test the script, and modify it and change the dependency like notify and others onces its stable for you.
- Read the Config too i have insert a comments for all important parts for you to easily understand the script
- If you need request for enhancement or you found a bug Open a Github Issue
- Support via PM or Github Issues page (prefered)
- Custom Map being used in DEMO is https://forum.cfx.re/t/free-mlo-tuner-auto-shop/4247145 (THANK YOU) @kiiya
