--[[ 
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
-	Fallout by Ransom (edit by Luk4s7_)
-	fallout_c.lua (clientside)
	
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
]]

local shakingPieces = {}

function shakeOnRender()
	local rotation
	local playerTeam = getPlayerTeam(localPlayer)
	if playerTeam and getTeamName(playerTeam) == "Fallout" then
		local currentTick = getTickCount()
		for object,originalTick in pairs(shakingPieces) do
			local tickDifference = currentTick - originalTick
			if tickDifference > 2400 then
				shakingPieces[object] = nil
			else
				local newx = tickDifference/125 * 1
				local newy = tickDifference/125 * 1
				if isElement(object) then
					local model = getElementModel(object)
					if model == 1697 then 
						rotation = math.deg(0.555)
						setElementRotation(object,rotation,3 * math.cos(newy + 1),3 * math.sin(newx + 1))
					end
					if model == 1649 then 
						rotation = 270.48481142853
						setElementRotation(object,rotation,3 * math.cos(newy + 1),3 * math.sin(newx + 1))
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,shakeOnRender)

function ShakePieces(fallingPiece)
	shakingPieces[fallingPiece] = getTickCount()
end
addEvent("clientShakePieces",true)
addEventHandler("clientShakePieces",root,ShakePieces)