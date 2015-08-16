local drift_checkpoints = {}
drift_checkpoints.colshape = nil
drift_checkpoints.data = {}
drift_checkpoints.current = nil
drift_checkpoints.max = nil
drift_checkpoints.marker = {}
drift_checkpoints.dimension = 99

addEvent("cMiniGamesDriftData",true)
addEventHandler("cMiniGamesDriftData",localPlayer,
function(data,dimension)
    drift_checkpoints.data = data
	drift_checkpoints.colshape = nil
	drift_checkpoints.dimension = dimension
	drift_checkpoints.marker = {}
	drift_checkpoints.current = 0
	drift_checkpoints.max = #drift_checkpoints.data
	createDriftCheckpoints(drift_checkpoints.current)
end)

function createDriftCheckpoints(i)
    if isPedDead(localPlayer) then return end
    if drift_checkpoints.marker[1] then
	    local x,y,z = getElementPosition(drift_checkpoints.marker[1])
		local px,py,pz = getElementPosition(localPlayer)
		--[[if pz > z+6 then return end
		if pz < z-3 then return end]]
		if math.abs(pz-z) > 6 then return end
	    --removeEventHandler("onClientMarkerHit",drift_checkpoints.marker[1],onDriftCheckpointHit)
		removeEventHandler("onClientColShapeHit",drift_checkpoints.colshape,onDriftCheckpointHit)
	    destroyElement(drift_checkpoints.marker[1])
		drift_checkpoints.marker[1] = nil
		if drift_checkpoints.marker[2] then
		    destroyElement(drift_checkpoints.marker[2])
		    drift_checkpoints.marker[2] = nil
		end
		if drift_checkpoints.colshape then
			destroyElement(drift_checkpoints.colshape)
			drift_checkpoints.colshape = nil
		end
	end
	local currentCheckpoint = i+1
    drift_checkpoints.marker[1] = createMarker(drift_checkpoints.data[currentCheckpoint][1],drift_checkpoints.data[currentCheckpoint][2],drift_checkpoints.data[currentCheckpoint][3],"checkpoint",8.0,0,255,0,150)
	drift_checkpoints.colshape = createColCircle(drift_checkpoints.data[currentCheckpoint][1],drift_checkpoints.data[currentCheckpoint][2],9)
	setElementDimension(drift_checkpoints.marker[1],drift_checkpoints.dimension)
	local blip = createBlipAttachedTo(drift_checkpoints.marker[1],0,2,0,255,0,170,0,99999.0)
	setElementParent(blip,drift_checkpoints.marker[1])
	drift_checkpoints.current = currentCheckpoint
	if currentCheckpoint ~= drift_checkpoints.max then
	    --addEventHandler("onClientMarkerHit",drift_checkpoints.marker[1],onDriftCheckpointHit)
		addEventHandler("onClientColShapeHit",drift_checkpoints.colshape,onDriftCheckpointHit)
	    local nextCheckpoint = currentCheckpoint+1
	    drift_checkpoints.marker[2] = createMarker(drift_checkpoints.data[nextCheckpoint][1],drift_checkpoints.data[nextCheckpoint][2],drift_checkpoints.data[nextCheckpoint][3],"checkpoint",8.0,255,0,0,50)
	    setElementDimension(drift_checkpoints.marker[2],drift_checkpoints.dimension)
		local blip = createBlipAttachedTo(drift_checkpoints.marker[2],0,2,255,0,0,120,0,99999.0)
		setElementParent(blip,drift_checkpoints.marker[1])
		setMarkerIcon(drift_checkpoints.marker[1],"arrow")
		setMarkerTarget(drift_checkpoints.marker[1],drift_checkpoints.data[nextCheckpoint][1],drift_checkpoints.data[nextCheckpoint][2],drift_checkpoints.data[nextCheckpoint][3])
	else
	    setMarkerIcon(drift_checkpoints.marker[1],"finish")
		--addEventHandler("onClientMarkerHit",drift_checkpoints.marker[1],onDriftFinishHit)
		addEventHandler("onClientColShapeHit",drift_checkpoints.colshape,onDriftFinishHit)
	end
end

--[[function onDriftCheckpointHit(hitPlayer,matchingDimension)
    if hitPlayer == localPlayer then
        createDriftCheckpoints(drift_checkpoints.current)
	end
end]]

function onDriftCheckpointHit(element)
    local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and element == vehicle or not vehicle and element == localPlayer then
        createDriftCheckpoints(drift_checkpoints.current)
	end
end

--[[function onDriftFinishHit(hitPlayer,matchingDimension)
    if drift_checkpoints.marker[1] then
	    removeEventHandler("onClientMarkerHit",drift_checkpoints.marker[1],onDriftCheckpointHit)
	    destroyElement(drift_checkpoints.marker[1])
		drift_checkpoints.marker[1] = nil
	end
    if hitPlayer == localPlayer then
	    triggerServerEvent("onServerDriftFinish",resourceRoot)
	end
end]]

function onDriftFinishHit(element)
    local vehicle = getPedOccupiedVehicle(localPlayer)
	if vehicle and element == vehicle or not vehicle and element == localPlayer then
		if drift_checkpoints.marker[1] then
			removeEventHandler("onClientMarkerHit",drift_checkpoints.marker[1],onDriftCheckpointHit)
			destroyElement(drift_checkpoints.marker[1])
			drift_checkpoints.marker[1] = nil
		end
		if drift_checkpoints.colshape then
			destroyElement(drift_checkpoints.colshape)
			drift_checkpoints.colshape = nil
		end
		triggerServerEvent("onServerDriftFinish",resourceRoot)
	end
end

addEvent("onServerDriftEnd",true)
addEventHandler("onServerDriftEnd",localPlayer,
function()
    if drift_checkpoints.marker[1] then
	    removeEventHandler("onClientMarkerHit",drift_checkpoints.marker[1],onDriftCheckpointHit)
	    destroyElement(drift_checkpoints.marker[1])
		drift_checkpoints.marker[1] = nil
		if drift_checkpoints.marker[2] then
		    destroyElement(drift_checkpoints.marker[2])
		    drift_checkpoints.marker[2] = nil
		end
	end
	if drift_checkpoints.colshape then
		destroyElement(drift_checkpoints.colshape)
		drift_checkpoints.colshape = nil
	end
	drift_checkpoints.marker = {}
	drift_checkpoints.current = 0
	drift_checkpoints.last_pos = ""
end)