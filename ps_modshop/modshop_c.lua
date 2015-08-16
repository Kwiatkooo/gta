local modShop = {}

modShop.items = {
    [0] = {"-","500"},
	[1] = {"-","500"},
	[2] = {"-","500"},
	[3] = {"-","500"},
	
    [1000] = {"Pro","400"},
    [1001] = {"Win","550"},
    [1002] = {"Drag","200"},
    [1003] = {"Alpha","250"},
    [1004] = {"Champ Scoop","100"},
    [1005] = {"Fury Scoop","150"},
    [1006] = {"Roof Scoop","80"},
    [1007] = {"R Sideskirt","500"},

    [1008] = {"5x Nitrous","500"},
    [1009] = {"2x Nitrous","200"},
    [1010] = {"10x Nitrous","1000"},
    [1011] = {"Race Scoop","220"},
    [1012] = {"Worx Scoop","250"},
    [1013] = {"Round Fog Lamp","100"},
    [1014] = {"Champ Spoiler","400"},
    [1015] = {"Race Spoiler","500"},
    [1016] = {"Worx Spoiler","200"},

    [1017] = {"L Sideskirt","500"},
    [1018] = {"Upsweptc Exhaust","350"},
    [1019] = {"Twin Cylinder Exhaust","300"},
    [1020] = {"Large Exhaust","250"},
    [1021] = {"Medium Exhaust","200"},
    [1022] = {"Small Exhaust","150"},
    [1023] = {"Fury Spoiler","350"},
    [1024] = {"Square Fog Lamp","50"},
    [1025] = {"Off Road","1000"},

    [1026] = {"R Alien Sideskirt","480"},
    [1027] = {"L Alien Sideskirt","480"},
    [1028] = {"Alien Exhaust","770"},
    [1029] = {"X-Flow Exhaust","680"},
    [1030] = {"L X-Flow Sideskirt","370"},
    [1031] = {"R X-Flow Sideskirt","370"},
    [1032] = {"Alien Roof Scoop","170"},
    [1033] = {"X-Flow Roof Scoop type 2","120"},
    [1034] = {"Alien Exhaust","790"},

    [1035] = {"X-Flow Exhaust","150"},
    [1036] = {"R Alien Sideskirt","500"},
    [1037] = {"X-Flow Exhaust","690"},
    [1038] = {"Alien Roof Scoop","190"},
    [1039] = {"L X-Flow Sideskirt","390"},
    [1040] = {"L Alien Sideskirt","500"},
    [1041] = {"R X-Flow Sideskirt","390"},
    [1042] = {"R Chrome Sideskirt","1000"},
    [1043] = {"Slamin Exhaust","500"},

    [1044] = {"Chrome Exhaust","500"},
    [1045] = {"X-Flow Exhaust","510"},
    [1046] = {"Alien Exhaust","710"},
    [1047] = {"R Alien Sideskirt","670"},
    [1048] = {"R X-Flow Sideskirt","530"},
    [1049] = {"Alien Spoiler","810"},
    [1050] = {"X-Flow Spoiler","620"},
    [1051] = {"L Alien Sideskirt","670"},
    [1052] = {"L X-Flow Sideskirt","530"},

    [1053] = {"X-Flow Roof Scoop","130"},
    [1054] = {"Alien Roof Scoop","210"},
    [1055] = {"Alien Roof Scoop","230"},
    [1056] = {"R Alien Sideskirt","520"},
    [1057] = {"R X-Flow Sideskirt","430"},
    [1058] = {"Alien Spoiler","620"},
    [1059] = {"X-Flow Exhaust","720"},
    [1060] = {"X-Flow Spoiler","530"},
    [1061] = {"X-Flow Roof Scoop","180"},

    [1062] = {"L Alien Sideskirt","520"},
    [1063] = {"L X-Flow Sideskirt","430"},
    [1064] = {"Alien Exhaust","830"},
    [1065] = {"Alien Exhaust","850"},
    [1066] = {"X-Flow Exhaust","750"},
    [1067] = {"Alien Roof Scoop","250"},
    [1068] = {"X-Flow Roof Scoop","200"},
    [1069] = {"R Alien Sideskirt","550"},
    [1070] = {"R X-Flow Sideskirt","450"},

    [1071] = {"L Alien Sideskirt","550"},
    [1072] = {"L X-Flow SIdeskirt","450"},
    [1073] = {"Shadow","1100"},
    [1074] = {"Mega","1030"},
    [1075] = {"Rimshine","980"},
    [1076] = {"Wires","1560"},
    [1077] = {"Classic","1620"},
    [1078] = {"Twist","1200"},
    [1079] = {"Cutter","1030"},

    [1080] = {"Switch","900"},
    [1081] = {"Grove","1230"},
    [1082] = {"Import","820"},
    [1083] = {"Dollar","1560"},
    [1084] = {"Trance","1350"},
    [1085] = {"Atomic","770"},
    [1086] = {"Stereo","100"},
    [1087] = {"Hydraulics","1500"},
    [1088] = {"Alien Roof Scoop","150"},

    [1089] = {"X-Flow Exhaust","650"},
    [1090] = {"R Alien Sideskirt","450"},
    [1091] = {"X-Flow Exhaust","100"},
    [1092] = {"Alien Exhaust","750"},
    [1093] = {"R X-Flow Sideskirt","350"},
    [1094] = {"L Alien Sideskirt","450"},
    [1095] = {"R X-Flow Sideskirt","350"},
    [1096] = {"Ahab","1000"},
    [1097] = {"Virtual","620"},

    [1098] = {"Access","1140"},
    [1099] = {"L Chrome Sideskirt","1000"},
    [1100] = {"Chrome Grill","940"},
    [1101] = {"L Chrome Flames","780"},
    [1102] = {"L Chrome Strip","830"},
    [1103] = {"Convertible Roof","3250"},
    [1104] = {"Chrome Exhaust","1610"},
    [1105] = {"Slamin Exhaust","1540"},
    [1106] = {"R Chrome Arches","780"},

    [1107] = {"L Chrome Strip","780"},
    [1108] = {"R Chrome Strip","780"},
    [1109] = {"Chrome R Bullbars","1610"},
    [1110] = {"Slamin R Bullbars","1540"},
    [1111] = {"Front Sign","100"},
    [1112] = {"Front Sign","100"},
    [1113] = {"Chrome Exhaust","1650"},
    [1114] = {"Slamin Exhaust","1590"},
    [1115] = {"Chrome Bullbars","2130"},

    [1116] = {"Slamin Bullbars","2050"},
    [1117] = {"Chrome F Bumper","2040"},
    [1118] = {"R Chrome Trim","720"},
    [1119] = {"R WHeelcovers","940"},
    [1120] = {"L Chrome Trim","940"},
    [1121] = {"L Wheelcovers","940"},
    [1122] = {"R Chrome Flames","780"},
    [1123] = {"Chrome Bars","860"},
    [1124] = {"L Chrome Arches","780"},

    [1125] = {"Chrome Lights","1120"},
    [1126] = {"Chrome Exhaust","3340"},
    [1127] = {"Slamin Exhaust","3250"},
    [1128] = {"Vinyl Hardtop","3340"},
    [1129] = {"Chrome Exhaust","1650"},
    [1130] = {"Hardtop","3380"},
    [1131] = {"Softtop","3290"},
    [1132] = {"Slamin Exhaust","1590"},
    [1133] = {"R Chrome Strip","830"},

    [1134] = {"R Chrome Strip","800"},
    [1135] = {"Slamin Exhaust","1500"},
    [1136] = {"Chrome Exhaust","1000"},
    [1137] = {"L Chrome Strip","800"},
    [1138] = {"Alien Spoiler","580"},
    [1139] = {"X-Flow Spoiler","470"},
    [1140] = {"X-Flow R Bumper","870"},
    [1141] = {"ALien R Bumper","980"},
    [1142] = {"Left Oval Vents","500"},

    [1143] = {"R Oval Vents","500"},
    [1144] = {"L Square Vents","500"},
    [1145] = {"R Square Vents","500"},
    [1146] = {"X-Flow Spoiler","490"},
    [1147] = {"Alien Spoiler","500"},
    [1148] = {"X-Flow R Bumper","500"},
    [1149] = {"EAlien R Bumper","1000"},
    [1150] = {"Alien R Bumper","1090"},
    [1151] = {"X-Flow R Bumper","840"},

    [1152] = {"X-Flow F Bumper","910"},
    [1153] = {"Alien F Bumper","1200"},
    [1154] = {"Alien R Bumper","1030"},
    [1155] = {"Alien F Bumper","1030"},
    [1156] = {"X-Flow R Bumper","920"},
    [1157] = {"X-Flow F Bumper","930"},
    [1158] = {"X-Flow Spoiler","550"},
    [1159] = {"Alien R Bumper","1050"},
    [1160] = {"Alien F Bumper","1050"},

    [1161] = {"X-Flow R Bumper","950"},
    [1162] = {"Alien Spoiler","650"},
    [1163] = {"X-Flow Spoiler","450"},
    [1164] = {"Alien Spoiler","550"},
    [1165] = {"X-Flow F Bumper","850"},
    [1166] = {"Alien F Bumper","950"},
    [1167] = {"X-Flow R Bumper","850"},
    [1168] = {"Alien R Bumper","950"},
    [1169] = {"Alien F Bumper","970"},

    [1170] = {"X-Flow F Bumper","880"},
    [1171] = {"Alien F Bumper","990"},
    [1172] = {"X-Flow F Bumper","900"},
    [1173] = {"X-Flow F Bumper","950"},
    [1174] = {"Chrome F Bumper","1000"},
    [1175] = {"Slamin R Bumper","900"},
    [1176] = {"Chrome F Bumper","1000"},
    [1177] = {"Slamin R Bumper","900"},
    [1178] = {"Slamin R Bumper","2050"},

    [1179] = {"Chrome F Bumper","2150"},
    [1180] = {"Chrome R Bumper","2130"},
    [1181] = {"Slamin F Bumper","2040"},
    [1182] = {"Chrome F Bumper","2150"},
    [1183] = {"Slamin R Bumper","2050"},
    [1184] = {"Chrome R Bumper","2150"},
    [1185] = {"Slamin F Bumper","2040"},
    [1186] = {"Slamin R Bumper","2095"},
    [1187] = {"Chrome R Bumper","2175"},

    [1188] = {"Slamin F Bumper","2080"},
    [1189] = {"Chrome F Bumper","2200"},
    [1190] = {"Slamin F Bumper","1200"},
    [1191] = {"Chrome F Bumper","1040"},
    [1192] = {"Chrome R Bumper","940"},
    [1193] = {"Slamin R Bumper","1100"},
}

modShop.selectedUpgrades = {}

modShop.defaultUpgrades = {}
modShop.defaultColor = {}
modShop.defaultPaintjob = {}

modShop.upgradeCost = 0

modShop.GUI = {
    gridlist = {},
    window = {},
    button = {},
	column = {},
    staticimage = {},
    label = {},
	scrollbar = {},
}

local rotSpeed = 0.5
local angle = 0
local elem
local zOff
local dist
local active = false

function getPointFromDistanceRotation(x,y,dist,angle)
    local a = math.rad(90-angle)
    local dx = math.cos(a)*dist
    local dy = math.sin(a)*dist
    return x+dx,y+dy
end

function attachRotatingCamera(bool,element,Zoffset,distance)
    if bool then
        active = true
        elem,zOff,dist = element,Zoffset,distance
        addEventHandler("onClientRender",root,createRotRamera)
    else
        removeEventHandler("onClientRender",root,createRotRamera)
		--setCameraTarget(localPlayer)
        active = false
    end
end

function createRotRamera()
   local x,y,z = getElementPosition(elem)
   local camx,camy = getPointFromDistanceRotation(x,y,dist,angle)
   setCameraMatrix(camx,camy,z+zOff,x,y,z)
   angle = (angle+rotSpeed)%360
end

local function hidePlayerCursor()
	for _,guiElement in ipairs(getElementChildren(guiRoot)) do
	    if guiGetEnabled(guiElement) ~= false and guiGetVisible(guiElement) == true then
		    return
		end
	end
	showCursor(false)
end

local function centerWindow(center_window)
    local screenW,screenH = guiGetScreenSize()
    local windowW,windowH = guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

addEventHandler("onClientResourceStop",resourceRoot,
function()
	attachRotatingCamera(false)
end)

addEventHandler("onClientResourceStart",resourceRoot,
function()
    local sX,sY = guiGetScreenSize()
	local width,height = (sX/800),(sY/600)
	
    modShop.GUI.window[3] = guiCreateWindow(559,280,252,175,"KOLOR",false)
	centerWindow(modShop.GUI.window[3])
    guiWindowSetSizable(modShop.GUI.window[3],false)
    guiSetAlpha(modShop.GUI.window[3],0.70)
    modShop.GUI.scrollbar[1] = guiCreateScrollBar(0.13,0.15,0.67,0.11,true,true,modShop.GUI.window[3])
    modShop.GUI.scrollbar[2] = guiCreateScrollBar(0.13,0.26,0.67,0.11,true,true,modShop.GUI.window[3])
    modShop.GUI.scrollbar[3] = guiCreateScrollBar(0.13,0.37,0.67,0.11,true,true,modShop.GUI.window[3])
    modShop.GUI.scrollbar[4] = guiCreateScrollBar(0.13,0.51,0.67,0.11,true,true,modShop.GUI.window[3])
    modShop.GUI.scrollbar[5] = guiCreateScrollBar(0.13,0.62,0.67,0.11,true,true,modShop.GUI.window[3])
    modShop.GUI.scrollbar[6] = guiCreateScrollBar(0.13,0.73,0.67,0.11,true,true,modShop.GUI.window[3])
	modShop.GUI.label[2] = guiCreateLabel(0.03,0.16,0.10,0.10,"R1",true,modShop.GUI.window[3])
    modShop.GUI.label[3] = guiCreateLabel(0.03,0.26,0.10,0.10,"G1",true,modShop.GUI.window[3])
    modShop.GUI.label[4] = guiCreateLabel(0.03,0.37,0.10,0.10,"B1",true,modShop.GUI.window[3])
    modShop.GUI.label[5] = guiCreateLabel(0.03,0.51,0.10,0.10,"R2",true,modShop.GUI.window[3])
    modShop.GUI.label[6] = guiCreateLabel(0.03,0.61,0.10,0.10,"G2",true,modShop.GUI.window[3])
    modShop.GUI.label[7] = guiCreateLabel(0.03,0.73,0.10,0.10,"B2",true,modShop.GUI.window[3])
    modShop.GUI.label[8] = guiCreateLabel(0.80,0.16,0.10,0.10,"255",true,modShop.GUI.window[3])
    modShop.GUI.label[9] = guiCreateLabel(0.80,0.26,0.10,0.10,"255",true,modShop.GUI.window[3])
    modShop.GUI.label[10] = guiCreateLabel(0.80,0.37,0.10,0.10,"255",true,modShop.GUI.window[3])
    modShop.GUI.label[11] = guiCreateLabel(0.80,0.51,0.10,0.10,"255",true,modShop.GUI.window[3])
    modShop.GUI.label[12] = guiCreateLabel(0.80,0.61,0.10,0.10,"255",true,modShop.GUI.window[3])
    modShop.GUI.label[13] = guiCreateLabel(0.80,0.73,0.10,0.10,"255",true,modShop.GUI.window[3])
    modShop.GUI.button[6] = guiCreateButton(0.04,0.85,0.92,0.09,"Zamknij",true,modShop.GUI.window[3])
    guiSetFont(modShop.GUI.button[6],"default-bold-small")
    guiSetProperty(modShop.GUI.button[6],"NormalTextColour","FFAAAAAA")  
	guiSetVisible(modShop.GUI.window[3],false)
	addEventHandler("onClientGUIClick",modShop.GUI.button[6],
	function()
	    guiSetVisible(modShop.GUI.window[3],false)
	end,false)
	
    modShop.GUI.window[2] = guiCreateWindow(0.1*width,345*height,200*width,258*height,"KOSZYK",false)
	guiSetAlpha(modShop.GUI.window[2],0.6)
    guiWindowSetSizable(modShop.GUI.window[2], false)
    modShop.GUI.staticimage[1] = guiCreateStaticImage(0.06,0.09,0.25,0.26,"cart.png",true,modShop.GUI.window[2])
    modShop.GUI.gridlist[2] = guiCreateGridList(0.04,0.37,0.93,0.49,true,modShop.GUI.window[2])
	guiSetFont(modShop.GUI.gridlist[2],"default-bold-small")
	modShop.GUI.column[4] = guiGridListAddColumn(modShop.GUI.gridlist[2],"upgrade",0.5)
	modShop.GUI.column[5] = guiGridListAddColumn(modShop.GUI.gridlist[2],"$",0.2)
    modShop.GUI.button[5] = guiCreateButton(0.04,0.88,0.92,0.08,"Usuń wybrany element",true,modShop.GUI.window[2])
	addEventHandler("onClientGUIClick",modShop.GUI.button[5],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(modShop.GUI.gridlist[2])
		local selectedItemType = guiGridListGetItemText(modShop.GUI.gridlist[2],selectedRow,modShop.GUI.column[4])
		if selectedItemType then
			modShop.upgradeCost = 0
			--triggerServerEvent("Server:modShopRemoveUpgrade",resourceRoot,selectedItemType,modShop.selectedUpgrades[selectedItemType])
			if vehicleCopy then
				if selectedItemType == "Paintjob" then setVehiclePaintjob(vehicleCopy,3) return end
				if modShop.selectedUpgrades[selectedItemType] then 
					removeVehicleUpgrade(vehicleCopy,modShop.selectedUpgrades[selectedItemType]) 
					modShop.selectedUpgrades[selectedItemType] = nil
				end
			end
			guiGridListClear(modShop.GUI.gridlist[2])
			for i,v in pairs(modShop.selectedUpgrades) do
				local row = guiGridListAddRow(modShop.GUI.gridlist[2])
				guiGridListSetItemText(modShop.GUI.gridlist[2],row,modShop.GUI.column[4],tostring(i),false,false)
				guiGridListSetItemText(modShop.GUI.gridlist[2],row,modShop.GUI.column[5],tostring(modShop.items[tonumber(v)][2]),false,false)
				modShop.upgradeCost = modShop.upgradeCost + tonumber(modShop.items[tonumber(v)][2])
			end
			guiSetText(modShop.GUI.label[1],"Koszt: "..modShop.upgradeCost.."$")
		end
	end,false)
    guiSetProperty(modShop.GUI.button[5],"NormalTextColour","FFAAAAAA")
    modShop.GUI.label[1] = guiCreateLabel(0.40,0.10,0.55,0.24,"Koszt:: 0$",true,modShop.GUI.window[2])
	guiSetVisible(modShop.GUI.window[2],false)
	
    modShop.GUI.window[1] = guiCreateWindow(490*width,0.1*height,319*width,319*height,"MODSHOP",false)
    guiWindowSetSizable(modShop.GUI.window[1],false)
    modShop.GUI.gridlist[1] = guiCreateGridList(0.05,0.09,0.90,0.65,true,modShop.GUI.window[1])
	guiSetFont(modShop.GUI.gridlist[1],"default-bold-small")
	guiSetAlpha(modShop.GUI.window[1],0.4)
	addEventHandler("onClientGUIDoubleClick",modShop.GUI.gridlist[1],
	function()
        local selectedRow,selectedCol = guiGridListGetSelectedItem(modShop.GUI.gridlist[1])
		local selectedItemType = guiGridListGetItemText(modShop.GUI.gridlist[1],selectedRow,modShop.GUI.column[1])
	    local selectedItemID = guiGridListGetItemText(modShop.GUI.gridlist[1],selectedRow,modShop.GUI.column[2])
		if selectedItemID and selectedItemID ~= "" then
			if not modShop.selectedUpgrades[selectedItemType] then modShop.selectedUpgrades[selectedItemType] = {} end
			modShop.selectedUpgrades[selectedItemType] = selectedItemID
			guiGridListClear(modShop.GUI.gridlist[2])
			modShop.upgradeCost = 0
			for i,v in pairs(modShop.selectedUpgrades) do
				local row = guiGridListAddRow(modShop.GUI.gridlist[2])
				guiGridListSetItemText(modShop.GUI.gridlist[2],row,modShop.GUI.column[4],tostring(i),false,false)
				guiGridListSetItemText(modShop.GUI.gridlist[2],row,modShop.GUI.column[5],tostring(modShop.items[tonumber(v)][2]),false,false)
				modShop.upgradeCost = modShop.upgradeCost + tonumber(modShop.items[tonumber(v)][2])
			end
			guiSetText(modShop.GUI.label[1],"Koszt: "..modShop.upgradeCost.."$")
			--triggerServerEvent("Server:modShopAddUpgrade",resourceRoot,selectedItemType,selectedItemID)
			if vehicleCopy then
				if selectedItemType == "Paintjob" then return setVehiclePaintjob(vehicleCopy,selectedItemID) end
				addVehicleUpgrade(vehicleCopy,selectedItemID)
			end
		end
	end,false)
	modShop.GUI.column[1] = guiGridListAddColumn(modShop.GUI.gridlist[1],"typ",0.31)
	modShop.GUI.column[3] = guiGridListAddColumn(modShop.GUI.gridlist[1],"nazwa",0.37)
	modShop.GUI.column[2] = guiGridListAddColumn(modShop.GUI.gridlist[1],"id",0.17)
    modShop.GUI.button[1] = guiCreateButton(0.05,0.81,0.90,0.05,"Kolor",true,modShop.GUI.window[1])
	addEventHandler("onClientGUIClick",modShop.GUI.button[1],
	function()
	    guiSetVisible(modShop.GUI.window[3],true)
		guiBringToFront(modShop.GUI.window[3])
	end,false)
	modShop.GUI.button[4] = guiCreateButton(0.05,0.87,0.90,0.05,"Reset",true,modShop.GUI.window[1])
	addEventHandler("onClientGUIClick",modShop.GUI.button[4],
	function()
		--triggerServerEvent("Server:modShopResetUpgrades",resourceRoot)
		if vehicleCopy then
			local upgrades = getVehicleUpgrades(vehicleCopy)
			for i,v in pairs(upgrades) do
				removeVehicleUpgrade(vehicleCopy,upgrades[i])
			end
			setVehiclePaintjob(vehicleCopy,3)
		end
		modShop.selectedUpgrades = {}
		guiGridListClear(modShop.GUI.gridlist[2])
		modShop.upgradeCost = 0
		guiSetText(modShop.GUI.label[1],"Koszt: "..modShop.upgradeCost.."$")
	end,false)
    modShop.GUI.button[2] = guiCreateButton(0.05,0.93,0.43,0.05,"OK",true,modShop.GUI.window[1])
	addEventHandler("onClientGUIClick",modShop.GUI.button[2],
	function()
		local upgrades = getVehicleUpgrades(vehicleCopy)
		local c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12 = getVehicleColor(vehicleCopy,true)
		local paintjob = getVehiclePaintjob(vehicleCopy)
		triggerServerEvent("Server:modShopClickOK",resourceRoot,modShop.upgradeCost,upgrades,{c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12},paintjob)
	end,false)
    modShop.GUI.button[3] = guiCreateButton(0.53,0.93,0.42,0.05,"Anuluj",true,modShop.GUI.window[1])
	addEventHandler("onClientGUIClick",modShop.GUI.button[3],
	function()
		triggerServerEvent("Server:modShopExit",resourceRoot--[[,modShop.defaultUpgrades,modShop.defaultColor,modShop.defaultPaintjob]])
	end,false)
    guiSetVisible(modShop.GUI.window[1],false)
	guiSetFont(modShop.GUI.button[1],"default-bold-small")
	guiSetFont(modShop.GUI.button[2],"default-bold-small")
	guiSetFont(modShop.GUI.button[3],"default-bold-small")
	guiSetFont(modShop.GUI.button[4],"default-bold-small")
	guiSetFont(modShop.GUI.button[5],"default-bold-small")
	guiSetFont(modShop.GUI.button[6],"default-bold-small")
end)

addEvent("Client:modShopHideGUI",true)
addEventHandler("Client:modShopHideGUI",localPlayer,
function()
    attachRotatingCamera(false)
	guiSetVisible(modShop.GUI.window[1],false)
	guiSetVisible(modShop.GUI.window[2],false)
	guiSetVisible(modShop.GUI.window[3],false)
	hidePlayerCursor()
	setCameraTarget(localPlayer)
	modShop.selectedUpgrades = {}
	modShop.defaultUpgrades = {}
	modShop.defaultColor = {}
	modShop.defaultPaintjob = {}
	fadeCamera(false,0.01)
	setTimer(function()
    	fadeCamera(true,2.0)
	end,1000,1)
end)

addEvent("Client:modShopMarkerHit",true)
addEventHandler("Client:modShopMarkerHit",localPlayer,
function(compatibleUpgrades,vehicleUpgrades,vehicleColor,vehiclePaintjob,vehicleID,randomDimension)
    fadeCamera(false,0.01)
	--setPedCanBeKnockedOffBike(localPlayer,false)
	setTimer(function()
    	--setTimer(setPedCanBeKnockedOffBike,2100,1,localPlayer,true)
    	modShop.selectedUpgrades = {}
		modShop.upgradeCost = 0
		guiSetText(modShop.GUI.label[1],"Koszt: "..modShop.upgradeCost.."$")
    	modShop.defaultUpgrades = vehicleUpgrades
   	 	modShop.defaultColor = vehicleColor
   	 	modShop.defaultPaintjob = vehiclePaintjob
    	guiGridListClear(modShop.GUI.gridlist[1])
		guiGridListClear(modShop.GUI.gridlist[2])
		--[[local theVehicle = getPedOccupiedVehicle(localPlayer)
		if theVehicle then
		    attachRotatingCamera(true,theVehicle,2,5.5)
		end]]
		local __vehicleUpgrades = {}
		for i,v in pairs(compatibleUpgrades) do
	    	local slotName = tostring(getVehicleUpgradeSlotName(v))
			if not __vehicleUpgrades[slotName] then 
			    __vehicleUpgrades[slotName] = {} 
			end
			table.insert(__vehicleUpgrades[slotName],v)
		end
		for i=0,3 do
	    	local row = guiGridListAddRow(modShop.GUI.gridlist[1])
			guiGridListSetItemText(modShop.GUI.gridlist[1],row,modShop.GUI.column[1],"Paintjob",false,false)
			guiGridListSetItemText(modShop.GUI.gridlist[1],row,modShop.GUI.column[2],tostring(i),false,false)
			guiGridListSetItemText(modShop.GUI.gridlist[1],row,modShop.GUI.column[3],"-",false,false)
		end
		for i,v in pairs(__vehicleUpgrades) do
	    	addUpgradesGridList(__vehicleUpgrades,tostring(i))
		end
		guiSetVisible(modShop.GUI.window[1],true)
		guiSetVisible(modShop.GUI.window[2],true)
		showCursor(true)
		doCreateVehicleCopy(vehicleID,randomDimension)
		fadeCamera(true,2.0)
	end,1000,1)
end)

function addUpgradesGridList(table,upgadeType)
	for i,v in pairs(table[upgadeType]) do
	    local row = guiGridListAddRow(modShop.GUI.gridlist[1])
		guiGridListSetItemText(modShop.GUI.gridlist[1],row,modShop.GUI.column[1],upgadeType,false,false)
		guiGridListSetItemText(modShop.GUI.gridlist[1],row,modShop.GUI.column[2],table[upgadeType][i],false,false)
		guiGridListSetItemText(modShop.GUI.gridlist[1],row,modShop.GUI.column[3],modShop.items[table[upgadeType][i]][1],false,false)
	end
end

setTimer(function()
	local px,py,pz = getElementPosition(localPlayer)
	for i=0,49 do
		local gx,gy,gz = getGaragePosition(i)
		local dist = getDistanceBetweenPoints3D(gx,gy,gz,px,py,pz)
		if dist < 25 then
			if isGarageOpen(i) == false then
				setGarageOpen(i,true)
			end
		else
			if isGarageOpen(i) == true then
				setGarageOpen(i,false)
			end
		end
	end
    if guiGetVisible(modShop.GUI.window[3]) == true then
	    local r1 = math.floor(255*(guiScrollBarGetScrollPosition(modShop.GUI.scrollbar[1])/100))
		local g1 = math.floor(255*(guiScrollBarGetScrollPosition(modShop.GUI.scrollbar[2])/100))
		local b1 = math.floor(255*(guiScrollBarGetScrollPosition(modShop.GUI.scrollbar[3])/100))
	    local r2 = math.floor(255*(guiScrollBarGetScrollPosition(modShop.GUI.scrollbar[4])/100))
		local g2 = math.floor(255*(guiScrollBarGetScrollPosition(modShop.GUI.scrollbar[5])/100))
		local b2 = math.floor(255*(guiScrollBarGetScrollPosition(modShop.GUI.scrollbar[6])/100))
		--[[local theVehicle = getPedOccupiedVehicle(localPlayer)
		if theVehicle then triggerServerEvent("Server:modShopSetVehicleColor",resourceRoot,r1,g1,b1,r2,g2,b2) end]]
		if vehicleCopy then
			setVehicleColor(vehicleCopy,r1,g1,b1,r2,g2,b2)
		end
		guiSetText(modShop.GUI.label[8],r1)
		guiSetText(modShop.GUI.label[9],g1)
		guiSetText(modShop.GUI.label[10],b1)
		guiSetText(modShop.GUI.label[11],r2)
		guiSetText(modShop.GUI.label[12],g2)
		guiSetText(modShop.GUI.label[13],b2)
	end
end,1000,0)

addEventHandler("onClientPlayerWasted",localPlayer,
function()
	if active == true then
		attachRotatingCamera(false)
		guiSetVisible(modShop.GUI.window[1],false)
		guiSetVisible(modShop.GUI.window[2],false)
		guiSetVisible(modShop.GUI.window[3],false)
		hidePlayerCursor()
		setCameraTarget(localPlayer)
		modShop.selectedUpgrades = {}
		modShop.defaultUpgrades = {}
		modShop.defaultColor = {}
		modShop.defaultPaintjob = {}
		fadeCamera(false,0.01)
		setTimer(function()
			fadeCamera(true,2.0)
		end,1000,1)
	end
end)

function doCreateVehicleCopy(id,dimension)
	if vehicleCopy then destroyElement(vehicleCopy) end
	vehicleCopy = createVehicle(id,0,0,999999999999999999,0,0,270.5)
	if vehicleCopy then
		setElementDimension(vehicleCopy,dimension)
		setElementFrozen(vehicleCopy,true)
		attachRotatingCamera(true,vehicleCopy,2,7.5)
		for i,v in pairs(modShop.defaultUpgrades) do
			addVehicleUpgrade(vehicleCopy,modShop.defaultUpgrades[i])
		end
		setVehicleColor(vehicleCopy,modShop.defaultColor[1],modShop.defaultColor[2],modShop.defaultColor[3],modShop.defaultColor[4],modShop.defaultColor[5],modShop.defaultColor[6])
		setTimer(function()
			setVehicleColor(vehicleCopy,modShop.defaultColor[1],modShop.defaultColor[2],modShop.defaultColor[3],modShop.defaultColor[4],modShop.defaultColor[5],modShop.defaultColor[6])
		end,500,1)
		setVehiclePaintjob(vehicleCopy,modShop.defaultPaintjob)
	end
end