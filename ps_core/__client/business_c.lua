local dbmanager = exports["ps_core"]

business = {}
business.data = nil
business.markers = {}
business.objects = {}

business.GUI = {
    button = {},
    window = {},
    label = {},
    memo = {}
}

addEvent("onClientBusinessMarkerHit",true)
addEventHandler("onClientBusinessMarkerHit",localPlayer,
function(businessData)
    local theVehicle = getPedOccupiedVehicle(localPlayer)
	if theVehicle then
	    --setElementFrozen(theVehicle,true)
	end
    --setElementFrozen(localPlayer,true)
    business.data = businessData
	local bName = getElementData(business.data,"bName")
	local bCost = getElementData(business.data,"bCost")
	local bPayout = getElementData(business.data,"bPayout")
	local bOwner = getElementData(business.data,"bOwner")
    guiSetVisible(business.GUI.window[1],true)
	showCursor(true,false)
    guiSetText(business.GUI.memo[1],"● Nazwa: "..bName.."\n● Koszt: "..bCost.."\n● Wypłata: "..bPayout.."\n● Właściciel: "..bOwner.."\n\nPieniądze będą wypłacane automatycznie co 1min.")
end)

addEvent("onClientBusinessMarkerLeave",true)
addEventHandler("onClientBusinessMarkerLeave",localPlayer,
function()
    business.data = nil
	guiSetVisible(business.GUI.window[1],false)
	dbmanager:hidePlayerCursor()
	unnFreezePlayerAndVehicle()
end)

addEventHandler("onClientResourceStart",resourceRoot,
function()
    local x,y = guiGetScreenSize()
	business.GUI.window[1] = guiCreateWindow(x/2-140,y/2-179,274,354,"BIZNES",false)
    guiWindowSetSizable(business.GUI.window[1],false)
	guiSetAlpha(business.GUI.window[1],0.75)
    business.GUI.label[1] = guiCreateLabel(0.02,0.07,0.96,0.20,"Biznes",true,business.GUI.window[1])
    business.GUI.memo[1] = guiCreateMemo(0.03,0.29,0.93,0.43,"● Nazwa: \n● Koszt: \n● Wypłata: \n● Właściciel: \n\nPieniądze będą wypłacane automatycznie co 1min.",true,business.GUI.window[1])
    business.GUI.button[1] = guiCreateButton(0.04,0.84,0.46,0.06,"Kup/Odkup",true,business.GUI.window[1])
    business.GUI.button[2] = guiCreateButton(0.04,0.91,0.92,0.06,"Anuluj",true,business.GUI.window[1]) 
    business.GUI.button[3] = guiCreateButton(0.51,0.84,0.45,0.06,"Sprzedaj",true,business.GUI.window[1])
	guiMemoSetReadOnly(business.GUI.memo[1],true)
	guiLabelSetColor(business.GUI.label[1],0,249,5)
	guiLabelSetHorizontalAlign(business.GUI.label[1],"center",false)
	--guiSetProperty(business.GUI.button[1],"NormalTextColour","FF2AFC00")
    --guiSetProperty(business.GUI.button[2],"NormalTextColour","FFFB0000")
    --guiSetProperty(business.GUI.button[3],"NormalTextColour","FFF8F600")
	guiSetFont(business.GUI.label[1],"sa-header")
	guiSetFont(business.GUI.memo[1],"default-bold-small")
	guiSetFont(business.GUI.button[3],"default-bold-small")
	guiSetFont(business.GUI.button[2],"default-bold-small")
	guiSetFont(business.GUI.button[1],"default-bold-small")
	addEventHandler("onClientGUIClick",business.GUI.button[2],cBusinessAnuluj,false)
	addEventHandler("onClientGUIClick",business.GUI.button[1],cBusinessKup,false)
	addEventHandler("onClientGUIClick",business.GUI.button[3],cBusinessSprzedaj,false)
	guiSetVisible(business.GUI.window[1],false)
    for _,v in pairs(getElementsByType("marker",getResourceRootElement(getThisResource()))) do
	    local markerType = getMarkerType(v)
		if markerType == "cylinder" then
		    local bName = getElementData(v,"bName")
			if bName then
			    table.insert(business.markers,v)
			end
		end
	end
	for _,v in pairs(getElementsByType("marker",getResourceRootElement(getThisResource()))) do
	    local bID = getElementData(v,"bID")
		if bID then
	    	local posX,posY,posZ = getElementPosition(v)
			local bObject = createObject(1274,posX,posY,posZ+0.7,0,0,0,true)
			table.insert(business.objects,bObject)
		end
	end
end)

function cBusinessAnuluj()
    guiSetVisible(business.GUI.window[1],false)
	dbmanager:hidePlayerCursor()
	unnFreezePlayerAndVehicle()
end

function cBusinessKup()
    if business.data then
	    triggerServerEvent("onPlayerBuyBusiness",resourceRoot,business.data,getElementData(business.data,"bID"))
	end
	unnFreezePlayerAndVehicle()
end

function cBusinessSprzedaj()
    if business.data then
	    triggerServerEvent("onPlayerSellBusiness",resourceRoot,business.data,getElementData(business.data,"bID"))
	end
	unnFreezePlayerAndVehicle()
end

addEvent("onClientBuyBusiness",true)
addEventHandler("onClientBuyBusiness",localPlayer,
function()
	business.data = nil
	guiSetVisible(business.GUI.window[1],false)
	dbmanager:hidePlayerCursor()
    unnFreezePlayerAndVehicle()
end)

function unnFreezePlayerAndVehicle()
	--setElementFrozen(localPlayer,false)
    local theVehicle = getPedOccupiedVehicle(localPlayer)
	if theVehicle then
	    --setElementFrozen(theVehicle,false)
	end
end

businessesListGui = {
    gridlist = {},
    window = {},
    button = {},
	column = {},
}

addEventHandler("onClientResourceStart",resourceRoot,
function()
    local x,y = guiGetScreenSize()
    businessesListGui.window[1] = guiCreateWindow(x/2-240,y/2-169,475,319,"LISTA BIZNESÓW",false)
    guiWindowSetSizable(businessesListGui.window[1],false)
    guiSetAlpha(businessesListGui.window[1],0.70)
    businessesListGui.gridlist[1] = guiCreateGridList(0.02,0.09,0.96,0.77, true, businessesListGui.window[1])
	guiGridListSetSortingEnabled(businessesListGui.gridlist[1],false)
    businessesListGui.button[1] = guiCreateButton(0.02,0.89,0.96,0.08,"ZAMKNIJ",true,businessesListGui.window[1])
	guiSetFont(businessesListGui.gridlist[1],"default-bold-small")
    guiSetFont(businessesListGui.button[1],"default-bold-small")
    --guiSetProperty(businessesListGui.button[1],"NormalTextColour","FFFE0000")
	businessesListGui.column[1] = guiGridListAddColumn(businessesListGui.gridlist[1],"ID",0.1)
	businessesListGui.column[2] = guiGridListAddColumn(businessesListGui.gridlist[1],"Nazwa",0.35)
	businessesListGui.column[3] = guiGridListAddColumn(businessesListGui.gridlist[1],"Właściciel",0.4)
    addEventHandler("onClientGUIClick",businessesListGui.button[1],hideBusinessesList,false)
	guiSetVisible(businessesListGui.window[1],false)
end)

addCommandHandler("biznesy",
function(_)
    if getElementData(localPlayer,"pCommands") then
    	guiGridListClear(businessesListGui.gridlist[1])
		for _,bMarker in pairs(getElementsByType("marker",getResourceRootElement(getThisResource()))) do
	    	local bID = getElementData(bMarker,"bID")
	    	local bName = getElementData(bMarker,"bName")
			local bOwner = getElementData(bMarker,"bOwner")
			if bID and bName and bOwner then
		    	local row = guiGridListAddRow(businessesListGui.gridlist[1])
				guiGridListSetItemText(businessesListGui.gridlist[1],row,businessesListGui.column[1],tostring(bID),false,false)
				guiGridListSetItemText(businessesListGui.gridlist[1],row,businessesListGui.column[2],tostring(bName),false,false)
				guiGridListSetItemText(businessesListGui.gridlist[1],row,businessesListGui.column[3],dbmanager:removeHEXFromString(tostring(bOwner)),false,false)
			end
		end
    	guiSetVisible(businessesListGui.window[1],true)
		showCursor(true)
	end
end)

function hideBusinessesList()
    guiSetVisible(businessesListGui.window[1],false)
	dbmanager:hidePlayerCursor()
end

addEventHandler("onClientRender",root,
function()
	local theDimension = getElementDimension(localPlayer)
	if theDimension ~= 0 then return end
	local camX,camY,camZ = getCameraMatrix()
	if business.markers then
		for i,v in pairs(business.markers) do
	    	local posX,posY,posZ = getElementPosition(v)
			if getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ) < 15 then
            	local bName = getElementData(v,"bName")
		    	local bID = getElementData(v,"bID")
   		    	local bCost = getElementData(v,"bCost")
    	    	local bPayout = getElementData(v,"bPayout")
    	    	local bOwner = dbmanager:removeHEXFromString(tostring(getElementData(v,"bOwner")))
	        	local scX,scY = getScreenFromWorldPosition(posX,posY,posZ+1.4)
		    	if scX then
			    	dxDrawText(""..bName.."(ID: "..bID..")\n● Koszt: "..bCost.."$\n● Wypłata: "..bPayout.."$\n● Właściciel: "..bOwner,scX+1,scY+15+1,scX+1,scY+15+1,tocolor(0,0,0,255),1,"default-bold","center","center",false,false,false,true)
			    	dxDrawText(""..bName.."(ID: "..bID..")\n● Koszt: "..bCost.."$\n● Wypłata: "..bPayout.."$\n● Właściciel: "..bOwner,scX,scY+15,scX,scY+15,tocolor(255,255,255,255),1,"default-bold","center","center",false,false,false,true)
		    	end
			end
		end
	end
    for i,v in pairs(business.objects) do
		local posX,posY,posZ = getElementPosition(v)
		if getDistanceBetweenPoints3D(camX,camY,camZ,posX,posY,posZ) < 35 then
		    local rx,ry,rz = getElementRotation(v)
		    setElementRotation(v,rx,ry,rz+2.5)
		end
	end
end)