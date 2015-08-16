--[[
  Digital Speedomeeter 1.8
  ~ New Version
  
  Created by NoliuS
  ]]--

Digital = dxCreateFont("Digital.ttf", 35) --Custom font 
dxfont1_Digital = dxCreateFont("Digital.ttf", 15) --Custom font 
local screenW, screenH = guiGetScreenSize() --getScreenSize

function speed ( )
    addEventHandler ( "onClientRender", root, getspeed )
end
addEventHandler ("onClientVehicleEnter", root, speed)

function hideSpeed ( )
    removeEventHandler ( "onClientRender", root, getspeed )
end
addEventHandler("onClientVehicleExit", root, hideSpeed)

function hud ( )
		if isPedInVehicle (localPlayer) == false then return end
		sx, sy, sz = getElementVelocity (getPedOccupiedVehicle(localPlayer))
		kmhs = math.floor(((sx^2 + sy^2 + sz^2)^(0.5))*180) --Calculate speed
		dxDrawText(""..tostring(kmhs).."", screenW * 0.8508, screenH * 0.8389, screenW * 0.9406, screenH * 0.9069, tocolor(0, 0, 0, 255), 1.00, Digital, "right", "center", false, false, false, false, false)
	    dxDrawText("km/h", (screenW * 0.9406) + 1, (screenH * 0.8389) + 1, (screenW * 0.9836) + 1, (screenH * 0.8750) + 1, tocolor(0, 0, 0, 255), 1.00, dxfont1_Digital, "center", "top", false, false, false, false, false)
        dxDrawText("km/h", screenW * 0.9406, screenH * 0.8389, screenW * 0.9836, screenH * 0.8750, tocolor(0, 0, 0, 255), 1.00, dxfont1_Digital, "center", "top", false, false, false, false, false)	 
 
		local nitroLevel = math.floor(getVehicleNitroLevel(veh)*100)
		local nitro = "".. tostring(nitroLevel) .. "%"
		dxDrawText(nitro, screenW * 0.8984, screenH * 0.8042, screenW * 0.9820, screenH * 0.8417, tocolor(0, 0, 0, 255), 1.00, dxfont1_Digital, "right", "top", false, true, false, false, false)

 end
addEventHandler("onClientRender",getRootElement(),hud)
