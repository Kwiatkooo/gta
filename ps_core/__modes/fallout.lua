--[[ 
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
-	Fallout by Ransom (edit by Luk4s7_)
-	fallout.lua (serverside)
	
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
]]

fallout = {}
fallout.played = false
fallout.team = createTeam("Fallout",255,255,255)
setTeamFriendlyFire(fallout.team,true)
fallout.maxplayers = 20
fallout.minplayers = 0
fallout.dimension = 1234
fallout.board = {}
fallout.timers = {}

addCommandHandler("foinfo",
function(p,_)
    if fallout.played == true then
	    outputChatBox("● INFO: Gracze na Fallout ("..#getPlayersInTeam(fallout.team).."):",p,0,255,255)
		for i,v in pairs(getPlayersInTeam(fallout.team)) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
	end
end)

addCommandHandler("fo",
function(p,_)
    if getElementData(p,"pCommands") == false or getPlayerTeam(p) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p)
		return
	end
    if fallout.played == false then
    	local playerTeam = getPlayerTeam(p)
		if playerTeam ~= fallout.team then
	    	if countPlayersInTeam(fallout.team) ~= fallout.maxplayers then
			    setPlayerTeam(p,fallout.team)
				outputChatBox("● INFO: Zapisałeś(aś) się na Fallout.",p,255,165,0,true)
				if countPlayersInTeam(fallout.team) > fallout.minplayers then
				    if not fallout.timers[1] then
	    			    fallout.timers[1] = setTimer(falloutPreStart,15000,1)
					    outputChatBox("● INFO: Fallout rozpocznie się za 15 sekund.",root,255,165,0,true)
					end
				end
            else
		        outputChatBox("● INFO: Na Fallout zapisała się już maksymalna ilość graczy.",p,255,0,0,true)
			end
		else
			outputChatBox("● INFO: Zapisałeś(aś) się już na Fallout.",p,255,0,0,true)
		end
	else
		outputChatBox("● INFO: Fallout aktualnie trwa i nie możesz się teraz zapisać.",p,255,0,0,true)
	end
end)

function falloutPreStart()
	--if countPlayersInTeam(fallout.team) > fallout.minplayers then
	if countPlayersInTeam(fallout.team) ~= 0 then
		fallout.played = true
		fallout.board = {}
		local count = 0
		local players = getPlayersInTeam(fallout.team)
		
		local random = math.random(1,2)
		
		if random == 1 then
			local rows = 10
			local columns = 8
			for i=1,rows do
				for j=1,columns do
					count = count+1
					fallout.board[count] = createObject(1697,1540.122926+4.466064*j,-1317.568237+5.362793*i,603.105469,math.deg(0.555),0,0)
					setElementDimension(fallout.board[count],fallout.dimension)
				end
			end
		end
		
		if random == 2 then
			local rows = 12
			local columns = 8
			for i=1,rows do
				for j=1,columns do
					count = count+1
					fallout.board[count] = createObject(1649,1540.122926+4.366064*j,-1317.568237+3.302793*i,603.105469,270.48481142853,0,0)
					setElementDimension(fallout.board[count],fallout.dimension)
				end
			end
		end
		
		for i,v in pairs(players) do
			if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
				triggerClientEvent(v,"onClientMiniGamesStart",v)
		    	takeAllWeapons(v)
		    	setElementData(v,"pCommands",false)
				triggerClientEvent(v,"hideGuiElements",v)
				removePedFromVehicle(v)
				removePedJetPack(v)
				setElementDimension(v,fallout.dimension)
				setElementInterior(v,0)
				local spawningBoard = math.random(1,#fallout.board)
				local x,y,z = getElementPosition(fallout.board[spawningBoard])
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
			else
				outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Fallout.",v,255,0,0,true)
				setPlayerTeam(v,nil)
			end
		end
		fallout.timers[2] = setTimer(falloutStart,3000,1)
	else
		outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Fallout.",root,255,0,0,true)
		falloutEnd(false)
	end
end

function falloutStart()
	--if countPlayersInTeam(fallout.team) > fallout.minplayers then
	if countPlayersInTeam(fallout.team) ~= 0 then
		for i,v in pairs(getPlayersInTeam(fallout.team)) do
			setElementFrozen(v,false)
		end
		breakAwayPieces()
		fallout.timers[3] = setTimer(falloutIdle,3000,0)
		setTeamFriendlyFire(fallout.team,false)
	else
		outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Fallout.",root,255,0,0,true)
		falloutEnd(false)
	end
end

function breakAwayPieces()
	local callSpeedA = 1250
	local callSpeedB = 1500
	local callSpeedC = 1750
	local tableSize = #fallout.board
	if tableSize == nil or tableSize == 0 then return end
	if tableSize ~= 2 then
		local callSpeed = 1000
		chosenBoard = math.random(1,tableSize)   
		triggerClientFall(fallout.board[chosenBoard])
		if tableSize >= 40 then 
			callSpeed = callSpeedA
		elseif tableSize <= 29 and tableSize > 15 then                    
			callSpeed = callSpeedB                                                                                                                         
		elseif tableSize < 15 then                        
			callSpeed = callSpeedC		                                                   
		end      
		table.remove(fallout.board,chosenBoard)
		setTimer(breakAwayPieces,callSpeed,1)
	else
		if not fallout.timers[4] then
		    --fallout.timers[4] = setTimer(falloutEnd,1000,1,true)
			fallout.timers[4] = setTimer(function()
				falloutEnd(true)
			end,1000,1)
		end
	end
end

function triggerClientFall(fallingPiece)
	triggerClientEvent("clientShakePieces",root,fallingPiece)
	local x,y = getElementPosition(fallingPiece)
    local rx,ry,rz = math.random(0,360),math.random(0,360),math.random(0,360)
	if rx < 245 then rx = -(rx + 245) end
	if ry < 245 then ry = -(ry + 245) end
	if rz < 245 then rz = -(rz + 245) end
	setTimer(moveObject,2500,1,fallingPiece,10000,x,y,404,rx,ry,rz)
	setTimer(destroyElement,8000,1,fallingPiece)
end

function falloutIdle()
	for i,v in pairs(getPlayersInTeam(fallout.team)) do
		local x,y,z = getElementPosition(v)
		if z < 595 then
			setPlayerTeam(v,nil)
			setElementFrozen(v,true)
			setElementPosition(v,0,0,0)
			triggerClientEvent(v,"Client:ShowSpawnMenu",v)
		end
	end
	local countPlayers = countPlayersInTeam(fallout.team)
	if countPlayers == 0 --[[or countPlayers == 1]] then
	    if fallout.timers[3] and isTimer(fallout.timers[3]) then
			killTimer(fallout.timers[3])
			fallout.timers[3] = nil
		end
		if not fallout.timers[4] then
		    --fallout.timers[4] = setTimer(falloutEnd,1000,1,true)
			fallout.timers[4] = setTimer(function()
				falloutEnd(true)
			end,1000,1)
		end
	end
end

function falloutEnd(nagroda)
    for i,v in pairs(fallout.timers) do
	    if isTimer(v) then
		    killTimer(v)
		end
	end
    local countPlayers = countPlayersInTeam(fallout.team)
	if countPlayers > 0 then
		for i,v in pairs(getPlayersInTeam(fallout.team)) do
			if nagroda == true then
				outputChatBox("● INFO: Fallout wygrał(a) ("..getPlayerName(v).." ID: "..getElementData(v,"ID")..") i otrzymuje 21 500$ +18 EXP.",root,255,165,0,false)
				givePlayerMoney(v,21500)
				addPlayerEXP(v,18)
			end
	    	setPlayerTeam(v,nil)
			triggerClientEvent(v,"Client:ShowSpawnMenu",v)
		end
	else
	    outputChatBox("● INFO: Fallout zakończone bez zwycięzcy.",root,255,0,0,true)
	end
	for i,v in pairs(fallout.board) do
		destroyElement(v)
	end
	fallout.played = false
    fallout.board = {}
	fallout.timers = {}
	setTeamFriendlyFire(fallout.team,true)
end