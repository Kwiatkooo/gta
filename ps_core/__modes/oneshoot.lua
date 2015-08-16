respawnTimer = {}

oneshoot = {}
oneshoot.players = {}
oneshoot.team = createTeam("OneShoot",255,255,255)
oneshoot.weapon = {}
oneshoot.current_map = 15
oneshoot.maps = {
	
	
    [1] = {
	    name = "Posterunek Policji Las Venturas",
	    interior = 3,
		dimension = 134,
	    spawnpoints = {
            {230.80078125,142.2158203125,1003.0234375,323.37377929688},
	        {247.4892578125,143.3291015625,1003.0234375,35.132080078125},
	        {251.8505859375,170.80859375,1003.0234375,5.0510559082031},
	        {299.443359375,172.390625,1007.171875,61.763336181641},
	        {298.27734375,187.9462890625,1007.171875,129.41818237305},
	        {268.16796875,186.412109375,1008.171875,1.5793151855469},
	        {245.8896484375,185.7822265625,1008.171875,354.37216186523},
	        {238.8193359375,195.736328125,1008.171875,269.14443969727},
	        {195.0888671875,157.744140625,1003.0234375,272.87982177734},
	        {230.0859375,179.9345703125,1003.03125,88.015563964844},
		},
	},
	
	
	[2] = {
	    name = "Kasyno Four Dragons",
	    interior = 10,
		dimension = 122,
		spawnpoints = {
		    {1995.3203125,1018.001953125,994.890625,88.526428222656},
			{1976.890625,989.35546875,994.46875,53.430084228516},
			{1943.1552734375,970.8837890625,994.46875,337.6012878418},
			{1930.6533203125,1018.3046875,993.92669677734,271.17694091797},
			{1943.009765625,1064.8671875,994.46875,186.57542419434},
			{1974.619140625,1047.0537109375,994.46875,122.34286499023},
			{1954.705078125,1041.2197265625,992.859375,174.666015625},
			{1943.5517578125,1017.22265625,992.46875,271.80316162109},
			{1939.21875,1049.876953125,992.47448730469,264.54656982422},
			{1938.40625,994.314453125,992.4609375,267.99633789063},
		},
	},
	
	
	[3] = {
	    name = "Bank Las Venturas",
	    interior = 3,
		dimension = 142,
		spawnpoints = {
		    {363.8681640625,173.58203125,1008.3828125,269.32022094727},
			{366.681640625,211.2490234375,1008.3828125,179.10461425781},
			{381.13671875,173.76171875,1008.3828125,89.493255615234},
			{372.0625,173.791015625,1014.1875,87.949645996094},
			{331.1865234375,173.958984375,1014.1875,268.1171875},
			{348.99609375,193.6259765625,1014.1796875,268.1171875},
			{337.86328125,174.0478515625,1019.984375,269.68276977539},
			{361.5205078125,197.0947265625,1019.984375,181.65895080566},
			{347.46875,162.0263671875,1025.7890625,271.90203857422},
			{363.6455078125,168.111328125,1025.7963867188,179.46716308594},
		},
	},
	
	
	[4] = {
	    name = "RC Zero's Battlefield",
	    interior = 10,
		dimension = 162,
		spawnpoints = {
		    {-972.208984375,1082.1416015625,1344.9992675781,111.63104248047},
			{-991.2412109375,1037.609375,1341.9169921875,88.130920410156},
			{-989.828125,1089.443359375,1342.9334716797,139.52026367188},
			{-1022.67578125,1096.0009765625,1342.4305419922,171.79309082031},
			{-1041.0869140625,1025.345703125,1343.3117675781,359.48089599609},
			{-1072.4580078125,1023.6923828125,1343.2198486328,3.2382507324219},
			{-1131.90234375,1038.7216796875,1345.7364501953,279.89471435547},
			{-1133.224609375,1094.57421875,1345.7996826172,248.56121826172},
			{-1112.927734375,1097.6220703125,1341.84375,195.6063079834},
			{-1069.001953125,1098.3427734375,1343.0676269531,183.0707244873},
		},
	},
	
	
	[5] = {
	    name = "JMotel",
	    interior = 15,
		dimension = 35,
		spawnpoints = {
		    {2221.6669921875,-1152.341796875,1025.796875,13.439239501953},
			{2227.2578125,-1141.6572265625,1029.796875,179.48364257813},
			{2241.37890625,-1157.46484375,1029.796875,178.857421875},
			{2240.533203125,-1189.76953125,1033.796875,359.04693603516},
			{2247.91796875,-1182.3818359375,1031.796875,176.05584716797},
			{2237.4765625,-1192.84375,1029.796875,1.2167663574219},
			{2198.1455078125,-1193.3544921875,1029.796875,88.010070800781},
			{2186.537109375,-1181.4541015625,1033.796875,180.73608398438},
			{2187.3818359375,-1182.044921875,1029.796875,265.96383666992},
			{2200.12109375,-1144.64453125,1029.796875,89.240539550781},
		},
	},
	
	
	[6] = {
	    name = "LV Meat Factory",
	    interior = 1,
		dimension = 235,
		spawnpoints = {
		    {962.296875,2149.5576171875,1011.0234375,88.905456542969},
			{963.466796875,2176.427734375,1011.0234375,88.279235839844},
			{954.501953125,2159.080078125,1011.0234375,1.4859313964844},
			{946.4228515625,2174.71875,1011.0234375,179.45617675781},
			{937.1279296875,2171.8037109375,1011.0234375,178.51684570313},
			{935.4580078125,2144.0791015625,1011.0234375,269.07302856445},
			{958.841796875,2109.353515625,1011.0234375,88.279235839844},
			{946.59375,2126.9189453125,1011.0234375,359.60174560547},
			{959.630859375,2142.900390625,1011.0198974609,175.98992919922},
			{959.87890625,2118.8212890625,1011.0234375,358.95355224609},
		},
	},
	
	
	[7] = {
	    name = "LV Stadium",
	    interior = 14,
		dimension = 235,
		spawnpoints = {
		    {-1492.94921875,1560.7763671875,1052.53125,353.92172241211},
			{-1488.1533203125,1636.1572265625,1052.53125,267.44152832031},
			{-1434.0751953125,1650.921875,1052.53125,185.65805053711},
			{-1365.470703125,1637.3759765625,1052.53125,179.39575195313},
			{-1351.4990234375,1606.2236328125,1052.53125,182.84001159668},
			{-1377.392578125,1561.1513671875,1052.53125,2.0462341308594},
			{-1414.3994140625,1564.158203125,1052.53125,90.405120849609},
			{-1429.3017578125,1590.3232421875,1052.53125,270.55068969727},
			{-1432.5224609375,1618.8642578125,1052.53125,89.465789794922},
			{-1391.314453125,1600.3193359375,1052.53125,272.74249267578},
		},
	},
	
	
	[8] = {
	    name = "Stealth:PRO Map #1 Mini-Strike",
	    interior = 0,
		dimension = 1456,
		spawnpoints = {
		    {90.830078125,2027.1435546875,17.990562438965,90.569915771484},
			{66.8935546875,2019.142578125,17.640625,178.30810546875},
			{38.76171875,2027.5576171875,17.640625,265.39254760742},
			{25.44921875,2021.337890625,17.640625,266.95809936523},
			{18.0615234375,2010.5283203125,17.640625,177.65435791016},
			{27.5263671875,1997.1552734375,17.647296905518,265.70565795898},
			{58.2236328125,1987.3388671875,17.640625,270.08926391602},
			{66.3583984375,2002.283203125,17.640625,359.07989501953},
			{94.4736328125,1989.2119140625,18.241495132446,87.729919433594},
			{114.97265625,2008.642578125,18.950805664063,175.77569580078},
		},
	},
	
	
	[9] = {
	    name = "Stealth:PRO Map #2 Aim-Map",
	    interior = 0,
		dimension = 1456,
		spawnpoints = {
		    {3021.7238769531,-1911.1379394531,8.320484161377,180.16479492188},
			{3022.1960449219,-1959.2824707031,8.320484161377,357.8274230957},
			{3033.4018554688,-1953.2360839844,2.0055284500122,268.52368164063},
			{3034.4663085938,-1918.3298339844,1.8865203857422,270.40786743164},
			{3041.1401367188,-1938.7976074219,1.8417339324951,267.8974609375},
			{3052.6079101563,-1965.1657714844,1.7351810932159,272.91278076172},
			{3107.4462890625,-1955.876953125,1.8398566246033,89.949188232422},
			{3105.46875,-1920.8603515625,1.9323410987854,89.949188232422},
			{3116.0302734375,-1910.884765625,8.1204843521118,179.85168457031},
			{3117.6037597656,-1960.28125,8.1204843521118,0.93661499023438},
		},
	},
	
	
	[10] = {
	    name = "Stealth:PRO Map #3 Sand",
	    interior = 0,
		dimension = 157,
		spawnpoints = {
		    {-14.4443359375,2019.2666015625,17.2265625,0.0},
			{20.9228515625,2017.369140625,17.640625,0.0},
			{70.0849609375,2024.3525390625,17.640625,0.0},
			{104.9794921875,2047.9013671875,18.160430908203,0.0},
			{67.646484375,2057.8720703125,17.821239471436,0.0},
			{28.2265625,2057.9423828125,17.831703186035,0.0},
			{-13.2255859375,2063.87890625,17.4921875,0.0},
			{-10.53125,1978.7763671875,17.647296905518,0.0},
			{62.462501525879,1975.3410644531,21.817188262939,0.0},
			{55.6455078125,1999.5380859375,17.640625,0.0},
		},
	},

	
	[11] = {
	    name = "Stealth:PRO Map #4 Eagle",
	    interior = 0,
		dimension = 159,
		spawnpoints = {
		    {1120.6552734375,1351.8388671875,10.8203125,0.0},
		    {1150.45703125,1337.134765625,10.8203125,0.0},
		    {1153.947265625,1288.0625,10.8203125,0.0},
		    {1149.349609375,1268.83984375,10.8203125,0.0},
		    {1168.7861328125,1242.181640625,10.8203125,0.0},
		    {1152.541015625,1213.177734375,10.8203125,0.0},
		    {1132.099609375,1220.173828125,10.8203125,0.0},
		    {1121.173828125,1245.0947265625,10.8203125,0.0},
		    {1106.21484375,1270.412109375,10.8203125,0.0},
		    {1123.2822265625,1294.67578125,10.8203125,0.0},
		},
	},
	
	
	[12] = {
	    name = "Stealth:PRO Map #5 Motor",
	    interior = 0,
		dimension = 160,
		spawnpoints = {
		    {1163.3798828125,1228.5244140625,10.812517166138,0.0},
		    {1108.97265625,1214.5458984375,10.8203125,0.0},
		    {1104.8212890625,1296.2587890625,10.8203125,0.0},
		    {1130.3115234375,1281.0859375,10.8203125,0.0},
		    {1133.7607421875,1296.791015625,10.8203125,0.0},
		    {1154.8310546875,1323.123046875,10.8203125,0.0},
		    {1156.5400390625,1294.9619140625,10.8203125,0.0},
		    {1174.083984375,1279.7841796875,10.8203125,0.0},
		    {1135.9091796875,1316.6416015625,10.8203125,0.0},
		    {1157.486328125,1284.6494140625,10.8203125,0.0},
		},
	},
	
	
	[13] = {
	    name = "Stealth:PRO Map #6 Qwerty",
	    interior = 0,
		dimension = 161,
		spawnpoints = {
		    {-4.3017578125,2057.0732421875,17.765625,0.0},
		    {12.1552734375,2059.185546875,17.668590545654,0.0},
		    {43.4775390625,2043.19140625,17.684574127197,0.0},
		    {58.3818359375,2037.3125,17.640625,0.0},
		    {84.9658203125,2050.7236328125,17.906482696533,0.0},
		    {93.529296875,2016.1787109375,18.099224090576,0.0},
		    {79.703125,2004.0068359375,17.640625,0.0},
		    {105.19140625,2015.765625,18.502847671509,0.0},
		    {57.978515625,2014.8544921875,17.640625,0.0},
		    {7.2490234375,2013.8583984375,17.640625,0.0},
		},
	},
	
	
	[14] = {
	    name = "Stealth:PRO Map #7 Strike",
	    interior = 0,
		dimension = 162,
		spawnpoints = {
		    {-82.3994140625,2042.5205078125,19.819213867188,0.0},
		    {-122.865234375,2067.91015625,17.4453125,0.0},
		    {-60.6474609375,2095.623046875,18.577640533447,0.0},
		    {-11.2900390625,2115.158203125,17.2265625,0.0},
		    {40.1015625,2120.2587890625,17.640625,0.0},
		    {49.88671875,2055.982421875,17.807571411133,0.0},
		    {61.037109375,2017.4521484375,17.640625,0.0},
		    {7.3076171875,2022.5625,17.647296905518,0.0},
		    {-7.6845703125,2042.1357421875,17.694471359253,0.0},
		    {-55.646484375,2017.6259765625,18.099792480469,0.0},
		},
	},
	
	
	[15] = {
	    name = "Stealth:PRO Map #8 Ubuntu",
	    interior = 0,
		dimension = 163,
		spawnpoints = {
		    {78.62890625,1984.3369140625,17.640625,0.0},
		    {51.217769622803,1964.3427734375,20.590625762939,0.0},
		    {42.705078125,1947.4169921875,17.640625,0.0},
		    {22.2099609375,1926.853515625,17.640625,0.0},
		    {29.9951171875,1897.41796875,17.647617340088,0.0},
		    {50.669921875,1899.814453125,17.640625,0.0},
		    {37.3876953125,1866.5390625,17.640625,0.0},
		    {57.9296875,1856.97265625,17.647617340088,0.0},
		    {60.357421875,1900.765625,17.640625,0.0},
		    {79.9951171875,1919.05078125,17.640625,0.0},
		},
	},
	
	
	[16] = {
	    name = "Stealth:PRO Map #9 Wars",
	    interior = 0,
		dimension = 164,
		spawnpoints = {
		    {-1287.310546875,-231.1240234375,14.14396572113},
		    {-1309.1611328125,-206.728515625,14.1484375},
		    {-1295.6875,-169.80859375,14.1484375},
		    {-1263.708984375,-163.896484375,14.1484375},
		    {-1250.2841796875,-108.1083984375,14.1484375},
		    {-1209.55859375,-143.9150390625,14.1484375},
		    {-1190.1357421875,-164.546875,14.1484375},
		    {-1229.857421875,-200.8671875,14.14396572113},
		    {-1254.5693359375,-237.158203125,14.1484375},
		    {-1264.9287109375,-227.708984375,14.1484375},
		},
	},
	
	
	[16] = {
	    name = "Stealth:PRO Map #9 Linux",
	    interior = 0,
		dimension = 165,
		spawnpoints = {
		    {39.173828125,2044.267578125,17.695087432861},
		    {32.1962890625,2026.638671875,17.640625},
		    {22.1669921875,2003.669921875,17.640625},
		    {15.0068359375,1973.3466796875,17.640625},
		    {39.0029296875,1969.6220703125,17.640625},
		    {58.1953125,1972.6591796875,17.640625},
		    {45.560546875,1939.6279296875,17.640625},
		    {96.14453125,1972.4345703125,18.308925628662},
		    {106.744140625,2013.4951171875,18.59192276001},
		    {-20.3603515625,1935.1689453125,17.647296905518},
		},
	},
	
	
}

addCommandHandler("osinfo",
function(plr,cmd)
    outputChatBox("● INFO: Gracze na Oneshoot("..#getPlayersInTeam(oneshoot.team).."):",p,0,255,255)
	for i,v in pairs(getPlayersInTeam(oneshoot.team)) do
		outputChatBox("● "..getPlayerName(v),p,0,255,255)
	end
end)

addCommandHandler("oneshoot",
function(plr,cmd)
    if getElementData(plr,"pCommands") == false or getPlayerTeam(plr) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr)
		return
	end
    --if getPlayerTeam(plr) then return end
    if isPedDead(plr) then return end
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
	if isPlayerActiveGUI(plr) then return end
	triggerClientEvent(plr,"Client:OneShootWeapon",plr)
end)

addCommandHandler("osexit",
function(plr,cmd)
    if oneshoot.players[plr] then
    	oneshoot.players[plr] = nil
		oneshoot.weapon[plr] = nil
		setPlayerTeam(plr,nil)
		setElementDimension(plr,0)
		triggerClientEvent(plr,"Client:ShowSpawnMenu",plr)
	end
end)

addEvent("Server:OneShootJoin",true)
addEventHandler("Server:OneShootJoin",resourceRoot,
function(weaponID)
    oneshoot.players[client] = true
	oneshoot.weapon[client] = weaponID
	setPlayerTeam(client,oneshoot.team)
	--triggerClientEvent(client,"clientMsgBox",client,"● Aby wyjść z oneshoot wpisz komendę /osexit")
	oneshoot.spawnPlayer(client)
	--outputChatBox("● INFO: ["..getPlayerName(client).."] dołączył(a) do /oneshoot",root,0,255,255)
	exports.killmessages:outputMessage("● "..getPlayerName(client).." dołączył(a) do /oneshoot",root,0,255,255)
end)

addEvent("Server:OneShootExit",true)
addEventHandler("Server:OneShootExit",resourceRoot,
function()
	executeCommandHandler("osexit",client)
end)

function oneshoot.spawnPlayer(p)
    if not isElement(p) then return false end
	if not oneshoot.players[p] then return false end
	local spawnpoint = oneshoot.maps[oneshoot.current_map].spawnpoints
	local interior = oneshoot.maps[oneshoot.current_map].interior
	local dimension = oneshoot.maps[oneshoot.current_map].dimension
	local random = math.random(1,10)
    setElementData(p,"pCommands",false)
	--[[setElementData(p,"pTeleporty",false)]]
	spawnPlayer(p,spawnpoint[random][1],spawnpoint[random][2],spawnpoint[random][3],spawnpoint[random][4],getElementModel(p),interior,dimension)
	giveWeapon(p,oneshoot.weapon[p],99999,true)
	setElementHealth(p,10)
	fadeCamera(p,true)
	setCameraTarget(p,p)
end

function oneshoot.changeMap()
    outputChatBox("● INFO: Za chwilę nastąpi zmiana mapy na /oneshoot",root,0,255,255,true)
	setTimer(function()
	    oneshoot.current_map = math.random(1,#oneshoot.maps)
		if oneshoot.current_map then
		    for i,v in pairs(getPlayersInTeam(oneshoot.team)) do
			    if not isPedDead(v) then oneshoot.spawnPlayer(v) end
			end
		end
	end,5000,1)
end
setTimer(oneshoot.changeMap,6*60000,0)

addEventHandler("onPlayerQuit",root,
function()
	respawnTimer[source] = nil
    if oneshoot.players[source] then oneshoot.players[source] = nil end
	if oneshoot.weapon[source] then oneshoot.weapon[source] = nil end
end)

addCommandHandler("spr",
function(plr,cmd)
	if isPlayerPlayMiniGame(plr) == true then
		outputChatBox("grasz w minigrę",plr)
	else
		outputChatBox("nie grasz w minigrę",plr)
	end
end)

addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart,stealth)
    if oneshoot.players[source] then
	    if killer then
		    if killer ~= source then givePlayerMoney(killer,100) end
		end
	    setTimer(oneshoot.spawnPlayer,3000,1,source) 
	return end
	
	if isPlayerPlayMiniGame(source) ~= true then
		if killer and killer ~= source then
			local money = getPlayerMoney(source)
			if money then
				givePlayerMoney(killer,money)
			end
		end
		setPlayerMoney(source,0)
	end
	
	serverMiniGameQuit(source)
	
    if killer and killer ~= source then
		local killerKills = getElementData(killer,"Kills")
		if killerKills and tonumber(killerKills) then
		    setElementData(killer,"Kills",killerKills+1)
		end
	end
	
	if serverData.customVeh[source] then
		setElementData(serverData.customVeh[source],"vehOwner",nil)
		destroyElement(serverData.customVeh[source])
		serverData.customVeh[source] = nil
	end
	
	--[[setTimer(function()
		if not isElement(source) then return end
		triggerClientEvent(source,"Client:ShowSpawnMenu",source)
	end,3000,1)]]
	
	if not respawnTimer[source] then
		respawnTimer[source] = setTimer(respawnPlayer,5000,1,source)
	end
	
	local sourceDeaths = getElementData(source,"Deaths")
	if sourceDeaths and tonumber(sourceDeaths) then
		setElementData(source,"Deaths",sourceDeaths+1)
	end
end)

addEventHandler("onPlayerSpawn",root,
function()
    if not oneshoot.players[source] then 
	    --[[triggerClientEvent(source,"Client:ShowWeaponSelection",source)]]
	else
		--triggerClientEvent(source,"Client:SpawnPlayer",source,true)
	end
end)

function respawnPlayer(plr)
	if isElement(plr) then
		respawnTimer[plr] = nil
		if isPedDead(plr) then triggerClientEvent(plr,"Client:ShowSpawnMenu",plr) end
	end
end