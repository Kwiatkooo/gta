mini_games = {}
mini_games.data = {}
addEvent("updateMiniGamesGUI",true)
addEventHandler("updateMiniGamesGUI",localPlayer,
function(g_Data)
	mini_games.data = g_Data
end)
mini_games.GUI = {
    {"Mini-Games"},
	{"/HAY"},
	{"/RACE"},
	{"/MC"},
	{"/DERBY"},
	{"/DR"},
	{"/WG"},
	{"/FO"},
	{"/ONESHOOT"},
	--[[{"/STEALTH"},]]
}



local aFont = "default"
local lineHeight = dxGetFontHeight(1,aFont)
local boxWidth = drawX/10
local boxHeight = #mini_games.GUI*lineHeight+24
local boX,boY = 255/1024*drawX,drawY*730/760-boxHeight
local screenW, screenH = guiGetScreenSize()
addEventHandler("onClientRender",root,
function()
    if isTargetClient() == true then
		if isPedDead(localPlayer) then return end
		for i,v in ipairs(mini_games.GUI) do
			if i==1 then
				 --dxDrawText(v[1], 5, 319 + lineHeight*(i-1)-8, 74, 621, tocolor(255, 255, 255, 255), 1.30, "sans", "left", "top", false, false, false, false, false)
				--dxDrawText(v[1],boX,boY + lineHeight*(i-1)-8,boX+boxWidth,drawY,tocolor(255,255,255,150),1,aFont,"center")
				dxDrawText("/Hay         /RC         /MC         /DB         /DR         /WG         /FO", (screenW * 0.0523) + 1, (screenH * 0.9181) + 1, (screenW * 0.3563) + 1, (screenH * 0.9389) + 1, tocolor(0, 0, 0, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
				dxDrawText("/Hay         /RC         /MC         /DB         /DR         /WG         /FO", screenW * 0.0523, screenH * 0.9181, screenW * 0.3563, screenH * 0.9389, tocolor(255, 255, 255, 255), 1.00, "sans", "left", "top", false, false, false, false, false)
				
			else
				--dxDrawText(v[1], 5, 319 + lineHeight*(i-1), 74, 621, tocolor(255, 255, 255, 255), 1.30, "sans", "left", "top", false, false, false, false, false)
				--dxDrawText(v[1],boX,boY + lineHeight*(i-1),boX+boxWidth,drawY,tocolor(255,255,255,150),1,aFont)
				--dxDrawText(tostring(mini_games.data[i-1]),boX,boY + lineHeight*(i-1),boX+boxWidth,drawY,tocolor(255,255,255,150),1,aFont,"right")
				
				dxDrawText(tostring(mini_games.data[1]), 62, 680, 101, 695, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--hay
				dxDrawText(tostring(mini_games.data[2]), 124, 680, 163, 695, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--rc
				dxDrawText(tostring(mini_games.data[3]), 182, 680, 221, 695, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--mc
				dxDrawText(tostring(mini_games.data[4]), 244, 680, 283, 695, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--db
				dxDrawText(tostring(mini_games.data[5]), 304, 680, 343, 695, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--dr
				dxDrawText(tostring(mini_games.data[6]), 363, 680, 402, 695, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)--wg
				dxDrawText(tostring(mini_games.data[7]), 427, 680, 459, 694, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
			end
		end
	end
end)

addEvent("onClientMiniGamesDisqualified",true)
addEventHandler("onClientMiniGamesDisqualified",localPlayer,
function()
    
end)

addEvent("onClientMiniGamesStart",true)
addEventHandler("onClientMiniGamesStart",localPlayer,
function()
    if cDamageTimer and isTimer(cDamageTimer) then
		killTimer(cDamageTimer)
		cDamageTimer = nil
	end
	triggerServerEvent("Server:toggleDamage",resourceRoot,false)
    fadeCamera(false,0.01)
	setTimer(fadeCamera,1000,1,true)
end)

addEventHandler("onClientPlayerSpawn",localPlayer,
function()
    setPedCanBeKnockedOffBike(localPlayer,true)
end)

addEvent("onClientMiniGamesEnd",true)
addEventHandler("onClientMiniGamesEnd",localPlayer,
function()
    
end)