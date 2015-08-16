local COLOR_RED = "#FF0000"

setTimer(function()
    local testTable = {}
	
    if hayGame.played == true then 
		testTable[1] = ""..COLOR_RED.."Trwa..." 
	else
		local hayPlayers = countPlayersInTeam(getTeamFromName("Hay"))
		if hayPlayers >= 2 then 
			testTable[1] = tostring(hayPlayers)
		else
			testTable[1] = tostring(hayPlayers).."/2"
		end
	end
	
	if race.played == true then 
		testTable[2] = ""..COLOR_RED.."Trwa..." 
	else
		local racePlayers = countPlayersInTeam(getTeamFromName("Race"))
		if racePlayers >= 2 then
			testTable[2] = tostring(racePlayers)
		else
			testTable[2] = tostring(racePlayers).."/2"
		end
	end
	
	if monsterCrash.played == true then 
		testTable[3] = ""..COLOR_RED.."Trwa..." 
	else 
		local monsterPlayers = countPlayersInTeam(getTeamFromName("Monster Crash"))
		if monsterPlayers >= 2 then
			testTable[3] = tostring(monsterPlayers)
		else
			testTable[3] = tostring(monsterPlayers).."/2"
		end
	end
	
	if derby.played == true then 
		testTable[4] = ""..COLOR_RED.."Trwa..." 
	else 
		local derbyPlayers = countPlayersInTeam(getTeamFromName("Derby"))
		if derbyPlayers >= 4 then
			testTable[4] = tostring(derbyPlayers)
		else
			testTable[4] = tostring(derbyPlayers).."/4"
		end
	end
	
	if driftGame.played == true then 
		testTable[5] = ""..COLOR_RED.."Trwa..." 
	else 
		local driftPlayers = countPlayersInTeam(getTeamFromName("Drift"))
		if driftPlayers >= 2 then
			testTable[5] = tostring(driftPlayers)
		else
			testTable[5] = tostring(driftPlayers).."/2"
		end
	end
	
	if gang_war.played == true then 
		testTable[6] = ""..COLOR_RED.."Trwa..."
	else
		local gangPlayers = countPlayersInTeam(getTeamFromName("Grove")) + countPlayersInTeam(getTeamFromName("Ballas"))
		if gangPlayers >= 4 then
			testTable[6] = tostring(gangPlayers)
		else
			testTable[6] = tostring(gangPlayers).."/4"
		end
	end
	
	if fallout.played == true then 
		testTable[7] = ""..COLOR_RED.."Trwa..."
	else
		local foPlayers = countPlayersInTeam(getTeamFromName("Fallout"))
		if foPlayers >= 1 then
			testTable[7] = tostring(foPlayers)
		else
			testTable[7] = tostring(foPlayers).."/1"
		end
	end
	
	testTable[8] = countPlayersInTeam(getTeamFromName("OneShoot"))
	
	--[[if stealth_mode.played == true then 
		testTable[9] = "Trwa..."
	else
		local sthPlayers = tonumber(countPlayersInTeam(stealth_mode.team[1]) + countPlayersInTeam(stealth_mode.team[2]))
		if sthPlayers > 4 or sthPlayers == 4 then
			testTable[9] = tostring(sthPlayers)
		else
			testTable[9] = tostring(sthPlayers).."/4"
		end
	end]]
	
	for i,v in pairs(getElementsByType("player")) do
		if isElement(v) and getElementData(v,"ID") then
	        triggerClientEvent(v,"updateMiniGamesGUI",v,testTable)
		end
	end
	
end,2000,0)

function isPlayerPlayMiniGame(plr)
    local t = getPlayerTeam(plr)
	if t then
	    if t == oneshoot.team then return true end
    	if t == driftGame.team and driftGame.played == true then return true end
   	    if t == monsterCrash.team and monsterCrash.played == true then return true end
    	if t == hayGame.team and hayGame.played == true then return true end
    	if t == race.team and race.played == true then return true end
		if t == derby.team and derby.played == true then return true end
		if t == gang_war.team[1] or t == gang_war.team[2] and gang_war.played == true then return true end
		if t == fallout.team and fallout.played == true then return true end
	else
		return false
	end
	return false
end

addCommandHandler("wypisz",
function(plr,cmd)
    if getElementData(plr,"pCommands") == false or getPlayerTeam(plr) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr)
		return
	end
    if isPedDead(plr) then return end
    if getElementData(plr,"pCommands") == false then return end
    --[[if getElementData(plr,"isPlayerDamage") == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
	if isPlayerActiveGui(plr) then return end]]
    local t = getPlayerTeam(plr)
	if t then
	    if t == oneshoot.team then return end
    	if t == driftGame.team and driftGame.played == true then return outputWarnningMsg(plr) end
   	    if t == monsterCrash.team and monsterCrash.played == true then return outputWarnningMsg(plr) end
    	if t == hayGame.team and hayGame.played == true then return outputWarnningMsg(plr) end
    	if t == race.team and race.played == true then return outputWarnningMsg(plr) end
		if t == fallout.team and fallout.played == true then return outputWarnningMsg(plr) end
		if t == derby.team and derby.played == true then return outputWarnningMsg(plr) end
		if t == gang_war.team[1] or t == gang_war.team[2] and gang_war.played == true then return outputWarnningMsg(plr) end
		setPlayerTeam(plr,nil)
		outputChatBox("● INFO: Wypisałeś(aś) się z minigry.",plr,255,0,0)
	end
end)

function outputWarnningMsg(plr)
    outputChatBox("● INFO: Nie możesz się teraz wypisać.",plr,255,0,0)
end

addEventHandler("onPlayerQuit",root,
function()
	serverMiniGameQuit(source)
end)

function serverMiniGameQuit(plr)
    local t = getPlayerTeam(plr)
	setPlayerTeam(plr,nil)
	if t == derby.team then
		triggerClientEvent(plr,"Client:DestructionDerbyEnd",plr)
	end
	if t == driftGame.team and driftGame.played == true then
	    removePedFromVehicle(plr)
		triggerClientEvent(plr,"onServerDriftEnd",plr)
		triggerClientEvent(plr,"Client:ShowSpawnMenu",plr)
	    driftGamePlayers(true)
	end
	if t == race.team and race.played == true then
		removePedFromVehicle(plr)
		triggerClientEvent(plr,"onServerRaceEnd",plr)
		triggerClientEvent(plr,"Client:ShowSpawnMenu",plr)
	    raceGamePlayers(true)
	end
	if t == gang_war.team[1] or t == gang_war.team[2] then
		if gang_war.played == true then
			local c = gang_war.plr_oldcolor[plr]
			setPlayerNametagColor(plr,c[1],c[2],c[3])
			if serverData.blips[plr] then setBlipColor(serverData.blips[plr],c[1],c[2],c[3],150) end
			setElementModel(plr,gang_war.plr_oldskin[plr])
		end
	end
end
