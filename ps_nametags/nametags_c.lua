local nametags = {}
nametags.players = {}
nametags.vehicles = {} 
nametags.font = "default"
nametags.target = {}
nametags.alpha = {}
nametags.maxdistance = 95
nametags.bone_position = {3,0.8}

function dxDrawBorderedText(text,left,top,right,bottom,color,scale,font,alignX,alignY,clip,wordBreak,postGUI,alpha,r,g,b)
    local r,g,b = r,g,b or 0,0,0
    for oX = -1,1 do
        for oY = -1,1 do
            dxDrawText(removeHEXFromString(text),left + oX,top + oY,right + oX,bottom + oY,tocolor(r,g,b,alpha),scale,font,alignX,alignY,clip,wordBreak,postGUI,true)
        end
    end
    dxDrawText(text,left,top,right,bottom,color,scale,font,alignX,alignY,clip,wordBreak,postGUI,true)
end

function removeHEXFromString(str)
    return str:gsub("#%x%x%x%x%x%x","")
end

addEventHandler("onClientPlayerJoin",root,
function()
	setPlayerNametagShowing(source,false)
end)

addEventHandler("onClientPlayerSpawn",root,
function()
	setPlayerNametagShowing(source,false)
end)

addEventHandler("onClientResourceStart",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
	    setPlayerNametagShowing(v,false)
	end
end)

addEventHandler("onClientResourceStop",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
	    setPlayerNametagShowing(v,true)
	end
end)

addEventHandler("onClientPlayerTarget",root,
function(targetElement)
    nametags.target = {}
	nametags.players = {}
	nametags.vehicles = {}
	if targetElement then
	   	local elementType = getElementType(targetElement)
		if elementType then
			if elementType == "player" or elementType == "ped" and targetElement then
			    nametags.target[targetElement] = true
			end
			if elementType == "vehicle" and targetElement then
			    table.insert(nametags.vehicles,targetElement)
			end
		end
	end
end)

addEventHandler("onClientRender",root,
function()
	
    local camX,camY,camZ = getCameraMatrix()
	local localDimension = getElementDimension(localPlayer)
	
	local theVehicle = getPedOccupiedVehicle(localPlayer)
	if #nametags.vehicles ~= 0 then
		for i,v in pairs(nametags.vehicles) do
			--if v ~= theVehicle then
				if not isElement(v) then table.remove(nametags.vehicles,i) return end
				local posX,posY,posZ = getElementPosition(v)
				local scX,scY = getScreenFromWorldPosition(posX,posY,posZ,0,false)
				if scX and scX then
					local health = getElementHealth(v)
					local lineLength = 56*(health/1000)
					dxDrawRectangle(scX-30,scY+15,60,10,tocolor(0,0,0,200))
					dxDrawRectangle(scX-28,scY+17,lineLength,6,tocolor(255-math.floor(255*(health/1000)),math.floor(255*(health/1000)),0,200))
				end
			--end
		end
	end
	
    for i,v in pairs(getElementsByType("player",root,true)) do
	    local posX,posY,posZ = getElementPosition(v)
		local dist = getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ)
		if dist < nametags.maxdistance or nametags.target[v] == true then
			if v ~= localPlayer and getElementDimension(v) == localDimension and getElementHealth(v) > 0 and isElementOnScreen(v) and isLineOfSightClear(camX,camY,camZ,posX,posY,posZ,true,false,false,true,true,false,false) then 
				local boneX,boneY,boneZ = getPedBonePosition(v,nametags.bone_position[1])
				local newBoneZ = boneZ+nametags.bone_position[2]*(dist/30)
                local scX,scY = getScreenFromWorldPosition(boneX,boneY,newBoneZ+nametags.bone_position[2],0.06,false)
                if nametags.target[v] == false or nametags.target[v] == nil then
                    nametags.alpha[v] = 170 - dist
    	        else
        	        nametags.alpha[v] = 200
        	    end
	            local health = getElementHealth(v)
        	    local lineLength = 56*(health/100)
	    	    local armor = getPedArmor(v)
	    	    local lineLength2 = 56*(armor/100)
		        dxDrawRectangle(scX-30,scY+15,60,10,tocolor(0,0,0,nametags.alpha[v]-20))
	            dxDrawRectangle(scX-28,scY+17,lineLength,6,tocolor(255-math.floor(255*(health/100)),math.floor(255*(health/100)),0,nametags.alpha[v]))
		    	dxDrawRectangle(scX-28,scY+17,lineLength2,6,tocolor(180,180,180,nametags.alpha[v]))
				local r,g,b = getPlayerNametagColor(v)
				local playerName = "● "..getPlayerName(v).."(ID: "..getElementData(v,"ID")..")"
				local playerGang = getElementData(v,"Gang")
                dxDrawBorderedText(playerName,scX,scY,scX,scY,tocolor(r,g,b,nametags.alpha[v]+50),1,nametags.font,"center","top",false,true,false,nametags.alpha[v]+50)
				if playerGang and playerGang ~= "-" then
				    dxDrawBorderedText("● Gang: "..playerGang,scX,scY-22,scX,scY-22,tocolor(r,g,b,nametags.alpha[v]+50),1,nametags.font,"center","top",false,true,false,nametags.alpha[v]+50)
				end
            end
		end
    end
	
	--[[for _,v in pairs(getElementsByType("ped"),resourceRoot,true) do
	    local posX,posY,posZ = getElementPosition(v)
		local localDimension = getElementDimension(localPlayer)
		local dist = getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ)
		if dist < nametags.maxdistance then
			if getElementDimension(v) == localDimension and getElementHealth(v) > 0 and isElementOnScreen(v) and isLineOfSightClear(camX,camY,camZ,posX,posY,posZ,true,false,false,true,true,false,false) then 
				local boneX,boneY,boneZ = getPedBonePosition(v,nametags.bone_position[1])
				local newBoneZ = boneZ+nametags.bone_position[2]*(dist/30)
                local scX,scY = getScreenFromWorldPosition(boneX,boneY,newBoneZ+nametags.bone_position[2],0.06,false)
                if scX and scY then
		    	    local r,g,b = getPlayerNametagColor(v)
					local pedName
					if getElementModel(v) == 179 then 
					    pedName = "● Witaj #FFFFFF"..getPlayerName(localPlayer).."!\n#00FFFF● W tym miejscu możesz kupić broń,pancerz itp."
					end
                    dxDrawBorderedText(pedName,scX,scY,scX,scY,tocolor(0,255,255,222),1,nametags.font,"center","top",false,true,false,222)
                end
            end
		end
	end]]
	
end)