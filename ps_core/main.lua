playerData = {}
serverData = {}

serverData.stop_resources = {
    "scoreboard","dxscoreboard",
	"helpmanager",
	"votemanager",
	"joinquit",
}

serverData.includes = {
    "defaultstats",
	"reload",
	"parachute",
	"killmessages",
	"deathpickups",
	"ps_privcar",
	"ps_gang_system",
	"ps_house",
	"ps_damagescript",
	"ps_interiors",
	"ps_mapnames",
	"ps_nametags",
	"ps_modshop",
	"ps_driveby",
	"ps_3dspeedo",
	"ps_prosync",
	"ps_spawnkill",
	"ps_fix_desync",
}

serverData.settings = {
    ["weather"] = 5,
	["time"] = 6,
	["game_type"] = "PlayDM ® v0.5.2",
	["map_name"] = "PlayDM ® v0.5.2",
}

serverData.respawnVeh = {}
serverData.customVeh = {}

serverData.blockedVehicles = {
    [447] = false,
    [464] = false,
	[592] = false,
	[577] = false,
	[425] = false,
	[520] = false,
	[432] = false,
	[449] = false,
	[537] = false,
	[538] = false,
	[570] = false,
	[569] = false,
	[590] = false,
}

serverData.weaponStats = {
    [69] = 999,
    [70] = 999,
    [71] = 999,
    [72] = 999,
    [73] = 999,
    [74] = 999,
    [75] = 999,
    [76] = 999,
    [77] = 999,
    [78] = 999,
    [79] = 999,
	[160] = 999,
	[229] = 999,
	[230] = 999,
}

serverData.cenzurowane_slowa = { 
    "[kK][uU]+[rR][wW]", 
	"[pP][iI][zZ][dD]", 
	"[pP][iI][eE][rR][dD][oO][lL]", 
	"[sS][uU][kK][iI][nN]",  
	"[jJ][eE][bB]", 
	"[cC][iI][pP][oO]", 
	"[hH][uU][jJ][uU]",
	"[hH][uU][jJ]",
	"[cC][iI][pP]+[aA]",
	"[cC][iI][pP][kK][aA]",
	"[dD][zZ][iI][wW][kK][aA]",
	"[sS][uU][kK][aA]",
	"[sS][zZ][mM][aA][tT][aA]",
	"[jJ][eE][bB][aA][cC]+[ćĆ]",
	"[cC][iI][oO][tT][aA]",
	"[dD][eE][bB][iI][lL]",
	"[cC][wW][eE][lL]",
	"[fF][uU][cC][kK]",
	"[dD][aA][mM][nN]",
}

function bindKeys(plr)
    bindKey(plr,"enter","down","removejetp")
	bindKey(plr,"l","down","vs")
	bindKey(plr,"f4","down","gang-panel")
	bindKey(plr,"F5","down","vippanel")
	bindKey(plr,"f3","down","privcar")
end

function unbindKeys(plr)
    unbindKey(plr,"enter","down","removejetp")
	unbindKey(plr,"l","down","vs")
	unbindKey(plr,"f4","down","gang-panel")
	unbindKey(plr,"F5","down","vippanel")
	unbindKey(plr,"f3","down","privcar")
end

addEventHandler("onPlayerJoin",root,
function() 
    bindKeys(source)
end)

addEventHandler("onPlayerQuit",root,
function() 
    unbindKeys(source)
end)

addEventHandler("onResourceStop",resourceRoot,
function()
    for i,v in pairs(getElementsByType("player")) do
        unbindKeys(v)
	end
end)

addEventHandler("onResourceStart",resourceRoot,
function()
    for i,v in pairs(getElementsByType("player")) do
        bindKeys(v)
	end
end)

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if unit=="mph" or unit==1 or unit =='1' then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function setElementSpeed(element,unit,speed)
	if unit == nil then unit = 0 end
	if speed == nil then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element,unit)
	if acSpeed ~= false then
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end
	return false
end

function isPlayerCMDEnabled(plr)
	if getElementData(plr,"pCommands") == false or getPlayerTeam(plr) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr)
		return false
	else
		return true
	end
end

addCommandHandler("tune",
function(plr,cmd)
    if not isPlayerCMDEnabled(plr) then return end
    local upgradesTable = {}
    local theVehicle = getPedOccupiedVehicle(plr)
	if theVehicle then
	    local g_Cost
	    if __isPlayerVIP[plr] then
	        g_Cost = 0
	    else
	        g_Cost = 5000
	    end
	    if getPlayerMoney(plr) > g_Cost-1 then
	        local upgrades = getVehicleCompatibleUpgrades(theVehicle)
			for i,v in pairs(upgrades) do
			    local slotName = tostring(getVehicleUpgradeSlotName(v))
				if not upgradesTable[slotName] then
				    upgradesTable[slotName] = {}
				end
				table.insert(upgradesTable[slotName],v)
			end
			for i,v in pairs(upgradesTable) do
			    addVehicleUpgrade(theVehicle,upgradesTable[i][math.random(1,#upgradesTable[i])])
			end
		    setVehiclePaintjob(theVehicle,math.random(1,3))
			takePlayerMoney(plr,g_Cost)
		else
			outputChatBox("● INFO: Na Automatyczny tunning potrzebujesz "..g_Cost.."$.",plr,255,0,0)
		end
	end
end)

addCommandHandler("flo",
function(plr,cmd)
    doRespawnPlayer(plr)
end)

addCommandHandler("rsp",
function(plr,cmd)
    doRespawnPlayer(plr)
end)

function doRespawnPlayer(plr)
    if not isPlayerCMDEnabled(plr) then return end
	if isPedInVehicle(plr) then return end
	if isPlayerGotDamage(plr) == true then triggerClientEvent(plr,"Client:isPlayerDamage",plr) return end
	local x,y,z = getElementPosition(plr)
	local rx,ry,rz = getElementRotation(plr)
	local health = getElementHealth(plr)
	local armor = getPedArmor(plr)
	local weapons = getPedWeapons(plr)
	local int = getElementInterior(plr)
	local dim = getElementDimension(plr)
	local skin = getElementModel(plr)
	local team = getPlayerTeam(plr)
	spawnPlayer(plr,x,y,z,rz,skin,int,dim,team)
	for weaponID,weaponAmmo in pairs(weapons) do
		giveWeapon(plr,weaponID,weaponAmmo,false)
	end
	setPedArmor(plr,armor)
	setElementHealth(plr,health)
end

function RGBtoHEX(r,g,b)
    return string.format("#%02X%02X%02X",r,g,b)
end

function removeHEXFromString(str)
    return str:gsub("#%x%x%x%x%x%x","")
end

addCommandHandler("okradnij",
function(plr,cmd,playerid)
    if not isPlayerCMDEnabled(plr) then return end
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if tonumber(playerid) then 
	    if tonumber(playerid) ~= tonumber(getElementData(plr,"ID")) then
	    	local thePlayer = getPlayerByID(playerid)
			if thePlayer then
		    	local camX,camY,camZ = getElementPosition(plr)
				local posX,posY,posZ = getElementPosition(thePlayer)
		    	local dist = getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ)
				if dist < 1 then
			    	local playerMoney = getPlayerMoney(thePlayer)
					local playerHealth = getElementHealth(thePlayer)
					local playerArmor = getPedArmor(thePlayer)
					local playerWeapons = getPedWeapons(thePlayer)
					givePlayerMoney(plr,playerMoney)
					addPlayerHealth(plr,playerHealth)
					addPlayerArmor(plr,playerArmor)
					for weaponID,weaponAmmo in pairs(playerWeapons) do
				   		giveWeapon(plr,weaponID,weaponAmmo,false)
					end
					takePlayerMoney(thePlayer,playerMoney)
					setElementHealth(thePlayer,1)
					takeAllWeapons(thePlayer)
					triggerClientEvent(thePlayer,"clientMsgBox",thePlayer,"● Zostałeś/aś okradziony/a przez gracza ("..removeHEXFromString(tostring(getPlayerName(plr)))..")")
				else
				    triggerClientEvent(plr,"clientMsgBox",plr,"● Ten gracz jest zbyt daleko.")
				end
			end
		else
		    triggerClientEvent(plr,"clientMsgBox",plr,"● Nie możesz okraść siebie ;p")
		end
	else
	    outputChatBox("● INFO: /okradnij <id gracza>",plr,255,0,0)
	end
end)

function addPlayerArmor(ped,arm)
	setPedArmor(ped,getPedArmor(ped)+arm)
end

function addPlayerHealth(ped,hp)
	setElementHealth(ped,getElementHealth(ped)+hp)
end

function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=1,11 do
			local weapon = getPedWeapon(ped,i)
			local ammo = getPedTotalAmmo(ped,i)
			if weapon and weapon ~= 0 then
				table.insert(playerWeapons,weapon,ammo)
			end
		end
	else
		return false
	end
	return playerWeapons
end

function isPlayerActiveGUI(plr)
    local _gui = getElementData(plr,"_activeGui")
	return _gui
end

addCommandHandler("gui",
function(plr,cmd)
    if not isPlayerActiveGUI(plr) then
	    outputChatBox("*** Brak aktywnego okna GUI. ***",plr)
	else
		outputChatBox("*** Masz aktywne okno GUI. ***",plr)
	end
end)

nagroda_za_gracza = {}
addCommandHandler("hitman",
function(plr,cmd,playerid,nagroda)
    local playerid = tonumber(playerid)
	local nagroda = tonumber(nagroda)
    if playerid and nagroda then
	    if nagroda > 0 then
	    	local thePlayer = getPlayerByID(playerid)
			if thePlayer then
		    	if tonumber(getPlayerMoney(plr)) > tonumber(nagroda) or tonumber(getPlayerMoney(plr)) == tonumber(nagroda) then
			    	if not nagroda_za_gracza[thePlayer] then
			        	nagroda_za_gracza[thePlayer] = tonumber(nagroda)
					else
				    	nagroda_za_gracza[thePlayer] = tonumber(nagroda_za_gracza[thePlayer]) + tonumber(nagroda)
					end
					takePlayerMoney(plr,tonumber(nagroda))
					outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] wyznaczył nagrodę "..nagroda.."$ (W sumie: "..nagroda_za_gracza[thePlayer].."$) za głowę gracza ["..getPlayerName(thePlayer).."].",root,0,255,255)
				end
			end
		end
	else
	    outputChatBox("● INFO: /hitman <id gracza> <kwota>",plr,255,0,0)
	end
end)

addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart,stealth)
    if nagroda_za_gracza[source] then
	    if killer and killer ~= source then
		    givePlayerMoney(killer,tonumber(nagroda_za_gracza[source]))
			--outputChatBox("● INFO: Otrzymałeś(aś) nagrodę "..nagroda_za_gracza[source].."$ za zabicie gracza "..getPlayerName(source),killer,0,255,255)
			triggerClientEvent(killer,"clientMsgBox",killer,"● INFO: Otrzymałeś(aś) nagrodę "..nagroda_za_gracza[source].."$ za zabicie gracza "..getPlayerName(source))
		end
	end
	nagroda_za_gracza[source] = nil
end)

addEventHandler("onPlayerQuit",root,
function()
    nagroda_za_gracza[source] = nil
end)

addCommandHandler("nagroda",
function(plr,cmd,playerid)
	local playerid = tonumber(playerid)
	if not playerid then return end
	local thePlayer = getPlayerByID(playerid)
	if thePlayer then
		if nagroda_za_gracza[thePlayer] then
			outputChatBox("* INFO: Nagroda za zabicie ["..getPlayerName(thePlayer).."]: "..nagroda_za_gracza[thePlayer].."$",plr,0,255,255)
		else
			outputChatBox("* INFO: Nagroda za zabicie ["..getPlayerName(thePlayer).."]: 0$",plr,0,255,255)
		end
	end
end)

addCommandHandler("vs",
function(plr,cmd,red,green,blue)
    local vehicle = getPedOccupiedVehicle(plr)
    if vehicle then
        if getVehicleOverrideLights(vehicle) ~= 2 then
            setVehicleOverrideLights(vehicle,2)
        else
            setVehicleOverrideLights(vehicle,1)
        end
    end
end)

addCommandHandler("vskolor",
function(plr,cmd,red,green,blue)
    local vehicle = getPedOccupiedVehicle(plr)
	if vehicle then
	    local r,g,b = tonumber(red) or math.random(0,255),tonumber(green) or math.random(0,255),tonumber(blue) or math.random(0,255)
		if r and g and b then
		    local color = setVehicleHeadLightColor(vehicle,r,g,b)
		end
	end
end)

addCommandHandler("plate",
function(plr,cmd,...)
    if not ... then return end
    local plate = tostring(table.concat({...}," "))
	if plate then
	    if string.len(plate) > 8 then return outputChatBox("● INFO: /plate <text> [Maksymalnie 8 znaków]",plr,255,0,0) end
        local seat = getPedOccupiedVehicleSeat(plr)
	    if seat == 0 then
		    setVehiclePlateText(getPedOccupiedVehicle(plr),plate)
	    end
	else
	    outputChatBox("● INFO: /plate <text>",plr,255,0,0)
	end
end)

addCommandHandler("nitro",
function(plr,cmd)
    if not isPlayerCMDEnabled(plr) then return end
    local g_Cost
	if __isPlayerVIP[plr] then
	    g_Cost = 0
	else
	    g_Cost = 1500
	end
    local vehicle = getPedOccupiedVehicle(plr)
	if vehicle then
	    if getPlayerMoney(plr) > g_Cost-1 then
	    	local succes = addVehicleUpgrade(vehicle,1010)
			if succes then
			    takePlayerMoney(plr,g_Cost)
			    outputChatBox("● INFO: Nitro zamontowane.",plr,0,255,255)
			else
			    outputChatBox("● INFO: Nitro nie może zostać zamontowane.",plr,255,0,0)
			end
	    else
			outputChatBox("● INFO: Aby kupić nitro potrzebujesz "..g_Cost.."$.",plr,255,0,0)
		end
	end
end)

addCommandHandler("style",
function(plr,cmd,style_id)
    local style_id = tonumber(style_id)
    if plr and style_id then
	    local succes = setPedFightingStyle(plr,style_id)
		if succes then
		    outputChatBox("● INFO: Styl walki zmieniony.",plr,0,255,255)
		else
		    outputChatBox("● INFO: Prawdopodobnie wpisałeś(aś) niepoprawne ID.",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: /style <id>",plr,255,0,0)
	end
end)

addCommandHandler("skin",
function(plr,cmd,skinID)
    if skinID then
	    local succes = setElementModel(plr,skinID)
		if (succes) then
		    outputChatBox("● INFO: Skin został zmieniony na ID: "..skinID,plr,0,255,255)
		else
		    outputChatBox("● INFO: Prawdopodobnie wpisałeś(aś) niepoprawne ID.",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: /skin <id>",plr,255,0,0)
	end
end)

addCommandHandler("pos",
function(plr,cmd)
    local x,y,z = getElementPosition(plr)
	local x2,y2,z2 = getElementRotation(plr)
	outputChatBox("Position+Rotation: "..tostring(x)..","..tostring(y)..","..tostring(z)..","..tostring(z2),plr,255,255,255,true)
	local dim = getElementDimension(plr)
	outputChatBox("Dimension: "..tostring(dim),plr,255,255,255,true)
	local int = getElementInterior(plr)
	outputChatBox("Interior: "..tostring(int),plr,255,255,255,true)
end)

addCommandHandler("lock",
function(plr,cmd)
    if not isPlayerCMDEnabled(plr) then return end
    local vehSeat = getPedOccupiedVehicleSeat(plr)
	if vehSeat == 0 then
	    setVehicleLocked(getPedOccupiedVehicle(plr),true)
		outputChatBox("● INFO: Pojazd zamknięty.",plr,0,255,255)
	end
end)

addCommandHandler("unlock",
function(plr,cmd)
    if not isPlayerCMDEnabled(plr) then return end
    local vehSeat = getPedOccupiedVehicleSeat(plr)
	if vehSeat == 0 then
	    setVehicleLocked(getPedOccupiedVehicle(plr),false)
		outputChatBox("● INFO: Pojazd otwarty.",plr,0,255,255)
	end
end)

addEventHandler("onVehicleEnter",root,
function(thePlayer,seat,jacked)
    setVehicleLocked(source,false)
	setVehicleDamageProof(source,false)
end)

addEventHandler("onVehicleExit",root,
function(thePlayer,seat,jacker)
    setVehicleLocked(source,false)
	setVehicleDamageProof(source,false)
	if getVehicleType(source) == "Helicopter" or getVehicleType(source) == "Plane" then
	    giveWeapon(thePlayer,46,1,true)
	end
end)

addEvent("Server:CreateVehicle",true)
addEventHandler("Server:CreateVehicle",resourceRoot,
function(theVehicle)
    executeCommandHandler("v",client,theVehicle)
end)

addCommandHandler("v",
function(plr,cmd,modelID)
	if getElementInterior(plr) ~= 0 or getElementDimension(plr) ~= 0 then return end
    if not isPlayerCMDEnabled(plr) then return end
	if not isPlayerAdmin(plr) then
		if tonumber(getElementData(plr,".LVL")) == 0 then triggerClientEvent(plr,"clientMsgBox",plr,"● Musisz osiągnąć co najmniej 1 Level, aby stworzyć pojazd.") return end
		if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
	end
    if getPlayerMoney(plr) > 999 then
    	if serverData.customVeh[plr] then
		    --setElementData(serverData.customVeh[plr],"vehOwner",nil)
			removeElementData(serverData.customVeh[plr],"vehOwner")
	   		destroyElement(serverData.customVeh[plr])
			serverData.customVeh[plr] = nil
			--[[if modelID then
				local theVehicle = tonumber(modelID) or getVehicleModelFromName(tostring(modelID))
				if theVehicle then
					setElementModel(serverData.customVeh[plr],theVehicle)
					takePlayerMoney(plr,1000)
					return
				end
				return
			end
			return]]
		end
		if modelID then
			local theVehicle = tonumber(modelID) or getVehicleModelFromName(tostring(modelID)) 
			if theVehicle then
	    		if serverData.blockedVehicles[theVehicle] ~= false then
       	    		local x,y,z = getElementPosition(plr)
	   	    		local rx,ry,rz = getElementRotation(plr)
					serverData.customVeh[plr] = createVehicle(theVehicle,x,y,z+2,rx,ry,rz)
					if serverData.customVeh[plr] then
    					setElementData(serverData.customVeh[plr],"vehOwner",plr)
						warpPedIntoVehicle(plr,serverData.customVeh[plr])
						outputChatBox("● INFO: Utworzyłeś(aś) pojazd: "..getVehicleName(serverData.customVeh[plr]).."("..getElementModel(serverData.customVeh[plr])..").",plr,0,255,255)
						takePlayerMoney(plr,1000)
					else
					    outputChatBox("● INFO: Niepoprawne ID.",plr,255,0,0)
					end
				else
				    outputChatBox("● INFO: Ten pojazd jest zablokowany.",plr,255,0,0)
				end
			else
			    outputChatBox("● INFO: Niepoprawna nazwa.",plr,255,0,0)
			end
		else
		    outputChatBox("● INFO: /v <nazwa pojazdu lub id>",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: Aby stworzyć pojazd potrzebujesz 1000$.",plr,255,0,0)
	end
end)

addCommandHandler("givecash",
function(plr,cmd,_id,_money)
    doPlayerGiveCash(plr,_id,_money)
end)
addCommandHandler("dajkase",
function(plr,cmd,_id,_money)
    doPlayerGiveCash(plr,_id,_money)
end)

function doPlayerGiveCash(plr,id,cash)
    local id = tonumber(id)
	local cash = tonumber(cash)
	local player_money = tonumber(getPlayerMoney(plr))
    if id and id ~= tonumber(getElementData(plr,"ID")) and cash and cash ~= 0 then
		if player_money > cash or player_money == cash then
		    local thisPlayer = getPlayerByID(id)
			if thisPlayer then
			    takePlayerMoney(plr,cash)
			    givePlayerMoney(thisPlayer,cash)
				outputChatBox("● INFO: Otrzymałeś(aś) ["..cash.."$] od ["..getPlayerName(plr).."].",thisPlayer,0,255,255)
				outputChatBox("● INFO: Przesłałeś(aś) ["..cash.."$] dla ["..getPlayerName(thisPlayer).."].",plr,0,255,255)
			else
			    outputChatBox("● INFO: Nie ma gracza o takim ID.",plr,255,0,0)
			end
		else
		    outputChatBox("● INFO: Nie masz takiej ilości pieniędzy.",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: /givecash <id gracza> <kwota>.",plr,255,0,0)
	end
end

--[[addCommandHandler("napraw",
function(plr,cmd)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    local theVehicle = getPedOccupiedVehicle(plr)
	if theVehicle then
        local g_Cost
	    if __isPlayerVIP[plr] then
	        g_Cost = 4500
	    else
	        g_Cost = 7500
	    end
	    if getPlayerMoney(plr) > g_Cost-1 then
		    takePlayerMoney(plr,g_Cost)
	        fixVehicle(theVehicle)
			playSoundFrontEnd(plr,46)
			outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] naprawił swój pojazd za "..g_Cost.."$.",root,0,255,255)
		else
			outputChatBox("● INFO: Aby naprawić pojazd potrzebujesz "..g_Cost.."$.",plr,255,0,0)
		end
	end
end)]]

addEvent("Server:naprawCommand",true)
addEventHandler("Server:naprawCommand",resourceRoot,
function()
	if isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
    if getElementData(client,"pCommands") == false or getPlayerTeam(client) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
		triggerClientEvent(client,"Client:isPlayerDamage",client)
		return
	end
    local theVehicle = getPedOccupiedVehicle(client)
	if theVehicle then
	  
	    fixVehicle(theVehicle)
		playSoundFrontEnd(client,46)
		outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] naprawił swój pojazd za ",root,0,255,255)
		
	end
end)

addEvent("Server:takePlayerMoney",true)
addEventHandler("Server:takePlayerMoney",resourceRoot,
function(g_Money)
	takePlayerMoney(client,g_Money)
end)

addEvent("Server:outputChatForAll",true)
addEventHandler("Server:outputChatForAll",resourceRoot,
function(g_Message)
	outputChatBox(g_Message,root,0,255,255)
end)

addCommandHandler("skok",
function(plr,cmd,odleglosc)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if not isPlayerCMDEnabled(plr) then return end
	local odleglosc = tonumber(odleglosc)
    if getElementInterior(plr) == 0 and odleglosc then
	    if odleglosc < 10001 and odleglosc > 499 then
		    giveWeapon(plr,46,1,true)
            local x,y,z = getElementPosition(plr)
		    setElementPosition(plr,x,y,z+odleglosc)
		else
		    outputChatBox("● INFO: /skok <500-10000>",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: /skok <500-10000>",plr,255,0,0)
	end
end)

addCommandHandler("removejetp",
function(plr,cmd)
    if doesPedHaveJetPack(plr) then removePedJetPack(plr) return end
end)
addCommandHandler("jetp",
function(plr,cmd)
    if not isPlayerCMDEnabled(plr) then return end
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if getPedOccupiedVehicle(plr) then return end
    if doesPedHaveJetPack(plr) then removePedJetPack(plr) return end
	local g_Cost
	if __isPlayerVIP[plr] then
	    g_Cost = 125000
	else
	    g_Cost = 250000
	end
	if getPlayerMoney(plr) > g_Cost-1 then
		takePlayerMoney(plr,g_Cost)
		givePedJetPack(plr)
		outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] kupił jetpack za "..g_Cost.."$.",root,0,255,255)
		triggerClientEvent(plr,"clientMsgBox",plr,"● Aby zdjąć jetpack naciśnij klawisz [ENTER]")
	else
		outputChatBox("● INFO: Aby kupić jetpack potrzebujesz "..g_Cost.."$.",plr,255,0,0)
	end
end)

serverData.savePosition = {0,0,0,0,0}

addCommandHandler("loadpos",
function(plr,cmd)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if not isPlayerCMDEnabled(plr) then return end
    triggerClientEvent(plr,"Client:LoadPos",plr,{serverData.savePosition[1],serverData.savePosition[2],serverData.savePosition[3],serverData.savePosition[4],serverData.savePosition[5]})
end)

addCommandHandler("savepos",
function(plr,cmd)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
	if getElementInterior(plr) ~= 0 then return outputChatBox("● INFO: Nie można zapisywać pozycji wewnątrz budynków.",plr,0,255,255) end
	if getElementDimension(plr) ~= 0 then return end
    local x,y,z = getElementPosition(plr)
	serverData.savePosition = {x,y,z,tonumber(getElementInterior(plr)),tonumber(getElementDimension(plr))}
	outputChatBox("● INFO: Twoja pozycja została zapisana.",plr,0,255,255)
end)

addCommandHandler("niespodzianka",
function(plr,cmd)
    
end)

--[[addCommandHandler("flip",
function(plr,cmd)
    if not isPlayerCMDEnabled(plr) then return end
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if isPedInVehicle(plr) then
		local theVehicle = getPedOccupiedVehicle(plr)
		if getVehicleController(theVehicle) ~= plr then return end
	    if getPlayerMoney(plr) > 999 then
	        takePlayerMoney(plr,1000)
            setVehicleRotation(theVehicle,0,0,getPedRotation(plr),true)
		else
		    outputChatBox("● INFO: Aby użyć komendę /flip potrzebujesz 1000$.",plr,255,0,0)
		end
	end
end)]]

addEvent("Server:flipCommand",true)
addEventHandler("Server:flipCommand",resourceRoot,
function()
    if getElementData(client,"pCommands") == false or getPlayerTeam(client) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
		triggerClientEvent(client,"Client:isPlayerDamage",client)
		return
	end
    if isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
    if isPedInVehicle(client) then
		local theVehicle = getPedOccupiedVehicle(client)
		if getVehicleController(theVehicle) ~= client then return end
	    if getPlayerMoney(client) > 999 then
	        takePlayerMoney(client,1000)
            setVehicleRotation(theVehicle,0,0,getPedRotation(client),true)
		else
		    outputChatBox("● INFO: Aby użyć komendę /flip potrzebujesz 1000$.",client,255,0,0)
		end
	end
end)

addCommandHandler("spawnkamizelka",
function(plr,cmd)
    if playerData[plr]["__spawnArmor"] == true then outputChatBox("● INFO: Kupiłeś(aś) już kamizelkę na spawn.",plr,255,0,0) return end
    if not isPlayerCMDEnabled(plr) then return end
	local g_Cost
	if __isPlayerVIP[plr] then
	    g_Cost = 65000
	else
	    g_Cost = 125000
	end
    if getPlayerMoney(plr) > g_Cost-1 then
	    takePlayerMoney(plr,g_Cost)
		playerData[plr]["__spawnArmor"] = true
		outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] kupił kamizelkę na swój spawn za "..g_Cost.."$.",root,0,255,255)
	else
		outputChatBox("● INFO: Aby kupić kamizelkę na spawn potrzebujesz "..g_Cost.."$.",plr,255,0,0)
	end
end)

--[[addCommandHandler("kamizelka",
function(plr,cmd)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if not isPlayerCMDEnabled(plr) then return end
	if math.floor(getPedArmor(plr)) > 99 then return end
    local g_Cost
	if __isPlayerVIP[plr] then
	    g_Cost = 6500
	else
	    g_Cost = 15000
	end
    if getPlayerMoney(plr) > g_Cost-1 then
	    takePlayerMoney(plr,g_Cost)
	    setPedArmor(plr,100)
		outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] kupił kamizelkę za "..g_Cost.."$.",root,0,255,255)
	else
		outputChatBox("● INFO: Aby kupić kamizelkę potrzebujesz "..g_Cost.."$.",plr,255,0,0)
	end
end)]]

addEvent("Server:kamizelkaCommand",true)
addEventHandler("Server:kamizelkaCommand",resourceRoot,
function()
    if isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
    if getElementData(client,"pCommands") == false or getPlayerTeam(client) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
		triggerClientEvent(client,"Client:isPlayerDamage",client)
		return
	end
	if math.floor(getPedArmor(client)) > 99 then return end
    local g_Cost
	if __isPlayerVIP[client] then
	    g_Cost = 6500
	else
	    g_Cost = 15000
	end
    if getPlayerMoney(client) > g_Cost-1 then
	    takePlayerMoney(client,g_Cost)
	    setPedArmor(client,100)
		outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] kupił kamizelkę za "..g_Cost.."$.",root,0,255,255)
	else
		outputChatBox("● INFO: Aby kupić kamizelkę potrzebujesz "..g_Cost.."$.",client,255,0,0)
	end
end)

--[[addCommandHandler("100hp",
function(plr,cmd)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if not isPlayerCMDEnabled(plr) then return end
	if math.floor(getElementHealth(plr)) > 99 then return end
    local g_Cost
	if __isPlayerVIP[plr] then
	    g_Cost = 3800
	else
	    g_Cost = 6500
	end
    if getPlayerMoney(plr) > g_Cost-1 then
	    takePlayerMoney(plr,g_Cost)
	    setElementHealth(plr,100)
		outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] uzdrowił się za "..g_Cost.."$.",root,0,255,255)
	else
		outputChatBox("● INFO: Aby kupic życie potrzebujesz "..g_Cost.."$.",plr,255,0,0)
	end
end)]]

addEvent("Server:100hpCommand",true)
addEventHandler("Server:100hpCommand",resourceRoot,
function()
    if isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
    if getElementData(client,"pCommands") == false or getPlayerTeam(client) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
		triggerClientEvent(client,"Client:isPlayerDamage",client)
		return
	end
	if math.floor(getElementHealth(client)) > 99 then return end
    local g_Cost
	if __isPlayerVIP[client] then
	    g_Cost = 3800
	else
	    g_Cost = 6500
	end
    if getPlayerMoney(client) > g_Cost-1 then
	    takePlayerMoney(client,g_Cost)
	    setElementHealth(client,100)
		outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] uzdrowił się za "..g_Cost.."$.",root,0,255,255)
	else
		outputChatBox("● INFO: Aby kupic życie potrzebujesz "..g_Cost.."$.",client,255,0,0)
	end
end)

addCommandHandler("vkolor",
function(p,cmd,r1,g1,b1,r2,g2,b2)
    local vehicle = getPedOccupiedVehicle(p)
    local r1,g1,b1,r2,g2,b2 = r1 or math.random(0,255),g1 or math.random(0,255),b1 or math.random(0,255),r2 or math.random(0,255),g2 or math.random(0,255),b2 or math.random(0,255)
	if vehicle then
        setVehicleColor(vehicle,r1,g1,b1,r2,g2,b2)
		--outputChatBox("● INFO: Kolor pojazdu został zmieniony.",p,0,255,255)
	end
end)

addCommandHandler("kolor",
function(plr,cmd,r,g,b)
    if not isPlayerAdmin(plr) then
		if tonumber(getElementData(plr,".LVL")) < 20 then
			if not __isPlayerVIP[plr] then outputChatBox("● INFO: Kolor nick'a może zmianiać tylko VIP lub gracz który osiągnął co najmniej 20 Level.",plr,255,0,0,true) return end
		end
	end
    if not isPlayerCMDEnabled(plr) then return end
    local red = r or math.random(50,255)
	local green = g or math.random(50,255)
	local blue = b or math.random(50,255)
    setPlayerNametagColor(plr,red,green,blue)
	outputChatBox("● INFO: Kolor nicka został zmieniony.",plr,0,255,255)
end)

addCommandHandler("kill",
function(plr,cmd)
    if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if not isPlayerCMDEnabled(plr) then return end
	if not isPedDead(plr) then
	    setPlayerMoney(plr,0)
        killPed(plr,plr)
	end
end)

addEvent("Server:SpawnPlayer",true)
addEventHandler("Server:SpawnPlayer",resourceRoot,
function(table)
	local x,y,z,rot,skinID = table[1],table[2],table[3],table[4],table[5]
    spawnPlayer(client,x,y,z,rot,skinID,0,0,nil)
	fadeCamera(client,true)
	setCameraTarget(client,client)
	if playerData[client]["__spawnArmor"] == true then
	    setPedArmor(client,100)
	end
	--triggerClientEvent(client,"Client:SpawnPlayer",client)
	--giveWeapon(client,5,1)
    givePlayerMoney(client,1500)
	--giveWeapon(client,24,100)
	--giveWeapon(client,26,150)
	--giveWeapon(client,32,300)
	--giveWeapon(client,30,250)
	--giveWeapon(client,1,1)
	setElementData(client,"pCommands",true)
	--setElementData(client,"pTeleporty",true)
	--setElementData(client,"isPlayerDamage",false)
	if __isPlayerVIP[client] then givePlayerMoney(client,5000) end
end)

addEvent("Server:GivePlayerWeapon",true)
addEventHandler("Server:GivePlayerWeapon",resourceRoot,
function(table)
    local weaponID,weaponAmmo = table[1],table[2]
    giveWeapon(client,weaponID,weaponAmmo)
end)

addEventHandler("onPlayerJoin",root,
function()
    local __numPlayers = getPlayerCount()
	local __maxPlayers = getMaxPlayers()
	local __playerSerial = getPlayerSerial(source)
	local __playerName = getPlayerName(source)
	local __playerIP = getPlayerIP(source)
    --[[outputChatBox("● INFO: ["..__playerName.."] #00FFFFdołączył(a) do gry [IP: "..__playerIP.."] ["..__numPlayers.."/"..__maxPlayers.."].",root,0,255,255,true)]]
	exports.killmessages:outputMessage("● "..__playerName.." dołączył(a) do gry.",root,0,255,255)
    downloadingResources(source)
end)

function downloadingResources(plr)
	playerData[plr] = {}
    playerData[plr]["textDisplay"] = textCreateDisplay()
    playerData[plr]["textItem"] = textCreateTextItem("\nTrwa ładowanie zasobów serwera.\nProszę czekać...",0.5,0.5,"high",255,255,255,200,2,"center","center",222)
    textDisplayAddText(playerData[plr]["textDisplay"],playerData[plr]["textItem"])
    textDisplayAddObserver(playerData[plr]["textDisplay"],plr)
	setPlayerHudComponentVisible(plr,"radar",false)
	fadeCamera(plr,true)
	setPlayerMoney(plr,0,false)
	setCameraMatrix(plr,-1360,1618,100,-1450,1200,100)
	setElementDimension(plr,math.random(123,65535))
end

addEventHandler("onPlayerQuit",root,
function(__quitType,__reason,__responsibleElement)
	if __quitType == "Kicked" then return end
    if __quitType == "Banned" then return end
    local __numPlayers = getPlayerCount() - 1
	local __maxPlayers = getMaxPlayers()
	local __playerName = getPlayerName(source)
	--[[outputChatBox("● INFO: ["..__playerName.."] #FF0000opuścił(a) serwer ["..__quitType.."] ["..__numPlayers.."/"..__maxPlayers.."].",root,255,0,0,true)]]
	exports.killmessages:outputMessage("● "..__playerName.." opuścił(a) serwer.",root,255,0,0)
    if serverData.customVeh[source] then
	    setElementData(serverData.customVeh[source],"vehOwner",nil)
	    destroyElement(serverData.customVeh[source])
		serverData.customVeh[source] = nil
	end
end)

function isTargetPlayer(thePlayer)
    local targetCamera = getCameraTarget(thePlayer)
	if targetCamera then
	    local targetElement = getElementType(targetCamera)
		if targetElement then
        	if targetElement == "player" or targetElement == "vehicle" then
        	    return true
        	else
     	       return false
    	    end
		end
	end
end

addEvent("removeClientFromVehicle",true)
addEventHandler("removeClientFromVehicle",resourceRoot,
function()
    removePedFromVehicle(client)
end)

addEventHandler("onVehicleExplode",root,
function()
	if serverData.respawnVeh[source] then
        setTimer(respawnVehicle,10000,1,source)
		setVehicleLocked(source,false)
	else
	    local vehOwner = getElementData(source,"vehOwner")
		if vehOwner then
		    serverData.customVeh[vehOwner] = nil
			setElementData(source,"vehOwner",false)
		end
	    local isCarPrivate = getElementData(source,"isPrivCar")
		if not isCarPrivate then
	        destroyElement(source)
			--[[setTimer(function()
				if isElement(source) then destroyElement(source) end
			end,5000,1)]]
		end
	end
end)

addEventHandler("onVehicleRespawn",root,
function()
    setVehicleDamageProof(source,true)
    fixVehicle(source)
	if serverData.respawnVeh[source] then
		setVehicleColor(source,math.random(50,255),math.random(50,255),math.random(50,255),math.random(50,255),math.random(50,255),math.random(50,255))
	    local upgrades = getVehicleUpgrades(source)
		for upgradeKey,upgradeValue in ipairs(upgrades) do
			removeVehicleUpgrade(source,upgradeValue)
		end
	end
end)

function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"),"Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving,isDriving and getPedOccupiedVehicle(ped) or nil
end

addEventHandler("onPlayerQuit",root,
function()
    destroyPlayerID(source)
	playerData[source] = nil
end)

function removePlayerAllData(p)
	local getMyData = getAllElementData(p)
	for i,data in pairs(getMyData) do
	    removeElementData(p,i)
	end
end

function cenzurujSlowo(slowo)
    return string.gsub(slowo,"(.).*(.)","%1**%2")
end

function cenzurujZdanie(zdanie)
    local cnt=0
    for _,slowo in ipairs(serverData.cenzurowane_slowa) do
        zdanie,lcnt=string.gsub(zdanie,slowo,cenzurujSlowo)
        if lcnt and lcnt>0 then cnt=cnt+lcnt end
    end
    return zdanie,cnt
end

addEvent("Server:GivePlayerMoney",true)
addEventHandler("Server:GivePlayerMoney",resourceRoot,
function(money)
    givePlayerMoney(client,tonumber(money))
end)

addEvent("Server:SetPlayerPosition",true)
addEventHandler("Server:SetPlayerPosition",resourceRoot,
function(table)
	local tp_X,tp_Y,tp_Z = table[1],table[2],table[3]
	setElementPosition(client,tp_X,tp_Y,tp_Z)
end)

addEvent("Server:ChangePlayerPosition",true)
addEventHandler("Server:ChangePlayerPosition",resourceRoot,
function(table)
	local tp_X,tp_Y,tp_Z,tp_Int,tp_Dim = table[1],table[2],table[3],table[4],table[5]
	local vehicle = getPedOccupiedVehicle(client)
	if vehicle then
		setElementPosition(vehicle,tp_X,tp_Y,tp_Z)
	else
		setElementPosition(client,tp_X,tp_Y,tp_Z)
	end
	if tp_Int then setElementInterior(client,tp_Int) else setElementInterior(client,0) end
	if tp_Dim then setElementDimension(client,tp_Dim) else setElementDimension(client,0) end
	--[[fadeCamera(client,true)]]
	setCameraTarget(client,client)
end)

addEvent("Server:setPedArmor",true)
addEventHandler("Server:setPedArmor",resourceRoot,
function(i)
	if i > getPedArmor(client) then
		setPedArmor(client,i)
	end
end)

addEvent("fixElementInterior",true)
addEventHandler("fixElementInterior",resourceRoot,
function(i)
	setElementInterior(client,i)
	local __theVehicle = getPedOccupiedVehicle(client)
	if __theVehicle then setElementInterior(__theVehicle,i) end
end)

addEvent("fixElementDimension",true)
addEventHandler("fixElementDimension",resourceRoot,
function(d)
	setElementDimension(client,d)
	local __theVehicle = getPedOccupiedVehicle(client)
	if __theVehicle then setElementDimension(__theVehicle,d) end
end)

local duel = {}
duel.disable = {}
duel.play = {}
duel.interior = 1
duel.spawnpoints = {
    {1413,-41,1000.9000244141,52.0018310},
	{1366.6999511719,-2.2999999523163,1000.9000244141,228.005493},
}

addCommandHandler("solo-on",
function(plr,cmd)
    duel.disable[plr] = nil
	outputChatBox("● INFO: Odblokowałeś(aś) możliwość zapraszania Cię na pojedynek.",plr,0,255,255,true)
end)

addCommandHandler("solo-off",
function(plr,cmd)
    duel.disable[plr] = true
	outputChatBox("● INFO: Zablokowałeś(aś) możliwość zapraszania Cię na pojedynek.",plr,255,0,0,true)
end)

addCommandHandler("solo",
function(plr,cmd,id)
    if not isPlayerCMDEnabled(plr) then return end
    if isPlayerCanPlayDuel(plr) then
    	if id then
	    	local playerID = getPlayerByID(id)
			if playerID and playerID ~= plr then
		    	if isPlayerCanPlayDuel(playerID) then
			    	triggerClientEvent(plr,"setupDuelWeapon",plr,playerID)
				else
			    	outputChatBox("● INFO: ["..getPlayerName(playerID).."] nie może stoczyć pojedynku w tej chwili.",plr,255,0,0,true)
				end
			else
			    outputChatBox("● INFO: Podałeś(aś) błędne ID.",plr,255,0,0,true)
			end
		end
	else
	    outputChatBox("● INFO: Nie możesz w tej chwili zapraszać na pojedynek.",plr,255,0,0,true)
	end
end)

addEvent("invitePlayerDuel",true)
addEventHandler("invitePlayerDuel",resourceRoot,
function(table)
	local plr,weaponName = table[1],table[2]
    if plr and client and weaponName then
	    if isPlayerCanPlayDuel(plr) then
	        triggerClientEvent(plr,"setupDuelRequest",plr,{client,weaponName})
		else
		    outputChatBox("● INFO: ("..getPlayerName(plr)..") nie może stoczyć pojedynku w tej chwili.",client,255,0,0,true)
		end
	end
end)

addEvent("onPlayerDuelRequest",true)
addEventHandler("onPlayerDuelRequest",resourceRoot,
function(table)
	local invitingPlayer,invitingWeapon,bool = table[1],table[2],table[3]
    if bool == true then
    	if invitingPlayer and client and invitingWeapon then
	    	if isPlayerCanPlayDuel(invitingPlayer) and isPlayerCanPlayDuel(client) then
    	    	local dimension = math.random(99,65535)
    	    	setPlayerDuelArea(client,1,dimension,invitingWeapon,invitingPlayer)
		    	setPlayerDuelArea(invitingPlayer,2,dimension,invitingWeapon,client)
			end
		end
	else
	    if invitingPlayer and client then
		    outputChatBox("● INFO: ("..getPlayerName(client)..") odrzucił(a) zaproszenie na pojedynek.",invitingPlayer,255,0,0,true)
		end
	end
end)

function setPlayerDuelArea(plr,spawnID,dimensionID,weaponID,playWith)
    triggerClientEvent(plr,"hideGuiElements",plr)
	duel.play[plr] = {}
	duel.play[plr].isPlayed = true
	duel.play[plr].playWith = playWith
	setElementData(plr,"pCommands",false)
    removePedFromVehicle(plr)
	removePedJetPack(plr)
	setElementInterior(plr,duel.interior)
	setElementDimension(plr,dimensionID)
	setElementPosition(plr,duel.spawnpoints[spawnID][1],duel.spawnpoints[spawnID][2],duel.spawnpoints[spawnID][3]+1)
	setElementRotation(plr,0,0,duel.spawnpoints[spawnID][4])
	takeAllWeapons(plr)
	triggerClientEvent(plr,"onClientPlayerDuelStart",plr)
	setElementHealth(plr,100)
	setPedArmor(plr,100)
	giveWeapon(plr,weaponID,999,true)
	setElementFrozen(plr,true)
	setTimer(setElementFrozen,5000,1,plr,false)
end

function endPlayerDuelArea()
    
end

function isPlayerCanPlayDuel(plr)
    if isPedDead(plr) then return false end
	if duel.play[plr] then
	    if duel.play[plr].isPlayed == true then
		    return false
		end
	end
	if getElementData(plr,"pCommands") ~= true then return false end
	--[[if getPlayerTeam(plr) then return false end]]
	if isPlayerPlayMiniGame(plr) == true then return false end
	if duel.disable[plr] then return false end
	--[[if isPlayerActiveGUI(plr) then return false end]]
	return true
end

function onDuelPlayerDead(plr)
    if duel.play[plr] then
    	if duel.play[plr].isPlayed == true then
	    	if not isPedDead(duel.play[plr].playWith) then
		    	outputChatBox("● INFO: Gracz ["..getPlayerName(duel.play[plr].playWith).."] wygrał pojedynek z ["..getPlayerName(plr).."].",root,0,255,255)
				triggerClientEvent(duel.play[plr].playWith,"Client:ShowSpawnMenu",duel.play[plr].playWith)
			end
		end
		duel.play[duel.play[plr].playWith] = nil
		duel.play[plr] = nil
	end
end

addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart,stealth)
    onDuelPlayerDead(source)
end)

addEventHandler("onPlayerQuit",root,
function()
    onDuelPlayerDead(source)
end)

addEventHandler("onResourceStart",resourceRoot,
function()
	setTimer(function()
		local g_Settings = serverData.settings
	    setGameType(g_Settings["game_type"])
	    setMapName(g_Settings["map_name"])
		setWeather(g_Settings["weather"])
		setTime(g_Settings["time"],0)
		for i,g_Vehicle in pairs(getElementsByType("vehicle")) do
		    serverData.respawnVeh[g_Vehicle] = true
			toggleVehicleRespawn(g_Vehicle,true)
		    setVehicleIdleRespawnDelay(g_Vehicle,3*60000)
		    setVehicleDamageProof(g_Vehicle,true)
		    setVehicleColor(g_Vehicle,math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255))
		end
		outputServerLog("* INFO: Trwa uruchamianie pozostałych zasobów...")
		for i,resName in pairs(serverData.includes) do
			startResource(getResourceFromName(tostring(resName)),false,true,true,true,true,true,true,true,true)
		end
	end,1000,1)
	for i,resName in pairs(serverData.stop_resources) do
	    if getResourceFromName(tostring(resName)) then
	        stopResource(getResourceFromName(tostring(resName)),false)
		end
	end
	for i,v in pairs(getElementsByType("player")) do
	    downloadingResources(v)
	end
end)

addEventHandler("onResourceStop",resourceRoot,
function()
	resetWaterLevel()
    for i,v in pairs(getTimers()) do
	    killTimer(v)
	end
end)

serverData.name_colors = {
	{143,143,143},{0,0,255},{0,255,255},{0,255,0},{255,140,0},{255,165,0},
	{255,20,147},{255,69,0},{255,28,174},{153,50,204},{148,0,211},{125,38,205},
	{255,255,0},
}

addEvent("Client:DownloadEnd",true)
addEventHandler("Client:DownloadEnd",resourceRoot,
function()
	textDestroyTextItem(playerData[client]["textItem"])
	textDestroyDisplay(playerData[client]["textDisplay"])
	setPlayerMoney(client,0)
	assingPlayerID(client)
	local __nameColor = serverData.name_colors[math.random(1,#serverData.name_colors)]
	setPlayerNametagColor(client,unpack(__nameColor))
	setElementData(client,"Kills",0)
	setElementData(client,"Deaths",0)
	setElementData(client,"Gang","-")
	setElementData(client,".EXP",0)
	setElementData(client,".LVL",0)
	__bank.players[client] = 0
	--[[setPedWalkingStyle(client,56)]]
end)

local __chatSpam = {}
__chatSpam.players = {}

addEventHandler("onPlayerChat",root,
function(g_Message,g_MessageType)
    cancelEvent()
    if g_MessageType == 0 then
	    --if __isPlayerLogin[source] then
		    if not __chatSpam.players[source] then
				__chatSpam.players[source] = {}
			end
			--outputChatBox(tostring(#__chatSpam.players[source]))
			if #__chatSpam.players[source] > 4 then
			    if not isPlayerMuted(source) then
					mutePlayer(source)
				end
			return end
			for i,v in pairs(__chatSpam.players[source]) do
				--outputChatBox(tostring("I: "..i))
				--outputChatBox(tostring("V: "..v))
				if v == g_Message then outputChatBox("● INFO: Nie powtarzaj się!",source,255,0,0) return end
			end
			table.insert(__chatSpam.players[source],g_Message)
			local g_ID = getElementData(source,"ID")
			if not g_ID then return end
			local red,green,blue = getPlayerNametagColor(source)
			local g_Message = removeHEXFromString(cenzurujZdanie(g_Message))
			local g_PlayerName = removeHEXFromString(getPlayerName(source))
			outputServerLog("CHAT: [ID: "..g_ID.."] "..g_PlayerName..": "..string.lower(g_Message))
			outputChatBox("● [ID: "..g_ID.."] "..g_PlayerName..": #FFFFFF"..string.lower(g_Message),root,red,green,blue,true)
		--else
		    --outputChatBox("● INFO: Tylko zalogowani gracze mogą wysyłać wiadomości.",source,255,0,0)
		--end
	end
end)

setTimer(function() 
	__chatSpam.players = {}
end,20000,0)

function mutePlayer(plr)
	setPlayerMuted(plr,true)
	outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] został uciszony na 120 sekund przez Anty-Spam.",root,255,0,0)
	setTimer(unmutePlayer,1000*120,1,plr)
end

function unmutePlayer(plr)
	setPlayerMuted(plr,false)
	outputChatBox("● INFO: Zostałeś automatycznie odciszony,",root,0,255,255)
end

serverData.privatemsg = {}

addEventHandler("onPlayerPrivateMessage",root,
function(message,recipient)
    cancelEvent()
end)

addEventHandler("onPlayerQuit",root,
function()
	serverData.privatemsg[source] = nil
end)

addCommandHandler("pw-off",
function(plr,cmd)
	serverData.privatemsg[plr] = true
	outputChatBox("● INFO: Prywatne wiadomości zostały zablokowane.",plr,255,0,0)
end)

addCommandHandler("pw-on",
function(plr,cmd)
	serverData.privatemsg[plr] = nil
	outputChatBox("● INFO: Prywatne wiadomości zostały odblokowane.",plr,0,255,255)
end)

addCommandHandler("pw",
function(plr,cmd,_id,...)
    if not __isPlayerLogin[plr] then outputChatBox("● INFO: Tylko zalogowani gracze mogą wysyłać prywatne wiadomości.",plr,255,0,0) return end
	if isPlayerMuted(plr) then return end
    local _id = tonumber(_id)
	local pID = tonumber(getElementData(plr,"ID"))
	if _id == pID then return end
	if _id and ... then
		local recipient = getPlayerByID(_id)
		if recipient then
		    if serverData.privatemsg[recipient] == true then outputChatBox("● INFO: Ten gracz ma zablokowane prywatne wiadomości.",p,255,0,0) return end
		    local recipientName = getPlayerName(recipient)
			local playerName = getPlayerName(plr)
			local g_Message = table.concat({...}," ")
			if string.len(g_Message) < 75 then
				--outputChatBox(tostring(#__chatSpam.players[plr]))
				if #__chatSpam.players[plr] > 4 then
					if not isPlayerMuted(plr) then
						mutePlayer(plr)
					end
				return end
				for i,v in pairs(__chatSpam.players[plr]) do
					--outputChatBox(tostring("I: "..i))
					--outputChatBox(tostring("V: "..v))
					if v == g_Message then outputChatBox("● INFO: Nie powtarzaj się!",plr,255,0,0) return end
				end
				table.insert(__chatSpam.players[plr],g_Message)
				outputChatBox("● [Prywatna Wiadomość > "..removeHEXFromString(recipientName).." ID: ".._id.."]:#FFFFFF " .. g_Message,plr,0,255,0,true)
				outputChatBox("● [Prywatna Wiadomość < "..removeHEXFromString(playerName).." ID: "..pID.."]:#FFFFFF " .. g_Message,recipient,255,255,0,true)
				outputServerLog("PW: ["..removeHEXFromString(playerName).." ID: "..pID.."] -> ["..removeHEXFromString(recipientName).." ID: ".._id.."]: "..g_Message)
				triggerClientEvent(recipient,"clientMsgBox",recipient,"● Otrzymałeś(aś) prywatną wiadomość.")
			    for i,v in pairs(getElementsByType("player")) do
					if isPlayerAdmin(v) then
					    local visibleTo = v
					    outputConsole("PW: ["..removeHEXFromString(playerName).." ID: "..pID.."] -> ["..removeHEXFromString(recipientName).." ID: ".._id.."]: "..g_Message,visibleTo)
					end
				end
			else
			    outputChatBox("● INFO: Wiadomość jest zbyt długa.",plr,255,0,0)
			end
		else
		    outputChatBox("● INFO: Nie ma gracza o takim ID.",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: /pw <id gracza> <treść wiadomości>",plr,255,0,0)
	end
end)

addCommandHandler("do",
function(plr,cmd,playerid,...)
    if isPlayerMuted(plr) then return end
    if tonumber(playerid) and ... then
	    if playerid == tonumber(getElementData(plr,"ID")) then return end
	    local thePlayer = getPlayerByID(playerid)
		if thePlayer then
		    local playerName = getPlayerName(thePlayer)
			if playerName then
				local g_Message = table.concat({...}, " ")
				if string.len(g_Message) < 75 then
					--outputChatBox(tostring(#__chatSpam.players[plr]))
					if #__chatSpam.players[plr] > 4 then
						if not isPlayerMuted(plr) then
							mutePlayer(plr)
						end
					return end
					for i,v in pairs(__chatSpam.players[plr]) do
						--outputChatBox(tostring("I: "..i))
						--outputChatBox(tostring("V: "..v))
						if v == g_Message then outputChatBox("● INFO: Nie powtarzaj się!",plr,255,0,0) return end
					end
					table.insert(__chatSpam.players[plr],g_Message)
				    local g_Message = cenzurujZdanie(g_Message)
			        local myR,myG,myB = getPlayerNametagColor(plr)
				    local r,g,b = getPlayerNametagColor(thePlayer)
					local HEX = RGBtoHEX(r,g,b)
					outputChatBox("● [ID: "..getElementData(plr,"ID").."] "..removeHEXFromString(getPlayerName(plr))..": "..HEX..""..removeHEXFromString(playerName).."#ffffff, "..removeHEXFromString(g_Message),root,myR,myG,myB,true)
					outputServerLog("CHAT: [ID: "..getElementData(plr,"ID").."] "..getPlayerName(plr)..": "..playerName..", "..removeHEXFromString(g_Message))
				else
				    outputChatBox("● INFO: Wiadomość jest zbyt długa.",plr,255,0,0)
				end
			end
		else
		    outputChatBox("● INFO: Nie ma gracza o takim ID.",plr,255,0,0)
		end
	else
	    outputChatBox("● INFO: /do <id gracza> <treść wiadomości>",plr,255,0,0)
	end
end)

addCommandHandler("walking",
function(plr,cmd,styleID)
	if not styleID then
		outputChatBox("● INFO: /walking <id stylu chodzenia>",plr,255,0,0)
		return
	end
    --[[if not isPlayerAdmin(plr) then
		if tonumber(getElementData(plr,".LVL")) < 5 then
			if not __isPlayerVIP[plr] then outputChatBox("● INFO: Styl chodzenia może zmianiać tylko VIP lub gracz który osiągnął co najmniej 5 Level.",plr,255,0,0,true) return end
		end
	end]]
	local succes = setPedWalkingStyle(plr,styleID)
	if succes then
		outputChatBox("● INFO: Styl chodzenia zmieniony pomyślnie na ID: "..styleID,plr,0,255,255)
	else
		outputChatBox("● INFO: Podałeś(aś) nieprawidłowe ID.",plr,255,0,0)
	end
end)

addEventHandler("onPickupHit",root,
function(thePlayer)
	local pickupType = getPickupType(source)
	if pickupType == 0 and getElementHealth(thePlayer) == 100 then cancelEvent() return end
	if pickupType == 2 then
		local pickupWeapon = getPickupWeapon(source)
		local pickupAmmo = getPickupAmmo(source)
        triggerClientEvent(thePlayer,"clientMsgBox",thePlayer,"● Podniosłeś(aś) Broń: "..getWeaponNameFromID(pickupWeapon).." Ammunicja: "..pickupAmmo.."")
	end
end)

pack_system = {}
pack_system.id = {}
pack_system.used = {}
pack_system.list = {
    {1986.462890625,1582.5556640625,22.7734375,15000},
	{1901.083984375,1628.4619140625,72.2578125,25000},
	{2161.9931640625,1483.6083984375,24.140625,22000},
	{2202.935546875,1285.9482421875,23.622676849365,12500},
	{2014.74609375,1007.9501953125,39.091094970703,15000},
	{2241.0810546875,1085.6650390625,33.5234375,35000},
	{1613.125,1448.630859375,33.095726013184,24500},
	{1077.5771484375,1529.43359375,52.416473388672,15000},
	{1410.94140625,2102.025390625,12.015625,15000},
	{2008.20703125,2334.6455078125,23.8515625,15000},
	{2092.7119140625,2414.83203125,74.578598022461,15000},
	{2219.59765625,2465.9326171875,-7.4475412368774,15000},
	{2390.0009765625,1565.8681640625,64.443016052246,15000},
	{2879.3564453125,1592.8916015625,10.8203125,15000},
	{2933.0810546875,2119.3369140625,18.390625,15000},
	{2781.6982421875,2011.4208984375,4.1091289520264,15000},
	{2618.8369140625,2721.4169921875,36.538642883301,18000},
	{2605.7763671875,2806.2919921875,10.8203125,15000},
	{2267.681640625,2812.3359375,18.929651260376,15000},
	{2006.89453125,2909.1455078125,47.82311630249,15000},
	{1749.67578125,2820.8671875,10.8359375,15000},
	{1450.08984375,2779.0888671875,18.8203125,15000},
	{1064.1201171875,2923.4208984375,41.880180358887,15000},
	{563.853515625,2875.7333984375,1.8298072814941,16000},
	{264.021484375,2898.9072265625,9.0765953063965,15000},
	{413.1962890625,2536.69140625,19.1484375,15000},
	{243.251953125,1861.05078125,17.926181793213,15000},
	{216.5048828125,1823.052734375,6.4140625,15000},
	{215.26953125,1467.8349609375,23.734375,15000},
	{-194.380859375,1890.8291015625,114.81405639648,15000},
	{-340.744140625,1548.0576171875,75.5625,12000},
	{-608.08984375,1831.6064453125,7,15000},
	{-852.5859375,1877.1640625,22.924459457397,15000},
	{-870.5947265625,1875.2861328125,139.62829589844,15000},
	{-1066.376953125,2194.67578125,87.721260070801,15000},
	{-1311.2158203125,2516.8076171875,87.170013427734,15000},
	{-1671.1318359375,2492.7431640625,87.153648376465,15000},
	{-1952.896484375,2376.095703125,49.499954223633,15000},
	{-1837.6357421875,2056.513671875,9.8577241897583,15000},
	{-1506.5283203125,1372.712890625,3.5508880615234,15000},
	{-1390.2373046875,1482.4658203125,1.8671875,15000},
	{-1022.140625,935.412109375,42.2578125,15000},
	{-1266.8173828125,965.47265625,133.05139160156,15000},
	{-684.94140625,939.5283203125,13.6328125,15000},
	{-408.0673828125,1326.9326171875,12.677808761597,15000},
	{-765.16015625,1121.544921875,33.21342086792,15000},
	{-146.3759765625,1054.330078125,20.010936737061,15000},
	{315.3994140625,1146.3603515625,8.5859375,15000},
	{586.0595703125,872.265625,-42.497318267822,15000},
	{1031.5576171875,1021.1376953125,26.921875,15000},
	{1267.9462890625,838.353515625,25.890625,15000},
	{1628.2685546875,600.248046875,1.7578125,15000},
	{1725.9873046875,480.3349609375,4.8828125,15000},
	{2770.0888671875,598.404296875,4.9769687652588,25000},
	{2893.72265625,810.4765625,14.229452133179,15000},
	{2787.3623046875,961.7958984375,14.255933761597,15000},
	{2661.4208984375,1187.7568359375,21.786987304688,15000},
	{2604.98046875,1352.3935546875,78.476387023926,15000},
	{2345.5654296875,1284.236328125,67.46875,15000},
	{1774.6455078125,884.4853515625,26.8828125,15000},
	{1919.0166015625,969.3544921875,10.8203125,15000},
	{2009.0419921875,1233.1357421875,23.110416412354,15000},
	{1949.4326171875,1350.3076171875,15.8434715271,15000},
	{1931.3896484375,1635.9873046875,22.767917633057,15000},
	{1920.267578125,1808.2158203125,12.743692398071,15000},
	{1687.6826171875,1844.546875,21.089450836182,15000},
	{1746.3779296875,2103.4794921875,15.669003486633,15000},
	{1676.345703125,2198.0625,32.633815765381,15000},
	{1460.5361328125,2156.767578125,24.106624603271,15000},
	{1605.0166015625,2391.5849609375,18.820369720459,15000},
	{1607.455078125,1786.79296875,30.46875,15000},
	{1571.9619140625,1681.3466796875,14.822175979614,15000},
	{1687.369140625,1167.0244140625,34.7890625,15000},
	{1093.8154296875,2107.623046875,15.350400924683,15000},
	{926.0361328125,2085.2548828125,10.8203125,15000},
	{1156.087890625,2222.0244140625,10.8203125,15000},
	{1432.6826171875,2619.94140625,19.580575942993,15000},
	{2099.7412109375,2741.1708984375,10.8203125,15000},
	{2230.9638671875,2813.828125,10.8203125,15000},
	{2172.193359375,2465.2724609375,30.5625,15000},
	{2066.3134765625,2436.2265625,49.5234375,15000},
	{2443,2167.7236328125,22.173961639404,15000},
	{2490.2451171875,2120.7158203125,20.55019569397,15000},
	{2541.9921875,2023.2822265625,10.814988136292,15000},
	{2499.0703125,1148.9345703125,22.023197174072,15000},
	{2049.1982421875,1916.13671875,21.491306304932,15000},
	{2173.591796875,2066.470703125,27.453308105469,15000},
	{1884.58984375,2426.4091796875,20.828125,15000},
	{1868.345703125,2117.408203125,28.922180175781,15000},
	{1750.611328125,2137.2666015625,11.129119873047,15000},
	{1398.5673828125,1931.271484375,23.959726333618,15000},
	{1315.5478515625,1912.486328125,10.8203125,15000},
	{1444.125,2534.1455078125,22.314725875854,15000},
	{1746.521484375,2659.15625,10.81294631958,15000},
	{1973.486328125,2755.7998046875,10.8203125,15000},
	{2593.236328125,2638.193359375,114.03125,15000},
	{2462.4013671875,2334.0146484375,82.7734375,15000},
	{2329.5615234375,1844.5234375,55.9280128479,15000},
	{2516.3681640625,1568.0546875,8.4170799255371,15000},
	{606.4794921875,1252.0732421875,22.426961898804,15000},
}

addEventHandler("onPlayerJoin",root,
function()
    pack_system.used[source] = {}
end)

addEventHandler("onResourceStart",resourceRoot,
function()
    for i,v in pairs(getElementsByType("player")) do
	    pack_system.used[v] = {}
	end
    for i,v in pairs(pack_system.list) do
	    local pack_pickup = createPickup(v[1],v[2],v[3],3,1279,0,1)
		pack_system.id[pack_pickup] = i
		addEventHandler("onPickupHit",pack_pickup,
		function(p)
		    if not __isPlayerLogin[p] then return end
		    local pack_id = getPackUID(source)
			if pack_system.used[p][pack_id] == true then return exports.ps_mass:showBox("Już wcześniej odnalazłeś(aś) tą paczkę.", p, 255, 20, 20, 3000) end
			pack_system.used[p][pack_id] = true
			local pack_money = pack_system.list[pack_id][4]
			givePlayerMoney(p,pack_money)
			local randomEXP = math.random(20,70)
			addPlayerEXP(p,randomEXP)
            exports.ps_mass:showBox("Podniosłeś(aś) paczkę "..countPlayerUsedPacks(p).."/"..#pack_system.list.." w której znajdowało się "..pack_money.."$ +"..randomEXP.." EXP", p, 0, 204, 0, 5000)
		end)
	end
end)



function getPackUID(e)
    local pack_id = pack_system.id[e] or false
    return pack_id
end

function countPlayerUsedPacks(p)
    local count = 0
	for pack_id,pack_value in pairs(pack_system.used[p]) do
	    count = count + 1
	end
	return count
end

function getPlayerUsedPacks(p)
    local i = 0
	local a = ""
    for pack_id,pack_value in pairs(pack_system.used[p]) do
	    local b
		b = pack_id
		if i > 0 then
	        a = a..";"..b
		else
			a = b
		end
	    i = i + 1
	end
	return tostring(a)
end

jail = {}
jail.team = createTeam("Jail",255,255,255)
jail.timer = {}

function isPlayerInJail(plr)
	local plrTeam = getPlayerTeam(plr)
	if plrTeam then
		if plrTeam ~= jail.team then return false end
		if plrTeam == jail.team then return true end
	else
		return false
	end
end

function setPlayerJail(plr,bool,time,reason)
    if isPedDead(plr) then return false end
	if getElementData(plr,"pCommands") == false then return false end
    if bool == true then
		if not isPlayerInJail(plr) then
		    takeAllWeapons(plr)
			setPlayerTeam(plr,jail.team)
			removePedFromVehicle(plr)
			setElementDimension(plr,tonumber(getElementData(plr,"ID")))
			setElementInterior(plr,6,263.89999389648,77.400001525879,1001.0999755859)
			--[[triggerClientEvent(plr,"Client:Jail",plr)]]
			jail.timer[plr] = setTimer(setPlayerJail,time*1000,1,plr,false)
			outputChatBox("● INFO: Gracz ["..getPlayerName(plr).."] został uwięziony na ["..time.." sekund] Powód: ["..reason.."]",root,255,0,0)
		end
	end
	if bool == false then
	    if not isElement(plr) then return end
		if isPlayerInJail(plr) then
			if jail.timer[plr] then
			    if isTimer(jail.timer[plr]) then
					killTimer(jail.timer[plr])
				end
				jail.timer[plr] = nil
			end
			setPlayerTeam(plr,nil)
			triggerClientEvent(plr,"Client:ShowSpawnMenu",plr)
		end
	end
end

addCommandHandler("jinfo",
function(p,_)
    if #getPlayersInTeam(jail.team) == 0 then return end
    outputChatBox("● INFO: Gracze w więzieniu("..#getPlayersInTeam(jail.team).."):",p,0,255,255)
	for i,v in pairs(getPlayersInTeam(jail.team)) do
		outputChatBox("● "..getPlayerName(v),p,0,255,255)
	end
end)

serverData.blips = {}

addEventHandler("onPlayerSpawn",root,
function()
	local r,g,b = getPlayerNametagColor(source)
	if not serverData.blips[source] then
		serverData.blips[source] = createBlipAttachedTo(source,0,2.5,r,g,b,150,0,99999.0,root)
	else
		setBlipColor(serverData.blips[source],r,g,b,150)
	end
end)

addEventHandler("onPlayerWasted",root,
function()
	if serverData.blips[source] then
		destroyElement(serverData.blips[source])
		serverData.blips[source] = nil
	end
end)

addEventHandler("onPlayerQuit",root,
function()
	if serverData.blips[source] then
		destroyElement(serverData.blips[source])
		serverData.blips[source] = nil
	end
end)

local strefa_smierci = {}
strefa_smierci.blokowane_pojazdy = {[464] = true,[592] = true,[577] = true,[425] = true,[520] = true,[432] = true,[449] = true,[537] = true,[538] = true,[570] = true,[569] = true,[590] = true}
strefa_smierci.col = createColCuboid(-1083.4365234375,467.173828125,-8.88337299704552,1856.0,2856.0,1356.0)
strefa_smierci.status = 1
	
addEventHandler("onColShapeHit",strefa_smierci.col,
function(theElement,matchingDimension)
	if strefa_smierci.status ~= 1 then return end
	if matchingDimension then
		if theElement and getElementType(theElement) == "player" then
		if getElementInterior(theElement) ~= 0 then return end
			if not isPedDead(theElement) then
				triggerClientEvent(theElement,"clientMsgBox",theElement,"● Uwaga! Znajdujesz się w Strefie Śmierci i grozi Ci niebiezpieczeństwo.")
			end
		end
	end
end)

addEventHandler("onColShapeLeave",strefa_smierci.col,
function(theElement,matchingDimension)
	if strefa_smierci.status ~= 1 then return end
	if matchingDimension then
		if getElementInterior(theElement) ~= 0 then return end
		if theElement and getElementType(theElement) == "vehicle" then
			if not strefa_smierci.blokowane_pojazdy[getElementModel(theElement)] then return end
			local vehX,vehY,vehZ = getElementPosition(theElement)
			local rotX,rotY,rotZ = getElementRotation(theElement)
			local newX = vehX+math.cos(rotZ)-42
			local newY = vehY+math.cos(rotZ)-42
			setElementPosition(theElement,newX,newY,vehZ)
			setElementRotation(theElement,0,0,rotZ+180)
			local rotX,rotY,rotZ = getElementRotation(theElement)
			setElementRotation(theElement,0,0,(rotX>90 and rotX<270) and (rotZ+180) or rotZ)
			setElementFrozen(theElement,true)
			setTimer(function() 
				if isElement(theElement) then
					setElementFrozen(theElement,false) 
				end
			end,1000,1)
			local vehicleController = getVehicleController(theElement)
			if vehicleController then
				triggerClientEvent(vehicleController,"clientMsgBox",vehicleController,"● Ten pojazd dozwolony jest tylko w Strefie Śmierci.")
			end
			return
		end
	end
end)

addCommandHandler("astrefa",
function(plr,cmd)
	if isPlayerAdmin(plr) then
		if strefa_smierci.status == 1 then
			strefa_smierci.status = 0
			outputChatBox("● INFO: Strefa Śmierci została wyłączona przez Administratora "..getPlayerName(plr)..".",root,255,0,0)
			return
		end
		if strefa_smierci.status == 0 then
			strefa_smierci.status = 1
			outputChatBox("● INFO: Strefa Śmierci została włączona przez Administratora "..getPlayerName(plr)..".",root,0,255,255)
			return
		end
	end
end)

addCommandHandler("servertimers",
function(plr,cmd)
	local count_timers_2 = #getTimers()
	outputChatBox("● INFO: Ilość uruchomionych timerów: "..count_timers_2,plr,0,255,255)
end)

__damagePlayers = {}
addEvent("Server:toggleDamage",true)
addEventHandler("Server:toggleDamage",resourceRoot,
function(bool)
	if not __damagePlayers[client] then __damagePlayers[client] = {} end
	__damagePlayers[client] = bool
end)

addEventHandler("onPlayerQuit",root,
function()
	__damagePlayers[source] = nil
end)

addEventHandler("onPlayerJoin",root,
function()
	__damagePlayers[source] = {}
	__damagePlayers[source] = false
end)

function isPlayerGotDamage(plr)
	return __damagePlayers[plr]
end