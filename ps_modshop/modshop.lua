local modShop = {}
modShop.players = {}
modShop.vehicles = {}
modShop.list = {
    [1] = {
	    ["name"] = "TransFender",
        ["position"] = "2386.658203125,1054.361328125,9.453382492065"
	},
    [2] = {
	    ["name"] = "Wheel Arch Angles",
        ["position"] = "-2723.7060,217.2689,2.6133"
	},
    [3] = {
	    ["name"] = "Loco Low Co.",
        ["position"] = "1990.6890,2056.8046,9.3844"
	},
    [4] = {
	    ["name"] = "TransFender",
        ["position"] = "2499.6159,-1779.8135,12.8"
	},
    [5] = {
	    ["name"] = "TransFender Los Santos",
        ["position"] = "2644.8984375,-2043.392578125,12.276514053345"
	},
    [6] = {
	    ["name"] = "TransFender San Fierro",
        ["position"] = "-1935.8642578125,249.5654296875,34.292495727539"
	},
}
modShop.blockedVehicles = {
    ["Plane"] = true,
	["Helicopter"] = true,
	["Boat"] = true,
	["Train"] = true,
	["Trailer"] = true,
}

function isPedDrivingVehicle(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ isPedDrivingVehicle [ped/player expected, got " .. tostring(ped) .. "]")
    local isDriving = isPedInVehicle(ped) and getVehicleOccupant(getPedOccupiedVehicle(ped)) == ped
    return isDriving, isDriving and getPedOccupiedVehicle(ped) or nil
end

addEventHandler("onResourceStart",resourceRoot,
function()
	for i,_ in pairs(modShop.list) do
		local pos = split(modShop.list[i]["position"],",")
		local modShopMarker = createMarker(pos[1],pos[2],pos[3]-1,"cylinder",3.5,255,255,255,100,root)
		createBlipAttachedTo(modShopMarker,27,2,255,0,0,255,0,400.0,root)
		setElementInterior(modShopMarker,0)
		setElementDimension(modShopMarker,0)
		addEventHandler("onMarkerHit",modShopMarker,modShopMarkerHit)
		addEventHandler("onMarkerLeave",modShopMarker,modShopMarkerLeave)
	end
end)

addEventHandler("onResourceStop",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
		thePlayerModShopExit(v)
	end
end)

function modShopMarkerHit(hitElement,matchingDimension)
    if isElement(hitElement) then
        local elementType = getElementType(hitElement)
		if elementType == "vehicle" then
		    local thePlayer = getVehicleController(hitElement)
			if thePlayer then
			    if modShop.players[thePlayer] then return end
			    if getElementData(thePlayer,"pCommands") == false then return end
			    if modShop.blockedVehicles[getVehicleType(hitElement)] then return end
				local occupants = getVehicleOccupants(hitElement)
				for seat,occupant in pairs(occupants) do
			    	if seat > 0 and occupant then
					    removePedFromVehicle(occupant)
					end
				end
				local x,y,z = getElementPosition(thePlayer)
				local rx,ry,rz = getElementRotation(hitElement)
				local int = getElementInterior(thePlayer)
				modShop.players[thePlayer] = {}
				modShop.players[thePlayer].position = {x,y,z,rx,ry,rz}
				modShop.players[thePlayer].interior = int
				local vehicleID = getElementModel(hitElement)
				local compatibleUpgrades = getVehicleCompatibleUpgrades(hitElement)
				local defaultUpgrades = getVehicleUpgrades(hitElement)
				local c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12 = getVehicleColor(hitElement,true)
				local defaultColor = {c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12}
				local defaultPaintjob = getVehiclePaintjob(hitElement)
				local randomDimension = math.random(1,666)
				setElementDimension(hitElement,randomDimension)
				setElementDimension(thePlayer,randomDimension)
				triggerClientEvent(thePlayer,"Client:modShopMarkerHit",thePlayer,compatibleUpgrades,defaultUpgrades,defaultColor,defaultPaintjob,vehicleID,randomDimension)
			    setElementData(thePlayer,"pCommands",false)
		    	setElementFrozen(hitElement,true)
				modShop.vehicles[hitElement] = true
			end
		end
	end
end

function thePlayerModShopExit(plr)
	if not modShop.players[plr] then return nil end
	local pos = modShop.players[plr].position
	local int = modShop.players[plr].interior
	local theVehicle = getPedOccupiedVehicle(plr)
	if theVehicle then
	    setElementInterior(theVehicle,int,pos[1],pos[2],pos[3])
		setElementRotation(theVehicle,pos[4],pos[5],pos[6])
		setElementDimension(theVehicle,0)
		setElementInterior(plr,int)
		setElementDimension(plr,0)
		triggerClientEvent(plr,"Client:modShopHideGUI",plr)
		setElementFrozen(theVehicle,false)
		setElementData(plr,"pCommands",true)
		setCameraTarget(plr,plr)
		fadeCamera(plr,true)
		modShop.players[plr] = nil
		modShop.vehicles[theVehicle] = nil
	end
end

addEventHandler("onPlayerWasted",root,
function()
	if modShop.players[source] then
		modShop.players[source] = nil
		local theVehicle = getPedOccupiedVehicle(source)
		if theVehicle then
			if modShop.vehicles[theVehicle] then
			local priv_car = getElementData(theVehicle,"isPrivCar")
			local custom_veh = getElementData(theVehicle,"vehOwner")
				if not priv_car and not custom_veh then 
					respawnVehicle(theVehicle)
				end
			end
			modShop.vehicles[theVehicle] = nil
		end
	end
end)

addEventHandler("onVehicleExplode",root,
function()
	if modShop.vehicles[source] then
		modShop.vehicles[source] = nil
	end
end)

function modShopMarkerLeave(leftElement,matchingDimension)
    if isElement(leftElement) then
        local elementType = getElementType(leftElement)
		if elementType == "vehicle" then
    		modShop.vehicles[leftElement] = nil
			local plr = getVehicleController(leftElement)
			if plr then
				modShop.players[plr] = nil
				setElementData(plr,"pCommands",true)
			end
		end
	end
end

addEventHandler("onVehicleStartExit",root,
function(exitingPlayer,seat,jacked,door)
    if modShop.vehicles[source] then
	    cancelEvent()
	end
end)

addEventHandler("onPlayerQuit",root,
function()
    local vehicle = getPedOccupiedVehicle(source)
	if vehicle and modShop.vehicles[vehicle] then
		setElementDimension(vehicle,0)
		setElementInterior(vehicle,0)
		setElementFrozen(vehicle,false)
		modShop.vehicles[vehicle] = nil
		modShop.players[source] = nil
		local priv_car = getElementData(vehicle,"isPrivCar")
		local custom_veh = getElementData(vehicle,"vehOwner")
		if not priv_car and not custom_veh then 
			respawnVehicle(vehicle)
		end
	end
end)

addEvent("Server:modShopAddUpgrade",true)
addEventHandler("Server:modShopAddUpgrade",resourceRoot,
function(selectedItemType,selectedItemID)
    local theVehicle = getPedOccupiedVehicle(client)
	if theVehicle then
	    if selectedItemType == "Paintjob" then return setVehiclePaintjob(theVehicle,selectedItemID) end
        addVehicleUpgrade(theVehicle,selectedItemID)
	end
end)

addEvent("Server:modShopRemoveUpgrade",true)
addEventHandler("Server:modShopRemoveUpgrade",resourceRoot,
function(selectedItemType,selectedItemID)
    local theVehicle = getPedOccupiedVehicle(client)
	if theVehicle then
	    if selectedItemType == "Paintjob" then return setVehiclePaintjob(theVehicle,3) end
        if selectedItemID then removeVehicleUpgrade(theVehicle,selectedItemID) end
	end
end)

addEvent("Server:modShopResetUpgrades",true)
addEventHandler("Server:modShopResetUpgrades",resourceRoot,
function()
    local theVehicle = getPedOccupiedVehicle(client)
	if theVehicle then
		local upgrades = getVehicleUpgrades(theVehicle)
		for i,v in pairs(upgrades) do
			removeVehicleUpgrade(theVehicle,upgrades[i])
		end
		setVehiclePaintjob(theVehicle,3)
	end
end)

addEvent("Server:modShopExit",true)
addEventHandler("Server:modShopExit",resourceRoot,
function(--[[__vehUpgrades,__vehColor,__vehPaintjob]])
    --[[local theVehicle = getPedOccupiedVehicle(client)
	if theVehicle then]]
	    thePlayerModShopExit(client)
		--[[local upgrades = getVehicleUpgrades(theVehicle)
		for i,v in pairs(upgrades) do
			removeVehicleUpgrade(theVehicle,upgrades[i])
		end
		for i,v in pairs(__vehUpgrades) do
		    addVehicleUpgrade(theVehicle,__vehUpgrades[i])
		end
		setVehiclePaintjob(theVehicle,__vehPaintjob)
		setVehicleColor(theVehicle,__vehColor[1],__vehColor[2],__vehColor[3],__vehColor[4],__vehColor[5],__vehColor[6],__vehColor[7],__vehColor[8],__vehColor[9],__vehColor[10],__vehColor[11],__vehColor[12])]]
	--end
end)

addEvent("Server:modShopSetVehicleColor",true)
addEventHandler("Server:modShopSetVehicleColor",resourceRoot,
function(r1,g1,b1,r2,g2,b2)
    local theVehicle = getPedOccupiedVehicle(client)
	if theVehicle then
		setVehicleColor(theVehicle,r1,g1,b1,r2,g2,b2)
	end
end)

addEvent("Server:modShopClickOK",true)
addEventHandler("Server:modShopClickOK",resourceRoot,
function(__upgradeCost,__vehUpgrades,__vehColor,__vehPaintjob)
    if getPlayerMoney(client) < __upgradeCost-1 then return triggerClientEvent(client,"clientMsgBox",client,"● Nie masz wystarczającej ilości pieniędzy.") end
	thePlayerModShopExit(client)
	takePlayerMoney(client,__upgradeCost)
	local theVehicle = getPedOccupiedVehicle(client)
	local upgrades = getVehicleUpgrades(theVehicle)
	for i,v in pairs(upgrades) do
		removeVehicleUpgrade(theVehicle,upgrades[i])
	end
	for i,v in pairs(__vehUpgrades) do
	    addVehicleUpgrade(theVehicle,__vehUpgrades[i])
	end
	setVehiclePaintjob(theVehicle,__vehPaintjob)
	setVehicleColor(theVehicle,__vehColor[1],__vehColor[2],__vehColor[3],__vehColor[4],__vehColor[5],__vehColor[6],__vehColor[7],__vehColor[8],__vehColor[9],__vehColor[10],__vehColor[11],__vehColor[12])
end)