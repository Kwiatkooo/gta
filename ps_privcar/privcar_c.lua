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

__privCar = {}

__privCar.lista = {}

__privCar.opcje = {
    "Teleportuj",
	"Przywołaj",
	"Wyrzuć pasażera",
	"Wyrzuć pasażerów",
	"Otwórz/Zamknij maskę",
	"Otwórz/Zamknij bagażnik",
	"Otwórz/Zamknij przednie prawe drzwi",
	"Otwórz/Zamknij przednie lewe drzwi",
	"Otwórz/Zamknij tylne prawe drzwi",
	"Otwórz/Zamknij tylne lewe drzwi",
	"Otwórz/Zamknij wszystkie drzwi",
	"Napraw",
	"Auto Tunning",
	"Sprzedaj",
}

__privCar.cost = "1"

__privCar.GUI = {
    gridlist = {},
    window = {},
    button = {},
	column = {},
}

__privCar.vehicles = {581,462,521,463,522,461,468,448,586,602,496,401,518,527,589,419,533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,467,426,547,405,409,550,566,540,421,529,485,552,431,438,437,574,420,525,408,416,433,427,490,528,523,470,598,596,597,599,428,499,609,498,524,532,578,486,406,573,455,588,403,514,423,414,443,515,531,456,459,422,482,605,530,418,572,582,413,440,543,583,478,554,536,575,534,567,535,576,412,402,542,603,475,568,424,504,457,483,508,571,500,444,556,557,471,495,539,429,541,415,480,562,565,434,494,502,503,411,559,561,560,506,451,558,555,477}

addEventHandler("onClientResourceStart", resourceRoot,
function()
    local x,y = guiGetScreenSize()
    __privCar.GUI.window[1] = guiCreateWindow(x/2-486,y/2-243,390,265,"KUP POJAZD",false)
    guiWindowSetSizable(__privCar.GUI.window[1],false)
    __privCar.GUI.gridlist[1] = guiCreateGridList(0.03,0.10,0.95,0.78,true,__privCar.GUI.window[1])
	guiSetFont(__privCar.GUI.gridlist[1],"default-bold-small")
	guiGridListSetSortingEnabled(__privCar.GUI.gridlist[1],false)
	__privCar.GUI.column[5] = guiGridListAddColumn(__privCar.GUI.gridlist[1],"ID",0.2)
	__privCar.GUI.column[1] = guiGridListAddColumn(__privCar.GUI.gridlist[1],"Nazwa",0.5)
	__privCar.GUI.column[2] = guiGridListAddColumn(__privCar.GUI.gridlist[1],"Cena",0.2)
    __privCar.GUI.button[1] = guiCreateButton(0.02,0.89,0.47,0.08,"Kup",true,__privCar.GUI.window[1])
	addEventHandler("onClientGUIClick",__privCar.GUI.button[1],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(__privCar.GUI.gridlist[1])
		local selectedVehicleName = guiGridListGetItemText(__privCar.GUI.gridlist[1],selectedRow,__privCar.GUI.column[1])
		if selectedVehicleName ~= "" then
		    triggerServerEvent("createPrivCar",resourceRoot,selectedVehicleName,tonumber(__privCar.cost))
		end
	    guiSetVisible(__privCar.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
    __privCar.GUI.button[2] = guiCreateButton(0.51,0.89,0.47,0.08,"Anuluj",true,__privCar.GUI.window[1])
	addEventHandler("onClientGUIClick",__privCar.GUI.button[2],
	function()
	    guiSetVisible(__privCar.GUI.window[1],false)
		hidePlayerCursor()
		triggerServerEvent("onClientExitVehicleShop",resourceRoot)
	end,false)
	for i,v in pairs(__privCar.vehicles) do
	    local carName = getVehicleNameFromModel(__privCar.vehicles[i])
		local carCost = __privCar.cost
		if carName and carCost then
		    local row = guiGridListAddRow(__privCar.GUI.gridlist[1])
			guiGridListSetItemText(__privCar.GUI.gridlist[1],row,__privCar.GUI.column[5],tostring(__privCar.vehicles[i]),false,false)
			guiGridListSetItemText(__privCar.GUI.gridlist[1],row,__privCar.GUI.column[1],tostring(carName),false,false)
			guiGridListSetItemText(__privCar.GUI.gridlist[1],row,__privCar.GUI.column[2],tostring(carCost).."$",false,false)
		end
	end
    centerWindow(__privCar.GUI.window[1])
	guiSetVisible(__privCar.GUI.window[1],false)
	
    __privCar.GUI.window[2] = guiCreateWindow(x/2-560,y/2-265,343,299,"PRYWATNY POJAZD",false)
    guiWindowSetSizable(__privCar.GUI.window[2],false)
    __privCar.GUI.gridlist[2] = guiCreateGridList(0.04,0.09,0.99,0.69,true,__privCar.GUI.window[2])
	guiSetFont(__privCar.GUI.gridlist[2],"default-bold-small")
	guiGridListSetSortingEnabled(__privCar.GUI.gridlist[2],false)
	__privCar.GUI.column[3] = guiGridListAddColumn(__privCar.GUI.gridlist[2],"Opcje",0.9)
	for i,v in pairs(__privCar.opcje) do
	    local row = guiGridListAddRow(__privCar.GUI.gridlist[2])
		guiGridListSetItemText(__privCar.GUI.gridlist[2],row,__privCar.GUI.column[3],tostring(v),false,false)
	end
    __privCar.GUI.button[3] = guiCreateButton(0.04,0.79,0.92,0.08,"OK",true,__privCar.GUI.window[2])
	addEventHandler("onClientGUIDoubleClick",__privCar.GUI.gridlist[2],
	function()
	    local cSelectedOption = guiGridListGetItemText(__privCar.GUI.gridlist[2],guiGridListGetSelectedItem(__privCar.GUI.gridlist[2]),1)
		if cSelectedOption and cSelectedOption ~= "" then
		    if cSelectedOption == "Sprzedaj" then
		        guiSetVisible(__privCar.GUI.window[2],false)
		        hidePlayerCursor()
			end
		    triggerServerEvent("onPrivCarOptionSelected",resourceRoot,cSelectedOption)
		end
	end,false)
	addEventHandler("onClientGUIClick",__privCar.GUI.button[3],
	function()
	    local cSelectedOption = guiGridListGetItemText(__privCar.GUI.gridlist[2],guiGridListGetSelectedItem(__privCar.GUI.gridlist[2]),1)
		if cSelectedOption and cSelectedOption ~= "" then
		    if cSelectedOption == "Sprzedaj" then
		        guiSetVisible(__privCar.GUI.window[2],false)
		        hidePlayerCursor()
			end
		    triggerServerEvent("onPrivCarOptionSelected",resourceRoot,cSelectedOption)
		end
	end,false)
    __privCar.GUI.button[4] = guiCreateButton(0.04,0.89,0.92,0.08,"Anuluj",true,__privCar.GUI.window[2])
	addEventHandler("onClientGUIClick",__privCar.GUI.button[4],
	function()
	    guiSetVisible(__privCar.GUI.window[2],false)
		hidePlayerCursor()
	end,false)
	centerWindow(__privCar.GUI.window[2])
	guiSetVisible(__privCar.GUI.window[2],false)
	
	__privCar.GUI.window[3] = guiCreateWindow(x/2-480,y/2-205,243,299,"PASAŻEROWIE",false)
	__privCar.GUI.gridlist[3] = guiCreateGridList(0.04,0.09,0.92,0.69,true,__privCar.GUI.window[3])
	guiSetFont(__privCar.GUI.gridlist[3],"default-bold-small")
	guiGridListSetSortingEnabled(__privCar.GUI.gridlist[3],false)
	__privCar.GUI.column[4] = guiGridListAddColumn(__privCar.GUI.gridlist[3],"",0.8)
	__privCar.GUI.button[5] = guiCreateButton(0.04,0.79,0.92,0.08,"Wyrzuć",true,__privCar.GUI.window[3])
	addEventHandler("onClientGUIClick",__privCar.GUI.button[5],
	function()
	    local cSelectedOccupant = guiGridListGetItemText(__privCar.GUI.gridlist[3],guiGridListGetSelectedItem(__privCar.GUI.gridlist[3]),1)
		if cSelectedOccupant and cSelectedOccupant ~= "" then
		    triggerServerEvent("kickVehicleOccupant",resourceRoot,cSelectedOccupant)
		end
	end,false)
	__privCar.GUI.button[6] = guiCreateButton(0.04,0.89,0.92,0.08,"Anuluj",true,__privCar.GUI.window[3])
	addEventHandler("onClientGUIClick",__privCar.GUI.button[6],
	function()
	    guiSetVisible(__privCar.GUI.window[3],false)
		hidePlayerCursor()
	end,false)
	--centerWindow(__privCar.GUI.window[3])
	guiSetVisible(__privCar.GUI.window[3],false)
	setTimer(function()
		triggerServerEvent("Server:loadPlayerPrivCar",resourceRoot)
	end,2000,1)
end)

addEvent("showVehicleOccupantsList",true)
addEventHandler("showVehicleOccupantsList",localPlayer,
function(occupants)
    guiSetVisible(__privCar.GUI.window[3],true)
	showCursor(true)
    guiGridListClear(__privCar.GUI.gridlist[3])
    for i,v in pairs(occupants) do
	    local row = guiGridListAddRow(__privCar.GUI.gridlist[3])
		guiGridListSetItemText(__privCar.GUI.gridlist[3],row,__privCar.GUI.column[4],tostring(getPlayerName(v)),false,false)
	end
end)

addEvent("showPrivCarMenu",true)
addEventHandler("showPrivCarMenu",localPlayer,
function()
    guiSetVisible(__privCar.GUI.window[2],true)
	showCursor(true)
end)

addEvent("onClientCarShopHit",true)
addEventHandler("onClientCarShopHit",localPlayer,
function()
    guiSetVisible(__privCar.GUI.window[1],true)
	showCursor(true)
end)

function refreshPrivCarsTable()
    __privCar.lista = {
	    ["list"] = {},
		["data"] = {},
	}
    for _,v in pairs(getElementsByType("vehicle")) do
	    local car_private = getElementData(v,"isPrivCar")
		local car_owner = getElementData(v,"PrivCarOwner")
		
		if car_private == true then
		    table.insert(__privCar.lista["list"],v)
			__privCar.lista["data"][v] = {}
			__privCar.lista["data"][v]["owner"] = car_owner
			__privCar.lista["data"][v]["name"] = getVehicleName(v)
		end
	end
end
--addEventHandler("onClientPlayerSpawn",root,refreshPrivCarsTable)
--addEventHandler("onClientVehicleRespawn",root,refreshPrivCarsTable)
--addEventHandler("onClientVehicleEnter",root,refreshPrivCarsTable)
addEvent("Client:RefreshPrivCarsTable",true)
addEventHandler("Client:RefreshPrivCarsTable",localPlayer,refreshPrivCarsTable)

addEventHandler("onClientRender",root,
function()
	local camX,camY,camZ = getCameraMatrix()
	if __privCar.lista["list"] then
    	for _,priv_car in pairs(__privCar.lista["list"]) do
	    	if isElement(priv_car) then
				local posX,posY,posZ = getElementPosition(priv_car)
				if posX and posY and posZ then
					if getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ) < 15 then
		    			local scX,scY = getScreenFromWorldPosition(posX,posY,posZ+0.0)
						if scX then
							local car_owner = dbmanager:removeHEXFromString(tostring(__privCar.lista["data"][priv_car]["owner"]))
			    			dxDrawText("Prywatny Pojazd\n● "..car_owner,scX,scY-14,scX,scY,tocolor(222,222,222,180),1,"default-bold","center","center",false,false,false,true)
						end
					end
				end
			end
		end
	end
end)