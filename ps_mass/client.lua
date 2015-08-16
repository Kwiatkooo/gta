local x, y = guiGetScreenSize()
local boxes = {}
local timers = {}
local id = 1

function showBox(text, r, g, b, t)
	if not r or not g or not b then	r, g, b = 255, 255, 255 end
	if not t then return end
    local color = tocolor(r, g, b, 255) or -1
	if t > 100 then
		playSoundFrontEnd ( 13 )
		boxes[id] = {text, color}
		timers[id] = setTimer(destroyBox,t,1,id)
		id = id + 1
	end  
end

function destroyBox(ids)
	boxes[ids] = nil
end

function drawBoxes()
	local nextx = 0
	local nexty = 0
	for i,tab in pairs(boxes) do
		nextx = x/2 - string.len(tab[1])*7.5/2
		--dxDrawRectangle(nextx, nexty,string.len(tab[1])*7.5, 17, tocolor(0, 0, 0, 85))
		--dxDrawText(tab[1], nextx + 5, nexty, nextx - 10, nexty, tab[2], 1.0, "sans", "left", "top")
		
		
		dxDrawImage(288, nexty, 706, 28, "bg.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText(tab[1], 288, nexty+15, 994, nexty+10, tab[2], 1.10, "sans", "center", "center", false, false, false, false, false)
		
		
		nextx = nextx
		nexty = nexty + 27
	end
end

addEvent("showBox", true)
addEventHandler("showBox", root, showBox)
addEventHandler("onClientRender", root, drawBoxes)

