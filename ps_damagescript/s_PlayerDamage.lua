addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart)
	if killer and killer ~= source then
		triggerClientEvent(source,"sendInfoToSource",source,{getPlayerName(killer),bodypart,killerWeapon})
		triggerClientEvent(killer,"sendInfoToKiller",killer,{getPlayerName(source),bodypart,killerWeapon})
	end
end)

addEventHandler("onPlayerDamage",root,
function(attacker,attackerweapon,bodypart,loss)
	if attacker and attacker ~= source then
		triggerClientEvent(source,"sendDmgToSource",source,{getPlayerName(attacker),attackerweapon,bodypart})
		triggerClientEvent(attacker,"sendDmgToAttacker",attacker,{loss,getPlayerName(source),attackerweapon,bodypart,getElementHealth(source)+getPedArmor(source)})
	end
end)











addEventHandler("customEvent:OnPlayerDead",root,
function(__player, __killer, __weapon, __bodypart, __loss)
	if __killer and __killer ~= __player then
		triggerClientEvent(__player,"sendInfoToSource",__player,{getPlayerName(__killer),__bodypart,__weapon})
		triggerClientEvent(__killer,"sendInfoToKiller",__killer,{getPlayerName(__player),__bodypart,__weapon})
	end
end)

addEventHandler("customEvent:OnPlayerDamage",root,
function(__player, __attacker, __weapon, __bodypart, __loss)
	if __attacker and __attacker ~= __player then
		triggerClientEvent(__player,"sendDmgToSource",__player,{getPlayerName(__attacker),__weapon,__bodypart})
		triggerClientEvent(__attacker,"sendDmgToAttacker",__attacker,{__loss,getPlayerName(__player),__weapon,__bodypart,getElementHealth(__player)+getPedArmor(__player)})
	end
end)