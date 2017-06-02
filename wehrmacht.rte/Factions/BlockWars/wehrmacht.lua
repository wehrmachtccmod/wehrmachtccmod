local factionid = "Wehrmacht";
print ("Loading "..factionid)

CF_Factions[#CF_Factions + 1] = factionid
CF_FactionNames[factionid] = "Wehrmacht"
CF_InfantryModules[factionid] = "Wehrmacht.rte";

CF_LightWeaponSets[factionid] = {"MG-08" , "Walther TA-12" , "M-1908" , "Panzerfaust" , "Ps.Kar 43" }
CF_HeavyWeaponSets[factionid] = { "PzB39" , "Panzershreck" , "22mm Luftfaust" , "Uber Laser MKIV" , }
CF_ExplosiveSets[factionid] = {"Model 24" , "Gas Grenade" , "M39"};
CF_ActorSets[factionid] = {"Volks Grenadier" , "Scharfschutze" , "MG-Schutze" , "Sturm Infanterie" , "Fallschirmjager" , "CQB Infantry" , "Rocket Infantry" , "Engineer" };
CF_Probabilities[factionid] = {0.35 , 0.30 , 0.30 , 0.15};

CF_ArmorCrabs[factionid] = nil
CF_ArmorHumans[factionid] = {"Flammenkrieger"}

print ("Load complete "..factionid)