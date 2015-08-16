local dbmanager = exports["ps_core"]

function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=1,11 do
			local weapon = getPedWeapon(ped,i)
			local ammo = getPedTotalAmmo(ped,i)
			if weapon and weapon ~= 0 then
				table.insert(playerWeapons,weapon,ammo)
			end
		end
	else
		return false
	end
	return playerWeapons
end

addEventHandler("onPlayerVehicleExit",root,
function()
	fixPlayerDesync(source)
end)

addEventHandler("onPlayerVehicleEnter",root,
function()
	fixPlayerDesync(source)
end)

function fixPlayerDesync(plr)
	if isPedDead(plr) then return end
	if dbmanager:isPlayerPlayMiniGame(plr) then return end
	local slot = getPedWeaponSlot(plr)
	local weapons = getPedWeapons(plr)
	takeAllWeapons(plr)
	if weapons then
		for weaponID,weaponAmmo in pairs(weapons) do
			giveWeapon(plr,weaponID,weaponAmmo,false)
		end
	end
	if slot then setPedWeaponSlot(plr,slot) end
	--[[setCameraTarget(plr,plr)]]
end