local dbmanager = exports["ps_core"]

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

house_system = {}
house_system.localData = {}

house_system.GUI = {
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {},
	column = {},
}

house_system.INT = {
	[1] = {223.0538482666,1287.3552246094,1082.140625,1,"Shitty house 1",224.16796875,1291.6015625,1082.140625},
	[2] = {2233.6594238281,-1114.9837646484,1050.8828125,5,"Hotel room 1",2233.0166015625,-1109.2001953125,1050.8828125},
	[3] = {2365.22265625,-1135.5612792969,1050.8825683594,8,"Modern house 1",2365.025390625,-1130.6875,1050.875},
	[4] = {2282.9401855469,-1140.1246337891,1050.8984375,11,"Hotel room 2",2282.8759765625,-1136.2998046875,1050.8984375},
	[5] = {2196.7075195313,-1204.3569335938,1049.0234375,6,"Modern house 2",2192.8046875,-1202.2314453125,1049.0234375},
	[6] = {2270.0834960938,-1210.4854736328,1047.5625,10,"Modern house 3",2264.775390625,-1210.5537109375,1049.0234375},
	[7] = {2308.755859375,-1212.5498046875,1049.0234375,6,"Shitty house 2",2307.9013671875,-1210.00390625,1049.0234375},
	[8] = {2217.7729492188,-1076.2110595703,1050.484375,1,"Hotel room 3",2214.3232421875,-1076.126953125,1050.484375},
	[9] = {2237.5009765625,-1080.9367675781,1049.0234375,2,"Good house 1",2237.4990234375,-1077.9501953125,1049.0234375},
	[10] = {2317.7609863281,-1026.4268798828,1050.2177734375,9,"Good Stair house 1",2319.6142578125,-1023.2802734375,1050.2109375},
	[11] = {261.05038452148,1284.7646484375,1080.2578125,4,"Goood house 2",261.01953125,1287.380859375,1080.2578125},
	[12] = {140.18000793457,1366.7183837891,1083.859375,5,"Modern house 4(Rich)",140.279296875,1369.888671875,1083.8651123047},
	[13] = {83.037002563477,1322.6156005859,1083.8662109375,9,"Good Stair house 2",84.3544921875,1324.9384765625,1083.859375},
	[14] = {-283.92623901367,1471.0096435547,1084.375,15,"Good Stair house 3",-287.2119140625,1471.2744140625,1084.375},
	[15] = {-261.03778076172,1456.6539306641,1084.3671875,4,"Good Stair house 4",-264.994140625,1456.3408203125,1084.3671875},
	[16] = {-42.609268188477,1405.8033447266,1084.4296875,8,"Shitty house 3",-42.826171875,1408.4853515625,1084.4296875},
	[17] = {-68.839866638184,1351.4775390625,1080.2109375,6,"Shitty house 4",-68.81640625,1355.439453125,1080.2109375},
	[18] = {2333.068359375,-1077.0648193359,1049.0234375,6,"Shitty house 5",2333.1591796875,-1072.978515625,1049.0234375},
	[19] = {1261.1168212891,-785.38037109375,1091.90625,5,"Mad Doggs Mansion",1264.3056640625,-782.033203125,1091.90625},
	[20] = {2215.1145019531,-1150.4993896484,1025.796875,15,"Jefferson Motel",2219.2392578125,-1150.716796875,1025.796875},
	[21] = {2352.4575195313,-1180.9454345703,1027.9765625,5,"Burning desire house(Buggy)",2348.2119140625,-1181.00390625,1027.9765625},
	[22] = {421.94845581055,2536.5021972656,10,10,"Abandoned Tower",418.8330078125,2536.90625,10},
	[23] = {2495.9753417969,-1692.4174804688,1014.7421875,3,"Johnson house",2495.9736328125,-1695.806640625,1014.7421875},
	[24] = {-2158.7209472656,642.83074951172,1052.375,1,"Bet Interior",-2160.716796875,641.30859375,1052.3817138672},
	[25] = {1701.1682128906,-1667.759765625,20.21875,18,"Atrium lobby",1704.638671875,-1668.0400390625,20.225704193115},
	[26] = {2324.640625,-1149.0224609375,1050.7100830078,12,"Modern House 5(Rich)",2324.5078125,-1146.1650390625,1050.7100830078},
	[27] = {244.411987,305.032989,999.148437,1,"1 Room house",246.8876953125,304.84375,999.1484375},
	[28] = {266.9306640625,304.904296875,999.1484375,2,"1 Room house",270.2802734375,305.109375,999.15576171875},
	[29] = {302.232421875,300.6513671875,999.1484375,4,"1 Room house",302.0693359375,303.9072265625,999.1484375},
}

local lastHouseJoin = getTickCount() - 60000
addEventHandler("onClientResourceStart",resourceRoot,
function()
    house_system.GUI.window[1] = guiCreateWindow(518,227,662,360,"CREATE HOUSE",false)
	centerWindow(house_system.GUI.window[1])
    guiWindowSetSizable(house_system.GUI.window[1],false)
    guiSetAlpha(house_system.GUI.window[1],0.70)
    house_system.GUI.edit[1] = guiCreateEdit(0.02,0.08,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[2] = guiCreateEdit(0.02,0.145,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[3] = guiCreateEdit(0.02,0.21,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.button[1] = guiCreateButton(0.02,0.27,0.20,0.05,"Enter Marker",true,house_system.GUI.window[1])
    guiSetProperty(house_system.GUI.button[1],"NormalTextColour","FFAAAAAA")
    house_system.GUI.edit[4] = guiCreateEdit(0.28,0.08,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[5] = guiCreateEdit(0.28,0.145,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[6] = guiCreateEdit(0.28,0.21,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.button[2] = guiCreateButton(0.28,0.27,0.20,0.05,"Exit Marker",true,house_system.GUI.window[1])
    guiSetProperty(house_system.GUI.button[2],"NormalTextColour","FFAAAAAA")
    house_system.GUI.edit[7] = guiCreateEdit(0.02,0.39,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[8] = guiCreateEdit(0.02,0.455,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[9] = guiCreateEdit(0.02,0.52,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.button[3] = guiCreateButton(0.02,0.58,0.20,0.05,"Enter Teleport",true,house_system.GUI.window[1])
    guiSetProperty(house_system.GUI.button[3],"NormalTextColour","FFAAAAAA")
    house_system.GUI.button[4] = guiCreateButton(0.28,0.58,0.20,0.05,"Exit Teleport",true,house_system.GUI.window[1])
    guiSetProperty(house_system.GUI.button[4],"NormalTextColour","FFAAAAAA")
    house_system.GUI.edit[10] = guiCreateEdit(0.28,0.52,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[11] = guiCreateEdit(0.28,0.455,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[12] = guiCreateEdit(0.28,0.39,0.20,0.05,"",true,house_system.GUI.window[1])
    house_system.GUI.edit[13] = guiCreateEdit(0.02,0.73,0.10,0.06,"",true,house_system.GUI.window[1])
    house_system.GUI.label[1] = guiCreateLabel(0.13,0.73,0.18,0.06,"Interior",true,house_system.GUI.window[1])
    house_system.GUI.edit[14] = guiCreateEdit(0.02,0.81,0.10,0.06,"",true,house_system.GUI.window[1])
    house_system.GUI.label[2] = guiCreateLabel(0.13,0.81,0.18,0.06,"Dimension",true,house_system.GUI.window[1])
    house_system.GUI.button[5] = guiCreateButton(0.27,0.83,0.20,0.06,"Save House",true,house_system.GUI.window[1])
    guiSetProperty(house_system.GUI.button[5],"NormalTextColour","FFAAAAAA")
    house_system.GUI.button[6] = guiCreateButton(0.27,0.91,0.20,0.06,"Exit",true,house_system.GUI.window[1])
    guiSetProperty(house_system.GUI.button[6],"NormalTextColour","FFAAAAAA")
    house_system.GUI.edit[15] = guiCreateEdit(0.02,0.89,0.10,0.06,"",true,house_system.GUI.window[1])
    house_system.GUI.label[3] = guiCreateLabel(0.13,0.89,0.18,0.06,"Cost",true,house_system.GUI.window[1])
    house_system.GUI.gridlist[1] = guiCreateGridList(0.55,0.08,0.43,0.37,true,house_system.GUI.window[1])
	house_system.GUI.column[1] = guiGridListAddColumn(house_system.GUI.gridlist[1],"ID",0.2)
	house_system.GUI.column[2] = guiGridListAddColumn(house_system.GUI.gridlist[1],"NAME",0.6)
	for i,v in ipairs(house_system.INT) do
		local row = guiGridListAddRow(house_system.GUI.gridlist[1])
		guiGridListSetItemText(house_system.GUI.gridlist[1],row,house_system.GUI.column[1],tostring(i),false,false)
		guiGridListSetItemText(house_system.GUI.gridlist[1],row,house_system.GUI.column[2],tostring(v[5]),false,false)
	end
    house_system.GUI.staticimage[1] = guiCreateStaticImage(0.55,0.56,0.42,0.40,"__images/1.jpg",true,house_system.GUI.window[1])
	addEventHandler("onClientGUIDoubleClick",house_system.GUI.gridlist[1],
	function()
		local selectedHouse = tonumber(guiGridListGetItemText(house_system.GUI.gridlist[1],guiGridListGetSelectedItem(house_system.GUI.gridlist[1]),1))
		if selectedHouse and selectedHouse ~= "" then
			guiStaticImageLoadImage(house_system.GUI.staticimage[1],"__images/"..selectedHouse..".jpg")
			
			guiSetText(house_system.GUI.edit[4],house_system.INT[selectedHouse][1])
			guiSetText(house_system.GUI.edit[5],house_system.INT[selectedHouse][2])
			guiSetText(house_system.GUI.edit[6],house_system.INT[selectedHouse][3])
			
			guiSetText(house_system.GUI.edit[7],house_system.INT[selectedHouse][6])
			guiSetText(house_system.GUI.edit[8],house_system.INT[selectedHouse][7])
			guiSetText(house_system.GUI.edit[9],house_system.INT[selectedHouse][8])
			
			guiSetText(house_system.GUI.edit[13],house_system.INT[selectedHouse][4])
			guiSetText(house_system.GUI.edit[14],math.random(123,12345))
		end
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[6],
	function()
		guiSetVisible(house_system.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[1],
	function()
		local x,y,z = getElementPosition(localPlayer)
		guiSetText(house_system.GUI.edit[1],x)
		guiSetText(house_system.GUI.edit[2],y)
		guiSetText(house_system.GUI.edit[3],z)
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[2],
	function()
		local x,y,z = getElementPosition(localPlayer)
		guiSetText(house_system.GUI.edit[4],x)
		guiSetText(house_system.GUI.edit[5],y)
		guiSetText(house_system.GUI.edit[6],z)
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[3],
	function()
		local x,y,z = getElementPosition(localPlayer)
		guiSetText(house_system.GUI.edit[7],x)
		guiSetText(house_system.GUI.edit[8],y)
		guiSetText(house_system.GUI.edit[9],z)
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[4],
	function()
		local x,y,z = getElementPosition(localPlayer)
		guiSetText(house_system.GUI.edit[12],x)
		guiSetText(house_system.GUI.edit[11],y)
		guiSetText(house_system.GUI.edit[10],z)
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[5],
	function()
		local h = {}
		h.en_X = guiGetText(house_system.GUI.edit[1])
		h.en_Y = guiGetText(house_system.GUI.edit[2])
		h.en_Z = guiGetText(house_system.GUI.edit[3])
		h.en_tX = guiGetText(house_system.GUI.edit[7])
		h.en_tY = guiGetText(house_system.GUI.edit[8])
		h.en_tZ = guiGetText(house_system.GUI.edit[9])
		h.ex_X = guiGetText(house_system.GUI.edit[4])
		h.ex_Y = guiGetText(house_system.GUI.edit[5])
		h.ex_Z = guiGetText(house_system.GUI.edit[6])
		h.ex_tX = guiGetText(house_system.GUI.edit[12])
		h.ex_tY = guiGetText(house_system.GUI.edit[11])
		h.ex_tZ = guiGetText(house_system.GUI.edit[10])
		h.interior = guiGetText(house_system.GUI.edit[13])
		h.dimension = guiGetText(house_system.GUI.edit[14])
		h.cost = guiGetText(house_system.GUI.edit[15])
		h.owner = ""
		h.key = ""
		triggerServerEvent("Server:SaveHouse",resourceRoot,h)
	end,false)
	guiSetVisible(house_system.GUI.window[1],false)
	
	
    house_system.GUI.window[2] = guiCreateWindow(533,308,277,177,"DOM OPCJE",false)
	centerWindow(house_system.GUI.window[2])
    guiWindowSetSizable(house_system.GUI.window[2],false)
    house_system.GUI.gridlist[2] = guiCreateGridList(0.03,0.15,0.93,0.66,true,house_system.GUI.window[2])
	house_system.GUI.column[3] = guiGridListAddColumn(house_system.GUI.gridlist[2],"-",0.7)
	local b = {
		"Kup posiadlość",
		"Obejrzyj posiadlość",
	}
	for i,v in pairs(b) do
		local row = guiGridListAddRow(house_system.GUI.gridlist[2])
		guiGridListSetItemText(house_system.GUI.gridlist[2],row,house_system.GUI.column[3],tostring(v),false,false)
	end
    house_system.GUI.button[7] = guiCreateButton(0.03,0.84,0.44,0.11,"OK",true,house_system.GUI.window[2])
    guiSetProperty(house_system.GUI.button[7],"NormalTextColour","FFAAAAAA")
    house_system.GUI.button[8] = guiCreateButton(0.52,0.84,0.44,0.11,"Anuluj",true,house_system.GUI.window[2])
    guiSetProperty(house_system.GUI.button[8],"NormalTextColour","FFAAAAAA")
	guiSetVisible(house_system.GUI.window[2],false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[8],
	function()
		guiSetVisible(house_system.GUI.window[2],false)
		hidePlayerCursor()
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[7],
	function()
		guiSetVisible(house_system.GUI.window[2],false)
		hidePlayerCursor()
		local wybranaOpcja = guiGridListGetItemText(house_system.GUI.gridlist[2],guiGridListGetSelectedItem(house_system.GUI.gridlist[2]),1)
		if wybranaOpcja == "Kup posiadlość" then
			triggerServerEvent("Server:BuyHouse",resourceRoot,house_system.localData)
		end
		if wybranaOpcja == "Obejrzyj posiadlość" then
			if getTickCount() - lastHouseJoin < 60000 then outputChatBox("● INFO: Kolejną posiadłość będziesz mógł(mogła) obejrzeć za "..math.floor((61000-(getTickCount()-lastHouseJoin))/1000).."s.",255,0,0) return end
			setElementData(localPlayer,"pCommands",false)
			local posX,posY,posZ,interior,dimension = house_system.localData["en_tX"],house_system.localData["en_tY"],house_system.localData["en_tZ"],house_system.localData["interior"],house_system.localData["dimension"]
			setElementInterior(localPlayer,interior,posX,posY,posZ)
			setElementDimension(localPlayer,dimension)
			outputChatBox("● INFO: Masz 15sec. na obejrzenie posiadłości.",0,255,255)
			toggleControl("fire",false)
			lastHouseJoin = getTickCount()
			setTimer(function()
				local posX,posY,posZ,interior,dimension = house_system.localData["ex_tX"],house_system.localData["ex_tY"],house_system.localData["ex_tZ"],0,0
				setElementInterior(localPlayer,interior,posX,posY,posZ)
				setElementDimension(localPlayer,dimension)
				toggleControl("fire",true)
				setElementData(localPlayer,"pCommands",true)
			end,15*1000,1)
		end
	end,false)
	
	
    house_system.GUI.window[3] = guiCreateWindow(533,308,277,177,"DOM OPCJE",false)
	centerWindow(house_system.GUI.window[3])
    guiWindowSetSizable(house_system.GUI.window[3],false)
    house_system.GUI.gridlist[3] = guiCreateGridList(0.03,0.15,0.93,0.66,true,house_system.GUI.window[3])
	house_system.GUI.column[4] = guiGridListAddColumn(house_system.GUI.gridlist[3],"-",0.7)
	local b = {
		"Wejdz do srodka",
	}
	for i,v in pairs(b) do
		local row = guiGridListAddRow(house_system.GUI.gridlist[3])
		guiGridListSetItemText(house_system.GUI.gridlist[3],row,house_system.GUI.column[4],tostring(v),false,false)
	end
    house_system.GUI.button[9] = guiCreateButton(0.03,0.84,0.44,0.11,"OK",true,house_system.GUI.window[3])
    guiSetProperty(house_system.GUI.button[9],"NormalTextColour","FFAAAAAA")
    house_system.GUI.button[10] = guiCreateButton(0.52,0.84,0.44,0.11,"Anuluj",true,house_system.GUI.window[3])
    guiSetProperty(house_system.GUI.button[10],"NormalTextColour","FFAAAAAA")
	guiSetVisible(house_system.GUI.window[3],false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[10],
	function()
		guiSetVisible(house_system.GUI.window[3],false)
		hidePlayerCursor()
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[9],
	function()
		local wybranaOpcja = guiGridListGetItemText(house_system.GUI.gridlist[3],guiGridListGetSelectedItem(house_system.GUI.gridlist[3]),1)
		if wybranaOpcja == "Wejdz do srodka" then
			guiSetVisible(house_system.GUI.window[3],false)
			hidePlayerCursor()
			local ID = house_system.localData["ID"]
			triggerServerEvent("Server:JoinHouse",resourceRoot,ID)
			return
		end
	end,false)
	
	
	house_system.GUI.window[4] = guiCreateWindow(526,326,224,104,"WPROWADŹ KOD",false)
	centerWindow(house_system.GUI.window[4])
	guiWindowSetSizable(house_system.GUI.window[4],false)
	house_system.GUI.edit[16] = guiCreateEdit(0.04,0.21,0.92,0.30,"",true,house_system.GUI.window[4])
	house_system.GUI.button[11] = guiCreateButton(0.04,0.63,0.43,0.27,"OK",true,house_system.GUI.window[4])
	guiSetProperty(house_system.GUI.button[11],"NormalTextColour","FFAAAAAA")
	house_system.GUI.button[12] = guiCreateButton(0.52,0.63,0.43,0.27,"Anuluj",true,house_system.GUI.window[4])
	guiSetProperty(house_system.GUI.button[12],"NormalTextColour","FFAAAAAA")
	guiSetVisible(house_system.GUI.window[4],false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[12],
	function()
		guiSetVisible(house_system.GUI.window[4],false)
		hidePlayerCursor()
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[11],
	function()
		guiSetVisible(house_system.GUI.window[4],false)
		hidePlayerCursor()
		local submit_key = guiGetText(house_system.GUI.edit[16])
		--outputChatBox(tostring(house_system.localData["key"]))
		if tostring(house_system.localData["key"]) == tostring(submit_key) then
			triggerServerEvent("Server:JoinHouseWithKey",resourceRoot,house_system.localData["ID"])
		else
			outputChatBox("● INFO: Wprowadziłeś(aś) błędny kod.",255,0,0)
		end
	end,false)
	
	
    house_system.GUI.window[5] = guiCreateWindow(533,308,277,177,"DOM OPCJE",false)
	centerWindow(house_system.GUI.window[5])
    guiWindowSetSizable(house_system.GUI.window[5],false)
    house_system.GUI.gridlist[4] = guiCreateGridList(0.03,0.15,0.93,0.66,true,house_system.GUI.window[5])
	house_system.GUI.column[5] = guiGridListAddColumn(house_system.GUI.gridlist[4],"-",0.7)
	local o = {
		"Teleportuj",
		"Pokaz kod",
		"Zmien kod",
		"Sprzedaj",
	}
	for i,v in pairs(o) do
		local row = guiGridListAddRow(house_system.GUI.gridlist[4])
		guiGridListSetItemText(house_system.GUI.gridlist[4],row,house_system.GUI.column[5],tostring(v),false,false)
	end
    house_system.GUI.button[13] = guiCreateButton(0.03,0.84,0.44,0.11,"OK",true,house_system.GUI.window[5])
    guiSetProperty(house_system.GUI.button[13],"NormalTextColour","FFAAAAAA")
    house_system.GUI.button[14] = guiCreateButton(0.52,0.84,0.44,0.11,"Anuluj",true,house_system.GUI.window[5])
    guiSetProperty(house_system.GUI.button[14],"NormalTextColour","FFAAAAAA")
	guiSetVisible(house_system.GUI.window[5],false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[14],
	function()
		guiSetVisible(house_system.GUI.window[5],false)
		hidePlayerCursor()
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[13],
	function()
		--guiSetVisible(house_system.GUI.window[5],false)
		--hidePlayerCursor()
		local wybranaOpcja = guiGridListGetItemText(house_system.GUI.gridlist[4],guiGridListGetSelectedItem(house_system.GUI.gridlist[4]),1)
		if wybranaOpcja ~= "" then
			if wybranaOpcja == "Zmien kod" then
				guiSetVisible(house_system.GUI.window[6],true)
				showCursor(true,false)
				guiBringToFront(house_system.GUI.window[6])
				return
			end
			guiSetVisible(house_system.GUI.window[5],false)
			hidePlayerCursor()
			triggerServerEvent("Server:onHousePanelSelected",resourceRoot,wybranaOpcja)
		end
	end,false)
	
	
	house_system.GUI.window[6] = guiCreateWindow(526,326,224,104,"WPROWADŹ NOWY KOD",false)
	centerWindow(house_system.GUI.window[6])
	guiWindowSetSizable(house_system.GUI.window[6],false)
	house_system.GUI.edit[17] = guiCreateEdit(0.04,0.21,0.92,0.30,"",true,house_system.GUI.window[6])
	house_system.GUI.button[15] = guiCreateButton(0.04,0.63,0.43,0.27,"OK",true,house_system.GUI.window[6])
	guiSetProperty(house_system.GUI.button[15],"NormalTextColour","FFAAAAAA")
	house_system.GUI.button[16] = guiCreateButton(0.52,0.63,0.43,0.27,"Anuluj",true,house_system.GUI.window[6])
	guiSetProperty(house_system.GUI.button[16],"NormalTextColour","FFAAAAAA")
	guiSetVisible(house_system.GUI.window[6],false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[16],
	function()
		guiSetVisible(house_system.GUI.window[6],false)
		hidePlayerCursor()
	end,false)
	addEventHandler("onClientGUIClick",house_system.GUI.button[15],
	function()
		guiSetVisible(house_system.GUI.window[6],false)
		hidePlayerCursor()
		local submit_key = tostring(guiGetText(house_system.GUI.edit[17]))
		--outputChatBox(tostring(house_system.localData["key"]))
		if submit_key ~= "" then
			triggerServerEvent("Server:changeHouseKey",resourceRoot,submit_key)
		end
	end,false)
end)

addEvent("Client:OpenHousePanel",true)
addEventHandler("Client:OpenHousePanel",localPlayer,
function()
	guiSetVisible(house_system.GUI.window[5],true)
	showCursor(true)
end)

addEvent("Client:ShowHouseKeyMenu",true)
addEventHandler("Client:ShowHouseKeyMenu",localPlayer,
function(houseData)
	house_system.localData = houseData
	guiSetVisible(house_system.GUI.window[4],true)
	showCursor(true,false)
end)

addEvent("Client:ShowHouseJoinMenu",true)
addEventHandler("Client:ShowHouseJoinMenu",localPlayer,
function(houseData)
	house_system.localData = houseData
	guiSetVisible(house_system.GUI.window[3],true)
	showCursor(true,false)
end)

addEvent("Client:HideHouseJoinMenu",true)
addEventHandler("Client:HideHouseJoinMenu",localPlayer,
function()
	guiSetVisible(house_system.GUI.window[3],false)
	for _,guiElement in ipairs(getElementChildren(getResourceGUIElement())) do
	    if isElement(guiElement) and guiGetEnabled(guiElement) ~= false then
		    guiSetVisible(guiElement,false)
		end
	end
	hidePlayerCursor()
	--house_system.localData = nil
end)

addEvent("Client:ShowHouseBuyMenu",true)
addEventHandler("Client:ShowHouseBuyMenu",localPlayer,
function(houseData)
	house_system.localData = houseData
	guiSetVisible(house_system.GUI.window[2],true)
	showCursor(true,false)
end)

addEvent("Client:HideHouseBuyMenu",true)
addEventHandler("Client:HideHouseBuyMenu",localPlayer,
function()
	guiSetVisible(house_system.GUI.window[2],false)
	for _,guiElement in ipairs(getElementChildren(getResourceGUIElement())) do
	    if isElement(guiElement) and guiGetEnabled(guiElement) ~= false then
		    guiSetVisible(guiElement,false)
		end
	end
	hidePlayerCursor()
	--house_system.localData = nil
end)

addEvent("Client:onPlayerHouseJoin",true)
addEventHandler("Client:onPlayerHouseJoin",localPlayer,
function()
	toggleControl("fire",false)
end)

addEvent("Client:onPlayerHouseExit",true)
addEventHandler("Client:onPlayerHouseExit",localPlayer,
function()
	toggleControl("fire",true)
end)

addEvent("Client:onPlayerHouseSell",true)
addEventHandler("Client:onPlayerHouseSell",localPlayer,
function() 
	for _,guiElement in ipairs(getElementChildren(getResourceGUIElement())) do
	    if isElement(guiElement) and guiGetEnabled(guiElement) ~= false then
		    guiSetVisible(guiElement,false)
		end
	end
end)

addEventHandler("onClientPlayerSpawn",localPlayer,
function()
	toggleControl("fire",true)
end)

bindKey("h","down",
function(key,keyState)
	if getPlayerName(localPlayer) == "Luk4s7_" then
		if guiGetVisible(house_system.GUI.window[1]) == false then
			guiSetVisible(house_system.GUI.window[1],true)
			showCursor(true)
		else
			guiSetVisible(house_system.GUI.window[1],false)
			hidePlayerCursor()
		end
	end
end)

addEventHandler("onClientRender",root,
function()
	if getElementDimension(localPlayer) ~= 0 then return end
	local camX,camY,camZ = getCameraMatrix()
	for i,v in pairs(getElementsByType("marker",resourceRoot,true)) do
		local posX,posY,posZ = getElementPosition(v)
		if getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ) < 15 then
			local houseID = getElementData(v,"house.id")
			local houseOwner = getElementData(v,"house.owner")
			local houseCost = getElementData(v,"house.cost")
			local houseExp = getElementData(v,"house.exp")
			local houseLocked = getElementData(v,"house.locked")
			local scX,scY = getScreenFromWorldPosition(posX,posY,posZ+0.5)
			if scX then
				if houseOwner then
					if houseOwner == "" then
						dxDrawText("DOM\nID: "..houseID.."\nCena: "..houseCost.."$\nCena za dzień: "..houseExp.." exp.",scX,scY+15,scX,scY+15,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,false,true)
					else
						dxDrawText("DOM:\nID: "..houseID.."\nWłaściciel: "..houseOwner.."\nStatus: "..houseLocked,scX,scY+15,scX,scY+15,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,false,true)
					end
				end
			end
		end
	end
end)