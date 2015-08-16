addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart,stealth)
	local r1,g1,b1 = getPlayerNametagColor(source)
	if killer then
		if killer == source then
			if killerWeapon == false then
				exports.killmessages:outputMessage({getPlayerName(source),{"padding",width=3},{"icon",id=255}},root,r1,g1,b1)
				return
			else
				exports.killmessages:outputMessage({getPlayerName(source),{"padding",width=3},{"icon",id=killerWeapon}},root,r1,g1,b1)
				return
			end
		end
		local r2,g2,b2 = getPlayerNametagColor(killer)
		if getElementType(killer) == "player" then
			if bodypart == 9 then
				exports.killmessages:outputMessage({getPlayerName(killer),{"padding",width=3},{"icon",id=killerWeapon},{"padding",width=3},{"icon",id=256},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source)},root,r2,g2,b2)
				return
			end
			exports.killmessages:outputMessage({getPlayerName(killer),{"padding",width=3},{"icon",id=killerWeapon},{"padding",width=3},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source)},root,r2,g2,b2)
			return
		elseif getElementType(killer) == "vehicle" then
			exports.killmessages:outputMessage({getPlayerName(getVehicleController(killer)),{"padding",width=3},{"icon",id=getElementModel(killer)},{"padding",width=3},{"padding",width=3},{"color",r=r1,g=g1,b=b1},getPlayerName(source)},root,r2,g2,b2)
			return
		end
	else
		exports.killmessages:outputMessage({getPlayerName(source),{"padding",width=3},{"icon",id=killerWeapon}},root,r1,g1,b1)
		return
	end
end)

addEvent("onPlayerKillMessage",true)
function cancelKillMessage(killer,weapon,bodypart)
	cancelEvent()
end
addEventHandler("onPlayerKillMessage",root,cancelKillMessage)

function setAutoAimForAllWeapons(bEnable)
    weaponList = {"colt 45","silenced","deagle","shotgun","sawed-off","combat shotgun","uzi","mp5","ak-47","m4","tec-9","rifle","sniper","minigun"}
    for _,weapon in ipairs(weaponList) do
        for _,skill in ipairs({"poor","std","pro"}) do
            setWeaponPropertyFlag(weapon,skill,0x0001,not bEnable)
        end
    end
end

function setWeaponPropertyFlag(weapon,skill,flagBit,bSet)
    local bIsSet = bitAnd(getWeaponProperty(weapon,skill,"flags"),flagBit) ~= 0
    if bIsSet ~= bSet then
        setWeaponProperty(weapon,skill,"flags",flagBit)
    end
end

setAutoAimForAllWeapons(false)

addEventHandler('onResourceStart',resourceRoot,
function()
	setWeaponProperty(31,"poor","accuracy",99)
	setWeaponProperty(31,"std","accuracy",99)
	setWeaponProperty(31,"pro","accuracy",99)
	setWeaponProperty(24,"poor","accuracy",99)
	setWeaponProperty(24,"std","accuracy",99)
	setWeaponProperty(24,"pro","accuracy",99)
	setWeaponProperty(23,"poor","accuracy",99)
	setWeaponProperty(23,"std","accuracy",99)
	setWeaponProperty(23,"pro","accuracy",99)
	setWeaponProperty(22,"poor","accuracy",99)
	setWeaponProperty(22,"std","accuracy",99)
	setWeaponProperty(22,"pro","accuracy",99)
	setWeaponProperty(28,"poor","accuracy",99)
	setWeaponProperty(28,"std","accuracy",99)
	setWeaponProperty(28,"pro","accuracy",99) 
	setWeaponProperty(29,"poor","accuracy",99)
	setWeaponProperty(29,"std","accuracy",99)
	setWeaponProperty(29,"pro","accuracy",99)
	setWeaponProperty(32,"poor","accuracy",99)
	setWeaponProperty(32,"std","accuracy",99)
	setWeaponProperty(32,"pro","accuracy",99)
	setWeaponProperty(30,"poor","accuracy",99)
	setWeaponProperty(30,"std","accuracy",99)
	setWeaponProperty(30,"pro","accuracy",99)
end)

addEventHandler('onResourceStop',resourceRoot,
function()
    local range = getOriginalWeaponProperty(31,"poor","accuracy")
	setWeaponProperty(31,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(31,"std","accuracy")
	setWeaponProperty(31,"std","accuracy",range)
	local range = getOriginalWeaponProperty(31,"pro","accuracy")
	setWeaponProperty(31,"pro","accuracy",range)
       
	local range = getOriginalWeaponProperty(24,"poor","accuracy")
	setWeaponProperty(24,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(24,"std","accuracy")
	setWeaponProperty(24,"std","accuracy",range)
	local range = getOriginalWeaponProperty(24,"pro","accuracy")
	setWeaponProperty(24,"pro","accuracy",range)
		
	local range = getOriginalWeaponProperty(23,"poor","accuracy")
	setWeaponProperty(23,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(23,"std","accuracy")
	setWeaponProperty(23,"std","accuracy",range)
	local range = getOriginalWeaponProperty(23,"pro","accuracy")
	setWeaponProperty(23,"pro","accuracy",range)
		
	local range = getOriginalWeaponProperty(22,"poor","accuracy")
	setWeaponProperty(22,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(22,"std","accuracy")
	setWeaponProperty(22,"std","accuracy",range)
	local range = getOriginalWeaponProperty(22,"pro","accuracy")
	setWeaponProperty(22,"pro","accuracy",range)
	
	local range = getOriginalWeaponProperty(28,"poor","accuracy")
	setWeaponProperty(28,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(28,"std","accuracy")
	setWeaponProperty(28,"std","accuracy",range)
	local range = getOriginalWeaponProperty(28,"pro","accuracy")
	setWeaponProperty(28,"pro","accuracy",range)
		
	local range = getOriginalWeaponProperty(28,"poor","accuracy")
	setWeaponProperty(28,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(28,"std","accuracy")
	setWeaponProperty(28,"std","accuracy",range)
	local range = getOriginalWeaponProperty(28,"pro","accuracy")
	setWeaponProperty(28,"pro","accuracy",range)
		
	local range = getOriginalWeaponProperty(29,"poor","accuracy")
	setWeaponProperty(29,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(29,"std","accuracy")
	setWeaponProperty(29,"std","accuracy",range)
	local range = getOriginalWeaponProperty(29,"pro","accuracy")
	setWeaponProperty(29,"pro","accuracy",range)		
	
	local range = getOriginalWeaponProperty(32,"poor","accuracy")
	setWeaponProperty(32,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(32,"std","accuracy")
	setWeaponProperty(32,"std","accuracy",range)
	local range = getOriginalWeaponProperty(32,"pro","accuracy")
	setWeaponProperty(32,"pro","accuracy",range)	
	
	local range = getOriginalWeaponProperty(30,"poor","accuracy")
	setWeaponProperty(30,"poor","accuracy",range)
	local range = getOriginalWeaponProperty(30,"std","accuracy")
	setWeaponProperty(30,"std","accuracy",range)
	local range = getOriginalWeaponProperty(30,"pro","accuracy")
	setWeaponProperty(30,"pro","accuracy",range)
end)