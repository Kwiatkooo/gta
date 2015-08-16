bank = {}
bank.timers = {}
bank.delay = 2000
--bank.rob = false
bank.GUI = {
    button = {},
    window = {},
    label = {},
    edit = {}
}
bank.objects = {}

local lastBankRob = getTickCount() - 500000
addEventHandler("onClientResourceStart",resourceRoot,
function()
    local x,y = guiGetScreenSize()
    bank.GUI.window[1] = guiCreateWindow(x/2-147,y/2-166,284,255,"BANK",false)
	guiSetAlpha(bank.GUI.window[1],0.75)
    guiWindowSetSizable(bank.GUI.window[1],false)
    bank.GUI.edit[1] = guiCreateEdit(0.35,0.20,0.60,0.11,"",true,bank.GUI.window[1])
    bank.GUI.label[1] = guiCreateLabel(0.04,0.20,0.26,0.11,"Ilość: ",true,bank.GUI.window[1])
    bank.GUI.label[2] = guiCreateLabel(0.04,0.08,0.93,0.11,"Stan Konta: ",true,bank.GUI.window[1])
    bank.GUI.button[1] = guiCreateButton(0.04,0.38,0.45,0.08,"Wpłać",true,bank.GUI.window[1])
    bank.GUI.button[2] = guiCreateButton(0.50,0.38,0.45,0.08,"Wpłać Wszystko",true,bank.GUI.window[1])
    bank.GUI.button[3] = guiCreateButton(0.04,0.47,0.45,0.08,"Wypłać",true,bank.GUI.window[1])
    bank.GUI.button[4] = guiCreateButton(0.50,0.47,0.45,0.08,"Wypłać Wszystko",true,bank.GUI.window[1])
	bank.GUI.button[6] = guiCreateButton(0.03,0.57,0.92,0.08,"Okradnij Bank",true,bank.GUI.window[1])
    bank.GUI.button[5] = guiCreateButton(0.03,0.89,0.92,0.07,"Zamknij",true,bank.GUI.window[1])
	guiLabelSetColor(bank.GUI.label[2],255,255,255)
	guiLabelSetVerticalAlign(bank.GUI.label[1],"center")
    guiLabelSetVerticalAlign(bank.GUI.label[2], "center")
	guiSetFont(bank.GUI.label[1],"default-bold-small")
	guiSetFont(bank.GUI.label[2],"default-bold-small")
	guiSetFont(bank.GUI.button[1],"default-bold-small")
	guiSetFont(bank.GUI.button[2],"default-bold-small")
	guiSetFont(bank.GUI.button[3],"default-bold-small")
	guiSetFont(bank.GUI.button[4],"default-bold-small")
    guiSetFont(bank.GUI.button[5],"default-bold-small")
	guiSetFont(bank.GUI.button[6],"default-bold-small")
	--[[guiSetProperty(bank.GUI.button[2],"NormalTextColour","FF28F700")
	guiSetProperty(bank.GUI.button[1],"NormalTextColour","FF28F700")
	guiSetProperty(bank.GUI.button[3],"NormalTextColour","FFFFFFFF")
	guiSetProperty(bank.GUI.button[4],"NormalTextColour","FFFFFFFF")
    guiSetProperty(bank.GUI.button[5],"NormalTextColour","FFF50000")]]
	addEventHandler("onClientGUIClick",bank.GUI.button[6],
	function()
	    --if bank.rob == false then
			if tonumber(getElementData(localPlayer,".LVL")) < 10 then createInfoBoxClient(20,"(drawY/5.0)*2","● Musisz osiągnąć co najmniej 10 Level, aby dokonać napadu na bank.",10000) return end
		    --if tonumber(getElementData(localPlayer,"Kills")) < 19 then createInfoBoxClient(20,"(drawY/5.0)*2","● Musisz posiadać na koncie co najmniej 20 zabójstw, aby napaść na bank.",10000) return end
			if getTickCount() - lastBankRob < 500000 then outputChatBox("● INFO: Nie możesz napaść na bank w tej chwili, wróć za "..formatMilliseconds(math.floor((501000-(getTickCount()-lastBankRob)))).."",255,0,0) return end
			--bank.rob = true
	    	guiSetVisible(bank.GUI.window[1],false)
			hidePlayerCursor()
			--setElementFrozen(localPlayer,false)
			triggerServerEvent("Server:BankRob",resourceRoot,math.random(1,3))
			lastBankRob = getTickCount()
			--bank.timers[1] = setTimer(function() bank.rob = false end,5*60000,1)
		--else
		    --local remaining,executesRemaining,totalExecutes = getTimerDetails(bank.timers[1])
		    --outputChatBox("● INFO: Nie możesz napaść na bank w tej chwili, wróć za "..formatMilliseconds(remaining)..".",255,0,0,true)
		--end
	end,false)
	addEventHandler("onClientGUIClick",bank.GUI.button[5],
	function()
	    guiSetVisible(bank.GUI.window[1],false)
		hidePlayerCursor()
		--setElementFrozen(localPlayer,false)
	end,false)
	addEventHandler("onClientGUIClick",bank.GUI.button[1],
	function()
	    local ilosc_kasy = guiGetText(bank.GUI.edit[1])
		if tonumber(ilosc_kasy) then
		    execBAntiSpam()
	    	triggerServerEvent("Server:BankWplac",resourceRoot,tonumber(ilosc_kasy))
		end
	end,false)
	addEventHandler("onClientGUIClick",bank.GUI.button[2],
	function()
        local ilosc_kasy = getPlayerMoney(localPlayer)
	    if tonumber(ilosc_kasy) then
		    execBAntiSpam()
	        triggerServerEvent("Server:BankWplac",resourceRoot,tonumber(ilosc_kasy))
	    end	
	end,false)
	addEventHandler("onClientGUIClick",bank.GUI.button[3],
	function()
        local ilosc_kasy = guiGetText(bank.GUI.edit[1])
	    if tonumber(ilosc_kasy) then
		    execBAntiSpam()
	        triggerServerEvent("Server:BankWyplac",resourceRoot,tonumber(ilosc_kasy))
	    end
	end,false)
	addEventHandler("onClientGUIClick",bank.GUI.button[4],
	function()
	    execBAntiSpam()
        triggerServerEvent("Server:BankWyplacAll",resourceRoot)
	end,false)
	guiSetVisible(bank.GUI.window[1],false)
	for _,v in pairs(getElementsByType("marker",getResourceRootElement(getThisResource()))) do
		if getElementData(v,"isBankMarker") then
	    	local posX,posY,posZ = getElementPosition(v)
			local interior = getElementInterior(v)
			local dimension = getElementDimension(v)
			local bObject = createObject(1277,posX,posY,posZ+0.7,0,0,0,true)
			setElementInterior(bObject,interior)
			setElementDimension(bObject,dimension)
			table.insert(bank.objects,bObject)
		end
	end
end)

function formatMilliseconds(milliseconds)
    local totalseconds = math.floor(milliseconds/1000)
    milliseconds = milliseconds % 1000
    local seconds = totalseconds % 60
    local minutes = math.floor(totalseconds/60)
    minutes = minutes % 60
    return string.format("%02d:%02d",minutes,seconds)  
end

function execBAntiSpam()
    for i=1,4 do
	    guiSetEnabled(bank.GUI.button[i],false)
	end
	setTimer(function()
        for i=1,4 do
	        guiSetEnabled(bank.GUI.button[i],true)
	    end   
	end,bank.delay,1)
end

addEvent("Client:BankMarkerHit",true)
addEventHandler("Client:BankMarkerHit",localPlayer,
function(table)
	local bank_money,account_name = table[1],table[2]
    --setElementFrozen(localPlayer,true)
    guiSetVisible(bank.GUI.window[1],true)
	showCursor(true)
	guiSetText(bank.GUI.label[2],"Stan Konta: "..tostring(bank_money).."$")
end)

addEvent("Client:BankMarkerLeave",true)
addEventHandler("Client:BankMarkerLeave",localPlayer,
function()
	guiSetVisible(bank.GUI.window[1],false)
	hidePlayerCursor()
	--setElementFrozen(localPlayer,false)
end)

addEvent("Client:BankUpdateGUI",true)
addEventHandler("Client:BankUpdateGUI",localPlayer,
function(table)
	local bank_money,account_name = table[1],table[2]
    guiSetText(bank.GUI.label[2],"Stan Konta: "..tostring(bank_money).."$")
end)

addEventHandler("onClientRender",root,
function()
	local camX,camY,camZ = getCameraMatrix()
	for i,v in pairs(bank.objects) do
		local posX,posY,posZ = getElementPosition(v)
		if getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ) < 35 then
		    local rx,ry,rz = getElementRotation(v)
		    setElementRotation(v,rx,ry,rz+2.5)
		end
	end
end)

local b_interiors = {
	[3] = true,
	[6] = true,
	[18] = true,
}

addEventHandler("onClientPlayerDamage",localPlayer,
function()
	local p_int = getElementInterior(localPlayer)
	if b_interiors[p_int] == true then cancelEvent() end
end)
