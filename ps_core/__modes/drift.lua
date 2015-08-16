addCommandHandler("drexit",
function(plr,cmd)
    local theTeam = getPlayerTeam(plr)
	if theTeam == driftGame.team and driftGame.played == true then 
		serverMiniGameQuit(plr)
	    --triggerClientEvent(plr,"onServerDriftEnd",plr) 
		--triggerClientEvent(plr,"Client:ShowSpawnMenu",plr) 
	end
end)

driftGame = {}
driftGame.played = false
driftGame.team = createTeam("Drift",255,255,255)
--setTeamFriendlyFire(driftGame.team,false)
driftGame.maxplayers = 2
driftGame.minplayers = 0
driftGame.dimension = 98
driftGame.timers = {}
driftGame.vehicles = {}
driftGame.maps = {
    {
	    ["spawnpoints"] = {
		    [1] = "1729.3515625,511.4931640625,28.309354782104,161.44958496094",
			[2] = "1739.1298828125,507.9130859375,28.323177337646,161.91101074219",
		},
	    ["checkpoints"] = {
		    {1653.5224609375,273.580078125,29.715637207031},
		    {1625.39453125,237.6943359375,29.810989379883},
		    {1572.6181640625,230.0927734375,27.350105285645},
		    {1609.9970703125,305.359375,20.561069488525},
		    {1592.6953125,342.068359375,21.686168670654},
		    {1622.0185546875,375.693359375,28.352470397949},
		    {1660.4814453125,331.5302734375,29.864774703979},
		    {1651.623046875,213.9716796875,30.437383651733},
		    {1696.0771484375,244.400390625,19.729822158813},
		    {1729.48828125,271.9091796875,17.605354309082},
		    {1723.048828125,296.158203125,18.075973510742},
		    {1692.9931640625,355.3046875,29.636526107788},
		    {1650.8662109375,265.931640625,29.710380554199},
		    {1612.9375,227.6533203125,29.679685592651},
		    {1570.6591796875,231.4443359375,27.038549423218},
		    {1558.8955078125,274.828125,20.70973777771},
		    {1585.0869140625,294.7734375,19.784227371216},
		    {1652.8203125,281.5322265625,20.719451904297},
		    {1737.796875,257.7333984375,17.675327301025},
		    {1748.0107421875,278.3720703125,17.729972839355},
		    {1707.8056640625,285.4697265625,18.203960418701},
		    {1591.4208984375,312.6474609375,21.755516052246},
		}
	},

    {
	    ["spawnpoints"] = {
		    [1] = "2333.2626953125,1393.1513671875,42.483425140381,0.3131103515625",
			[2] = "2320.529296875,1393.1376953125,42.483734130859,0.4833984375",
		},
	    ["checkpoints"] = {
		    {2325.0888671875,1435.498046875,42.480518341064},
		    {2297.84765625,1512.6142578125,42.482643127441},
		    {2275.017578125,1470.5068359375,40.427947998047},
		    {2304.71875,1394.0244140625,36.082313537598},
		    {2337.22265625,1433.9990234375,34.140193939209},
		    {2309.876953125,1512.8154296875,29.728412628174},
		    {2274.98828125,1468.2392578125,27.489238739014},
		    {2306.2021484375,1394.599609375,23.286027908325},
		    {2341.2392578125,1441.6162109375,20.877059936523},
		    {2306.76953125,1513.095703125,16.924798965454},
		    {2275.529296875,1467.427734375,14.64367389679},
		    {2302.2646484375,1397.2666015625,10.474299430847},
		    {2319.6767578125,1441.7548828125,10.525319099426},
		    {2309.6015625,1523.4111328125,10.414837837219},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "-2730.3974609375,2351.2958984375,71.535377502441,280.13186645508",
			[2] = "-2732.03125,2360.5439453125,71.536315917969,279.69232177734",
		},
	    ["checkpoints"] = {
		    {-2655.408203125,2494.642578125,32.090198516846},
			{-2504.9375,2421.7783203125,16.256076812744},
			{-2462.388671875,2332.443359375,4.4936137199402},
			{-2328.2099609375,2389.5107421875,5.4082922935486},
			{-2273.474609375,2351.5,4.4535341262817},
			{-2262.5947265625,2295.3583984375,4.4783668518066},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "-714.0537109375,2390.2587890625,128.26313781738,160.92309570313",
			[2] = "-709.4931640625,2388.5048828125,128.26449584961,154.24176025391",
		},
	    ["checkpoints"] = {
		    {-738.1201171875,2346.14453125,124.96754455566},
			{-834.54296875,2371.056640625,121.06899261475},
			{-797.888671875,2500.740234375,99.645370483398},
			{-772.69140625,2560.3466796875,85.503578186035},
			{-712.9306640625,2522.6044921875,74.451469421387},
			{-741.984375,2646.373046875,64.39518737793},
			{-701.7939453125,2684.23046875,56.331829071045},
			{-768.56640625,2691.232421875,47.156074523926},
			{-774.21484375,2748.8330078125,45.379657745361},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "-723.46875,2317.1025390625,126.89292144775,318.9010925293",
			[2] = "-719.6630859375,2314.251953125,127.05354309082,322.15383911133",
		},
	    ["checkpoints"] = {
		    {-693.8984375,2397.525390625,130.57147216797},
			{-677.4609375,2466.1806640625,114.93926239014},
			{-565.6953125,2365.3642578125,77.72843170166},
			{-396.611328125,2284.8017578125,39.849895477295,251.82417297363},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "-305.662109375,1514.130859375,75.022720336914,182.02198791504",
			[2] = "-299.626953125,1514.3349609375,75.021583557129,184.5714263916",
		},
	    ["checkpoints"] = {
		    {-303.087890625,1396.650390625,71.977432250977},
			{-367.2314453125,1464.13671875,62.753471374512},
			{-325.3818359375,1317.4169921875,52.534168243408},
			{-424.6728515625,1447.3583984375,34.0817527771},
			{-416.2236328125,1363.265625,29.275497436523},
			{-329.77734375,1259.193359375,22.948745727539},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "-455.9052734375,2032.6806640625,60.226795196533,47.340667724609",
			[2] = "-452.880859375,2036.1513671875,60.316776275635,47.428588867188",
		},
	    ["checkpoints"] = {
		    {-471.287109375,2072.4140625,60.056663513184},
			{-413.9013671875,2148.3134765625,43.947704315186},
			{-384.8662109375,2241.4775390625,41.749652862549},
			{-375.1962890625,2362.5595703125,30.210563659668},
			{-400.5712890625,2457.7001953125,42.186641693115},
			{-347.6044921875,2520.7802734375,35.574783325195},
			{-509.00390625,2593.046875,53.072875976563},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "-483.6826171875,1932.2998046875,86.21598815918,184.74725341797",
			[2] = "-477.240234375,1932.974609375,85.975723266602,186.06593322754",
		},
	    ["checkpoints"] = {
		    {-461.9912109375,1764.3310546875,72.172309875488},
			{-421.884765625,1917.14453125,57.054454803467},
			{-394.5712890625,1746.2802734375,42.091331481934},
			{-291.62890625,1735.865234375,42.345966339111},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "784.78125,846.57421875,5.4882960319519,1.97802734375",
			[2] = "779.181640625,847.0224609375,5.5174694061279,1.97802734375",
		},
	    ["checkpoints"] = {
		    {760.35546875,928.953125,5.5146732330322},
			{553.4404296875,979.97265625,-7.1866655349731},
			{685.4658203125,964.2529296875,-13.015042304993},
			{726.712890625,884.431640625,-26.804027557373},
			{644.7587890625,949.0703125,-35.201511383057},
			{625.0849609375,907.3427734375,-44.524856567383},
			{684.048828125,894.5859375,-40.052936553955},
		}
	},
	
    {
	    ["spawnpoints"] = {
		    [1] = "1240.8330078125,-2057.380859375,59.656703948975,268.35165405273",
			[2] = "1240.8388671875,-2052.8662109375,59.631530761719,268.79119873047",
		},
	    ["checkpoints"] = {
		    {1422.9267578125,-2028.955078125,52.08922958374},
			{1251.0478515625,-1926.3818359375,30.755924224854},
			{1401.46484375,-1928.87890625,16.419809341431},
			{1426.4599609375,-1871.9951171875,13.042163848877},
		}
	},
}

addCommandHandler("drinfo",
function(p,_)
    if driftGame.played == true then
	    outputChatBox("● INFO: Gracze na Drift ("..#getPlayersInTeam(driftGame.team).."):",p,0,255,255)
		for i,v in pairs(getPlayersInTeam(driftGame.team)) do
			outputChatBox("● "..getPlayerName(v),p,0,255,255)
		end
	end
end)

addCommandHandler("dr",
function(p,_)
    if getElementData(p,"pCommands") == false or getPlayerTeam(p) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p)
		return
	end
    if driftGame.played == false then
    	local playerTeam = getPlayerTeam(p)
		if playerTeam ~= driftGame.team then
	    	if countPlayersInTeam(driftGame.team) ~= driftGame.maxplayers then
			    setPlayerTeam(p,driftGame.team)
				outputChatBox("● INFO: Zapisałeś(aś) się na Drift.",p,255,165,0,true)
				if countPlayersInTeam(driftGame.team) > driftGame.minplayers then
				    if not driftGame.timers[1] then
	    			    driftGame.timers[1] = setTimer(driftGamePreStart,15000,1)
					    outputChatBox("● INFO: Drift rozpocznie się za 15 sekund.",root,255,165,0,true)
					end
				end
            else
		        outputChatBox("● INFO: Na Drift zapisała się już maksymalna ilość graczy.",p,255,0,0,true)
			end
		else
			outputChatBox("● INFO: Zapisałeś(aś) się już na Drift.",p,255,0,0,true)
		end
	else
		outputChatBox("● INFO: Drift aktualnie trwa i nie możesz się teraz zapisać.",p,255,0,0,true)
	end
end)

function driftGamePreStart()
    driftGame.played = true
    if countPlayersInTeam(driftGame.team) > driftGame.minplayers then
        local sRandomMap = math.random(1,#driftGame.maps)
	    if sRandomMap then
			local spawnpoint1 = split(driftGame.maps[sRandomMap]["spawnpoints"][1],",")
			local spawnpoint2 = split(driftGame.maps[sRandomMap]["spawnpoints"][2],",")
			driftGame.vehicles[1] = createVehicle(562,spawnpoint1[1],spawnpoint1[2],spawnpoint1[3],0,0,spawnpoint1[4])
			driftGame.vehicles[2] = createVehicle(562,spawnpoint2[1],spawnpoint2[2],spawnpoint2[3],0,0,spawnpoint2[4])
			addEventHandler("onVehicleStartExit",driftGame.vehicles[1],function(exitingPlayer,seat,jacked,door) cancelEvent() end)
			addEventHandler("onVehicleStartExit",driftGame.vehicles[2],function(exitingPlayer,seat,jacked,door) cancelEvent() end)
			setElementFrozen(driftGame.vehicles[1],true)
			setElementFrozen(driftGame.vehicles[2],true)
			setElementDimension(driftGame.vehicles[1],driftGame.dimension)
			setElementDimension(driftGame.vehicles[2],driftGame.dimension)
			local upgradesTable = {}
			local upgrades = getVehicleCompatibleUpgrades(driftGame.vehicles[1])
			for i,v in pairs(upgrades) do
			    local slotName = tostring(getVehicleUpgradeSlotName(v))
				if not upgradesTable[slotName] then
				    upgradesTable[slotName] = {}
				end
				table.insert(upgradesTable[slotName],v)
			end
			for i,v in pairs(upgradesTable) do
			    addVehicleUpgrade(driftGame.vehicles[1],upgradesTable[i][math.random(1,#upgradesTable[i])])
				addVehicleUpgrade(driftGame.vehicles[2],upgradesTable[i][math.random(1,#upgradesTable[i])])
			end
		    setVehiclePaintjob(driftGame.vehicles[1],math.random(1,3))
			setVehiclePaintjob(driftGame.vehicles[2],math.random(1,3))
            for i,v in pairs(getPlayersInTeam(driftGame.team)) do
			    if --[[not isPlayerActiveGUI(v) and]] not isPedDead(v) and getElementData(v,"pCommands") ~= false then
			    	triggerClientEvent(v,"onClientMiniGamesStart",v)
			    	takeAllWeapons(v)
			    	setElementData(v,"pCommands",false)
			    	triggerClientEvent(v,"cMiniGamesDriftData",v,driftGame.maps[sRandomMap]["checkpoints"],driftGame.dimension)
					triggerClientEvent(v,"hideGuiElements",v)
					removePedFromVehicle(v)
					removePedJetPack(v)
					setElementDimension(v,driftGame.dimension)
					setElementInterior(v,0)
					warpPedIntoVehicle(v,driftGame.vehicles[i])
					--setVehicleDamageProof(driftGame.vehicles[i],true)
					triggerClientEvent(v,"clientMsgBox",v,"● Wjeżdzaj w punkty kontrolne i dojedź do mety jako pierwszy(a), aby wygrać.")
				else
				    outputChatBox("● INFO: Zostałeś(aś) zdyskwalifikowany(a) z Drift",v,255,0,0,true)
				    setPlayerTeam(v,nil)
				end
			end
			driftGame.timers[2] = setTimer(driftGameStart,1000,6)
		end
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Drift.",root,255,0,0,true)
		--[[driftGamePlayers(false)]] driftGameEnd(false)
	end
end

function driftCountDownText(text)
    for i,v in pairs(getPlayersInTeam(driftGame.team)) do
        local textDisplay = textCreateDisplay()
        local textItem = textCreateTextItem(tostring(text),0.5,0.4,"medium",255,255,255,200,3,"center","center",200)
        textDisplayAddText(textDisplay,textItem)
        textDisplayAddObserver(textDisplay,v)
        setTimer(textDestroyTextItem,800,1,textItem)
        setTimer(textDestroyDisplay,800,1,textDisplay)
		if text ~= "Start!" then playSoundFrontEnd(v,44) else playSoundFrontEnd(v,45) end
	end
end

function driftGameStart()
    local remaining,executesRemaining,totalExecutes = getTimerDetails(driftGame.timers[2])
	local __countdown = executesRemaining-1
	if __countdown ~= 0 then return driftCountDownText(__countdown) end
	driftCountDownText("Start!")
    if countPlayersInTeam(driftGame.team) > driftGame.minplayers then
		setElementFrozen(driftGame.vehicles[1],false)
		setElementFrozen(driftGame.vehicles[2],false)
	else
	    outputChatBox("● INFO: Nie udało się skompletować minimalnej ilości graczy na Drift.",root,255,0,0,true)
	    --[[driftGamePlayers(false)]] driftGameEnd(true)
	end
end

function driftGameEnd(rsp)
    for i,v in pairs(driftGame.timers) do
	    if isTimer(v) then
		    killTimer(v)
			v = nil
		end
	end
	for i,v in pairs(getPlayersInTeam(driftGame.team)) do
	    triggerClientEvent(v,"onServerDriftEnd",v)
		if rsp == true then
			setPlayerTeam(v,nil)
			removePedFromVehicle(v)
			triggerClientEvent(v,"Client:ShowSpawnMenu",v)
		end
	end
	if driftGame.vehicles[1] then
	    if isElement(driftGame.vehicles[1]) then destroyElement(driftGame.vehicles[1]) end
		driftGame.vehicles[1] = nil
	end
	if driftGame.vehicles[2] then
	    if isElement(driftGame.vehicles[2]) then destroyElement(driftGame.vehicles[2]) end
		driftGame.vehicles[2] = nil
	end
    driftGame.timers = {}
    driftGame.vehicles = {}
	driftGame.played = false
end

function driftGamePlayers(nagroda)
    if driftGame.played == true then
    	local countPlayers = countPlayersInTeam(driftGame.team)
		if countPlayers < 2 then
	    	for i,v in pairs(getPlayersInTeam(driftGame.team)) do
			    if nagroda == true then
		    	    outputChatBox("● INFO: Drift wygrał(ła) ("..getPlayerName(v).." ID: "..getElementData(v,"ID")..") i otrzymuje 10 000$ +10 EXP.",root,255,165,0,true)
				    givePlayerMoney(v,10000)
					addPlayerEXP(v,10)
				end
			end
			driftGameEnd(true)
		end
	end
end

addEvent("onServerDriftFinish",true)
addEventHandler("onServerDriftFinish",resourceRoot,
function()
	if driftGame.played == true then
		outputChatBox("● INFO: Drift wygrał(ła) ("..getPlayerName(client).." ID: "..getElementData(client,"ID")..") i otrzymuje 10 000$ +10 EXP.",root,255,165,0,true)
		givePlayerMoney(client,10000)
		addPlayerEXP(client,10)
		driftGameEnd(true)
	end
end)