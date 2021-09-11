Config = {}
Config.Locale = "en"
-- MAIN CONFIG START
Config.Mysql = 'mysql-async' -- "ghmattisql", "msyql-async"
Config.usePopui = false -- POPUI or Drawmarker Floating Text https://github.com/renzuzu/renzu_popui
Config.showmarker = true -- Drawmarker and FLoating Text
Config.job = 'mechanic' -- job permmision - default permmision level for inventory, stock room and paint menus. (interactive Upgrade)
Config.JobPermissionAll = false -- if this is true only mechanics can access even the upgrade menu (Main Menu)
Config.InteractiveFeature = { -- Enable Disable All Extra Features like: Inventory, Stock Room, Paint Room
	['garage_inventory'] = true,
	['stockroom'] = true,
	['paintmenu'] = true,
}
Config.PlateSpace = true -- is your plate is ABC 123 format
Config.VehicleValuetoFormula = false -- if true we will calculate the final cost for each upgrades from the original value from vehicles.table
Config.VehicleValuePercent = 0.1 -- 0.1 = 10% 0.5 = 50%, 1.0 = 100% (this will be the formula to calculate the total cost for each upgrade)
Config.VehicleValueList = { -- custom cars that are not exist in vehicles table (vehicles pricing are automatic fetched from DB vehicles table by default)
	[1] = {model = 'zentorno', value = 100000},
}
-- Main Config END

-- CUSTOM CONFIG
Config.UseRenzu_jobs = false -- to have a profits for each upgrades https://github.com/renzuzu/renzu_jobs (This Have Crafting Table, Shop, Vehicle Shop, Garage and more Job Needs!)
Config.UseRenzu_progressbar = false -- Use Progressbar while repairing a vehicle and maybe more use case in future update https://github.com/renzuzu/renzu_progressbar
Config.PayoutShare = 0.5 -- 0.5 = 50% (how much profit share)
Config.DefaultProp = 'hei_prop_heist_box' -- default prop when carrying a parts

-- if you want CUSTOM ENGINE UPGRADE ,TURBO and TIRES make sure to true this all
Config.UseCustomTurboUpgrade = false -- use renzu_custom Turbo System -- enable disable custom turbo upgrade
Config.useturbosound = true -- use custom BOV Sound for each turbo
Config.turbosoundSync = true -- true = Server Sync Sound? or false = only the driver can hear it

Config.UseCustomEngineUpgrade = false -- enable disable custom engine upgrade
Config.UseCustomTireUpgrade = false -- enable disable custom tires upgrade

Config.RepairCost = 1500 -- repair cost
-- CUSTOM END

-- FAQ
-- RADIUS = SHOP SIZE in radius
-- STOCK ROOM = COMPLETE LIST OF VEHICLE MOD LIST FOR EA VEHICLES IN AREA
-- PAINTMENU = CUSTOM PAINT MENU (SPRAY)
-- SHOPCOORDS = The main and center of the Shop Area
-- MOD.coord = Upgrade Section ( you can insert multiple )
-- garage_inventory = Custom Inventory for VEHICLE MOD PARTS
-- BLIPS = BLIP info sprite , color and scale.
-- 
Config.Customs = { -- Multiple Shop Start
    ['Bennys'] = { -- Shop id -- Sample bennys (IPL coordinates) Change this to your liking (CHANGE COORDINATES IF CUSTOM BENNYS MAP)
		radius = 30, -- radius for whole shop
		stockroom = vector4(-227.70811462402,-1322.9874267578,30.890409469604,90.902221679688), -- vector 4 why the F is this vector4, x,y,z,w (heading)
		paintmenu = vector3(-228.27142333984,-1333.4058837891,30.89038848877),
		shopcoord = vector4(-212.58630371094,-1325.0119628906,30.89038848877,157.28034973145),
		mod = {
			{coord = vector4(-224.20236206055,-1329.8156738281,30.21583366394,87.278968811035), taken = false},
			{coord = vector4(-213.22569274902,-1331.546875,30.215799331665,356.6969909668), taken = false},
		},
		garage_inventory = vector4(-200.8703918457,-1317.6979980469,31.089340209961,267.89974975586),
		Blips = {sprite = 446, color = 68, scale = 0.8},
    },
	['Custom Garage'] = { -- Shop id -- Custom Map Tuner Garage (2372 Build only, canary and release) IPL and Int https://forum.cfx.re/t/free-mlo-tuner-auto-shop/4247145
		radius = 30, -- radius for whole shop
		stockroom = vector4(818.46160888672,-969.87396240234,26.10876083374,269.27597045898),
		paintmenu = vector3(809.76037597656,-959.36596679688,26.10876083374),
		shopcoord = vector4(818.54309082031,-953.44543457031,26.108730316162,305.57107543945),
		mod = {
			{coord = vector4(823.82153320312,-944.92102050781,25.440004348755,94.50008392334), taken = false},
			{coord = vector4(830.01727294922,-953.10614013672,25.440238952637,97.936683654785), taken = false},
		},
		garage_inventory = vector4(807.99078369141,-979.44848632812,26.308683395386,165.16065979004),
		Blips = {sprite = 446, color = 68, scale = 0.8},
    },
}

-- PAINT COLORS AND INDEX NAME
Config.Metallic = {
    ['Black'] = 0,
    ['Carbon Black'] = 147,
    ['Graphite'] = 1,
    ['Anhracite Black'] = 11,
    ['Black Steel'] = 2,
    ['Dark Steel'] = 3,
    ['Silver'] = 4,
    ['Bluish Silver'] = 5,
    ['Rolled Steel'] = 6,
    ['Shadow Silver'] = 7,
    ['Stone Silver'] = 8,
    ['Midnight Silver'] = 9,
    ['Cast Iron Silver'] = 10,
    ['Red'] = 27,
    ['Torino Red'] = 28,
    ['Formula Red'] = 29,
    ['Lava Red'] = 150,
    ['Blaze Red'] = 30,
    ['Grace Red'] = 31,
    ['Garnet Red'] = 32,
    ['Sunset Red'] = 33,
    ['Cabernet Red'] = 34,
    ['Wine Red'] = 143,
    ['Candy Red'] = 35,
    ['Hot Pink'] = 135,
    ['Pfsiter Pink'] = 137,
    ['Salmon Pink'] = 136,
    ['Sunrise Orange'] = 36,
    ['Orange'] = 38,
    ['Bright Orange'] = 138,
    ['Gold'] = 99,
    ['Bronze'] = 90,
    ['Yellow'] = 88,
    ['Race Yellow'] = 89,
    ['Dew Yellow'] = 91,
    ['Dark Green'] = 49,
    ['Racing Green'] = 50,
    ['Sea Green'] = 51,
    ['Olive Green'] = 52,
    ['Bright Green'] = 53,
    ['Gasoline Green'] = 54,
    ['Lime Green'] = 92,
    ['Midnight Blue'] = 141,
    ['Galaxy Blue'] = 61,
    ['Dark Blue'] = 62,
    ['Saxon Blue'] = 63,
    ['Blue'] = 64,
    ['Mariner Blue'] = 65,
    ['Harbor Blue'] = 66,
    ['Diamond Blue'] = 67,
    ['Surf Blue'] = 68,
    ['Nautical Blue'] = 69,
    ['Racing Blue'] = 73,
    ['Ultra Blue'] = 70,
    ['Light Blue'] = 74,
    ['Chocolate Brown'] = 96,
    ['Bison Brown'] = 101,
    ['Creeen Brown'] = 95,
    ['Feltzer Brown'] = 94,
    ['Maple Brown'] = 97,
    ['Beechwood Brown'] = 103,
    ['Sienna Brown'] = 104,
    ['Saddle Brown'] = 98,
    ['Moss Brown'] = 100,
    ['Woodbeech Brown'] = 102,
    ['Straw Brown'] = 99,
    ['Sandy Brown'] = 105,
    ['Bleached Brown'] = 106,
    ['Schafter Purple'] = 71,
    ['Spinnaker Purple'] = 72,
    ['Midnight Purple'] = 142,
    ['Bright Purple'] = 145,
    ['Cream'] = 107,
    ['Ice White'] = 111,
    ['Frost White'] = 112,
}

Config.Matte = {
    ['Black'] = 12,
    ['Gray'] = 13,
    ['Light Gray'] = 14,
    ['Ice White'] = 131,
    ['Blue'] = 83,
    ['Dark Blue'] = 82,
    ['Midnight Blue'] = 84,
    ['Midnight Purple'] = 149,
    ['Schafter Purple'] = 148,
    ['Red'] = 39,
    ['Dark Red'] = 40,
    ['Orange'] = 41,
    ['Yellow'] = 42,
    ['Lime Green'] = 55,
    ['Green'] = 128,
    ['Forest Green'] = 151,
    ['Foliage Green'] = 155,
    ['Olive Darb'] = 152,
    ['Dark Earth'] = 153,
    ['Desert Tan'] = 154,
}

Config.Metals = {
    ['Brushed Steel'] = 117,
    ['Brushed Black Steel'] = 118,
    ['Brushed Aluminum'] = 119,
    ['Pure Gold'] = 158,
    ['Brushed Gold'] = 159,
}

allcolors = {}
for k,v in pairs(Config.Metallic) do
	allcolors[k] = v
end

for k,v in pairs(Config.Matte) do
	allcolors[k] = v
end

for k,v in pairs(Config.Metals) do
	allcolors[k] = v
end

Config.Crome = {['Crome'] = 120}

-- VEHICLE MODS , you can change parts value / cost here
-- FAQ
-- multicost  = if true cost will multiple the level from the original cost
-- camera angles (you can customize this as i dont have a proper test to perfect the angles yet)
-- type = Menu Main title
-- bone = bone target for camera (obsolete)
-- index = MOD index name
-- cost = the cost of vehicle mod in all lvls (unless multicost)
Config.VehicleMod = {
    ----------Liveries--------
	[48] = {
		label = 'Liveries',
		name = 'liveries',
        index = 48,
		cost = 15000,
		percent_cost = 7,
		bone = 'chassis',
        type = 'Exterior',
		camera = {val = 'front', x = -2.1, y = 0.6,z = 1.1},
	},
	
----------Windows--------
	[46] = {
		label = 'Windows',
		name = 'windows',
        index = 46,
		cost = 15000,
		percent_cost = 2,
		bone = 'window_lf1',
		camera = {val = 'right', x = 0.8, y = 0.8,z = 0.8},
        type = 'Exterior',
	},
	
----------Tank--------
	[45] = {
		label = 'Intercooler',
		name = 'tank',
        index = 45,
		cost = 15000,
		percent_cost = 4,
		bone = 'chassis',
        type = 'Exterior',
		camera = {val = 'front', x = 0.2, y = 0.3,z = 0.1},
	},
	
----------Trim--------
	[44] = {
		label = 'Trim',
		name = 'trim',
        index = 44,
		cost = 15000,
		percent_cost = 2,
		bone = 'boot',
        type = 'cosmetic',
	},
	
----------Aerials--------
	[43] = {
		label = 'Aerials',
		name = 'aerials',
        index = 42,
		cost = 15000,
		percent_cost = 2,
		camera = {val = 'front', x = 0.5, y = 0.6,z = 0.4},
        type = 'cosmetic',
	},

----------Arch cover--------
	[42] = {
		label = 'Arch cover',
		name = 'archcover',
        index = 42,
		cost = 15000,
		percent_cost = 2.5,
		bone = 'engine',
		action = 'openhood',
		action = 'openhood',
        type = 'cosmetic',
	},

----------Struts--------
	[41] = {
		label = 'Struts',
		name = 'struts',
        index = 41,
		cost = 15000,
		percent_cost = 2.5,
		bone = 'engine',
		action = 'openhood',
        type = 'Performance Parts',
	},
	
----------Air filter--------
	[40] = {
		label = 'Air filter',
		name = 'airfilter',
        index = 40,
		cost = 15000,
		percent_cost = 3.5,
		bone = 'engine',
		action = 'openhood',
        type = 'Performance Parts',
	},
	
----------Engine block--------
	[39] = {
		label = 'Engine block',
		name = 'engineblock',
        index = 39,
		cost = 15000,
		percent_cost = 3.5,
		bone = 'engine',
		action = 'openhood',
        type = 'Performance Parts',
	},

----------Hydraulics--------
	[38] = {
		label = 'Hydraulics',
		name = 'hydraulics',
        index = 38,
		cost = 15000,
		percent_cost = 7,
		bone = 'wheel_rf',
        type = 'cosmetic',
	},
	
----------Trunk--------
	[37] = {
		label = 'Trunk',
		name = 'trunk',
        index = 37,
		cost = 15000,
		percent_cost = 4,
        type = 'Exterior',
		bone = 'boot',
        prop = 'imp_prop_impexp_trunk_01a',
	},

----------Speakers--------
	[36] = {
		label = 'Speakers',
		name = 'speakers',
        index = 36,
		cost = 15000,
		percent_cost = 3,
		bone = 'door_dside_f',
        type = 'Interior',
	},

----------Plaques--------
	[35] = {
		label = 'Plaques',
		name = 'plaques',
        index = 35,
		cost = 15000,
		percent_cost = 3,
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
		bone = 'steeseat_dside_fring',
        type = 'Interior',
	},
	
----------Shift leavers--------
	[34] = {
		label = 'Shift leavers',
		name = 'shiftleavers',
        index = 34,
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
		bone = 'steeseat_dside_fring',
		cost = 15000,
		percent_cost = 3,
        type = 'Interior',
	},
	
----------Steeringwheel--------
	[33] = {
		label = 'Steeringwheel',
		name = 'steeringwheel',
        index = 33,
		bone = 'seat_dside_f',
		cost = 15000,
		percent_cost = 3,
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
        type = 'Interior',
	},
	
----------Seats--------
	[32] = {
		label = 'Seats',
		name = 'seats',
        index = 32,
		cost = 15000,
		percent_cost = 5,
        type = 'Interior',
		bone = 'seat_dside_f',
        prop = 'prop_car_seat',
	},
	
----------Door speaker--------
	[31] = {
		label = 'Door speaker',
		name = 'doorspeaker',
        index = 31,
		percent_cost = 3,
		bone = 'door_dside_f',
		cost = 15000,
        type = 'Interior',
	},

----------Dial--------
	[30] = {
		label = 'Dial',
		name = 'dial',
        index = 30,
		cost = 15000,
		percent_cost = 3,
		bone = 'seat_dside_f',
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
        type = 'Interior',
	},
----------Dashboard--------
	[29] = {
		label = 'Dashboard',
		name = 'dashboard',
        index = 29,
		cost = 15000,
		percent_cost = 5,
		bone = 'seat_dside_f',
        type = 'interior',
	},
	
----------Ornaments--------
	[28] = {
		label = 'Ornaments',
		name = 'ornaments',
        index = 28,
		cost = 15000,
		percent_cost = 4,
		bone = 'seat_dside_f',
        type = 'cosmetic',
	},
	
----------Trim--------
	[27] = {
		label = 'Trim',
		name = 'trim',
        index = 27,
		cost = 15000,
		percent_cost = 3,
		bone = 'bumper_f',
        type = 'cosmetic',
	},
	
----------Vanity plates--------
	[26] = {
		label = 'Vanity plates',
		name = 'vanityplates',
        index = 26,
		cost = 15000,
		percent_cost = 2,
		bone = 'exhaust',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
        prop = 'p_num_plate_01',
	},
	
----------Plate holder--------
	[25] = {
		label = 'Plate holder',
		name = 'plateholder',
        index = 25,
		cost = 15000,
		percent_cost = 3,
		bone = 'exhaust',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
	},
---------Back Wheels---------
	[24] = {
		label = 'Back Wheels',
		name = 'backwheels',
        index = 24,
		cost = 15000,
		percent_cost = 4,
        type = 'Wheel Parts',
		bone = 'wheel_lr',
        prop = 'imp_prop_impexp_wheel_03a',
	},
---------Front Wheels---------
	[23] = {
		label = 'Front Wheels',
		name = 'frontwheels',
        index = 23,
		cost = 15000,
		percent_cost = 5,
		bone = 'wheel_rf',
        type = 'Wheel Parts',
        prop = 'imp_prop_impexp_wheel_03a',
		list = {WheelType = {Sport = 0, Muscle = 1, Lowrider = 2, SUV = 3, Offroad = 4,Tuner = 5, BikeWheel = 6, HighEnd = 7 } , WheelColor = allcolors, Accessories = { CustomTire = 1, BulletProof = 1, SmokeColor = 1, DriftTires = 1} } -- BennysWheel = 8, BespokeWheel = 9
	},
---------Headlights---------
	[22] = {
		label = 'Headlights',
		name = 'headlights',
        index = 22,
		cost = 15000,
		percent_cost = 3,
		bone = 'headlight_r',
        type = 'cosmetic',
        prop = 'v_ind_tor_bulkheadlight',
	},
	
----------Turbo---------
	[18] = {
		label = 'Turbo',
		name = 'turbo',
        index = 18,
		cost = 15000,
		percent_cost = 20,
		bone = 'engine',
        type = 'Performance Parts',
		list = {Default = 0, Turbo = 1}
	},
	
-----------Armor-------------
	[16] = {
		label = 'Armor',
		name = 'armor',
        index = 16,
		cost = 15000,
		percent_cost = 25,
		bone = 'bodyshell',
		multicostperlvl = true,
        type = 'Shell',
	},

---------Suspension-----------
	[15] = {
		label = 'Suspension',
		name = 'suspension',
        index = 15,
		cost = 15000,
		percent_cost = 6,
		bone = 'wheel_rf',
		multicostperlvl = true,
        type = 'Performance Parts',
	},
-----------Horn----------
    [14] = {
        label = 'Horn',
		name = 'horn',
        index = 14,
		cost = 15000,
		percent_cost = 3,
		bone = 'bumper_f',
        type = 'cosmetic',
    },
-----------Transmission-------------
    [13] = {
        label = 'Transmission',
		name = 'transmission',
        index = 13,
		cost = 15000,
		percent_cost = 8,
		bone = 'engine',
		multicostperlvl = true,
        type = 'Performance Parts',
        prop = 'imp_prop_impexp_gearbox_01',
	},
	
-----------Brakes-------------
	[12] = {
        label = 'Brakes',
		name = 'brakes',
        index = 12,
		cost = 15000,
		percent_cost = 5,
		bone = 'wheel_rf',
		multicostperlvl = true,
        type = 'Performance Parts',
        prop = 'imp_prop_impexp_brake_caliper_01a',
	},
	
------------Engine----------
	[11] = {
        label = 'Engine',
		name = 'engine',
        index = 11,
		cost = 15000,
		percent_cost = 10,
		bone = 'engine',
		action = 'openhood',
		multicostperlvl = true,
        type = 'Performance Parts',
        prop = 'prop_car_engine_01',
	},
    ---------Roof----------
	[10] = {
		label = 'Roof',
		name = 'roof',
        index = 10,
		cost = 15000,
		percent_cost = 5,
		bone = 'roof',
		camera = {val = 'front-top', x = 0.5, y = -2.6,z = 1.5},
        type = 'exterior',
	},
	
------------Fenders---------
	[8] = {
		label = 'Fenders',
		name = 'fenders',
        index = 8,
		cost = 15000,
		percent_cost = 5,
        type = 'cosmetic',
		bone = 'wheel_rf',
        prop = 'imp_prop_impexp_car_panel_01a'
	},
	
------------Hood----------
	[7] = {
		label = 'Hood',
		name = 'Hood',
        index = 7,
		cost = 15000,
		percent_cost = 8,
        type = 'cosmetic',
		bone = 'bonnet',
        prop = 'imp_prop_impexp_bonnet_02a',
	},
	
----------Grille----------
	[6] = {
		label = 'Grille',
		name = 'grille',
        index = 6,
		percent_cost = 3,
		cost = 15000,
		bone = 'bumper_f',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
	},
	
----------Roll cage----------
	[5] = {
		label = 'Roll cage',
		name = 'rollcage',
        index = 5,
		cost = 15000,
		percent_cost = 7,
        type = 'interior',
		bone = 'seat_dside_f',
		camera = {val = 'front-top', x = 0.1, y = -1.5,z = 0.5},
        prop = 'imp_prop_impexp_rear_bars_01b'
	},
	
----------Exhaust----------
	[4] = {
		label = 'Exhaust',
		name = 'exhaust',
        index = 4,
		cost = 15000,
		percent_cost = 6,
        type = 'exterior',
		bone = 'exhaust',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 0.4},
        prop = 'imp_prop_impexp_exhaust_01',
	},
	
----------Skirts----------
	[3] = {
		label = 'Skirts',
		name = 'skirts',
        index = 3,
		cost = 15000,
		percent_cost = 3,
		bone = 'neon_r',
        type = 'cosmetic',
        prop = 'imp_prop_impexp_rear_bumper_01a',
	},
	
-----------Rear bumpers----------
	[2] = {
		label = 'Rear bumpers',
		name = 'rearbumpers',
        index = 2,
		cost = 15000,
		percent_cost = 3,
		bone = 'bumper_r',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 0.4},
        type = 'cosmetic',
        prop = 'imp_prop_impexp_rear_bumper_03a',
	},
	
----------Front bumpers----------
	[1] = {
		label = 'Front bumpers',
		name = 'frontbumpers',
        index = 1,
		cost = 15000,
		percent_cost = 4,
		bone = 'bumper_f',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
        prop = 'imp_prop_impexp_front_bumper_01a',
	},
	
----------Spoiler----------
	[0] = {
		label = 'Spoiler',
		name = 'spoiler',
        index = 0,
		cost = 15000,
		percent_cost = 5,
		bone = 'boot',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 1.3},
        type = 'cosmetic',
        prop = 'imp_prop_impexp_spoiler_04a',
	},

	['paint1'] = {
		label = 'Primary Color',
		name = 'paint1',
        index = 99,
		cost = 15000,
		percent_cost = 8,
		bone = 'boot',
        type = 'Primary Color',
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Metallic = Config.Metallic, Matte = Config.Matte, Metals = Config.Metals, Crome = Config.Crome}
	},
	['paint2'] = {
		label = 'Secondary Color',
		name = 'paint2',
        index = 100,
		cost = 15000,
		percent_cost = 5,
		bone = 'boot',
        type = 'Secondary Color',
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Metallic = Config.Metallic, Matte = Config.Matte, Metals = Config.Metals, Crome = Config.Crome}
	},
	['headlight'] = {
		label = 'Headlights',
		name = 'headlight',
        index = 101,
		cost = 15000,
		percent_cost = 3,
		bone = 'boot',
        type = 'Headlights',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Default = false, XenonLights = true, 
		XenonColor = {
				Default = -1,
				White = 0,
				Blue = 1,
				ElectricBlue = 2,
				MintGreen = 3,
				LimeGreen = 4,
				Yellow = 5,
				GoldenShower = 6,
				Orange = 7,
				Red = 8,
				PonyPink = 9,
				HotPink = 10,
				Purple = 11,
			},
		}
	},
	['plate'] = {
		label = 'Plate',
		name = 'plate',
        index = 102,
		cost = 15000,
		percent_cost = 2,
		bone = 'boot',
        type = 'Plate',
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {BlueWhite = 0, YellowBlack = 1, YellowBlue = 2,BlueWhite1 = 3,BlueWhite2 = 4,Yankton = 5}
	},
	['neon'] = {
		label = 'Neon Lights',
		name = 'neon',
        index = 103,
		cost = 15000,
		percent_cost = 3,
		bone = 'boot',
        type = 'Neon Lights',
		camera = {val = 'middle', x = 2.1, y = 2.1,z = -0.1},
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Default = 0, NeonKit = 1, NeonColor = 2}
	},
	['window'] = {
		label = 'Window Tints',
		name = 'window',
        index = 104,
		cost = 15000,
		percent_cost = 5,
        type = 'Window Tints',
		bone = 'boot',
		camera = {val = 'left', x = -0.3, y = -0.3,z = 0.9},
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {  
			None = 0,  
			PURE_BLACK = 1,  
			DARKSMOKE = 2,  
			LIGHTSMOKE = 3,  
			STOCK = 4,  
			LIMO = 5,  
			GREEN = 6  
		}
	},
	['extra'] = {
		label = 'Vehicle Extra',
		name = 'extra',
        index = 105,
		percent_cost = 5,
		cost = 15000,
        type = 'Extras',
		bone = 'boot',
		camera = {val = 'left', x = -0.3, y = -0.3,z = 0.9},
        prop = 'imp_prop_impexp_spoiler_04a',
		--['list'] = {exports = (function() e = exports["cd_keymaster"]:StartKeyMaster() end)},
		['extra'] = function() GetExtras() end
	},

}

-- CUSTOM UPGRADE START
-- Turbo Stats Modification
-- Power = Level of Boost Pressure
-- Torque = Level of Torque to add
-- value = Cost
if Config.UseCustomTurboUpgrade then
	Config.VehicleMod['custom_turbo'] = {
		label = 'Custom Turbo',
		name = 'custom_turbo',
		index = 107,
		cost = 25000,
		percent_cost = 25,
		bone = 'bonnet',
		type = 'Custom Turbo',
		prop = 'imp_prop_impexp_spoiler_04a',
		list = {
			Default = {}, -- needed for uninstall
			Street = {Power = 1.2, Torque = 1.3, value = 25000},
			Sports = {Power = 1.4, Torque = 1.5, value = 55000},
			Racing = {Power = 2.2, Torque = 2.3, value = 125000},
		}
	}
end

-- Engine Stat Modification
-- Adding New Engine is easy
-- ex Elegy = {model = 'elegy', value = 25000},
-- just insert this line from the inside of list = {} (table)
-- Engien upgrades Copy Both Sound and Original Handling (Fmass is excluded and tractions handling) (only related to Vehicle Engine power)
if Config.UseCustomEngineUpgrade then
	Config.VehicleMod['custom_engine'] = {
		label = 'Custom Engine',
		name = 'custom_engine',
		index = 106,
		cost = 25000,
		percent_cost = 30,
		bone = 'bonnet',
		type = 'Custom Engine',
		prop = 'imp_prop_impexp_spoiler_04a',
		list = { -- table
			Default = {}, -- needed for uninstall
			Adder = {model = 'adder', value = 25000},
			FMJ = {model = 'fmj', value = 25000},
			Ruston = {model = 'ruston', value = 25000},
			RT3000 = {model = 'rt3000', value = 25000},
			Stinger = {model = 'stingergt', value = 25000},
		} -- table end
	}
end

-- Custom Tire Modification
-- Preconfigured Variations
-- You can tuned the Spec of the each handling
-- the value for each handling name is Not perfect, but can be used in more use cases and realistic.
if Config.UseCustomTireUpgrade then
	Config.VehicleMod['custom_tires'] = {
		label = 'Custom Tires',
		name = 'custom_tires',
		index = 108,
		cost = 25000,
		percent_cost = 15,
		bone = 'bonnet',
		type = 'Custom Tires',
		prop = 'imp_prop_impexp_spoiler_04a',
		list = {
			Default = {}, -- needed for uninstall
			Street = {fLowSpeedTractionLossMult = 1.1,fTractionLossMult = 1.1,fTractionCurveMin = 1.2, fTractionCurveMax = 1.0, fTractionCurveLateral = 0.8, value = 25000},
			Sports = {fLowSpeedTractionLossMult = 0.9,fTractionLossMult = 0.9,fTractionCurveMin = 1.1, fTractionCurveMax = 1.1, fTractionCurveLateral = 1.1, value = 35000},
			Racing = {fLowSpeedTractionLossMult = 0.65,fTractionLossMult = 0.7,fTractionCurveMin = 1.25, fTractionCurveMax = 1.35, fTractionCurveLateral = 1.25, value = 45000},
			Drag = {fLowSpeedTractionLossMult = 0.1,fTractionLossMult = 0.1,fTractionCurveMin = 2.2, fTractionCurveMax = 0.1, fTractionCurveLateral = 1.1, value = 55000},
		}
	}
end

-- RGB color for Spray Cans
-- do not rename and edit custom
Config.Pilox = {
    ['white'] = {255, 255, 255},
    ['red'] =  {246, 75, 60},
    ['pink'] = {253, 226, 226},
    ['blue'] = {0, 168, 204},
    ['yellow'] = {245, 252, 193},
    ['green'] = {99, 154, 103},
    ['orange'] = {255, 164, 27},
    ['brown'] = {156, 85, 24},
    ['purple'] =  {190, 121, 223},
    ['grey'] = {50, 50, 50},
    ['black'] = {0, 0, 0},
	['custom'] = {0, 0, 0}, -- do not change this is a custom for RGB
}
id = 'A'
cam = nil
gameplaycam = nil
inGarage = false
ingarage = false
garage_coords = {}
shell = nil
ESX = nil
fetchdone = false
PlayerData = {}
playerLoaded = false
canpark = false
spawned_cars = {}
local type = 'car'
newprop = nil
multimenu = {}
openmenu = false
object = nil
saved = {}
control = nil
vehiclesdb = {}
insidegarage = true
private_garages = {}
activeshare = nil
currentprivate = nil
carrymode = false
carrymod = false
tostore = {}
vehicleinarea = {}
spraying = false
customturbo = {}
customengine = {}
netids = {}
customtire = {}
extras = nil
spraycan = nil
custompaint = nil
tospray = false
oldprop = {}
inmark = false
markers = {}
-- disable drift tires if build is not tuner
if GetGameBuildNumber() < 2372 then
	Config.VehicleMod[23]['list'].Accessories.DriftTires = nil
end