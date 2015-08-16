local __gunShop = {}
__gunShop.shopsList = {
    { -- Las Venturas #1
	    ["marker_pos"] = {295.599609375,-80.376953125,1000.115625},
		["bot_pos"] = {295.6484375,-82.8876953125,1001.515625,2.2659606933594},
		["blip_pos"] = {2539.5400390625,2084.71875,10.8203125},
		["dimension"] = 3,
		["interior"] = 4,
	},
    { -- Las Venturas #2
	    ["marker_pos"] = {288.1025390625,-106.662109375,1000.1},
		["bot_pos"] = {288.0068359375,-104.400390625,1001.515625,180.0439453125},
		["blip_pos"] = {772.287109375,1872.533203125,8.0956926345825},
		["dimension"] = 3,
		["interior"] = 6,
	},
    { -- Las Venturas #3 /lv
	    ["marker_pos"] = {295.5361328125,-80.4716796875,1000.515625},
		["bot_pos"] = {295.6826171875,-82.681640625,1001.515625,1.9198913574219},
		["blip_pos"] = {2170.3173828125,943.0859375,15.672016143799},
		["dimension"] = 2,
		["interior"] = 4,
	},
	
    { -- San Fierro #1
	    ["marker_pos"] = {296.33984375,-37.8505859375,1000.115625},
		["bot_pos"] = {296.533203125,-40.546875,1001.515625,0.05767822265625},
		["blip_pos"] = {-2625.7685546875,208.2353515625,4.8125},
		["dimension"] = 1,
		["interior"] = 1,
	},
	
    { -- Los Santos #1
	    ["marker_pos"] = {287.9443359375,-109.4140625,1000.115625},
		["bot_pos"] = {288.025390625,-111.65234375,1001.515625,0.04669189453125},
		["blip_pos"] = {2400.423828125,-1981.994140625,13.546875},
		["dimension"] = 6,
		["interior"] = 6,
	},
}

function createGunShops()
    for i,v in pairs(__gunShop.shopsList) do
	    local m_Pos = __gunShop.shopsList[i]["marker_pos"]
		local bot_Pos = __gunShop.shopsList[i]["bot_pos"]
		local blip_pos = __gunShop.shopsList[i]["blip_pos"]
		local int = __gunShop.shopsList[i]["interior"]
		local dim = __gunShop.shopsList[i]["dimension"]
	    local gMarker = createMarker(m_Pos[1],m_Pos[2],m_Pos[3],"cylinder",1.5,0,255,255,175,root)
		local gBot = createPed(179,bot_Pos[1],bot_Pos[2],bot_Pos[3],bot_Pos[4],false)
		createBlip(blip_pos[1],blip_pos[2],blip_pos[3],6,2,255,0,0,255,0,300.0,root)
		setElementInterior(gMarker,int)
		setElementInterior(gBot,int)
		setElementDimension(gMarker,dim)
		setElementDimension(gBot,dim)
		setElementCollisionsEnabled(gBot,false)
		setElementData(gMarker,"isGunShopMarker",true)
		addEventHandler("onMarkerHit",gMarker,onGunShopMarkerHit)
		addEventHandler("onMarkerLeave",gMarker,onGunShopMarkerLeave)
	end
end

addEventHandler("onResourceStart",resourceRoot,
function()
	createGunShops()
end)

function onGunShopMarkerHit(hitElement,matchingDimension)
	if getElementHealth(hitElement) > 0 and matchingDimension then
		triggerClientEvent(hitElement,"Client:gunShopHit",hitElement)
	end
end

function onGunShopMarkerLeave(LeaveElement,matchingDimension)
	if getElementHealth(LeaveElement) > 0 and matchingDimension then
		triggerClientEvent(LeaveElement,"Client:gunShopLeave",LeaveElement)
	end
end

addEvent("Server:gunShopGiveWeapon",true)
addEventHandler("Server:gunShopGiveWeapon",resourceRoot,
function(weaponID,weaponAmmo,weaponCost)
    if getPlayerMoney(client) > weaponCost-1 then
	    takePlayerMoney(client,weaponCost)
	    if weaponID == "armor" then return setPedArmor(client,100) end
		if weaponID == "hp" then return setElementHealth(client,100) end
	    giveWeapon(client,weaponID,weaponAmmo,true)
    else
	    outputChatBox("● INFO: Nie posiadasz wystarczającej ilości pieniędzy.",client,255,0,0)
	end
end)

