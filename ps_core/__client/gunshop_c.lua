local gunShop = {}
gunShop.weaponsTable = {
	{"armor","100","1000"},
	{"hp","100","1000"},
	
	{"flower","1","1"},
	{"chainsaw","1","850"},
	{"katana","1","420"},
	{"dildo","1","70"},
	{"vibrator","1","70"},
	{"golfclub","1","80"},
	{"nightstick","1","350"},
	{"bat","1","50"},
	{"spraycan","100","50"},
	{"fire extinguisher","50","325"},
	
    {"colt 45","15","100"},
	{"silenced","15","120"},
	{"deagle","15","150"},
	
	{"shotgun","15","350"},
	{"sawed-off","25","500"},
	{"combat shotgun","12","600"},
	
	{"uzi","100","520"},
	{"tec-9","100","500"},
	{"mp5","100","635"},
	
	{"ak-47","150","950"},
	{"m4","100","1250"},
	
	{"rifle","10","1000"},
	{"sniper","10","1500"},
}
gunShop.GUI = {
    gridlist = {},
    window = {},
    button = {},
	gridlist = {},
	column = {},
}
gunShop.objects = {}

addEventHandler("onClientResourceStart", resourceRoot,
function()
    gunShop.GUI.window[1] = guiCreateWindow(517,215,353,296,"GUN SHOP",false)
	guiSetAlpha(gunShop.GUI.window[1],0.8)
	centerWindow(gunShop.GUI.window[1])
    guiWindowSetSizable(gunShop.GUI.window[1],false)
    gunShop.GUI.gridlist[1] = guiCreateGridList(0.03,0.10,0.94,0.76,true,gunShop.GUI.window[1])
	addEventHandler("onClientGUIDoubleClick",gunShop.GUI.gridlist[1],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(gunShop.GUI.gridlist[1])
		local weaponName = string.lower(guiGridListGetItemText(gunShop.GUI.gridlist[1],selectedRow,gunShop.GUI.column[1]))
		local weaponAmmo = tonumber(guiGridListGetItemText(gunShop.GUI.gridlist[1],selectedRow,gunShop.GUI.column[2]))
		local weaponCost = tonumber(guiGridListGetItemText(gunShop.GUI.gridlist[1],selectedRow,gunShop.GUI.column[3]))
		if weaponName and weaponAmmo and weaponCost then
		    if weaponName == "hp" or weaponName == "armor" then return triggerServerEvent("Server:gunShopGiveWeapon",resourceRoot,weaponName,weaponAmmo,weaponCost) end
			local weaponID = getWeaponIDFromName(weaponName)
		    triggerServerEvent("Server:gunShopGiveWeapon",resourceRoot,weaponID,weaponAmmo,weaponCost)
		end
	end,false)
    gunShop.GUI.button[1] = guiCreateButton(0.03,0.90,0.31,0.07,"Kupuj",true,gunShop.GUI.window[1])
	addEventHandler("onClientGUIClick",gunShop.GUI.button[1],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(gunShop.GUI.gridlist[1])
		local weaponName = string.lower(guiGridListGetItemText(gunShop.GUI.gridlist[1],selectedRow,gunShop.GUI.column[1]))
		local weaponAmmo = tonumber(guiGridListGetItemText(gunShop.GUI.gridlist[1],selectedRow,gunShop.GUI.column[2]))
		local weaponCost = tonumber(guiGridListGetItemText(gunShop.GUI.gridlist[1],selectedRow,gunShop.GUI.column[3]))
		if weaponName and weaponAmmo and weaponCost then
		    if weaponName == "hp" or weaponName == "armor" then return triggerServerEvent("Server:gunShopGiveWeapon",resourceRoot,weaponName,weaponAmmo,weaponCost) end
			local weaponID = getWeaponIDFromName(weaponName)
		    triggerServerEvent("Server:gunShopGiveWeapon",resourceRoot,weaponID,weaponAmmo,weaponCost)
		end
	end,false)
    gunShop.GUI.button[2] = guiCreateButton(0.86,0.90,0.10,0.07,"X",true,gunShop.GUI.window[1])
	gunShop.GUI.column[1] = guiGridListAddColumn(gunShop.GUI.gridlist[1],"Broń",0.4)
	gunShop.GUI.column[2] = guiGridListAddColumn(gunShop.GUI.gridlist[1],"Ammunicja",0.2)
	gunShop.GUI.column[3] = guiGridListAddColumn(gunShop.GUI.gridlist[1],"$",0.2)
	addEventHandler("onClientGUIClick",gunShop.GUI.button[2],
	function()
	    guiSetVisible(gunShop.GUI.window[1],false)
		hidePlayerCursor()
		--setElementFrozen(localPlayer,false)
	end,false)
    guiSetVisible(gunShop.GUI.window[1],false)
	for i,v in pairs(gunShop.weaponsTable) do
	    local row = guiGridListAddRow(gunShop.GUI.gridlist[1])
		guiGridListSetItemText(gunShop.GUI.gridlist[1],row,gunShop.GUI.column[1],string.upper(gunShop.weaponsTable[i][1]),false,false)
		guiGridListSetItemText(gunShop.GUI.gridlist[1],row,gunShop.GUI.column[2],gunShop.weaponsTable[i][2],false,false)
		guiGridListSetItemText(gunShop.GUI.gridlist[1],row,gunShop.GUI.column[3],gunShop.weaponsTable[i][3],false,false)
	end
	for _,v in pairs(getElementsByType("marker",getResourceRootElement(getThisResource()))) do
		if getElementData(v,"isGunShopMarker") then
	    	local posX,posY,posZ = getElementPosition(v)
			local interior = getElementInterior(v)
			local dimension = getElementDimension(v)
			local object = createObject(355,posX,posY,posZ+0.7,0,0,0,true)
			setElementInterior(object,interior)
			setElementDimension(object,dimension)
			setElementAlpha(object,200)
			table.insert(gunShop.objects,object)
		end
	end
	guiGridListSetSortingEnabled(gunShop.GUI.gridlist[1],false)
end)

addEvent("Client:gunShopHit",true)
addEventHandler("Client:gunShopHit",localPlayer,
function(weaponsTable)
    guiSetVisible(gunShop.GUI.window[1],true)
	showCursor(true)
	--setElementFrozen(localPlayer,true)
end)

addEvent("Client:gunShopLeave",true)
addEventHandler("Client:gunShopLeave",localPlayer,
function(weaponsTable)
    guiSetVisible(gunShop.GUI.window[1],false)
	hidePlayerCursor()
	--setElementFrozen(localPlayer,false)
end)

addEventHandler("onClientRender",root,
function()
	local camX,camY,camZ = getCameraMatrix()
	for i,v in pairs(gunShop.objects) do
		local posX,posY,posZ = getElementPosition(v)
		if getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ) < 35 then
		    local rx,ry,rz = getElementRotation(v)
		    setElementRotation(v,rx,ry,rz+2.5)
		end
	end
end)