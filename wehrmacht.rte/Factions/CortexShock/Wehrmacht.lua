-- Unique Faction ID
local factionid = "Wehrmacht";
print ("Loading "..factionid)

CF_Factions[#CF_Factions + 1] = factionid

-- Faction name	
CF_FactionNames[factionid] = "Wehrmacht";
-- Set true if faction is selectable by player or AI	
CF_FactionPlayable[factionid] = true;

-- Player controlled actor presets [factionid][actornumber][levelnumber]
CF_PlayerActorPresets[factionid] = {}
CF_PlayerActorPresets[factionid][1] = {"Volks Grenadier lvl 1", "Volks Grenadier lvl 5", "Volks Grenadier lvl 3", "Volks Grenadier lvl 4", "Volks Grenadier lvl 5"}
CF_PlayerActorPresets[factionid][2] = {"Volks Officer lvl 1", "Volks Officer lvl 2", "Volks Officer lvl 3", "Volks Officer lvl 4", "Volks Officer lvl 5"}
CF_PlayerActorPresets[factionid][3] = {"Sturm Infanterie lvl 1", "Sturm Infanterie lvl 2", "Sturm Infanterie lvl 3", "Sturm Infanterie lvl 4", "Sturm Infanterie lvl 5"}
CF_PlayerActorPresets[factionid][4] = {"Sturm Infanterie lvl 1", "Sturm Infanterie lvl 2", "Sturm Infanterie lvl 3", "Sturm Infanterie lvl 4", "Sturm Infanterie lvl 5"}
CF_PlayerActorPresets[factionid][5] = {"Fallschirmjager lvl 1", "Fallschirmjager lvl 2", "Fallschirmjager lvl 3", "Fallschirmjager lvl 4", "Fallschirmjager lvl 5"}

-- Modules where player controlled actor presets are defined
CF_PlayerActorModules[factionid] = {}
CF_PlayerActorModules[factionid][1] = {"Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte"}
CF_PlayerActorModules[factionid][2] = {"Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte"}
CF_PlayerActorModules[factionid][3] = {"Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte"}
CF_PlayerActorModules[factionid][4] = {"Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte"}
CF_PlayerActorModules[factionid][5] = {"Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte", "Wehrmacht.rte"}

-- Player character names
CF_PlayerActorNames[factionid] = {"Hans", "Wolfgang", "Wilhelm", "Gunther", "Klaus"}

CF_PlayerActorDescriptions[factionid] = {}
CF_PlayerActorDescriptions[factionid][1] = "Poor Hans, conscripted into the Wehrmacht. He won't last long."
CF_PlayerActorDescriptions[factionid][2] = "The radio operator. Strong follower of the Reich."
CF_PlayerActorDescriptions[factionid][3] = "Wilhelm, visually indistinguishable from Gunther."
CF_PlayerActorDescriptions[factionid][4] = "Ready to serve the Reich in the Second Galactic War."
CF_PlayerActorDescriptions[factionid][5] = "Klaus, a seasoned veteran of Eurogalactic warfare on the Western Quadrant."

-- CSk checks if all these modules are present to enable or disable faction. These modules must
-- include all modules containing weapons, actors etc
CF_RequiredModules[factionid] = {"Wehrmacht.rte", "Undead.rte", "Coalition.rte"}

-- RPG effects tables
-- Those explosive are constantly given for every level of Explosives skill
CF_RPGExplosives[factionid] = {{"Model 24"}, nil, {"S-mine"} , nil, {"Gas Grenade"}}
CF_RPGExplosiveClasses[factionid] = {{"TDExplosive"} , nil, {"TDExplosive"} , nil , {"TDExplosive"}}

-- Define buyable items available for purchase or unlocks
CF_ItmNames[factionid] = {}
CF_ItmPresets[factionid] = {}
CF_ItmModules[factionid] = {}
CF_ItmPrices[factionid] = {}
CF_ItmDescriptions[factionid] = {}
CF_ItmUnlockData[factionid] = {}
CF_ItmClasses[factionid] = {}

local itm;

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Medikit"
CF_ItmPresets[factionid][itm] = "Medikit"
CF_ItmModules[factionid][itm] = "CortexShock.rte"
CF_ItmPrices[factionid][itm] = 25
CF_ItmDescriptions[factionid][itm] = "Brings life to everything with two legs."
CF_ItmUnlockData[factionid][itm] = 50

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Trench Shovel"
CF_ItmPresets[factionid][itm] = "Trench Shovel"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 25
CF_ItmDescriptions[factionid][itm] = "Cheap shovel."
CF_ItmUnlockData[factionid][itm] = 50

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Luger"
CF_ItmPresets[factionid][itm] = "Luger"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 25
CF_ItmDescriptions[factionid][itm] = "Standard 7 round pistol firing 9mm Parabellum projectiles."
CF_ItmUnlockData[factionid][itm] = 100

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Mauser"
CF_ItmPresets[factionid][itm] = "Mauser"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 30
CF_ItmDescriptions[factionid][itm] = "Rapid firing pistol with little stopping power."
CF_ItmUnlockData[factionid][itm] = 120

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Pistole 35(p)"
CF_ItmPresets[factionid][itm] = "Pistole 35(p)"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 40
CF_ItmDescriptions[factionid][itm] = "Firing heavy rounds, this Polish sidearm is reliable, accurate, and deadly."
CF_ItmUnlockData[factionid][itm] = 150

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "MP40"
CF_ItmPresets[factionid][itm] = "MP40"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 60
CF_ItmDescriptions[factionid][itm] = "MP-40 SMG - Cheap, accurate, sturdy."
CF_ItmUnlockData[factionid][itm] = 350

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Kar-98k"
CF_ItmPresets[factionid][itm] = "Kar-98k"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 65
CF_ItmDescriptions[factionid][itm] = "Karabiner - 98 kurz bolt-action rifle, fed from a 5-round stripper clip, excellent for hunting on your opponents!"
CF_ItmUnlockData[factionid][itm] = 350

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Sauer M30"
CF_ItmPresets[factionid][itm] = "Sauer M30"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 65
CF_ItmDescriptions[factionid][itm] = "Double-barelled shotgun with a toggle-able underslung 9.3mm rifle."
CF_ItmUnlockData[factionid][itm] = 400

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "VSG 1-5"
CF_ItmPresets[factionid][itm] = "VSG 1-5"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 35
CF_ItmDescriptions[factionid][itm] = "Extremely cheap, this substitute to a fully automatic assault rifle offers good range and accuracy."
CF_ItmUnlockData[factionid][itm] = 400

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Walther TA-12"
CF_ItmPresets[factionid][itm] = "Walther TA-12"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 100
CF_ItmDescriptions[factionid][itm] = "Semi-automatic 12 gauge shotgun, effective at medium ranges, offering high stopping power. Pellets can be reflected off roofs to damage targets behind low cover."
CF_ItmUnlockData[factionid][itm] = 520

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "StG44"
CF_ItmPresets[factionid][itm] = "StG44"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 80
CF_ItmDescriptions[factionid][itm] = "The first assault rifle to see major deployment, acclaimed the first modern assaukt rifle. High power and accuracy when aimed."
CF_ItmUnlockData[factionid][itm] = 690

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Gewehr 43"
CF_ItmPresets[factionid][itm] = "Gewehr 43"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 85
CF_ItmDescriptions[factionid][itm] = "Semi-automatic sniper rifle with a medium zoom scope. 10 rounds and moderate power at a fair price."
CF_ItmUnlockData[factionid][itm] = 700

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "FG42"
CF_ItmPresets[factionid][itm] = "FG42"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 125
CF_ItmDescriptions[factionid][itm] = "Accurate and deadly. High rate of fire and well made. A weapon to be feared."
CF_ItmUnlockData[factionid][itm] = 820

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "MG-42"
CF_ItmPresets[factionid][itm] = "MG-42"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 120
CF_ItmDescriptions[factionid][itm] = "MG-42 light maachinegun. It's incredible rate of fire is balanced by it's slow reload and inaccuracy. Fed through an 80-round belt."
CF_ItmUnlockData[factionid][itm] = 850

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "Panzerschreck"
CF_ItmPresets[factionid][itm] = "Panzerschreck"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 120
CF_ItmDescriptions[factionid][itm] = "Fires armour-peircing rockets at low accuracy, though with a high damage radius. Cheaply manufactured rockets have a chance to dud."
CF_ItmUnlockData[factionid][itm] = 900

itm = #CF_ItmNames[factionid] + 1
CF_ItmNames[factionid][itm] = "PzB39"
CF_ItmPresets[factionid][itm] = "PzB39"
CF_ItmModules[factionid][itm] = "Wehrmacht.rte"
CF_ItmPrices[factionid][itm] = 140
CF_ItmDescriptions[factionid][itm] = "Six shot semi automatic anti-tank rifle."
CF_ItmUnlockData[factionid][itm] = -1

-- Define enemies fighting against this faction
-- Level 1 enemies and weapons
CF_Weapons[factionid] = {}
CF_WeaponModules[factionid] = {}
CF_Probabilities[factionid] = {}
CF_ExplosiveSets[factionid] = {}
CF_ExplosiveSetModules[factionid] = {}
CF_ActorSets[factionid] = {}
CF_ActorSetModules[factionid] = {}
CF_ArmorCrabs[factionid] = {}
CF_ArmorCrabModules[factionid] = {}
CF_ArmorHumans[factionid] = {}
CF_ArmorHumanModules[factionid] = {}
CF_ArmorHumanWeapons[factionid] = {}
CF_ArmorHumanWeaponModules[factionid] = {}
CF_ArmorPistols[factionid] = {}
CF_ArmorPistolModules[factionid] = {}
CF_ArmorShields[factionid] = {}
CF_ArmorShieldModules[factionid] = {}
CF_Turrets[factionid] = {}
CF_TurretModules[factionid] = {}
CF_TurretOffsetsReplace[factionid] = {}
CF_TurretOffsetsGarrison[factionid] = {}

-- Turrets are mandatory for all levels!!!

-- Probabilities changed!
-- 1. Probability to spawn armored unit
-- 2. Probability to get explosive
-- 3. Probability to get second explosive
CF_Probabilities[factionid][1] = {0, 0.10 , 0};

CF_Weapons[factionid][1] = {"Glock"}
CF_WeaponModules[factionid][1] = {"Ronin.rte"};

CF_ExplosiveSets[factionid][1] = {"Pineapple Grenade"};
CF_ExplosiveSetModules[factionid][1] = {"Ronin.rte"};

CF_ActorSets[factionid][1] = {"Zombie Medium" , "Zombie Thin"};
CF_ActorSetModules[factionid][1] = {"Undead.rte" , "Undead.rte"};

CF_ArmorCrabs[factionid][1] = nil
CF_ArmorCrabModules[factionid][1] = nil

CF_ArmorHumans[factionid][1] = nil
CF_ArmorHumanModules[factionid][1] = nil

CF_ArmorHumanWeapons[factionid][1] = nil
CF_ArmorHumanWeaponModules[factionid][1] = nil

CF_ArmorPistols[factionid][1] = {"Glock"}
CF_ArmorPistolModules[factionid][1] = {"Ronin.rte"}

CF_ArmorShields[factionid][1] = {"Riot Shield"}
CF_ArmorShieldModules[factionid][1] = {"Base.rte"}

CF_Turrets[factionid][1] = {"Gatling Turret"}
CF_TurretModules[factionid][1] = {"Coalition.rte"}

CF_TurretOffsetsReplace[factionid][1] = nil;
CF_TurretOffsetsGarrison[factionid][1] = nil;


-- Level 2 enemies and weapons
CF_Probabilities[factionid][2] = {0, 0.20 , 0};

CF_Weapons[factionid][2] = {"Glock", "Desert Eagle"}
CF_WeaponModules[factionid][2] = {"Ronin.rte", "Ronin.rte"};

CF_ExplosiveSets[factionid][2] = {"Pineapple Grenade"};
CF_ExplosiveSetModules[factionid][2] = {"Ronin.rte"};

CF_ActorSets[factionid][2] = {"Zombie Medium" , "Zombie Thin"};
CF_ActorSetModules[factionid][2] = {"Undead.rte" , "Undead.rte"};

CF_ArmorCrabs[factionid][2] = nil
CF_ArmorCrabModules[factionid][2] = nil

CF_ArmorHumans[factionid][2] = nil
CF_ArmorHumanModules[factionid][2] = nil

CF_ArmorHumanWeapons[factionid][2] = nil
CF_ArmorHumanWeaponModules[factionid][2] = nil

CF_ArmorPistols[factionid][2] = {"Glock"}
CF_ArmorPistolModules[factionid][2] = {"Ronin.rte"}

CF_ArmorShields[factionid][2] = {"Riot Shield"}
CF_ArmorShieldModules[factionid][2] = {"Base.rte"}

CF_Turrets[factionid][2] = nil
CF_TurretModules[factionid][2] = nil

CF_TurretOffsetsReplace[factionid][2] = nil;
CF_TurretOffsetsGarrison[factionid][2] = nil;

-- Level 3 enemies and weapons
CF_Probabilities[factionid][3] = {0, 0.30 , 0.10};

CF_Weapons[factionid][3] = {"Glock", "Desert Eagle", "Peacemaker"}
CF_WeaponModules[factionid][3] = {"Ronin.rte", "Ronin.rte", "Ronin.rte"};

CF_ExplosiveSets[factionid][3] = {"Pineapple Grenade"};
CF_ExplosiveSetModules[factionid][3] = {"Ronin.rte"};

CF_ActorSets[factionid][3] = {"Zombie Medium" , "Zombie Thin"};
CF_ActorSetModules[factionid][3] = {"Undead.rte" , "Undead.rte"};

CF_ArmorCrabs[factionid][3] = nil
CF_ArmorCrabModules[factionid][3] = nil

CF_ArmorHumans[factionid][3] = nil
CF_ArmorHumanModules[factionid][3] = nil

CF_ArmorHumanWeapons[factionid][3] = nil
CF_ArmorHumanWeaponModules[factionid][3] = nil

CF_ArmorPistols[factionid][3] = {"Glock"}
CF_ArmorPistolModules[factionid][3] = {"Ronin.rte"}

CF_ArmorShields[factionid][3] = {"Riot Shield"}
CF_ArmorShieldModules[factionid][3] = {"Base.rte"}

CF_Turrets[factionid][3] = {"Gatling Turret"}
CF_TurretModules[factionid][3] = {"Coalition.rte"}

CF_TurretOffsetsReplace[factionid][3] = nil;
CF_TurretOffsetsGarrison[factionid][3] = nil;

-- Level 4 enemies and weapons
CF_Probabilities[factionid][4] = {0, 0.50 , 0.30};

CF_Weapons[factionid][4] = {"Desert Eagle", "Peacemaker", "Uzi", "Shortgun"}
CF_WeaponModules[factionid][4] = {"Ronin.rte", "Ronin.rte", "Ronin.rte", "Ronin.rte"};

CF_ExplosiveSets[factionid][4] = {"Pineapple Grenade"};
CF_ExplosiveSetModules[factionid][4] = {"Ronin.rte"};

CF_ActorSets[factionid][4] = {"Zombie Medium" , "Zombie Thin"};
CF_ActorSetModules[factionid][4] = {"Undead.rte" , "Undead.rte"};

CF_ArmorCrabs[factionid][4] = nil
CF_ArmorCrabModules[factionid][4] = nil

CF_ArmorHumans[factionid][4] = nil
CF_ArmorHumanModules[factionid][4] = nil

CF_ArmorHumanWeapons[factionid][4] = nil
CF_ArmorHumanWeaponModules[factionid][4] = nil

CF_ArmorPistols[factionid][4] = {"Glock"}
CF_ArmorPistolModules[factionid][4] = {"Ronin.rte"}

CF_ArmorShields[factionid][4] = {"Riot Shield"}
CF_ArmorShieldModules[factionid][4] = {"Base.rte"}

CF_Turrets[factionid][4] = {"Gatling Turret"}
CF_TurretModules[factionid][4] = {"Coalition.rte"}

CF_TurretOffsetsReplace[factionid][4] = nil;
CF_TurretOffsetsGarrison[factionid][4] = nil;

-- Level 5 enemies and weapons
CF_Probabilities[factionid][5] = {0, 0, 0};

CF_Weapons[factionid][5] = {"Uzi", "Shortgun"}
CF_WeaponModules[factionid][5] = {"Ronin.rte", "Ronin.rte"};

CF_ExplosiveSets[factionid][5] = {"Pineapple Grenade"};
CF_ExplosiveSetModules[factionid][5] = {"Ronin.rte"};

CF_ActorSets[factionid][5] = {"Robot 1" , "Robot 2"};
CF_ActorSetModules[factionid][5] = {"Base.rte" , "Base.rte"};

CF_ArmorCrabs[factionid][5] = nil
CF_ArmorCrabModules[factionid][5] = nil

CF_ArmorHumans[factionid][5] = nil
CF_ArmorHumanModules[factionid][5] = nil

CF_ArmorHumanWeapons[factionid][5] = nil
CF_ArmorHumanWeaponModules[factionid][5] = nil

CF_ArmorPistols[factionid][5] = {"Glock"}
CF_ArmorPistolModules[factionid][5] = {"Ronin.rte"}

CF_ArmorShields[factionid][5] = {"Riot Shield"}
CF_ArmorShieldModules[factionid][5] = {"Base.rte"}

CF_Turrets[factionid][5] = {"Gatling Turret"}
CF_TurretModules[factionid][5] = {"Coalition.rte"}

CF_TurretOffsetsReplace[factionid][5] = nil;
CF_TurretOffsetsGarrison[factionid][5] = nil;