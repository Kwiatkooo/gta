__mySerial = "2528E6BF2B8DDDE1349C15D4ADDB02F3"
__isPlayerAdmin = {}

function isPlayerAdmin(p)
    return __isPlayerAdmin[p]
end

addEventHandler("onPlayerQuit",root,
function() 
	__isPlayerAdmin[source] = nil 
end)
	
addEventHandler("onPlayerLogout",root,
function() 
	__isPlayerAdmin[source] = nil 
end)

addEventHandler("onResourceStart",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
		local playerAccount = getPlayerAccount(v)
		if not isGuestAccount(playerAccount) then
			if isObjectInACLGroup("user."..getAccountName(playerAccount),aclGetGroup("Admin")) then __isPlayerAdmin[v] = true end
		end
	end
end)

addEventHandler("onPlayerLogin",root,
function(thePreviousAccount,theCurrentAccount,autoLogin)
	if isObjectInACLGroup("user."..getAccountName(theCurrentAccount),aclGetGroup("Admin")) then __isPlayerAdmin[source] = true end
end)

addCommandHandler("admins",
function(plr,cmd) 
    --[[outputChatBox("● INFO: Lista Administratorów ONLINE:",plr,0,255,255)
	for i,v in pairs(getElementsByType("player")) do
		if isPlayerAdmin(v) then outputChatBox("● "..getPlayerName(v),plr,0,255,255) end
	end]]
	local table = {
		"Luk4s7_"
	}
	outputChatBox("● INFO: Lista Administratorów("..#table.."):",plr,0,255,255,true)
	for i,v in pairs(table) do
		local thePlayer = getPlayerFromName(v)
		if thePlayer then
			outputChatBox("● "..v.." #00FF00(ONLINE)",plr,0,255,255,true)
		else
			outputChatBox("● "..v.." #FF2400(OFFLINE)",plr,0,255,255,true)
		end
	end
end)

addCommandHandler("aexp",
function(plr,cmd,player_id,exp)
	if isPlayerAdmin(plr) then
		local player_id = tonumber(player_id)
		local exp = tonumber(exp)
		if player_id and exp then
			local thePlayer = getPlayerByID(player_id)
			if thePlayer then
				addPlayerEXP(thePlayer,exp)
			end
		end
	end
end)

addCommandHandler("arexp",
function(plr,cmd,player_id,exp)
	if isPlayerAdmin(plr) then
		local player_id = tonumber(player_id)
		local exp = tonumber(exp)
		if player_id and exp then
			local thePlayer = getPlayerByID(player_id)
			if thePlayer then
				removePlayerEXP(thePlayer,exp)
			end
		end
	end
end)

addCommandHandler("aconf",
function(plr,cmd,name,value)
	if isPlayerAdmin(plr) and name and value then
		setServerConfigSetting(tostring(name),tostring(value),false)
	end
end)

addCommandHandler("afps",
function(plr,cmd,fps_limit)
	if isPlayerAdmin(plr) and fps_limit then setFPSLimit(fps_limit) end
end)

addCommandHandler("ajail",
function(plr,cmd,player_id,time,...)
	if isPlayerAdmin(plr) then
	    local player_id = tonumber(player_id)
		local time = time
		local reason = table.concat({...}," ")
		if player_id and reason and time then
			local jailedPlayer = getPlayerByID(player_id)
			if jailedPlayer then
				setPlayerJail(jailedPlayer,true,time,reason)
			end
		else
			outputChatBox("● INFO: /ajail <id gracza> <czas w sekundach> <powód>",plr,255,0,0,true)
		end
	end
end)
addCommandHandler("aunjail",
function(plr,cmd,player_id)
	if isPlayerAdmin(plr) then
	    local player_id = tonumber(player_id)
		if player_id then
			local jailedPlayer = getPlayerByID(player_id)
			if jailedPlayer then
				setPlayerJail(jailedPlayer,false)
			end
		else
			outputChatBox("● INFO: /aunjail <id gracza>",plr,255,0,0,true)
		end
	end
end)

addCommandHandler("agang-delete",
function(plr,cmd,theGang) 
    if isPlayerAdmin(plr) then if gangsTable[theGang] then removeGang(theGang) outputChatBox("● INFO: Gang ["..theGang.."] został usunięty.",plr,255,0,0,true) end end
end)

addCommandHandler("acc",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    for i=0,99 do
		    if i then outputChatBox(" ",root) end
		end
    end
end)

addCommandHandler("atext",
function(plr,cmd,time,...)
    if isPlayerAdmin(plr) then
	    if not ... then return outputChatBox("● INFO: /atext <time> <text>",plr,255,0,0,true) end
		if not time then return outputChatBox("● INFO: /atext <time> <text>",plr,255,0,0,true) end
		if not tonumber(time) then return outputChatBox("● INFO: /atext <time> <text>",plr,255,0,0,true) end
		local time = time*1000
        for i,v in ipairs(getElementsByType("player")) do
            local g_Message = table.concat({...}," ")
            local textDisplay = textCreateDisplay()
            local textItem = textCreateTextItem(tostring("● Admin: "..g_Message),0.5,0.3,"low",255,0,0,255,2,"center","center",150)
            textDisplayAddText(textDisplay,textItem)
            textDisplayAddObserver(textDisplay,v)
            setTimer(textDestroyTextItem,time,1,textItem)
            setTimer(textDestroyDisplay,time,1,textDisplay)
        end
    end
end)

addCommandHandler("aban",
function(plr,cmd,__playerID,...)
    local reason = table.concat({...}," ")
    if isPlayerAdmin(plr) then
	    if __playerID then
		    local bannedPlayer = getPlayerByID(__playerID)
			if bannedPlayer then
			    local IP = true
				local Username = false
				local Serial = true
				local responsiblePlayer = plr
				local reason = tostring(reason) or ""
				outputChatBox("● INFO: Gracz ["..getPlayerName(bannedPlayer).."] został zbanowany przez Administratora: ["..getPlayerName(plr).."] Powód: ["..reason.."].",root,255,0,0)
			    banPlayer(bannedPlayer,IP,Username,Serial,responsiblePlayer,reason)
			end
		end
	end
end)

addCommandHandler("akick",
function(plr,cmd,__playerID,...)
    local reason = table.concat({...}," ")
    if isPlayerAdmin(plr) then
	    if __playerID then
		    local kickedPlayer = getPlayerByID(__playerID)
			if kickedPlayer then
				local responsiblePlayer = plr
				local reason = tostring(reason) or ""
				outputChatBox("● INFO: Gracz ["..getPlayerName(kickedPlayer).."] został wyrzucony przez Administratora: ["..getPlayerName(plr).."]  Powód: ["..reason.."] .",root,255,0,0)
			    kickPlayer(kickedPlayer,responsiblePlayer,reason)
			end
		end
	end
end)

local doPlayerWarn = {}
addCommandHandler("awarn",
function(plr,cmd,id)
    local playerid = getPlayerByID(id)
    if isPlayerAdmin(plr) and playerid then
	    if not doPlayerWarn[playerid] then
		    doPlayerWarn[playerid] = 0
		end
		doPlayerWarn[playerid] = doPlayerWarn[playerid] + 1
		outputChatBox("● INFO: Gracz ("..getPlayerName(playerid)..") otrzymał ostrzeżenie ("..doPlayerWarn[playerid].."/3) od Administratora ("..getPlayerName(plr)..").",root,255,0,0,true)
		if doPlayerWarn[playerid] == 3 then
		    kickPlayer(playerid,plr)
		end
	end
end)

addCommandHandler("agivecash-all",
function(plr,cmd,money)
    local money = tonumber(money)
    if isPlayerAdmin(plr) and money then
	    for i,v in pairs(getElementsByType("player")) do
		    givePlayerMoney(v,money)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] podarował wszystkim graczom ["..money.."$].",root,0,255,255,true)
	end
end)

addCommandHandler("a100hp-all",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    for i,v in pairs(getElementsByType("player")) do
		    setElementHealth(v,100)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] uzdrowił wszystkich graczy.",root,0,255,255,true)
	end
end)

addCommandHandler("akamizelka-all",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    for i,v in pairs(getElementsByType("player")) do
		    setPedArmor(v,100)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] dał wszystkim graczom kamizelkę.",root,0,255,255,true)
	end
end)

addCommandHandler("atp-all",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    local x,y,z = getElementPosition(plr)
		local int = getElementInterior(plr)
	    for i,v in pairs(getElementsByType("player")) do
		    if (getElementData(v,"pCommands") ~= false) then
			    removePedFromVehicle(v)
				setElementInterior(v,int)
				setElementPosition(v,x,y,z+0.1)
			end
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] teleportował wszystkich graczy do siebie.",root,0,255,255,true)
	end
end)

addCommandHandler("aunlock-all",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    for i,v in pairs(getElementsByType("vehicle"),resourceRoot) do
		    setVehicleLocked(v,false)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] otworzył wszystkie pojazdy.",root,0,255,255,true)
	end
end)

addCommandHandler("alock-all",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    for i,v in pairs(getElementsByType("vehicle"),resourceRoot) do
		    setVehicleLocked(v,true)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] zamknął wszystkie pojazdy.",root,0,255,255,true)
	end
end)

addCommandHandler("anapraw-all",
function(plr,cmd)
    if isPlayerAdmin(plr) then
	    for i,v in pairs(getElementsByType("vehicle"),resourceRoot) do
		    setTimer(function()
		        fixVehicle(v)
			end,50,1)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] naprawił wszystkie pojazdy.",root,0,255,255,true)
	end
end)

addCommandHandler("aweapon-all",
function(plr,cmd,weaponID,weaponAmmo)
    local weaponID = tonumber(weaponID)
	local weaponAmmo = tonumber(weaponAmmo)
    if isPlayerAdmin(plr) and weaponID and weaponAmmo then
	    for i,v in pairs(getElementsByType("player")) do
		    giveWeapon(v,weaponID,weaponAmmo,true)
		end
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."] dał wszystkim graczom broń ["..getWeaponNameFromID(weaponID).."] ["..weaponID.."].",root,0,255,255,true)
	end
end)

addCommandHandler("awave",
function(plr,cmd,lvl)
    local level = tonumber(lvl)
    if isPlayerAdmin(plr) and level then
	    setWaveHeight(level)
		outputChatBox("● INFO: Admin: ["..getPlayerName(plr).."]  zmienił poziom fal na: ["..level.."] .",root,0,255,255,true)
	end
end)

addCommandHandler("ahideban",
function(plr,cmd,__playerID,...)
    local reason = table.concat({...}," ")
    if isPlayerAdmin(plr) then
	    if __playerID then
		    local bannedPlayer = getPlayerByID(__playerID)
			if bannedPlayer then
			    local IP = true
				local Username = false
				local Serial = true
				local responsiblePlayer = plr
				local reason = tostring(reason) or ""
			    banPlayer(bannedPlayer,IP,Username,Serial,nil,reason)
			end
		end
	end
end)

addCommandHandler("ahidekick",
function(plr,cmd,__playerID,...)
    local reason = table.concat({...}," ")
    if isPlayerAdmin(plr) then
	    if __playerID then
		    local kickedPlayer = getPlayerByID(__playerID)
			if kickedPlayer then
				local responsiblePlayer = plr
				local reason = tostring(reason) or ""
			    kickPlayer(kickedPlayer,nil,reason)
			end
		end
	end
end)

addCommandHandler("adodajkonto",
function(plr,cmd,name,pass)
	local name = tostring(name)
	local pass = tostring(pass)
	if isPlayerAdmin(plr) then
		local account = addAccount(name,pass)
		if account then
			outputChatBox("● INFO: Utworzyłeś konto (Login: "..name.." Hasło: "..pass..").",plr,0,255,255)
		end
	end
end)

function isVehicleEmpty(vehicle)
	if not isElement(vehicle) or getElementType(vehicle) ~= "vehicle" then
		return true
	end
	local passengers = getVehicleMaxPassengers(vehicle)
	if type(passengers) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant(vehicle,seat) then
				return false
			end
		end
	end
	return true
end

addCommandHandler("avehrsp",
function(plr,cmd)
	if isPlayerAdmin(plr) then
		for i,v in pairs(getElementsByType("vehicle"),resourceRoot) do
			if serverData.respawnVeh[v] == true and isVehicleEmpty(v) then
				respawnVehicle(v)
			end
		end
	end
end)

addEventHandler("onPlayerCommand",root,
function(command)
	if command == "register" and getPlayerSerial(source) ~= __mySerial then
		cancelEvent()
		outputChatBox("● INFO: Zarejestruj się za pomocą komendy: /zarejestruj <login> <hasło> (bez <>).",source,255,0,0)
	end
end)