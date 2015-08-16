local damageGui = {
    label = {}
}
local damageTimers = {}
local damageCam

function removeHEXFromString(str)
    return str:gsub("#%x%x%x%x%x%x","")
end

function fadeGuiElement(id,timerID)
    if id and timerID then
		if id == 1 then guiSetAlpha(damageGui.label[3],0) end
		if id == 2 then guiSetAlpha(damageGui.label[4],0) end
	    local guiAlpha = guiGetAlpha(damageGui.label[id])
		if guiAlpha ~= 0 and id and timerID then
		    guiSetAlpha(damageGui.label[id],guiAlpha - 0.05)
		else
		    if isTimer(damageTimers[timerID]) then
			    killTimer(damageTimers[timerID])
				damageTimers[timerID] = nil
			end
		end
	end
end

function hideGuiElement(id,bool,timerID)
    if bool == true and id then
	    guiSetAlpha(damageGui.label[id],1)
		if id == 1 then guiSetAlpha(damageGui.label[3],0.8) end
		if id == 2 then guiSetAlpha(damageGui.label[4],0.8) end
	end
	if bool == false and id and timerID then
		if isTimer(damageTimers[timerID]) then
			killTimer(damageTimers[timerID])
			damageTimers[timerID] = nil
		end
		damageTimers[timerID] = setTimer(fadeGuiElement,50,0,id,timerID)
	end
end

addEventHandler("onClientResourceStart",resourceRoot,
function()
	damageGui.label[3] = guiCreateLabel(0.601,0.521,0.37,0.24,"",true)
	damageGui.label[4] = guiCreateLabel(0.601,0.561,0.37,0.24,"",true)
	damageGui.label[1] = guiCreateLabel(0.6,0.52,0.37,0.24,"",true)
	damageGui.label[2] = guiCreateLabel(0.6,0.56,0.37,0.24,"",true)
	
	guiSetEnabled(damageGui.label[1],false)
	guiSetEnabled(damageGui.label[2],false)
	guiSetEnabled(damageGui.label[3],false)
	guiSetEnabled(damageGui.label[4],false)
	
	guiSetAlpha(damageGui.label[1],0.0)
	guiSetAlpha(damageGui.label[2],0.0)
	guiSetAlpha(damageGui.label[3],0.0)
	guiSetAlpha(damageGui.label[4],0.0)
	
	guiLabelSetColor(damageGui.label[1],255,0,0)
	guiLabelSetColor(damageGui.label[2],0,255,0)
	guiLabelSetColor(damageGui.label[3],0,0,0)
	guiLabelSetColor(damageGui.label[4],0,0,0)
	
	guiSetFont(damageGui.label[1],"default-bold-small")
	guiSetFont(damageGui.label[2],"default-bold-small")
	guiSetFont(damageGui.label[3],"default-bold-small")
	guiSetFont(damageGui.label[4],"default-bold-small")
end)

addEvent("sendDmgToAttacker",true)
addEventHandler("sendDmgToAttacker",localPlayer,
function(table)
	local loss,playerName,attackerweapon,bodypart,health = table[1],table[2],table[3],table[4],table[5]
	local text = "+"..math.floor(loss).." dmg / "..removeHEXFromString(playerName).." / "..getWeaponNameFromID(attackerweapon).." / "..getBodyPartName(bodypart).." / "..math.floor(health).."%"
	if isTimer(damageTimers[2]) then
		killTimer(damageTimers[2])
		damageTimers[2] = nil
	end
	guiSetText(damageGui.label[2],text)
	guiSetText(damageGui.label[4],text)
	hideGuiElement(2,true)
	damageTimers[2] = setTimer(hideGuiElement,8000,1,2,false,4)
end)

addEvent("sendDmgToSource",true)
addEventHandler("sendDmgToSource",localPlayer,
function(table)
	local attacker,attackerweapon,bodypart = table[1],table[2],table[3]
	local text = "#You've been hit by "..removeHEXFromString(attacker).." / "..getWeaponNameFromID(attackerweapon).." / "..getBodyPartName(bodypart)
	if isTimer(damageTimers[1]) then
		killTimer(damageTimers[1])
		damageTimers[1] = nil
	end
	guiSetText(damageGui.label[1],text)
	guiSetText(damageGui.label[3],text)
	hideGuiElement(1,true)
	damageTimers[1] = setTimer(hideGuiElement,8000,1,1,false,3)
end)

addEvent("sendInfoToKiller",true)
addEventHandler("sendInfoToKiller",localPlayer,
function(table)
    local playerName,bodypart,killerWeapon = table[1],table[2],table[3]
	local text = "#You killed "..removeHEXFromString(playerName).." / "..getWeaponNameFromID(killerWeapon).." / "..getBodyPartName(bodypart)
	if isTimer(damageTimers[2]) then
		killTimer(damageTimers[2])
		damageTimers[2] = nil
	end
	guiSetText(damageGui.label[2],text)
	guiSetText(damageGui.label[4],text)
	hideGuiElement(2,true)
	damageTimers[2] = setTimer(hideGuiElement,8000,1,2,false,4)
end)

addEvent("sendInfoToSource",true)
addEventHandler("sendInfoToSource",localPlayer,
function(table)
	local playerName,bodypart,killerWeapon = table[1],table[2],table[3]
	local text = "#You killed by "..removeHEXFromString(playerName).." / "..getWeaponNameFromID(killerWeapon).." / "..getBodyPartName(bodypart)
	if isTimer(damageTimers[1]) then
		killTimer(damageTimers[1])
		damageTimers[1] = nil
	end
	guiSetText(damageGui.label[1],text)
	guiSetText(damageGui.label[3],text)
	hideGuiElement(1,true)
	damageTimers[1] = setTimer(hideGuiElement,8000,1,1,false,3)
end)

addEventHandler("onClientPlayerSpawn",localPlayer,
function()
	guiSetText(damageGui.label[1],"")
	guiSetText(damageGui.label[2],"")
	guiSetText(damageGui.label[3],"")
	guiSetText(damageGui.label[4],"")
end)

addEventHandler("onClientPlayerDamage",localPlayer,
function()
	if damageCam and isTimer(damageCam) then return end
    fadeCamera(false,1.0,222,0,0)
	damageCam = setTimer(fadeCameraDelayed,300,1)
end)

function fadeCameraDelayed()
    fadeCamera(true,0.5)
	damageCam = nil
end