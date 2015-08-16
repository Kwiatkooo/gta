local dbmanager = exports["ps_core"]

local __privCars = {}

addEventHandler("onResourceStop",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
		if dbmanager:isPlayerLogin(v) then
			local accID = dbmanager:getAccID(v)
			updatePrivCar(v,accID)
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,
function()
	loadPrivCarsFromDatabase()
end)

function loadPrivCarsFromDatabase()
	dbmanager:zapytanie("CREATE TABLE IF NOT EXISTS privcars(pID INT,pCar TEXT,pOwner TEXT,pPos TEXT,pUpgrades TEXT,pPaintJob TEXT,pColor TEXT,pPlate TEXT)")
end

function deletePrivCar(pID)
    
end

addEvent("Server:loadPlayerPrivCar",true)
addEventHandler("Server:loadPlayerPrivCar",resourceRoot,
function()
	if dbmanager:isPlayerLogin(client) then
		local accID = dbmanager:getAccID(client)
		loadPlayerPrivCar(client,accID)
	end
end)

addCommandHandler("privcar",
function(plr,cmd)
	if getElementInterior(plr) ~= 0 or getElementDimension(plr) ~= 0 then return end
	if dbmanager:isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
    if getElementData(plr,"pCommands") == false or dbmanager:isPlayerInJail(plr) == true then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr)
		return
	end
    if not dbmanager:isPlayerLogin(plr) then return end
	if tonumber(getElementData(plr,".LVL")) < 15 then triggerClientEvent(plr,"clientMsgBox",plr,"● Musisz osiągnąć co najmniej 15 Level, aby kupić prywatny pojazd.") return end
    if __privCars[plr] then
	    triggerClientEvent(plr,"showPrivCarMenu",plr)
	else
	    triggerClientEvent(plr,"onClientCarShopHit",plr)
	end
end)

addEvent("onPrivCarOptionSelected",true)
addEventHandler("onPrivCarOptionSelected",resourceRoot,
function(selectedOption)
	if getElementInterior(client) ~= 0 or getElementDimension(client) ~= 0 then return end
	if dbmanager:isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
    if getElementData(client,"pCommands") == false or dbmanager:isPlayerInJail(client) == true then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
		triggerClientEvent(client,"Client:isPlayerDamage",client)
		return
	end
    if __privCars[client] then
        if selectedOption == "Teleportuj" then
	        warpPedIntoVehicle(client,__privCars[client])
			setElementInterior(__privCars[client],0)
			setElementDimension(__privCars[client],0)
	    end
        if selectedOption == "Przywołaj" then
	        local x,y,z = getElementPosition(client)
			local rx,ry,rz = getElementRotation(client)
			local vx = x+((math.cos(math.rad(rz)))*3)
			local vy = y+((math.sin(math.rad(rz)))*3)
			if vx and vy then
			    setElementPosition(__privCars[client],vx,vy,z+0.1)
				setElementRotation(__privCars[client],0,0,rz)
				setElementInterior(__privCars[client],0)
				setElementDimension(__privCars[client],0)
			end
	    end
		if selectedOption == "Napraw" then
		    if tonumber(getPlayerMoney(client)) > 1499 or tonumber(getPlayerMoney(client)) == 1500 then
			    fixVehicle(__privCars[client])
				takePlayerMoney(client,1500)
			else
			    outputChatBox("● [Info]: Nie posiadasz wystarczającej ilości pieniędzy.",client,255,0,0,true)
			end
		end
		if selectedOption == "Sprzedaj" then
		    local __vehName = getVehicleName(__privCars[client])
			local __vehCost = 1000000
			local __accountID = dbmanager:getAccID(client)
			dbmanager:zapytanie("DELETE FROM privcars WHERE pOwner=?",__accountID)
			givePlayerMoney(client,__vehCost)
			destroyElement(__privCars[client])
			__privCars[client] = nil
			triggerClientEvent(client,"clientMsgBox",client,"● Sprzedałeś/aś swój prywatny pojazd za "..__vehCost.."$")
		end
		if selectedOption == "Wyrzuć pasażera" then
		    local occupants = getVehicleOccupants(__privCars[client])
			if occupants then
		        triggerClientEvent(client,"showVehicleOccupantsList",client,occupants)
			end
		end
		if selectedOption == "Wyrzuć pasażerów" then
		    local occupants = getVehicleOccupants(__privCars[client])
			for seat,occupant in pairs(occupants) do
			    if seat ~= 0 and occupant then
				    removePedFromVehicle(occupant)
				end
			end
		end
		if selectedOption == "Otwórz/Zamknij maskę" then
		    setVehicleDoorOpenRatio(__privCars[client],0,1-getVehicleDoorOpenRatio(__privCars[client],0),500)
		end
		if selectedOption == "Otwórz/Zamknij bagażnik" then
		    setVehicleDoorOpenRatio(__privCars[client],1,1-getVehicleDoorOpenRatio(__privCars[client],1),500)
		end
		if selectedOption == "Otwórz/Zamknij przednie prawe drzwi" then
		    setVehicleDoorOpenRatio(__privCars[client],3,1-getVehicleDoorOpenRatio(__privCars[client],3),500)
		end
		if selectedOption == "Otwórz/Zamknij przednie lewe drzwi" then
		    setVehicleDoorOpenRatio(__privCars[client],2,1-getVehicleDoorOpenRatio(__privCars[client],2),500)
		end
		if selectedOption == "Otwórz/Zamknij tylne prawe drzwi" then
		    setVehicleDoorOpenRatio(__privCars[client],5,1-getVehicleDoorOpenRatio(__privCars[client],5),500)
		end
		if selectedOption == "Otwórz/Zamknij tylne lewe drzwi" then
		    setVehicleDoorOpenRatio(__privCars[client],4,1-getVehicleDoorOpenRatio(__privCars[client],4),500)
		end
		if selectedOption == "Otwórz/Zamknij wszystkie drzwi" then
		    for i=0,5 do
			    setVehicleDoorOpenRatio(__privCars[client],i,1-getVehicleDoorOpenRatio(__privCars[client],i),500)
			end
		end
		if selectedOption == "Auto Tunning" then
		    executeCommandHandler("tune",client)
		end
	end
end)

addEvent("kickVehicleOccupant",true)
addEventHandler("kickVehicleOccupant",resourceRoot,
function(occupant)
    local thePlayer = getPlayerFromName(occupant)
	if thePlayer then
	    if isPedInVehicle(thePlayer) then
		    removePedFromVehicle(thePlayer)
		end
		local occupants = getVehicleOccupants(__privCars[client])
		if occupants then
		    triggerClientEvent(client,"showVehicleOccupantsList",client,occupants)
		end
	end
end)

function loadPlayerPrivCar(p,accountID)
	if __privCars[p] then return end
	local data = dbmanager:pobierzWyniki("SELECT pID,pCar,pOwner,pPos,pUpgrades,pPaintJob,pColor,pPlate FROM privcars WHERE pOwner=? LIMIT 1;",accountID)
	if data then
		local __vehModelID,__vehPosition,__vehUpgrades,__vehPaintjob,__vehColor,__vehPlate = data.pCar,fromJSON(data.pPos),fromJSON(data.pUpgrades),data.pPaintJob,fromJSON(data.pColor),fromJSON(data.pPlate)
		__privCars[p] = createVehicle(__vehModelID,__vehPosition[1],__vehPosition[2],__vehPosition[3]+0.1,0,0,0)
		if __privCars[p] then
			setElementData(__privCars[p],"isPrivCar",true)
			setElementData(__privCars[p],"PrivCarOwner",dbmanager:getAccName(p))
			setVehicleColor(__privCars[p],__vehColor[1],__vehColor[2],__vehColor[3],__vehColor[4],__vehColor[5],__vehColor[6],__vehColor[7],__vehColor[8],__vehColor[9],__vehColor[10],__vehColor[11],__vehColor[12])
			setVehiclePaintjob(__privCars[p],__vehPaintjob)
			setVehicleDamageProof(__privCars[p],true)
			setVehiclePlateText(__privCars[p],__vehPlate)
			for i,v in pairs(__vehUpgrades) do
				if isElement(__privCars[p]) then addVehicleUpgrade(__privCars[p],__vehUpgrades[i]) end
			end
			refreshPrivCars()
		end
	end
end

addEventHandler("__onPlayerChangeLogin",root,
function(p,oldLogin,newLogin)
    if __privCars[p] then
	    setElementData(__privCars[p],"PrivCarOwner",dbmanager:getAccName(p))
        refreshPrivCars()
	end
end)

function refreshPrivCars()
	for i,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"Client:RefreshPrivCarsTable",v)
	end
end

addEventHandler("__onPlayerLogout",root,
function(plr,accID,accName)
    if __privCars[plr] then
        updatePrivCar(plr,accID)
	end
end)

function updatePrivCar(p,accountID)
	local vehX,vehY,vehZ = getElementPosition(__privCars[p])
	local c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12 = getVehicleColor(__privCars[p],true)
	local __vehModelID = getElementModel(__privCars[p])
	local __vehPosition = {vehX,vehY,vehZ}
	local __vehUpgrades = getVehicleUpgrades(__privCars[p])
	local __vehPaintjob = getVehiclePaintjob(__privCars[p])
	local __vehColor = {c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12}
	local __vehPlate = getVehiclePlateText(__privCars[p])
	dbmanager:zapytanie("UPDATE privcars SET pCar=?,pPos=?,pUpgrades=?,pPaintJob=?,pColor=?,pPlate=? WHERE pOwner=?",__vehModelID,toJSON(__vehPosition),toJSON(__vehUpgrades),__vehPaintjob,toJSON(__vehColor),toJSON(__vehPlate),accountID)
	destroyElement(__privCars[p])
	__privCars[p] = nil
end

addEvent("createPrivCar",true)
addEventHandler("createPrivCar",resourceRoot,
function(vehicleName,vehicleCost)
	if dbmanager:isPlayerLogin(client) then
		if getPlayerMoney(client) > vehicleCost or getPlayerMoney(client) == vehicleCost then
    		local modelID = getVehicleModelFromName(string.lower(vehicleName))
			local x,y,z = getElementPosition(client)
			local rx,ry,rz = getElementRotation(client)
    		__privCars[client] = createVehicle(modelID,x,y,z+1,0,0,rz)
			if __privCars[client] then
	            local vehX,vehY,vehZ = getElementPosition(__privCars[client])
	            local c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12 = getVehicleColor(__privCars[client],true)
			    local accountID = dbmanager:getAccID(client)
				local __vehModelID = modelID
				local __vehPosition = {vehX,vehY,vehZ}
				local __vehUpgrades = getVehicleUpgrades(__privCars[client])
				local __vehPaintjob = getVehiclePaintjob(__privCars[client])
				local __vehColor = {c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12}
				local __vehPlate = getVehiclePlateText(__privCars[client])
				savePrivCar(accountID,__vehModelID,__vehPosition,__vehUpgrades,__vehPaintjob,__vehColor,__vehPlate)
	    		setElementData(__privCars[client],"isPrivCar",true)
				setElementData(__privCars[client],"PrivCarOwner",getPlayerName(client))
	    		warpPedIntoVehicle(client,__privCars[client])
				setVehicleDamageProof(__privCars[client],false)
				triggerClientEvent(client,"clientMsgBox",client,"● Aby zarządzać swoim prywatnym pojazdem naciśnij klawisz [F3]")
				takePlayerMoney(client,vehicleCost)
				refreshPrivCars()
			end
		else
		    outputChatBox("● [Info]: Nie masz wystarczającej ilości pieniędzy, aby kupić ten pojazd.",client,255,0,0,true)
		end
	end
end)

function savePrivCar(accountID,__vehModelID,__vehPosition,__vehUpgrades,__vehPaintjob,__vehColor,__vehPlate)
    local __id = #__privCars+1
	dbmanager:zapytanie("INSERT INTO privcars(pID,pCar,pOwner,pPos,pUpgrades,pPaintJob,pColor,pPlate) VALUES(?,?,?,?,?,?,?,?)",__id,__vehModelID,accountID,toJSON(__vehPosition),toJSON(__vehUpgrades),__vehPaintjob,toJSON(__vehColor),toJSON(__vehPlate),0,0,0,0,0)
end

addEventHandler("onVehicleExplode",root,
function()
    if source then
    	local isCarPrivate = getElementData(source,"isPrivCar") or nil
		if isCarPrivate == true and source then
	    	local x,y,z = getElementPosition(source)
	    	setVehicleRespawnPosition(source,x,y,z+0.1)
	    	setTimer(respawnVehicle,3000,1,source)
		end
	end
end)

addEventHandler("onVehicleStartEnter",root,
function(enteringPlayer,seat,jacked,door)
    local isCarPrivate = getElementData(source,"isPrivCar")
	local PrivCarOwner = getElementData(source,"PrivCarOwner")
	if isCarPrivate == true then 
	    if seat == 0 then 
		    if PrivCarOwner ~= getPlayerName(enteringPlayer) then
	            cancelEvent()
		        outputChatBox("● [Info]: Nie możesz wsiąść do tego pojazdu.",enteringPlayer,255,0,0,true)
			end
		end
	end
end)