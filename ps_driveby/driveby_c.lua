local driveby_blocked_vehicles = {432,601,437,431,592,553,577,488,497,548,563,512,476,447,425,519,520,460,417,469,487,513,441,464,501,465,564,538,449,537,539,570472,473,493,595,484,430,453,452,446,454,606,591,607,611,610,590,569,611,435,608,584,450}

function setDoingDriveby()
	if isPedDead(localPlayer) then return end
	local theVehicle = getPedOccupiedVehicle(localPlayer)
	if theVehicle then
		local vehicleID = getElementModel(theVehicle)
		for i,v in pairs(driveby_blocked_vehicles) do
			if vehicleID == v then return end
		end
		if not isPedDoingGangDriveby(localPlayer) then
			setPedDoingGangDriveby(localPlayer,true)
			setPedWeaponSlot(localPlayer,4)
		else
			setPedDoingGangDriveby(localPlayer,false)
			setPedWeaponSlot(localPlayer,0)
			setCameraTarget(localPlayer)
		end
	end
end
addCommandHandler("driveby",setDoingDriveby)
bindKey("mouse2","down","driveby")