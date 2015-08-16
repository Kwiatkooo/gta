local dbmanager = exports["ps_core"]

local house_system = {}
house_system.PLR = {}
house_system.CREATE = {}
house_system.DATA = {}

addEventHandler("onResourceStop",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
		if isPlayerInHouse(v) then
			local houseID = getPlayerHouseID(v)
			exitPlayerHouse(v,houseID)
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,
function()
	loadHouseSystemDatabase()
end)

function loadHouseSystemDatabase()
	dbmanager:zapytanie("CREATE TABLE IF NOT EXISTS house(ID INT,en_X INT,en_Y INT,en_Z INT,en_tX INT,en_tY INT,en_tZ INT,ex_X INT,ex_Y INT,ex_Z INT,ex_tX INT,ex_tY INT,ex_tZ INT,interior INT,dimension INT,cost INT,owner TEXT,key TEXT,exp INT,time INT)")
	wczytajDomy()
end

function wczytajDomy()
	local data = dbmanager:pobierzTabeleWynikow("SELECT * FROM house")
	for i,v in pairs(data) do
		houseCreate(v.ID,v.en_X,v.en_Y,v.en_Z,v.en_tX,v.en_tY,v.en_tZ,v.ex_X,v.ex_Y,v.ex_Z,v.ex_tX,v.ex_tY,v.ex_tZ,v.interior,v.dimension,v.cost,v.owner,v.key,v.exp,v.time)
	end
end

function houseCreate(ID,en_X,en_Y,en_Z,en_tX,en_tY,en_tZ,ex_X,ex_Y,ex_Z,ex_tX,ex_tY,ex_tZ,interior,dimension,cost,owner,key,exp,time)
    house_system.DATA[ID] = {
		["ID"] = ID,
		["en_X"] = en_X,
		["en_Y"] = en_Y,
		["en_Z"] = en_Y,
		["en_tX"] = en_tX,
		["en_tY"] = en_tY,
		["en_tZ"] = en_tZ,
		["ex_X"] = ex_X,
		["ex_Y"] = ex_Y,
		["ex_Z"] = ex_Z,
		["ex_tX"] = ex_tX,
		["ex_tY"] = ex_tY,
		["ex_tZ"] = ex_tZ,
		["interior"] = interior,
		["dimension"] = dimension,
		["cost"] = cost,
		["owner"] = owner,
		["key"] = key,
		["exp"] = exp,
		["time"] = time,
	}
	house_system.DATA[ID].enterPickup = createPickup(en_X,en_Y,en_Z,3,1273)
	house_system.DATA[ID].enterMarker = createMarker(en_X,en_Y,en_Z-1,"cylinder",2,0,255,0,130,root)
	setElementData(house_system.DATA[ID].enterMarker,"house.locked","Zamknięty")
	setElementData(house_system.DATA[ID].enterMarker,"house.id",ID)
	local ownerLogin
	if owner ~= "" then
		ownerLogin = dbmanager:getAccNameByID(owner)
	else
		ownerLogin = ""
	end
	setElementData(house_system.DATA[ID].enterMarker,"house.owner",ownerLogin)
	setElementData(house_system.DATA[ID].enterMarker,"house.cost",cost)
	--setElementData(house_system.DATA[ID].enterMarker,"house.key",key)
	setElementData(house_system.DATA[ID].enterMarker,"house.exp",exp)
	addEventHandler("onMarkerHit",house_system.DATA[ID].enterMarker,
	function(element,matchingDimension)
		if element and matchingDimension then
			local elementType = getElementType(element)
			if elementType == "player" then
				local isPlayerLogin = dbmanager:isPlayerLogin(element)
				if isPlayerLogin then
					local houseID = getElementData(source,"house.id")
					local houseData = house_system.DATA[houseID]
					if houseData["owner"] == "" then
						if isPlayerHaveHouse(element) then return end
						triggerClientEvent(element,"Client:ShowHouseBuyMenu",element,houseData)
					else
						triggerClientEvent(element,"Client:ShowHouseJoinMenu",element,houseData)
					end
				end
			end
		end
	end)
	addEventHandler("onMarkerLeave",house_system.DATA[ID].enterMarker,
	function(element,matchingDimension)
		if element then
			local elementType = getElementType(element)
			if elementType == "player" then
				local isPlayerLogin = dbmanager:isPlayerLogin(element)
				if isPlayerLogin then
					triggerClientEvent(element,"Client:HideHouseBuyMenu",element)
					triggerClientEvent(element,"Client:HideHouseJoinMenu",element)
				end
			end
		end
	end)
	addEventHandler("onPickupHit",house_system.DATA[ID].enterPickup,
	function(plr)
		cancelEvent()
	end)
	house_system.DATA[ID].exitPickup = createPickup(ex_X,ex_Y,ex_Z,3,1318)
	setElementInterior(house_system.DATA[ID].exitPickup,interior)
	setElementDimension(house_system.DATA[ID].exitPickup,dimension)
	addEventHandler("onPickupHit",house_system.DATA[ID].exitPickup,
	function(plr)
		cancelEvent()
		local isPlayerLogin = dbmanager:isPlayerLogin(plr)
		if isPlayerLogin then
			local h = house_system.DATA[ID]
			local x,y,z = h["ex_tX"],h["ex_tY"],h["ex_tZ"]
			setElementDimension(plr,0)
			setElementInterior(plr,0,x,y,z)
			setElementData(plr,"pCommands",true)
			house_system.PLR[plr] = nil
			triggerClientEvent(plr,"Client:onPlayerHouseExit",plr)
		end
	end)
	if owner == "" or not owner then
		house_system.DATA[ID].blip = createBlip(en_X,en_Y,en_Z,31,2,255,0,0,255,0,99.0,root)
		setMarkerColor(house_system.DATA[ID].enterMarker,0,255,0,130)
		setPickupType(house_system.DATA[ID].enterPickup,3,1273)
	else
		house_system.DATA[ID].blip = createBlip(en_X,en_Y,en_Z,32,2,255,0,0,255,0,99.0,root)
		setMarkerColor(house_system.DATA[ID].enterMarker,255,0,0,130)
		setPickupType(house_system.DATA[ID].enterPickup,3,1272)
	end
end

function saveHouseCallback(h)
	local __id = #house_system.DATA+1
	dbmanager:zapytanie("INSERT INTO house(ID,en_X,en_Y,en_Z,en_tX,en_tY,en_tZ,ex_X,ex_Y,ex_Z,ex_tX,ex_tY,ex_tZ,interior,dimension,cost,owner,key,exp,time) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",__id,h.en_X,h.en_Y,h.en_Z,h.en_tX,h.en_tY,h.en_tZ,h.ex_X,h.ex_Y,h.ex_Z,h.ex_tX,h.ex_tY,h.ex_tZ,h.interior,h.dimension,h.cost,h.owner,h.key,0,nil)
	houseCreate(__id,h.en_X,h.en_Y,h.en_Z,h.en_tX,h.en_tY,h.en_tZ,h.ex_X,h.ex_Y,h.ex_Z,h.ex_tX,h.ex_tY,h.ex_tZ,h.interior,h.dimension,h.cost,h.owner,h.key,0,nil)
end

addEvent("Server:SaveHouse",true)
addEventHandler("Server:SaveHouse",resourceRoot,
function(houseData)
	saveHouseCallback(houseData)
end)

addEvent("Server:BuyHouse",true)
addEventHandler("Server:BuyHouse",resourceRoot,
function(houseData)
	buyHouse(client,houseData)
end)

addEvent("Server:JoinHouse",true)
addEventHandler("Server:JoinHouse",resourceRoot,
function(houseID)
	joinHouse(client,houseID)
end)

addEvent("Server:JoinHouseWithKey",true)
addEventHandler("Server:JoinHouseWithKey",resourceRoot,
function(houseID)
	joinHouse(client,houseID,true)
end)

function buyHouse(plr,houseData)
	local houseID = houseData["ID"]
	local houseCost = tonumber(houseData["cost"])
	local playerMoney = tonumber(getPlayerMoney(plr))
	if playerMoney >= houseCost then
		takePlayerMoney(plr,houseCost)
		local ownerID = dbmanager:getAccID(plr)
		local generuj_kod = tostring(math.random(12345,3131414))
		dbmanager:zapytanie("UPDATE house SET owner=?,key=? WHERE ID=?",ownerID,generuj_kod,houseID)
		local houseMarker = house_system.DATA[houseID].enterMarker
		local housePickup = house_system.DATA[houseID].enterPickup
		local houseBlip = house_system.DATA[houseID].blip
		setElementData(houseMarker,"house.locked","Zamknięty")
		setElementData(houseMarker,"house.owner",tostring(getPlayerName(plr)))
		house_system.DATA[houseID]["owner"] = ownerID
		house_system.DATA[houseID]["key"] = generuj_kod
		setMarkerColor(houseMarker,255,0,0,130)
		setBlipIcon(houseBlip,32)
		setPickupType(housePickup,3,1272)
		outputChatBox("● INFO: Kupiłeś(aś) dom za "..houseCost.."$.",plr,0,255,255)
		outputChatBox("● INFO: Kod do domu został automatycznie wygenerowany (możesz go zmienić w ustawieniach).",plr,0,255,255)
		outputChatBox("● INFO: Twój kod to: "..generuj_kod,plr,0,255,255)
		outputChatBox("● INFO: Ustawienie domu są dostępne pod komendą /house",plr,0,255,255)
	else
		outputChatBox("● INFO: Nie masz wystarczającej ilości pieniędzy na ten dom.",plr,255,0,0)
	end
end

function joinHouse(plr,houseID,houseKey)
	local h = house_system.DATA[houseID]
	local ownerID = tonumber(dbmanager:getAccID(plr))
	if ownerID == tonumber(h["owner"]) then
		local x,y,z,int,dim = h["en_tX"],h["en_tY"],h["en_tZ"],h["interior"],h["dimension"]
		setElementDimension(plr,dim)
		setElementInterior(plr,int,x,y,z)
		outputChatBox("● INFO: Witaj "..getPlayerName(plr).."!",plr,0,255,255)
		outputChatBox("● INFO: Ustawienie domu są dostępne pod komendą /house",plr,0,255,255)
		setElementData(plr,"pCommands",false)
		house_system.PLR[plr] = true
		triggerClientEvent(plr,"Client:onPlayerHouseJoin",plr)
	else
		if houseKey == true then
			local x,y,z,int,dim = h["en_tX"],h["en_tY"],h["en_tZ"],h["interior"],h["dimension"]
			setElementDimension(plr,dim)
			setElementInterior(plr,int,x,y,z)
			house_system.PLR[plr] = true
			triggerClientEvent(plr,"Client:onPlayerHouseJoin",plr)
			return
		end
		local key = h["key"]
		if key then
			triggerClientEvent(plr,"Client:ShowHouseKeyMenu",plr,h)
		end
	end
end

function isPlayerInHouse(plr)
	if house_system.PLR[plr] == true then return true else return false end
end

addEventHandler("__onPlayerLogout",root,
function(plr,accountID,accountName,isPlayerQuit)
	house_system.PLR[plr] = nil
	if isPlayerQuit ~= true then
		triggerClientEvent(plr,"Client:HideHouseBuyMenu",plr)
		triggerClientEvent(plr,"Client:HideHouseJoinMenu",plr)
	end
end)

function exitPlayerHouse(plr,houseID)
	local h = house_system.DATA[houseID]
	local x,y,z = h["ex_tX"],h["ex_tY"],h["ex_tZ"]
	setElementDimension(plr,0)
	setElementInterior(plr,0,x,y,z)
	house_system.PLR[plr] = nil
end

function sellHouse(houseID)		
	local houseMarker = house_system.DATA[houseID].enterMarker
	local housePickup = house_system.DATA[houseID].enterPickup
	local houseBlip = house_system.DATA[houseID].blip
	dbmanager:zapytanie("UPDATE house SET owner=?,key=? WHERE ID=?","","",houseID)
	setMarkerColor(houseMarker,0,255,0,130)
	setBlipIcon(houseBlip,31)
	setPickupType(housePickup,3,1273)
	setElementData(house_system.DATA[houseID].enterMarker,"house.locked","Otwarty")
	setElementData(house_system.DATA[houseID].enterMarker,"house.owner","")
	house_system.DATA[houseID]["owner"] = ""
	house_system.DATA[houseID]["key"] = ""
end

function destroyHouse(houseID)
	
end

function keyHouse(houseID)
	
end

function isPlayerHaveHouse(plr)
	local ownerID = dbmanager:getAccID(plr)
	local data = dbmanager:pobierzWyniki("SELECT ID FROM house WHERE owner=? LIMIT 1;",ownerID)
	if data then return true else return false end
end

function getPlayerHouseID(plr)
	local ownerID = dbmanager:getAccID(plr)
	local data = dbmanager:pobierzWyniki("SELECT ID FROM house WHERE owner=? LIMIT 1;",ownerID)
	if data then
		return data.ID
	end
end

function getPlayerHouseKey(plr)
	local ownerID = dbmanager:getAccID(plr)
	local data = dbmanager:pobierzWyniki("SELECT key FROM house WHERE owner=? LIMIT 1;",ownerID)
	if data then
		return data.key
	end
end

function getPayment()
	outputServerLog("* INFO: Trwa pobieranie exp za domy...")
	for i,v in ipairs(house_system.DATA) do
		--[[outputChatBox(tostring(i))
		outputChatBox(tostring(v))
		outputChatBox(tostring(v["exp"]))]]
		local ownerEXP
		local houseID = tonumber(v["ID"])
		local houseOwnerID = tonumber(v["owner"])
		local houseEXP = tonumber(v["exp"])
		if houseOwnerID ~= "" then
			local ownerLogin = dbmanager:getAccNameByID(houseOwnerID)
			if ownerLogin then
				local plr = getPlayerFromName(ownerLogin)
				if plr then
					local isPlayerLogin = dbmanager:isPlayerLogin(plr)
					if isPlayerLogin then
						ownerEXP = tonumber(getElementData(plr,".EXP"))
						if ownerEXP >= houseEXP then
							dbmanager:removePlayerEXP(plr,houseEXP)
						else
							sellHouse(houseID)
						end
					else
						ownerEXP = tonumber(dbmanager:getAccountEXP(houseOwnerID))
						if ownerEXP >= houseEXP then
							dbmanager:removeAccountEXP(houseOwnerID,houseEXP)
						else
							sellHouse(houseID)
						end
					end
				else
					ownerEXP = tonumber(dbmanager:getAccountEXP(houseOwnerID))
					if ownerEXP >= houseEXP then
						dbmanager:removeAccountEXP(houseOwnerID,houseEXP)
					else
						sellHouse(houseID)
					end
				end
			end
		end
	end
	outputServerLog("* INFO: Pobieranie exp za domy zakończone...")
end
--addCommandHandler("payment",getPayment)
setTimer(getPayment,60000*1440,0)

addCommandHandler("house",
function(plr,cmd)
	local isPlayerLogin = dbmanager:isPlayerLogin(plr)
	if isPlayerLogin then
		if isPlayerHaveHouse(plr) then
			local houseID = getPlayerHouseID(plr)
			outputChatBox("● INFO: Komendy dla właściciela domu: ",plr,0,255,255)
			outputChatBox("● /house-p - Wyświetla panel z różnymi opcjami.",plr,0,255,255)
			outputChatBox("● /house-id - Wyświetla ID twojego domu.",plr,0,255,255)
			outputChatBox("● /house-tp - Teleportuje Cię do domu.",plr,0,255,255)
			outputChatBox("● /house-key - Wyświetla kod domu.",plr,0,255,255)
			outputChatBox("● /house-setkey - Zmienia kod domu.",plr,0,255,255)
			outputChatBox("● /house-sell - Sprzedaje dom.",plr,0,255,255)
		else
			
		end
	end
end)

addCommandHandler("house-tp",
function(plr,cmd)
	local isPlayerDamage = dbmanager:isPlayerGotDamage(plr)
	if isPlayerDamage == true then triggerClientEvent(plr,"Client:isPlayerDamage",plr) return end
	local isPlayerLogin = dbmanager:isPlayerLogin(plr)
	if isPlayerLogin then
		if isPlayerHaveHouse(plr) then
			if getElementData(plr,"pCommands") == true and dbmanager:isPlayerInJail(plr) == false then
				local houseID = getPlayerHouseID(plr)
				joinHouse(plr,houseID)
			end
		else
			
		end
	end
end)

addCommandHandler("house-id",
function(plr,cmd)
	local isPlayerLogin = dbmanager:isPlayerLogin(plr)
	if isPlayerLogin then
		if isPlayerHaveHouse(plr) then
			local houseID = getPlayerHouseID(plr)
			outputChatBox("● INFO: ID Twojego domu: "..houseID,plr,0,255,255)
		else
			
		end
	end
end)

addCommandHandler("house-key",
function(plr,cmd)
	local isPlayerLogin = dbmanager:isPlayerLogin(plr)
	if isPlayerLogin then
		if isPlayerHaveHouse(plr) then
			local houseKey = getPlayerHouseKey(plr)
			outputChatBox("● INFO: Kod: "..houseKey,plr,0,255,255)
		else
			
		end
	end
end)

addCommandHandler("house-setkey",
function(plr,cmd,newkey)
	if newkey and string.len(newkey) > 0 then
		if string.len(newkey) > 10 then outputChatBox("● INFO: Kod może składać się maksymalnie z 10 znaków.",plr,255,0,0) return end
		local isPlayerLogin = dbmanager:isPlayerLogin(plr)
		if isPlayerLogin then
			if isPlayerHaveHouse(plr) then
				local houseID = getPlayerHouseID(plr)
				dbmanager:zapytanie("UPDATE house SET key=? WHERE ID=?",newkey,houseID)
				house_system.DATA[houseID]["key"] = newkey
				outputChatBox("● INFO: Kod domku został zmieniony na: "..newkey,plr,0,255,255)
			else
			
			end
		end
	end
end)

addCommandHandler("house-sell",
function(plr,cmd)
	local isPlayerLogin = dbmanager:isPlayerLogin(plr)
	if isPlayerLogin then
		if isPlayerHaveHouse(plr) then
			local houseID = getPlayerHouseID(plr)
			if houseID then
				if house_system.PLR[plr] == true then
					exitPlayerHouse(plr,houseID)
					triggerClientEvent(plr,"Client:onPlayerHouseExit",plr)
				end
				local houseCost = house_system.DATA[houseID]["cost"]
				local houseMarker = house_system.DATA[houseID].enterMarker
				local housePickup = house_system.DATA[houseID].enterPickup
				local houseBlip = house_system.DATA[houseID].blip
				dbmanager:zapytanie("UPDATE house SET owner=?,key=? WHERE ID=?","","",houseID)
				setMarkerColor(houseMarker,0,255,0,130)
				setBlipIcon(houseBlip,31)
				setPickupType(housePickup,3,1273)
				setElementData(house_system.DATA[houseID].enterMarker,"house.locked","Otwarty")
				setElementData(house_system.DATA[houseID].enterMarker,"house.owner","")
				house_system.DATA[houseID]["owner"] = ""
				house_system.DATA[houseID]["key"] = ""
				givePlayerMoney(plr,tonumber(houseCost))
				outputChatBox("● INFO: Sprzedałeś(aś) swój dom za "..houseCost.."$",plr,0,255,255)
				house_system.PLR[plr] = nil
				triggerClientEvent(plr,"Client:onPlayerHouseSell",plr)
			end
		else
			
		end
	end
end)

addCommandHandler("house-p",
function(plr,cmd)
	local isPlayerLogin = dbmanager:isPlayerLogin(plr)
	if isPlayerLogin then
		if isPlayerHaveHouse(plr) then
			--if getElementData(plr,"pCommands") == true then
				triggerClientEvent(plr,"Client:OpenHousePanel",plr)
			--end
		end
	end
end)

addEvent("Server:onHousePanelSelected",true)
addEventHandler("Server:onHousePanelSelected",resourceRoot,
function(selectedOption)
	if selectedOption == "Teleportuj" then
		executeCommandHandler("house-tp",client)
		return
	end
	if selectedOption == "Pokaz kod" then
		executeCommandHandler("house-key",client)
		return
	end
	if selectedOption == "Sprzedaj" then
		executeCommandHandler("house-sell",client)
		return
	end
end)

addEvent("Server:changeHouseKey",true)
addEventHandler("Server:changeHouseKey",resourceRoot,
function(new_key)
	executeCommandHandler("house-setkey",client,new_key)
end)