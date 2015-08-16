monsterCrash = {}
monsterCrash.played = false
monsterCrash.team = createTeam("Monster Crash",255,255,255)
monsterCrash.maxplayers = 10
monsterCrash.minplayers = 1
monsterCrash.dimension = 99
monsterCrash.timers = {}
monsterCrash.vehicles = {}
monsterCrash.currentMap = nil
monsterCrash.maps = {
    {
	    ["spawnpoints"] = {
		    {-1912.4033203125,625.3623046875,145.69160461426,45.230773925781},
			{-1987.1884765625,622.5849609375,145.69149780273,326.72528076172},
			{-1919.900390625,622.29296875,145.70401000977,30.813201904297},
			{-1950.0009765625,623.4326171875,145.68626403809,356.35165405273},
			{-1911.267578125,651.1455078125,145.69161987305,86.989013671875},
			{-1920.794921875,697.029296875,145.68980407715,154.41760253906},
			{-1942.408203125,697.888671875,145.68531799316,180.79121398926},
			{-1967.0849609375,698.15234375,145.70442199707,182.28570556641},
			{-1985.8779296875,696.810546875,145.6915435791,210.59341430664},
			{-1992.267578125,655.1796875,145.71656799316,267.64834594727},
		},
		["limit"] = 100,
	},
    {
	    ["spawnpoints"] = {
		    {-305.1337890625,2360.634765625,113.06508636475,267.91207885742},
			{-262.052734375,2407.4482421875,109.30149841309,175.69232177734},
			{-230.6064453125,2375.2626953125,110.6710357666,70.989013671875},
			{-230.3525390625,2344.3017578125,109.41442871094,74.241760253906},
			{-230.8623046875,2325.94921875,109.73070526123,97.626373291016},
			{-245.59765625,2285.5869140625,110.65305328369,17.274749755859},
			{-277.2236328125,2139.3369140625,113.14409637451,18.065948486328},
			{-288.9755859375,2145.7548828125,113.41786193848,326.8132019043},
			{-297.40234375,2157.853515625,112.6290512085,253.49450683594},
			{-290.4931640625,2176.7265625,113.23397064209,219.03297424316},
		},
		["limit"] = 90,
	},
    {
	    ["spawnpoints"] = {
		    {1054.390625,1524.0078125,52.393402099609,274.94506835938},
			{1051.4228515625,1533.681640625,52.488391876221,268.96704101563},
			{1053.0537109375,1543.068359375,51.78507232666,258.50549316406},
			{1129.607421875,1571.7666015625,46.538112640381,121.80218505859},
			{1135.6044921875,1561.4296875,48.945911407471,108.52746582031},
			{1139.28515625,1552.5458984375,50.860134124756,105.71429443359},
			{1140.83984375,1542.8876953125,51.798545837402,95.780212402344},
			{1142.30078125,1531.4072265625,52.658748626709,86.549468994141},
			{1142.48046875,1522.2626953125,52.254787445068,87.076934814453},
			{1139.0458984375,1501.431640625,49.783508300781,59.208801269531},
		},
		["limit"] = 30,
	},
    {
	    ["spawnpoints"] = {
		    {2442.8955078125,2249.20703125,92.001342773438,326.72528076172},
			{2456.0849609375,2247.0615234375,92.001365661621,359.34066772461},
			{2471.69140625,2246.689453125,92.001327514648,0.923095703125},
			{2483.521484375,2247.1640625,92.001319885254,21.93408203125},
			{2484.5615234375,2264.376953125,92.001350402832,89.362640380859},
			{2484.66015625,2277.744140625,92.001350402832,92.615386962891},
			{2484.1689453125,2290.00390625,92.001342773438,87.868133544922},
			{2485.1923828125,2328.3544921875,92.001342773438,151.86813354492},
			{2470.197265625,2328.6591796875,92.001350402832,180.87911987305},
			{2440.5078125,2327.251953125,92.001350402832,202.50549316406},
		},
		["limit"] = 80,
	},
    {
	    ["spawnpoints"] = {
		    {-466.7373046875,2333.62890625,120.92012786865,350.8132019043},
			{-474.201171875,2345.041015625,122.03252410889,306.24176025391},
			{-480.0556640625,2360.892578125,122.67754364014,290.41757202148},
			{-484.6181640625,2377.017578125,122.92958831787,282.76922607422},
			{-481.7587890625,2403.37890625,120.07290649414,217.01098632813},
			{-471.24609375,2417.5703125,115.9132232666,197.93406677246},
			{-444.5419921875,2418.337890625,108.86054229736,143.34066772461},
			{-425.2421875,2396.947265625,106.26657104492,134.10989379883},
			{-418.3388671875,2363.9296875,108.15505981445,78.989013671875},
			{-429.2314453125,2336.70703125,109.86150360107,34.945068359375},
		},
		["limit"] = 80,
	},
}

addCommandHandler("mcinfo",
function(p,_)
    if monsterCrash.played == true then
	    outputChatBox("● INFO: Gracze na Monster Crash ("..#getPlayersInTeam(monsterCrash.team).."):",p,0,255,255)
		for i,v in pairs(getPlayersInTeam(monsterCrash.team)) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
	end
end)

addCommandHandler("mc",
function(p,_)
    if getElementData(p,"pCommands") == false or getPlayerTeam(p) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p)
		return
	end
    if monsterCrash.played == false then
    	local playerTeam = getPlayerTeam(p)
		if playerTeam ~= monsterCrash.team then
	    	if countPlayersInTeam(monsterCrash.team) ~= monsterCrash.maxplayers then
			    setPlayerTeam(p,monsterCrash.team)
				outputChatBox("● INFO: Zapisałeś(aś) się na Monster Crash.",p,255,165,0,true)
				if countPlayersInTeam(monsterCrash.team) > monsterCrash.minplayers then
				    if not monsterCrash.timers[1] then
	    			    monsterCrash.timers[1] = setTimer(monsterCrashPreStart,15000,1)
					    outputChatBox("● INFO: Monster Crash rozpocznie się za 15 sekund.",root,255,165,0,true)
					end
				end
            else
		        outputChatBox("● INFO: Na Monster Crash zapisała się już maksymalna ilość graczy.",p,255,0,0,true)
			end
		else
			outputChatBox("● INFO: Zapisałeś(aś) się już na Monster Crash",p,255,0,0,true)
		end
	else
		outputChatBox("● INFO: Monster Crash aktualnie trwa i nie możesz się teraz zapisać.",p,255,0,0,true)
	end
end)

function monsterCrashPreStart()
    if countPlayersInTeam(monsterCrash.team) > monsterCrash.minplayers then
	    monsterCrash.played = true
        local sRandomMap = math.random(1,#monsterCrash.maps)
	    if sRandomMap then
		    monsterCrash.currentMap = sRandomMap
		    local randomSpawn = monsterCrash.maps[sRandomMap]["spawnpoints"]
            for i,v in pairs(getPlayersInTeam(monsterCrash.team)) do
			    if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
			    	triggerClientEvent(v,"onClientMiniGamesStart",v)
			    	takeAllWeapons(v)
			    	setElementData(v,"pCommands",false)
					triggerClientEvent(v,"hideGuiElements",v)
					removePedFromVehicle(v)
					removePedJetPack(v)
					setElementInterior(v,0)
					setElementDimension(v,monsterCrash.dimension)
					monsterCrash.vehicles[i] = createVehicle(556,randomSpawn[i][1],randomSpawn[i][2],randomSpawn[i][3],0,0,randomSpawn[i][4])
					addEventHandler("onVehicleStartExit",monsterCrash.vehicles[i],function(exitingPlayer,seat,jacked,door) cancelEvent() end)
					setElementDimension(monsterCrash.vehicles[i],monsterCrash.dimension)
					setElementFrozen(monsterCrash.vehicles[i],true)
			        warpPedIntoVehicle(v,monsterCrash.vehicles[i])
					addVehicleUpgrade(monsterCrash.vehicles[i],1010)
					triggerClientEvent(v,"clientMsgBox",v,"● Zepchnij lub zniszcz pojazdy pozostałych graczy, aby wygrać.")
				else
				    outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Monster Crash",v,255,0,0,true)
					setPlayerTeam(v,nil)
				end
			end
			monsterCrash.timers[2] = setTimer(monsterCrashStart,1000,6)
		end
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Monster Crash.",root,255,0,0,true)
		monsterCrashEnd(false,false)
	end
end

function monsterCrashCountDownText(text)
    for i,v in pairs(getPlayersInTeam(monsterCrash.team)) do
        local textDisplay = textCreateDisplay()
        local textItem = textCreateTextItem(tostring(text),0.5,0.4,"medium",255,255,255,200,3,"center","center",200)
        textDisplayAddText(textDisplay,textItem)
        textDisplayAddObserver(textDisplay,v)
        setTimer(textDestroyTextItem,800,1,textItem)
        setTimer(textDestroyDisplay,800,1,textDisplay)
		if text ~= "Start!" then playSoundFrontEnd(v,44) else playSoundFrontEnd(v,45) end
	end
end

function monsterCrashStart()
    local remaining,executesRemaining,totalExecutes = getTimerDetails(monsterCrash.timers[2])
	local __countdown = executesRemaining-1
	if __countdown ~= 0 then return monsterCrashCountDownText(__countdown) end
	monsterCrashCountDownText("Start!")
    if countPlayersInTeam(monsterCrash.team) > monsterCrash.minplayers then
	    for i,v in pairs(monsterCrash.vehicles) do
		    setElementFrozen(v,false)
		end
		monsterCrash.timers[3] = setTimer(monsterCrashIdle,3000,0)
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Monster Crash.",root,255,0,0,true)
		monsterCrashEnd(false,true)
	end
end

function monsterCrashEnd(nagroda,rsp)
    for i,v in pairs(monsterCrash.timers) do
	    if isTimer(v) then
		    killTimer(v)
		end
	end
	if monsterCrash.timers[3] then
		if isTimer(monsterCrash.timers[3]) then
			killTimer(monsterCrash.timers[3])
		end
		monsterCrash.timers[3] = nil
	end
    if countPlayersInTeam(monsterCrash.team) == 1 then
	    for i,v in pairs(getPlayersInTeam(monsterCrash.team)) do
		    if nagroda == true then
		        outputChatBox("● INFO: Monster Crash wygrał(a) ("..getPlayerName(v).." ID: "..getElementData(v,"ID")..") i otrzymuje 10 000$ +25 EXP.",root,255,165,0,true)
			    givePlayerMoney(v,10000)
				addPlayerEXP(v,25)
			end
			if rsp == true then
				setPlayerTeam(v,nil)
				removePedFromVehicle(v)
				triggerClientEvent(v,"Client:ShowSpawnMenu",v)
				setElementPosition(v,0,0,0)
			end
		end
	else
	    outputChatBox("● INFO: Monster Crash zakończone bez zwycięzcy.",root,255,0,0,true)
	end
	for i,v in pairs(monsterCrash.vehicles) do
		if isElement(v) then destroyElement(v) end
	end
	monsterCrash.played = false
	monsterCrash.timers = {}
	monsterCrash.vehicles = {}
	monsterCrash.currentMap = nil
end

function monsterCrashIdle()
    local monsterCrashLimit = monsterCrash.maps[monsterCrash.currentMap]["limit"]
	if monsterCrashLimit then
	    for i,v in pairs(getPlayersInTeam(monsterCrash.team)) do
		    local x,y,z = getElementPosition(v)
			if z < monsterCrashLimit then
			    local monsterVehicle = getPedOccupiedVehicle(v)
				if monsterVehicle then
				    destroyElement(monsterVehicle)
					monsterVehicle = nil
				end
			    setPlayerTeam(v,nil)
				setElementPosition(v,0,0,0)
				triggerClientEvent(v,"Client:ShowSpawnMenu",v)
			end
		end
	end
	if countPlayersInTeam(monsterCrash.team) < 2 then
	    monsterCrashEnd(true,true)
	end
end