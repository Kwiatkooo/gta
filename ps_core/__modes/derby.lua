derby = {}
derby.played = false
derby.team = createTeam("Derby",255,255,255)
derby.maxplayers = 20
derby.minplayers = 3
derby.dimension = 128
derby.timers = {}
derby.vehicles = {}
derby.spawnpoints = {
    {-1516.61328125,990.931640625,1037.5909423828,269.46853637695},
	{-1506.2939453125,967.560546875,1037.1802978516,303.93865966797},
	{-1491.8623046875,954.2197265625,1036.9296875,311.45892333984},
	{-1357.0224609375,933.3916015625,1036.3381347656,5.9794006347656},
	{-1340.7314453125,938.50390625,1036.3969726563,5.9794006347656},
	{-1323.3818359375,944.22265625,1036.4733886719,26.342864990234},
	{-1306.5048828125,954.9267578125,1036.6158447266,38.252227783203},
	{-1291.1220703125,968.54296875,1036.8115234375,57.989471435547},
	{-1300.9287109375,1033.15625,1037.9147949219,129.65438842773},
	{-1315.5263671875,1046.0244140625,1038.1469726563,144.68939208984},
	{-1334.037109375,1052.560546875,1038.2938232422,150.33096313477},
	{-1349.921875,1056.7841796875,1038.3890380859,164.43212890625},
	{-1367.8720703125,1059.033203125,1038.4559326172,168.50811767578},
	{-1384.4951171875,1057.9169921875,1038.4676513672,170.69989013672},
	{-1406.7529296875,1058.474609375,1038.5150146484,179.78576660156},
	{-1427.6591796875,1057.876953125,1038.5406494141,183.23002624512},
	{-1444.5234375,1055.40234375,1038.5307617188,188.24536132813},
	{-1457.65625,1052.875,1038.5129394531,202.03341674805},
	{-1470.8681640625,1048.6943359375,1038.4636230469,205.16458129883},
	{-1485.13671875,1040.8251953125,1038.3597412109,222.08377075195},
}

addCommandHandler("derbyinfo",
function(p,_)
    if derby.played == true then
	    outputChatBox("● INFO: Gracze na Destruction Derby ("..#getPlayersInTeam(derby.team).."):",p,0,255,255)
		for i,v in pairs(getPlayersInTeam(derby.team)) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
	end
end)

addCommandHandler("db",
function(p,_)
    if getElementData(p,"pCommands") == false or getPlayerTeam(p) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p)
		return
	end
    if derby.played == false then
    	local playerTeam = getPlayerTeam(p)
		if playerTeam ~= derby.team then
	    	if countPlayersInTeam(derby.team) ~= derby.maxplayers then
			    setPlayerTeam(p,derby.team)
				outputChatBox("● INFO: Zapisałeś(aś) się na Destruction Derby.",p,255,165,0,true)
				if countPlayersInTeam(derby.team) > derby.minplayers then
				    if not derby.timers[1] then
	    			    derby.timers[1] = setTimer(derbyPreStart,15000,1)
					    outputChatBox("● INFO: Destruction Derby rozpocznie się za 15 sekund.",root,255,165,0,true)
					end
				end
            else
		        outputChatBox("● INFO: Na Destruction Derby zapisała się już maksymalna ilość graczy.",p,255,0,0,true)
			end
		else
			outputChatBox("● INFO: Zapisałeś(aś) się już na Destruction Derby.",p,255,0,0,true)
		end
	else
		outputChatBox("● INFO: Destruction Derby aktualnie trwa i nie możesz się teraz zapisać.",p,255,0,0,true)
	end
end)

function derbyPreStart()
    if countPlayersInTeam(derby.team) > derby.minplayers then
	    derby.played = true
	    local spawn = derby.spawnpoints
        for i,v in pairs(getPlayersInTeam(derby.team)) do
		    if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
		    	triggerClientEvent(v,"onClientMiniGamesStart",v)
		    	takeAllWeapons(v)
		    	setElementData(v,"pCommands",false)
				triggerClientEvent(v,"hideGuiElements",v)
				removePedFromVehicle(v)
				removePedJetPack(v)
				setElementInterior(v,15)
				setElementDimension(v,derby.dimension)
				derby.vehicles[i] = createVehicle(504,spawn[i][1],spawn[i][2],spawn[i][3],0,0,spawn[i][4])
				addEventHandler("onVehicleStartExit",derby.vehicles[i],function(exitingPlayer,seat,jacked,door) cancelEvent() end)
				setElementDimension(derby.vehicles[i],derby.dimension)
				setElementFrozen(derby.vehicles[i],true)
		        warpPedIntoVehicle(v,derby.vehicles[i])
				--addVehicleUpgrade(derby.vehicles[i],1010)
				setElementInterior(derby.vehicles[i],15)
				triggerClientEvent(v,"clientMsgBox",v,"● Zniszcz pojazdy pozostałych graczy, aby wygrać.")
				triggerClientEvent(v,"Client:DestructionDerbyPreStart",v)
			else
			    outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Destruction Derby.",v,255,0,0,true)
				setPlayerTeam(v,nil)
			end
		end
		derby.timers[2] = setTimer(derbyStart,1000,6)
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Destruction Derby.",root,255,0,0,true)
		derbyEnd(false,false)
	end
end

function derbyCountDownText(text)
    for i,v in pairs(getPlayersInTeam(derby.team)) do
        local textDisplay = textCreateDisplay()
        local textItem = textCreateTextItem(tostring(text),0.5,0.4,"medium",255,255,255,200,3,"center","center",200)
        textDisplayAddText(textDisplay,textItem)
        textDisplayAddObserver(textDisplay,v)
        setTimer(textDestroyTextItem,800,1,textItem)
        setTimer(textDestroyDisplay,800,1,textDisplay)
		if text ~= "Start!" then playSoundFrontEnd(v,44) else playSoundFrontEnd(v,45) end
	end
end


function derbyStart()
    local remaining,executesRemaining,totalExecutes = getTimerDetails(derby.timers[2])
	local __countdown = executesRemaining-1
	if __countdown ~= 0 then return derbyCountDownText(__countdown) end
	derbyCountDownText("Start!")
    if countPlayersInTeam(derby.team) > derby.minplayers then
	    for i,v in pairs(derby.vehicles) do
		    setElementFrozen(v,false)
		end
		for i,v in pairs(getPlayersInTeam(derby.team)) do
			triggerClientEvent(v,"Client:DestructionDerbyStart",v)
		end
		derby.timers[3] = setTimer(derbyIdle,3000,0)
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Destruction Derby.",root,255,0,0,true)
		derbyEnd(false,true)
	end
end

function derbyEnd(nagroda,rsp)
    for i,v in pairs(derby.timers) do
	    if isTimer(v) then
		    killTimer(v)
		end
	end
	if derby.timers[3] then
		if isTimer(derby.timers[3]) then
			killTimer(derby.timers[3])
		end
		derby.timers[3] = nil
	end
    if countPlayersInTeam(derby.team) == 1 then
	    for i,v in pairs(getPlayersInTeam(derby.team)) do
		    if nagroda == true then
		        outputChatBox("● INFO: Destruction Derby wygrał(a) ("..getPlayerName(v).." ID: "..getElementData(v,"ID")..") i otrzymuje 10 000$ +25 EXP.",root,255,165,0,true)
			    givePlayerMoney(v,10000)
				addPlayerEXP(v,25)
			end
			triggerClientEvent(v,"Client:DestructionDerbyEnd",v)
			if rsp == true then
				setPlayerTeam(v,nil)
				removePedFromVehicle(v)
				triggerClientEvent(v,"Client:ShowSpawnMenu",v)
				setElementPosition(v,0,0,0)
			end
		end
	else
	    outputChatBox("● INFO: Destruction Derby zakończone bez zwycięzcy.",root,255,0,0,true)
	end
	for i,v in pairs(derby.vehicles) do
		if isElement(v) then destroyElement(v) end
	end
	derby.played = false
	derby.timers = {}
	derby.vehicles = {}
end

function derbyIdle()
	if countPlayersInTeam(derby.team) < 2 then
	    derbyEnd(true,true)
	end
end