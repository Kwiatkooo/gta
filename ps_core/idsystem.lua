local avaibleIDs = {}

function assingPlayerID(plr)
    setPlayerID(plr,-1)
end

function setPlayerID(plr,i)
	local pID = i + 1
	if pID then
	    if avaibleIDs[pID] ~= false then
		    avaibleIDs[pID] = false
			setElementData(plr,"ID",pID)
		else
		    return setPlayerID(plr,pID)
		end
	end
end

function getPlayerByID(theID)
	local plr
	for i,v in pairs(getElementsByType("player")) do
		local thePlayerID = getElementData(v,"ID")
		if thePlayerID then
			if tonumber(thePlayerID) == tonumber(theID) then
				plr = v
				return plr
			end
		end
	end
	return false
end

function destroyPlayerID(plr)
    local pID = tonumber(getElementData(plr,"ID"))
    if pID then
        avaibleIDs[pID] = nil
    end
	removeElementData(plr,"ID")
end