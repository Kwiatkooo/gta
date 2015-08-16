local anti_spawn_kill = {}

addEventHandler("onClientPlayerSpawn",root,
function(hisTeam)
	if anti_spawn_kill[source] then return end
	if source ~= localPlayer then
		anti_spawn_kill[source] = true
		setTimer(doDisableAntiSpawnKill,5000,1,source)
		setElementAlpha(source,100)
	else
		toggleControl("fire",false)
		toggleControl("aim_weapon",false)
		toggleControl("sprint",false)
		exports.ps_mass:showBox("Spawn ochrona włączona", 0, 204, 0, 5000)
		setTimer(toggleControl,5000,1,"fire",true)
		setTimer(toggleControl,5000,1,"aim_weapon",true)
		setTimer(toggleControl,5000,1,"sprint",true)
		
		anti_spawn_kill[source] = true
		setTimer(doDisableAntiSpawnKill,5000,1,source)
		setElementAlpha(source,100)
	end
end)

function doDisableAntiSpawnKill(plr,bool)
	anti_spawn_kill[plr] = nil
	setElementAlpha(plr,255)
	exports.ps_mass:showBox("Spawn ochrona wyłączona", 255, 20, 20, 3000)
end

addEventHandler("onClientPlayerDamage",root,
function(attacker,weapon,bodypart,loss)
	if anti_spawn_kill[source] and anti_spawn_kill[source] == true then
		cancelEvent()
	end
end)