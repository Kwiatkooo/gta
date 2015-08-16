gang_war = {}
gang_war.played = false

gang_war.team = {
	createTeam("Grove",255,255,255),
	createTeam("Ballas",255,255,255),
}
setTeamFriendlyFire(gang_war.team[1],true)
setTeamFriendlyFire(gang_war.team[2],true)

gang_war.players = {[1] = {},[2] = {}}

gang_war.plr_oldcolor = {}
gang_war.plr_oldskin = {}

gang_war.maxplayers = 20
gang_war.minplayers = 3
gang_war.timers = {}
gang_war.currentMap = nil

gang_war.maps = {
	{ -- wg-strike.map
		dimension = 2002,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{-78.89453125,2045.42578125,19.314060211182},
				{-86.2109375,2046.6103515625,19.036540985107},
				{-81.306640625,2051.0009765625,18.270210266113},
				{-117.224609375,2068.357421875,17.447414398193},
				{-116.2998046875,2064.9833984375,17.4453125},
				{-115.0419921875,2046.7294921875,19.503993988037},
				{-109.353515625,2041.203125,20.096855163574},
				{-105.109375,2040.2275390625,20.041030883789},
				{-98.7822265625,2045.7939453125,18.992511749268},
				{-95.068359375,2039.396484375,20.168884277344},
			},
			["Ballas"] = {
				{45.2802734375,2043.1865234375,17.684522628784},
				{46.798828125,2043.796875,17.690486907959},
				{47.2197265625,2044.9755859375,17.701999664307},
				{46.7265625,2046.66015625,17.718454360962},
				{45.0693359375,2049.333984375,17.74457359314},
				{45.7744140625,2051.33984375,17.764169692993},
				{45.3427734375,2052.81640625,17.778593063354},
				{44.90234375,2054.3193359375,17.793270111084},
				{47.283203125,2051.8857421875,17.769498825073},
				{48.701171875,2050.3232421875,17.754234313965},
			},
		},
	},
	
	
	{ -- wg-aim_map.map
		dimension = 2001,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{3035.5512695313,-1916.4304199219,1.8639297485352},
				{3035.1860351563,-1918.3024902344,1.8751528263092},
				{3035.1586914063,-1919.1735839844,1.8781280517578},
				{3033.0444335938,-1917.5261230469,1.9064917564392},
				{3035.7729492188,-1951.8366699219,1.9837679862976},
				{3035.9204101563,-1953.2575683594,1.9847693443298},
				{3036.0522460938,-1954.8278808594,1.9864065647125},
				{3034.1928710938,-1953.0935058594,1.9926862716675},
				{3033.5786132813,-1954.2067871094,2.0055959224701},
				{3031.9165039063,-1953.3659667969,2.0292272567749},
			},
			["Ballas"] = {
				{3105.755859375,-1958.1669921875,1.8064846992493},
				{3105.5791015625,-1956.8857421875,1.8075532913208},
				{3105.4658203125,-1955.677734375,1.8093845844269},
				{3105.478515625,-1954.7109375,1.8124871253967},
				{3106.8828125,-1956.314453125,1.8297176361084},
				{3104.439453125,-1922.6923828125,1.9105627536774},
				{3104.439453125,-1921.3857421875,1.9138498306274},
				{3104.251953125,-1920.5078125,1.9129250049591},
				{3104.3095703125,-1919.546875,1.9163055419922},
				{3105.7275390625,-1920.89453125,1.936580657959},
			},
		},
	},
	
	
	{ -- wg-qwerty.map
		dimension = 2003,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{-4.921875,2057.240234375,17.75080871582},
				{-3.0146484375,2057.5029296875,17.736724853516},
				{-1.5,2058.0654296875,17.698463439941},
				{-1.7275390625,2059.369140625,17.597797393799},
				{-3.4970703125,2056.5830078125,17.809341430664},
				{-1.9580078125,2053.904296875,17.810598373413},
				{-4.12109375,2052.841796875,17.801010131836},
				{-2.65234375,2051.2734375,17.784591674805},
				{-4.755859375,2050.2333984375,17.775211334229},
				{-3.099609375,2048.2431640625,17.754472732544},
			},
			["Ballas"] = {
				{104.1103515625,2021.048828125,18.464296340942},
				{105.5087890625,2020.62890625,18.514163970947},
				{107.0888671875,2020.77734375,18.570543289185},
				{107.546875,2018.552734375,18.586862564087},
				{106.1494140625,2018.173828125,18.537033081055},
				{104.3857421875,2018.0078125,18.474092483521},
				{104.3115234375,2016.1162109375,18.47146987915},
				{105.6767578125,2016.001953125,18.520149230957},
				{107.1083984375,2016.13671875,18.571231842041},
				{105.6806640625,2013.951171875,18.548336029053},
			},
		},
	},
	
	
	{ -- wg-sand.map
		dimension = 2004,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{-18.916015625,2069.10546875,17.4453125},
				{-16.0966796875,2070.34765625,17.4921875},
				{-13.6064453125,2069.5419921875,17.4921875},
				{-9.1787109375,2069.4306640625,17.4921875},
				{-11.830078125,2071.017578125,17.4921875},
				{-11.8037109375,2066.578125,17.4921875},
				{-9.150390625,2064.8369140625,17.4921875},
				{-7.185546875,2066.7490234375,17.447860717773},
				{-14.5126953125,2063.29296875,17.4921875},
				{-18.7041015625,2062.21484375,17.4453125},
			},
			["Ballas"] = {
				{62.21875,1979.640625,17.640625},
				{62.7451171875,1977.6923828125,17.640625},
				{63.1650390625,1976.0205078125,17.640625},
				{62.5908203125,1974.6533203125,17.640625},
				{58.3935546875,1976.46875,17.640625},
				{58.775390625,1978.4619140625,17.640625},
				{57.8662109375,1980.896484375,17.640625},
				{59.4521484375,1983.806640625,17.640625},
				{62.3662109375,1989.419921875,17.640625},
				{62.80078125,1991.5439453125,17.640625},
			},
		},
	},
	
	
	{ -- wg-ubuntu.map
		dimension = 2005,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{80.029296875,1980.1494140625,17.640625},
				{78.365234375,1980.978515625,17.640625},
				{76.5146484375,1980.685546875,17.640625},
				{75.666015625,1982.708984375,17.640625},
				{73.7431640625,1982.3935546875,17.640625},
				{72.548828125,1982.0400390625,17.640625},
				{71.8740234375,1980.818359375,17.640625},
				{70.19921875,1980.0751953125,17.640625},
				{67.94921875,1980.7978515625,17.640625},
				{65.408203125,1980.6279296875,17.640625},
			},
			["Ballas"] = {
				{51.6689453125,1873.876953125,17.640625},
				{52.69921875,1874.1513671875,17.640625},
				{54.0517578125,1874.189453125,17.640625},
				{55.171875,1874.220703125,17.640625},
				{56.6220703125,1874.2626953125,17.640625},
				{57.5146484375,1874.2880859375,17.640625},
				{58.404296875,1874.3134765625,17.640625},
				{59.302734375,1873.9296875,17.647617340088},
				{60.546875,1873.9658203125,17.647617340088},
				{61.8017578125,1874.0009765625,17.647617340088},
			},
		},
	},
	
	
	{ -- wg-mini-strike.map
		dimension = 2006,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{111.677734375,2003.08203125,18.92993927002},
				{111.521484375,2004.04296875,18.908893585205},
				{112.2001953125,2005.35546875,18.91047668457},
				{112.294921875,2006.359375,18.897230148315},
				{112.3388671875,2006.8271484375,18.891063690186},
				{112.4130859375,2007.625,18.88055229187},
				{112.50390625,2008.5888671875,18.867835998535},
				{112.6005859375,2009.6220703125,18.8542137146},
				{112.755859375,2011.2724609375,18.832454681396},
				{112.9296875,2013.125,18.808029174805},
			},
			["Ballas"] = {
				{21.658203125,2015.107421875,17.640625},
				{21.4033203125,2013.494140625,17.640625},
				{21.681640625,2012.501953125,17.640625},
				{19.921875,2011.740234375,17.640625},
				{19.173828125,2009.6298828125,17.640625},
				{19.763671875,2008.4189453125,17.640625},
				{21.8623046875,2007.8017578125,17.640625},
				{21.8916015625,2006.63671875,17.640625},
				{21.11328125,2006.220703125,17.640625},
				{20.9912109375,2004.72265625,17.640625},
			},
		},
	},
	
	
	{ -- wg-eagle.map
		dimension = 2007,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{1119.4921875,1346.2314453125,10.8203125},
				{1122.4287109375,1345.4384765625,10.8203125},
				{1125.1123046875,1346.0654296875,10.8203125},
				{1128.51171875,1345.29296875,10.8203125},
				{1129.8984375,1343.083984375,10.8203125},
				{1129.0263671875,1349.3232421875,10.8203125},
				{1126.20703125,1351.4404296875,10.8203125},
				{1123.2265625,1351.314453125,10.8203125},
				{1119.5087890625,1351.158203125,10.8203125},
				{1119.3720703125,1348.6572265625,10.8203125},
			},
			["Ballas"] = {
				{1161.6904296875,1214.474609375,10.8203125},
				{1161.859375,1212.6357421875,10.8203125},
				{1163.3427734375,1210.7255859375,10.8203125},
				{1165.9501953125,1209.3076171875,10.8203125},
				{1168.6904296875,1209.7275390625,10.8203125},
				{1171.291015625,1209.9375,10.8203125},
				{1173.7001953125,1211.4814453125,10.812517166138},
				{1174.5830078125,1214.4541015625,10.812517166138},
				{1172.1865234375,1215.87109375,10.812517166138},
				{1169.341796875,1215.626953125,10.8203125},
			},
		},
	},
	
	
	{ -- wg-wars.map
		dimension = 2008,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{-1275.0048828125,-218.5419921875,14.1484375},
				{-1273.169921875,-218.6630859375,14.1484375},
				{-1271.3076171875,-221.0361328125,14.1484375},
				{-1276.0302734375,-221.5166015625,14.1484375},
				{-1279.1201171875,-221.1669921875,14.1484375},
				{-1279.9228515625,-223.8759765625,14.1484375},
				{-1277.6416015625,-224.7890625,14.1484375},
				{-1276.12109375,-226.974609375,14.1484375},
				{-1276.876953125,-229.3134765625,14.1484375},
				{-1271.0166015625,-227.5830078125,14.1484375},
			},
			["Ballas"] = {
				{-1258.5439453125,-107.0732421875,14.1484375},
				{-1256.7236328125,-104.767578125,14.1484375},
				{-1255.013671875,-103.4521484375,14.1484375},
				{-1253.517578125,-102.5498046875,14.1484375},
				{-1252.095703125,-101.6923828125,14.1484375},
				{-1249.6513671875,-102.029296875,14.1484375},
				{-1248.2900390625,-103.8115234375,14.1484375},
				{-1249.0478515625,-104.5537109375,14.1484375},
				{-1251.150390625,-105.8212890625,14.1484375},
				{-1253.3662109375,-107.1572265625,14.1484375},
			},
		},
	},
	
	
	{ -- wg-motor.map
		dimension = 2009,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{1161.1240234375,1216.345703125,10.8203125},
				{1162.984375,1215.990234375,10.8203125},
				{1166.0380859375,1215.658203125,10.8203125},
				{1168.515625,1216.583984375,10.8203125},
				{1171.396484375,1216.6728515625,10.8203125},
				{1174.44140625,1219.642578125,10.8203125},
				{1171.857421875,1214.126953125,10.812517166138},
				{1170.4609375,1213.5380859375,10.812517166138},
				{1167.810546875,1212.548828125,10.8203125},
				{1164.7255859375,1212.1279296875,10.8203125},
			},
			["Ballas"] = {
				{1100.318359375,1300.7919921875,10.8203125},
				{1102.3291015625,1300.9326171875,10.8203125},
				{1104.40625,1300.8232421875,10.8203125},
				{1106.876953125,1300.693359375,10.8203125},
				{1109.0693359375,1300.578125,10.8203125},
				{1109.1494140625,1297.51953125,10.8203125},
				{1107.015625,1297.3896484375,10.8203125},
				{1105.0029296875,1297.744140625,10.8203125},
				{1102.7705078125,1296.9365234375,10.8203125},
				{1100.1220703125,1296.5791015625,10.8203125},
			},
		},
	},
	
	
	{ -- wg-linux.map
		dimension = 2010,
		interior = 0,
		spawnpoints = {
			["Grove"] = {
				{58.818359375,1925.716796875,17.640625},
				{56.8046875,1926.6630859375,17.640625},
				{56.7216796875,1924.478515625,17.640625},
				{56.490234375,1921.70703125,17.640625},
				{53.9482421875,1919.4951171875,17.640625},
				{52.4072265625,1916.2158203125,17.640625},
				{50.005859375,1917.083984375,17.640625},
				{46.2099609375,1917.73828125,17.640625},
				{43.2060546875,1914.86328125,17.640625},
				{38.345703125,1917.1865234375,17.640625},
			},
			["Ballas"] = {
				{30.55859375,2041.8115234375,17.671092987061},
				{30.0859375,2044.1884765625,17.694316864014},
				{30.244140625,2046.927734375,17.721067428589},
				{30.3837890625,2049.333984375,17.744594573975},
				{33.328125,2048.94921875,17.74081993103},
				{36.689453125,2048.2607421875,17.734092712402},
				{39.7021484375,2048.0869140625,17.732395172119},
				{42.74609375,2047.9111328125,17.730682373047},
				{45.49609375,2044.9482421875,17.701740264893},
				{40.009765625,2044.298828125,17.695388793945},
			},
		},
	},
}

addCommandHandler("wginfo",
function(p,_)
    if gang_war.played == true then
		local grovePlayers = getPlayersInTeam(gang_war.team[1])
		local ballasPlayers = getPlayersInTeam(gang_war.team[2])
	    outputChatBox("● INFO: Gracze na Wojnie gangów("..#grovePlayers + #ballasPlayers.."):",p,0,255,255)
		for i,v in pairs(grovePlayers) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
		for i,v in pairs(ballasPlayers) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
	end
end)

addCommandHandler("wg",
function(p,_)
    if getElementData(p,"pCommands") == false or getPlayerTeam(p) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p)
		return
	end
    if gang_war.played == false then
    	local playerTeam = getPlayerTeam(p)
		if playerTeam ~= gang_war.team[1] and playerTeam ~= gang_war.team[2] then
	    	if countPlayersInTeam(gang_war.team[1]) + countPlayersInTeam(gang_war.team[2]) ~= gang_war.maxplayers then
			    setPlayerGangWarTeam(p)
				outputChatBox("● INFO: Zapisałeś(aś) się na Wojnę gangów.",p,255,165,0,true)
				if countPlayersInTeam(gang_war.team[1]) + countPlayersInTeam(gang_war.team[2]) > gang_war.minplayers then
				    if not gang_war.timers[1] then
	    			    gang_war.timers[1] = setTimer(gangWarPreStart,15000,1)
					    outputChatBox("● INFO: Wojna gangów rozpocznie się za 15 sekund.",root,255,165,0,true)
					end
				end
            else
		        outputChatBox("● INFO: Na wojnę gangów zapisała się już maksymalna ilość graczy.",p,255,0,0,true)
			end
		else
			outputChatBox("● INFO: Zapisałeś(aś) się już na Wojnę gangów.",p,255,0,0,true)
		end
	else
		outputChatBox("● INFO: Wojna gangów aktualnie trwa i nie możesz się teraz zapisać.",p,255,0,0,true)
	end
end)

function setPlayerGangWarTeam(plr)
	local grove_count = countPlayersInTeam(gang_war.team[1])
	local ballas_count = countPlayersInTeam(gang_war.team[2])
	if grove_count == ballas_count then setPlayerTeam(plr,gang_war.team[math.random(1,2)]) return end
	if grove_count > ballas_count then setPlayerTeam(plr,gang_war.team[2]) return end
	if grove_count < ballas_count then setPlayerTeam(plr,gang_war.team[1]) return end
end

function gangWarPreStart()
    if countPlayersInTeam(gang_war.team[1]) + countPlayersInTeam(gang_war.team[2]) > gang_war.minplayers then
	    gang_war.played = true
		local randomMap = math.random(1,#gang_war.maps)
		gang_war.currentMap = randomMap
		
		--[[if gang_war.currentMap == gang_war.currentMap then
			setTimer(gangWarPreStart,50,1)
			return
		end]]
		
	    for i,v in pairs(getPlayersInTeam(gang_war.team[1])) do
		    if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
		    	triggerClientEvent(v,"onClientMiniGamesStart",v)
		    	takeAllWeapons(v)
		    	setElementData(v,"pCommands",false)
				triggerClientEvent(v,"hideGuiElements",v)
				removePedFromVehicle(v)
				removePedJetPack(v)
				local s = gang_war.maps[gang_war.currentMap].spawnpoints["Grove"][math.random(1,#gang_war.maps[gang_war.currentMap].spawnpoints["Grove"])]
				local int = gang_war.maps[gang_war.currentMap].interior
				local dim = gang_war.maps[gang_war.currentMap].dimension
				setElementDimension(v,dim)
				setElementInterior(v,int)
				setElementPosition(v,s[1],s[2],s[3]+1)
				setElementFrozen(v,true)
				gang_war.plr_oldskin[v] = getElementModel(v)
				setElementModel(v,106)
				local r,g,b = getPlayerNametagColor(v)
				gang_war.plr_oldcolor[v] = {r,g,b}
				setPlayerNametagColor(v,0,255,0)
				if serverData.blips[v] then setBlipColor(serverData.blips[v],0,255,0,150) end
			else
			    outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Wojny gangów.",v,255,0,0,true)
				setPlayerTeam(v,nil)
			end
		end
	    for i,v in pairs(getPlayersInTeam(gang_war.team[2])) do
		    if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
		    	triggerClientEvent(v,"onClientMiniGamesStart",v)
		    	takeAllWeapons(v)
		    	setElementData(v,"pCommands",false)
				triggerClientEvent(v,"hideGuiElements",v)
				removePedFromVehicle(v)
				removePedJetPack(v)
				local s = gang_war.maps[gang_war.currentMap].spawnpoints["Ballas"][math.random(1,#gang_war.maps[gang_war.currentMap].spawnpoints["Ballas"])]
				local int = gang_war.maps[gang_war.currentMap].interior
				local dim = gang_war.maps[gang_war.currentMap].dimension
				setElementDimension(v,dim)
				setElementInterior(v,int)
				setElementPosition(v,s[1],s[2],s[3]+1)
				setElementFrozen(v,true)
				gang_war.plr_oldskin[v] = getElementModel(v)
				setElementModel(v,104)
				local r,g,b = getPlayerNametagColor(v)
				gang_war.plr_oldcolor[v] = {r,g,b}
				setPlayerNametagColor(v,130,0,255)
				if serverData.blips[v] then setBlipColor(serverData.blips[v],130,0,255,150) end
			else
			    outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Wojny gangów.",v,255,0,0,true)
				setPlayerTeam(v,nil)
			end
		end
		gang_war.timers[2] = setTimer(gangWarStart,3000,1)
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Wojnę gangów.",root,255,0,0,true)
		gangWarEnd(false)
	end
end

function gangWarStart()
	if countPlayersInTeam(gang_war.team[1]) + countPlayersInTeam(gang_war.team[2]) > gang_war.minplayers then
		for i,v in pairs(getPlayersInTeam(gang_war.team[1])) do
			table.insert(gang_war.players[1],v)
			setElementFrozen(v,false)
			givePlayerGangWarWeapons(v)
			setElementHealth(v,100)
			setPedArmor(v,100)
		end
		for i,v in pairs(getPlayersInTeam(gang_war.team[2])) do
			table.insert(gang_war.players[2],v)
			setElementFrozen(v,false)
			givePlayerGangWarWeapons(v)
			setElementHealth(v,100)
			setPedArmor(v,100)
		end
		gang_war.timers[3] = setTimer(gangWarIdle,3000,0)
		setTeamFriendlyFire(gang_war.team[1],false)
		setTeamFriendlyFire(gang_war.team[2],false)
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Wojnę gangów.",root,255,0,0,true)
		gangWarEnd(false)
	end
end

function givePlayerGangWarWeapons(plr)
	giveWeapon(plr,24,999)
	giveWeapon(plr,31,999)
	giveWeapon(plr,34,999)
	giveWeapon(plr,17,1)
end

function gangWarEnd(nagroda)
    for i,v in pairs(gang_war.timers) do
	    if isTimer(v) then
		    killTimer(v)
		end
	end

	if gang_war.timers[3] then
		if isTimer(gang_war.timers[3]) then
			killTimer(gang_war.timers[3])
		end
		gang_war.timers[3] = nil
	end
	
	if nagroda == true then
	
		local theWinTeam
		if countPlayersInTeam(gang_war.team[1]) == countPlayersInTeam(gang_war.team[2]) then
			outputChatBox("● INFO: Wojna gangów zakończyła się remisem.",root,255,165,0,true)
			theWinTeam = 3
		elseif countPlayersInTeam(gang_war.team[1]) > countPlayersInTeam(gang_war.team[2]) then
			outputChatBox("● INFO: Wojnę gangów wygrała drużyna Grove.",root,255,165,0,true)
			theWinTeam = 1
		elseif countPlayersInTeam(gang_war.team[1]) < countPlayersInTeam(gang_war.team[2]) then
			outputChatBox("● INFO: Wojnę gangów wygrała drużyna Ballas.",root,255,165,0,true)
			theWinTeam = 2
		end
		
		if theWinTeam == 3 then
			--[[for i,v in pairs(gang_war.players[1]) do
				givePlayerMoney(v,12000)
				addPlayerEXP(v,16)
			end
			for i,v in pairs(gang_war.players[2]) do
				givePlayerMoney(v,12000)
				addPlayerEXP(v,16)
			end]]
		end
		if theWinTeam == 2 then
			for i,v in pairs(gang_war.players[2]) do
				givePlayerMoney(v,12000)
				addPlayerEXP(v,16)
			end
		end
		if theWinTeam == 1 then
			for i,v in pairs(gang_war.players[1]) do
				givePlayerMoney(v,12000)
				addPlayerEXP(v,16)
			end
		end
	end
	
	if gang_war.played == true then
		for i,v in pairs(gang_war.players[1]) do
			if isElement(v) then
				local c = gang_war.plr_oldcolor[v]
				setPlayerNametagColor(v,c[1],c[2],c[3])
				if serverData.blips[v] then setBlipColor(serverData.blips[v],c[1],c[2],c[3],150) end
				setElementModel(v,gang_war.plr_oldskin[v])
			end
		end
		for i,v in pairs(gang_war.players[2]) do
			if isElement(v) then
				local c = gang_war.plr_oldcolor[v]
				setPlayerNametagColor(v,c[1],c[2],c[3])
				if serverData.blips[v] then setBlipColor(serverData.blips[v],c[1],c[2],c[3],150) end
				setElementModel(v,gang_war.plr_oldskin[v])
			end
		end
		
		for i,v in pairs(getPlayersInTeam(gang_war.team[1])) do
			triggerClientEvent(v,"Client:ShowSpawnMenu",v)
		end
		for i,v in pairs(getPlayersInTeam(gang_war.team[2])) do
			triggerClientEvent(v,"Client:ShowSpawnMenu",v)
		end
	end
	
	for i,v in pairs(getPlayersInTeam(gang_war.team[1])) do
		setPlayerTeam(v,nil)
	end
	for i,v in pairs(getPlayersInTeam(gang_war.team[2])) do
		setPlayerTeam(v,nil)
	end
	
	gang_war.played = false
	gang_war.timers = {}
	gang_war.players = {[1] = {},[2] = {}}
	gang_war.plr_oldcolor = {}
	gang_war.currentMap = nil
	
	setTeamFriendlyFire(gang_war.team[1],true)
	setTeamFriendlyFire(gang_war.team[2],true)
end

function gangWarIdle()
	if countPlayersInTeam(gang_war.team[1]) == 0 then return gangWarEnd(true) end
	if countPlayersInTeam(gang_war.team[2]) == 0 then return gangWarEnd(true) end
end