hayGame = {}
hayGame.played = false
hayGame.team = createTeam("Hay",255,255,255)
setTeamFriendlyFire(hayGame.team,true)
hayGame.maxplayers = 20
hayGame.minplayers = 1
hayGame.dimension = 99
hayGame.objects = {}
hayGame.timers = {}
hayGame.weapon = nil

hayGame.spawnpoints = {
    {2312.2998046875,1355.2998046875,401.10000610352},
    {2312.2998046875,1359.2998046875,401.10000610352},
    {2316.2998046875,1355.2998046875,401.10000610352},
    {2320.2001953125,1355.2998046875,401.10000610352},
    {2324.2001953125,1355.2998046875,401.10000610352},
    {2328.2001953125,1355.2998046875,401.10000610352},
    {2312.2998046875,1363.2998046875,401.10000610352},
    {2316.2998046875,1359.2998046875,401.10000610352},
    {2320.2001953125,1359.2998046875,401.10000610352},
    {2324.2001953125,1359.2998046875,401.10000610352},
    {2328.2001953125,1359.2998046875,401.10000610352},
    {2316.2998046875,1363.2998046875,401.10000610352},
    {2320.2001953125,1363.2998046875,401.10000610352},
    {2324.2001953125,1363.2998046875,401.10000610352},
    {2328.2001953125,1363.2998046875,401.10000610352},
    {2312.2998046875,1367.2998046875,401.10000610352},
    {2316.2998046875,1367.2998046875,401.10000610352},
    {2320.2001953125,1367.2998046875,401.10000610352},
    {2324.2001953125,1367.2998046875,401.10000610352},
    {2328.2001953125,1367.2998046875,401.10000610352},
    {2312.2998046875,1371.2998046875,401.10000610352},
    {2316.2998046875,1371.2998046875,401.10000610352},
    {2320.2001953125,1371.2998046875,401.10000610352},
    {2324.2001953125,1371.2998046875,401.10000610352},
    {2328.2001953125,1371.2998046875,401.10000610352},
    {2328.2001953125,1375.2998046875,401.10000610352},
    {2324.2001953125,1375.2998046875,401.10000610352},
    {2320.2001953125,1375.2998046875,401.10000610352},
    {2316.2998046875,1375.2998046875,401.10000610352},
    {2312.2998046875,1375.2998046875,401.10000610352},
    {2308.2998046875,1375.2998046875,401.10000610352},
    {2308.2998046875,1371.2998046875,401.10000610352},
    {2308.2998046875,1367.2998046875,401.10000610352},
    {2308.2998046875,1363.2998046875,401.10000610352},
    {2308.2998046875,1359.2998046875,401.10000610352},
    {2308.2998046875,1355.2998046875,401.10000610352},
    {2308.2998046875,1379.2001953125,401.10000610352},
    {2304.2998046875,1375.2998046875,401.10000610352},
    {2304.2998046875,1379.2001953125,401.10000610352},
    {2312.2998046875,1379.2001953125,401.10000610352},
    {2316.2998046875,1379.2001953125,401.10000610352},
    {2320.2001953125,1379.2001953125,401.10000610352},
    {2324.2001953125,1379.2001953125,401.10000610352},
    {2328.2001953125,1379.2001953125,401.10000610352},
    {2304.2998046875,1371.2998046875,401.10000610352},
    {2304.2998046875,1367.2998046875,401.10000610352},
    {2304.2998046875,1363.2998046875,401.10000610352},
    {2304.2998046875,1359.2998046875,401.10000610352},
    {2304.2998046875,1355.2998046875,401.10000610352},
    {2328.2001953125,1383.2001953125,401.10000610352},
    {2324.2001953125,1383.2001953125,401.10000610352},
    {2320.2001953125,1383.2001953125,401.10000610352},
    {2316.2998046875,1383.2001953125,401.10000610352},
    {2312.2998046875,1383.2001953125,401.10000610352},
    {2308.2998046875,1383.2001953125,401.10000610352},
    {2304.2998046875,1383.2001953125,401.10000610352},
    {2300.400390625,1383.2001953125,401.10000610352},
    {2300.400390625,1379.2001953125,401.10000610352},
    {2300.400390625,1375.2001953125,401.10000610352},
    {2300.400390625,1371.2001953125,401.10000610352},
    {2300.400390625,1367.2001953125,401.10000610352},
    {2300.400390625,1363.2001953125,401.10000610352},
    {2300.400390625,1359.2998046875,401.10000610352},
    {2300.400390625,1355.2998046875,401.10000610352},
}

hayGame.map = {
    {2312.2998046875,1355.2998046875,398.10000610352},
    {2312.2998046875,1359.2998046875,398.10000610352},
    {2316.2998046875,1355.2998046875,398.10000610352},
    {2320.2001953125,1355.2998046875,398.10000610352},
    {2324.2001953125,1355.2998046875,398.10000610352},
    {2328.2001953125,1355.2998046875,398.10000610352},
    {2312.2998046875,1363.2998046875,398.10000610352},
    {2316.2998046875,1359.2998046875,398.10000610352},
    {2320.2001953125,1359.2998046875,398.10000610352},
    {2324.2001953125,1359.2998046875,398.10000610352},
    {2328.2001953125,1359.2998046875,398.10000610352},
    {2316.2998046875,1363.2998046875,398.10000610352},
    {2320.2001953125,1363.2998046875,398.10000610352},
    {2324.2001953125,1363.2998046875,398.10000610352},
    {2328.2001953125,1363.2998046875,398.10000610352},
    {2312.2998046875,1367.2998046875,398.10000610352},
    {2316.2998046875,1367.2998046875,398.10000610352},
    {2320.2001953125,1367.2998046875,398.10000610352},
    {2324.2001953125,1367.2998046875,398.10000610352},
    {2328.2001953125,1367.2998046875,398.10000610352},
    {2312.2998046875,1371.2998046875,398.10000610352},
    {2316.2998046875,1371.2998046875,398.10000610352},
    {2320.2001953125,1371.2998046875,398.10000610352},
    {2324.2001953125,1371.2998046875,398.10000610352},
    {2328.2001953125,1371.2998046875,398.10000610352},
    {2328.2001953125,1375.2998046875,398.10000610352},
    {2324.2001953125,1375.2998046875,398.10000610352},
    {2320.2001953125,1375.2998046875,398.10000610352},
    {2316.2998046875,1375.2998046875,398.10000610352},
    {2312.2998046875,1375.2998046875,398.10000610352},
    {2308.2998046875,1375.2998046875,398.10000610352},
    {2308.2998046875,1371.2998046875,398.10000610352},
    {2308.2998046875,1367.2998046875,398.10000610352},
    {2308.2998046875,1363.2998046875,398.10000610352},
    {2308.2998046875,1359.2998046875,398.10000610352},
    {2308.2998046875,1355.2998046875,398.10000610352},
    {2308.2998046875,1379.2001953125,398.10000610352},
    {2304.2998046875,1375.2998046875,398.10000610352},
    {2304.2998046875,1379.2001953125,398.10000610352},
    {2312.2998046875,1379.2001953125,398.10000610352},
    {2316.2998046875,1379.2001953125,398.10000610352},
    {2320.2001953125,1379.2001953125,398.10000610352},
    {2324.2001953125,1379.2001953125,398.10000610352},
    {2328.2001953125,1379.2001953125,398.10000610352},
    {2304.2998046875,1371.2998046875,398.10000610352},
    {2304.2998046875,1367.2998046875,398.10000610352},
    {2304.2998046875,1363.2998046875,398.10000610352},
    {2304.2998046875,1359.2998046875,398.10000610352},
    {2304.2998046875,1355.2998046875,398.10000610352},
    {2328.2001953125,1383.2001953125,398.10000610352},
    {2324.2001953125,1383.2001953125,398.10000610352},
    {2320.2001953125,1383.2001953125,398.10000610352},
    {2316.2998046875,1383.2001953125,398.10000610352},
    {2312.2998046875,1383.2001953125,398.10000610352},
    {2308.2998046875,1383.2001953125,398.10000610352},
    {2304.2998046875,1383.2001953125,398.10000610352},
    {2300.400390625,1383.2001953125,398.10000610352},
    {2300.400390625,1379.2001953125,398.10000610352},
    {2300.400390625,1375.2001953125,398.10000610352},
    {2300.400390625,1371.2001953125,398.10000610352},
    {2300.400390625,1367.2001953125,398.10000610352},
    {2300.400390625,1363.2001953125,398.10000610352},
    {2300.400390625,1359.2998046875,398.10000610352},
    {2300.400390625,1355.2998046875,398.10000610352},
}

function table.random(theTable)
    return theTable[math.random(#theTable)]
end

addCommandHandler("hayinfo",
function(p,_)
    if hayGame.played == true then
	    outputChatBox("● INFO: Gracze na Hay ("..#getPlayersInTeam(hayGame.team).."):",p,0,255,255)
		for i,v in pairs(getPlayersInTeam(hayGame.team)) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
	end
end)

addCommandHandler("hay",
function(p,_)
    if getElementData(p,"pCommands") == false or getPlayerTeam(p) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p,commandName)
		return
	end
    if hayGame.played == false then
    	local playerTeam = getPlayerTeam(p)
		if playerTeam ~= hayGame.team then
	    	if countPlayersInTeam(hayGame.team) ~= hayGame.maxplayers then
	        	setPlayerTeam(p,hayGame.team)
		    	outputChatBox("● INFO: Zapisałeś(aś) się na Hay.",p,255,165,0,true)
			else
		    	outputChatBox("● INFO: Na Hay zapisała się już maksymalna ilość graczy.",p,255,0,0,true)
			end
		else
	    	outputChatBox("● INFO: Zapisałeś(aś) się już na Hay",p,255,0,0,true)
		end
		if not hayGame.timers[1] then
			if countPlayersInTeam(hayGame.team) > hayGame.minplayers then
	    		hayGame.timers[1] = setTimer(hayGameStart,15000,1)
				outputChatBox("● INFO: Hay rozpocznie się za 15 sekund.",root,255,165,0,true)
			end
		end
	else
	    outputChatBox("● INFO: Hay aktualnie trwa i nie możesz się teraz zapisać.",p,255,0,0,true)
	end
end)

function unFreezeHayPlayers()
    for i,v in pairs(getPlayersInTeam(hayGame.team)) do
	    setElementFrozen(v,false)
	end
end

function hayGameStart()
    if countPlayersInTeam(hayGame.team) > hayGame.minplayers then
    	--[[for i,v in pairs(hayGame.map) do
	    	hayGame.objects[i] = createObject(3374,v[1],v[2],v[3],0,0,0,false)
			setElementDimension(hayGame.objects[i],hayGame.dimension)
		end]]
		
		local random = math.random(1,4)
		local count = 0
		
		if random == 1 then
			hayGame.weapon = 23
			local rows = 10
			local columns = 8
			for i=1,rows do
				for j=1,columns do
					count = count+1
					hayGame.objects[count] = createObject(3374,1540.122926+3.966064*j,-1317.568237+3.962793*i,603.105469,0,0,0)
					setElementDimension(hayGame.objects[count],hayGame.dimension)
				end
			end
		end
		
		if random == 2 then
			hayGame.weapon = 26
			local rows = 10
			local columns = 8
			for i=1,rows do
				for j=1,columns do
					count = count+1
					hayGame.objects[count] = createObject(1649,1540.122926+4.366064*j,-1317.568237+3.302793*i,603.105469,270.48481142853,0,0)
					setElementDimension(hayGame.objects[count],hayGame.dimension)
				end
			end
		end
		
		if random == 3 then
			hayGame.weapon = 24
			local rows = 12
			local columns = 8
			for i=1,rows do
				for j=1,columns do
					count = count+1
					hayGame.objects[count] = createObject(1447,1540.122926+4.466064*j,-1317.568237+2.362793*i,603.105469,270,0.042083740234375,0.042083740234375)
					setElementDimension(hayGame.objects[count],hayGame.dimension)
				end
			end
		end
		
		if random == 4 then
			hayGame.weapon = 25
			local rows = 9
			local columns = 13
			for i=1,rows do
				for j=1,columns do
					count = count+1
					hayGame.objects[count] = createObject(3260,1540.122926+1.966064*j,-1317.568237+3.0*i,603.105469,270.0,180,180)
					setElementDimension(hayGame.objects[count],hayGame.dimension)
				end
			end
		end
		
		for i,v in pairs(getPlayersInTeam(hayGame.team)) do
	    	if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
			    triggerClientEvent(v,"onClientMiniGamesStart",v)
			    setElementData(v,"pCommands",false)
		    	if doesPedHaveJetPack(v) then
			    	removePedJetPack(v)
				end
				takeAllWeapons(v)
	        	setElementHealth(v,100)
				removePedFromVehicle(v)
				triggerClientEvent(v,"hideGuiElements",v)
				setElementDimension(v,hayGame.dimension)
				setElementInterior(v,0)
		    	--[[local randomPosition = math.random(1,#hayGame.spawnpoints)
		    	setElementPosition(v,hayGame.spawnpoints[randomPosition][1],hayGame.spawnpoints[randomPosition][2],hayGame.spawnpoints[randomPosition][3])]]
				local spawningBoard = math.random(1,#hayGame.objects)
				local x,y,z = getElementPosition(hayGame.objects[spawningBoard])
				--[[local changex = math.random(0,1)
				local changey = math.random(0,1)
				if changex == 0 then
					x = x - math.random(0,200)/100
				elseif changex == 1 then
					x = x + math.random(0,200)/100
				end
				if changey == 0 then
					y = y - math.random(0,200)/100
				elseif changey == 1 then
					y = y + math.random(0,200)/100
				end				
				local spawnAngle = 360 - math.deg(math.atan2((1557.987182 - x),(-1290.754272 - y)))]]
				setElementPosition(v,x,y,607.105469)
				--[[setElementRotation(v,0,0,spawnAngle)]]
				setElementFrozen(v,true)
				--[[triggerClientEvent(v,"clientMsgBox",v,"● Utrzymaj się jak najdłużej na stogach siana i strzelaj w nie, aby strącić pozostałych graczy.")]]
			else
			    outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Hay",v,255,0,0,true)
		    	setPlayerTeam(v,nil)
			end
		end
		hayGame.played = true
		hayGame.timers[2] = setTimer(getHayRandomPlayer,5000,0)
	    hayGame.timers[4] = setTimer(unFreezeHayPlayers,3000,1)
		setTeamFriendlyFire(hayGame.team,false)
	else
        for i,v in pairs(hayGame.timers) do
	        if isTimer(v) then
		        killTimer(v)
			    v = nil
		    end
	    end
        for i,v in pairs(hayGame.objects) do
	        destroyElement(v)
	    end
		for i,v in pairs(getPlayersInTeam(hayGame.team)) do
	    	setPlayerTeam(v,nil)
		end
        hayGame.objects = {}
	    hayGame.timers = {}
	    hayGame.played = false
		setTeamFriendlyFire(hayGame.team,true)
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na /hay",root,255,0,0,true)
	end
end

function hayGameEnd()
    for i,v in pairs(hayGame.timers) do
	    if isTimer(v) then
		    killTimer(v)
		end
	end
    local countPlayers = countPlayersInTeam(hayGame.team)
	if countPlayers > 0 then
		for i,v in pairs(getPlayersInTeam(hayGame.team)) do
	        outputChatBox("● INFO: Hay wygrał(ła) ("..getPlayerName(v).." ID: "..getElementData(v,"ID")..") i otrzymuje 25 000$ +25 EXP.",root,255,165,0,false)
			givePlayerMoney(v,25000)
			addPlayerEXP(v,25)
	    	setPlayerTeam(v,nil)
			triggerClientEvent(v,"Client:ShowSpawnMenu",v)
		end
	else
	    outputChatBox("● INFO: Hay zakończone bez zwycięzcy.",root,255,0,0,true)
	end
    for i,v in pairs(hayGame.objects) do
	    destroyElement(v)
	end
	hayGame.played = false
    hayGame.objects = {}
	hayGame.timers = {}
	setTeamFriendlyFire(hayGame.team,true)
	hayGame.weapon = nil
end

function getHayRandomPlayer()
    local countPlayers = countPlayersInTeam(hayGame.team)
	if countPlayers > hayGame.minplayers then
	    local hayPlayers = getPlayersInTeam(hayGame.team)
		giveWeapon(table.random(hayPlayers),hayGame.weapon,1,true)
		for i,v in pairs(getPlayersInTeam(hayGame.team)) do
		    setElementHealth(v,100)
			local x,y,z = getElementPosition(v)
			if z < 595 then
			    setPlayerTeam(v,nil)
				setElementFrozen(v,true)
			    setElementPosition(v,0,0,0)
				triggerClientEvent(v,"Client:ShowSpawnMenu",v)
			end
		end
	end
	local countPlayers = countPlayersInTeam(hayGame.team)
	if countPlayers == 1 or countPlayers == 0 then
	    if hayGame.timers[2] then
		    if isTimer(hayGame.timers[2]) then
			    killTimer(hayGame.timers[2])
				hayGame.timers[2] = nil
			end
		end
		if not hayGame.timers[3] then
		    hayGame.timers[3] = setTimer(hayGameEnd,100,1)
		end
	end
end