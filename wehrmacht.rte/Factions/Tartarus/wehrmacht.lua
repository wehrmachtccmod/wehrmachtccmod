local factionid = "Wehrmacht";
print ("Loading "..factionid)

CF_Factions[#CF_Factions + 1] = factionid
CF_FactionNames[factionid] = "Wehrmacht"
CF_InfantryModules[factionid] = "Wehrmacht.rte";

CF_LightWeaponSets[factionid] = {"MG-08" , "Walther TA-12" , "M-1908" , "Panzerfaust" , "Ps.Kar 43" , "Kar-98 Sharpshooter" }
CF_HeavyWeaponSets[factionid] = { "PzB39" , "Panzershreck" , "22mm Luftfaust" , "Uber Laser MKIV" , "8cm GrW-34"}
CF_ExplosiveSets[factionid] = {"Model 24" , "Gas Grenade" , "M39"};
CF_ActorSets[factionid] = {"Volks Grenadier" , "Sturm Infanterie" , "Scharfschutze" , "CQB Infantry" , "Fallschirmjager" , "Rocket Infantry" , "MG-Schutze" };
CF_Probabilities[factionid] = {0.35 , 0.30 , 0.30 , 0.15};

CF_ArmorCrabs[factionid] = nil
CF_ArmorHumans[factionid] = {"Flammenkrieger"}

print ("Load complete "..factionid)