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

local gang = {}

gang.GUI = {
    button = {},
    window = {},
    label = {},
	column = {},
	gridlist = {},
}

addEventHandler("onClientResourceStart",resourceRoot,
function()
    local x,y = guiGetScreenSize()
    gang.GUI.window[1] = guiCreateWindow(x/2-205,y/2-108,413,135,"ZAPROSZENIE DO GANGU",false)
    guiWindowSetSizable(gang.GUI.window[1],false)
    gang.GUI.label[1] = guiCreateLabel(0.02,0.16,0.96,0.43,"",true,gang.GUI.window[1])
    guiLabelSetHorizontalAlign(gang.GUI.label[1],"center",false)
    guiLabelSetVerticalAlign(gang.GUI.label[1],"center")
    gang.GUI.button[1] = guiCreateButton(0.10,0.64,0.36,0.25,"Akceptuj",true,gang.GUI.window[1])
	addEventHandler("onClientGUIClick",gang.GUI.button[1],
	function()
	    if gang.theGang then
		    triggerServerEvent("onPlayerGangJoin",resourceRoot,gang.theGang)
		end
	    guiSetVisible(gang.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
	gang.GUI.button[2] = guiCreateButton(0.51,0.64,0.36,0.25,"Odrzuć",true,gang.GUI.window[1])
	addEventHandler("onClientGUIClick",gang.GUI.button[2],
	function()
        gang.theGang = nil
        gang.theInviterName = nil
		
	    guiSetVisible(gang.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
    guiSetFont(gang.GUI.button[1],"default-bold-small")
    guiSetFont(gang.GUI.label[1],"default-bold-small")
    guiSetFont(gang.GUI.button[2],"default-bold-small")
	guiSetProperty(gang.GUI.button[1],"NormalTextColour","FF0BFE00")
    guiSetProperty(gang.GUI.button[2],"NormalTextColour","FFFD0000")
	centerWindow(gang.GUI.window[1])
	guiSetVisible(gang.GUI.window[1],false)
    
	
	
    gang.GUI.window[2] = guiCreateWindow(x/2-149,y/2-157,356,240,"LISTA GANGÓW",false)
    guiWindowSetSizable(gang.GUI.window[2],false)
    gang.GUI.gridlist[1] = guiCreateGridList(0.03,0.11,0.93, 0.71,true,gang.GUI.window[2])
	guiGridListSetSortingEnabled(gang.GUI.gridlist[1],false)
    gang.GUI.button[3] = guiCreateButton(0.03,0.88,0.93,0.08,"Zamknij",true,gang.GUI.window[2])
	addEventHandler("onClientGUIClick",gang.GUI.button[3],
	function()
	    guiSetVisible(gang.GUI.window[2],false)
		hidePlayerCursor()
	end,false)
    gang.GUI.column[1] = guiGridListAddColumn(gang.GUI.gridlist[1],"Nazwa",0.32)
	gang.GUI.column[2] = guiGridListAddColumn(gang.GUI.gridlist[1],"Ilość Członków",0.26)
	gang.GUI.column[11] = guiGridListAddColumn(gang.GUI.gridlist[1],"Leader",0.3)
	guiSetFont(gang.GUI.gridlist[1],"default-bold-small")
	guiSetFont(gang.GUI.button[3],"default-bold-small")
	centerWindow(gang.GUI.window[2])
	guiSetVisible(gang.GUI.window[2],false)
	
	
	
    gang.GUI.window[3] = guiCreateWindow(x/2-149,y/2-157,296,240,"LISTA CZŁONKÓW GANGU",false)
    guiWindowSetSizable(gang.GUI.window[3],false)
    gang.GUI.gridlist[2] = guiCreateGridList(0.03,0.11,0.93, 0.71,true,gang.GUI.window[3])
	guiGridListSetSortingEnabled(gang.GUI.gridlist[2],false)
	guiSetFont(gang.GUI.gridlist[2],"default-small")
    gang.GUI.button[4] = guiCreateButton(0.03,0.88,0.93,0.08,"Zamknij",true,gang.GUI.window[3])
	addEventHandler("onClientGUIClick",gang.GUI.button[4],
	function()
	    guiSetVisible(gang.GUI.window[3],false)
		hidePlayerCursor()
	end,false)
    gang.GUI.column[3] = guiGridListAddColumn(gang.GUI.gridlist[2],"Nick",0.4)
	gang.GUI.column[4] = guiGridListAddColumn(gang.GUI.gridlist[2],"Status",0.2)
	gang.GUI.column[5] = guiGridListAddColumn(gang.GUI.gridlist[2],"Rank",0.2)
	centerWindow(gang.GUI.window[3])
	guiSetVisible(gang.GUI.window[3],false)
	
	
	
    gang.GUI.window[4] = guiCreateWindow(x/2-149,y/2-157,336,340,"PANEL ZARZĄDZANIA GANGIEM",false)
    guiWindowSetSizable(gang.GUI.window[4],false)
    gang.GUI.gridlist[3] = guiCreateGridList(0.03,0.11,0.95, 0.51,true,gang.GUI.window[4])
	guiGridListSetSortingEnabled(gang.GUI.gridlist[3],false)
	guiSetFont(gang.GUI.gridlist[3],"default-small")
    gang.GUI.button[5] = guiCreateButton(0.03,0.92,0.94,0.06,"Zamknij",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[5],
	function()
	    guiSetVisible(gang.GUI.window[4],false)
		hidePlayerCursor()
	end,false)
	gang.GUI.button[6] = guiCreateButton(0.03,0.73,0.44,0.06,"Dodaj Członka",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[6],
	function()
	    guiGridListClear(gang.GUI.gridlist[4])
		for i,v in pairs(getElementsByType("player")) do
		    local row = guiGridListAddRow(gang.GUI.gridlist[4])
			local r,g,b = getPlayerNametagColor(v)
			guiGridListSetItemText(gang.GUI.gridlist[4],row,gang.GUI.column[9],dbmanager:removeHEXFromString(tostring(getPlayerName(v))),false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[4],row,gang.GUI.column[9],r,g,b,255)
		end
	    guiSetVisible(gang.GUI.window[5],true)
		guiBringToFront(gang.GUI.window[5])
	end,false)
	gang.GUI.button[7] = guiCreateButton(0.53,0.73,0.44,0.06,"Wyrzuć Członka",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[7],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(gang.GUI.gridlist[3])
		local memberName = guiGridListGetItemText(gang.GUI.gridlist[3],selectedRow,selectedCol)
		if memberName and memberName ~= "" then
	        triggerServerEvent("Server:Gang-Panel:Kick",resourceRoot,memberName)
		else
		    outputChatBox("● [Gang]: Nie wybrałeś/aś żadnego gracza z listy.",255,0,0,true)
		end
	end,false)
	gang.GUI.button[6] = guiCreateButton(0.03,0.79,0.44,0.06,"Dodaj Sub Lidera",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[6],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(gang.GUI.gridlist[3])
		local memberName = guiGridListGetItemText(gang.GUI.gridlist[3],selectedRow,selectedCol)
		if memberName and memberName ~= "" then
	        triggerServerEvent("Server:Gang-Panel:MakeSubLeader",resourceRoot,memberName)
		else
		    outputChatBox("● [Gang]: Nie wybrałeś/aś żadnego gracza z listy.",255,0,0,true)
		end
	end,false)
	gang.GUI.button[7] = guiCreateButton(0.53,0.79,0.44,0.06,"Usuń Sub Lidera",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[7],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(gang.GUI.gridlist[3])
		local memberName = guiGridListGetItemText(gang.GUI.gridlist[3],selectedRow,selectedCol)
		if memberName and memberName ~= "" then
	        triggerServerEvent("Server:Gang-Panel:RemoveSubLeader",resourceRoot,memberName)
		else
		    outputChatBox("● [Gang]: Nie wybrałeś/aś żadnego gracza z listy.",255,0,0,true)
		end
	end,false)
	gang.GUI.button[8] = guiCreateButton(0.03,0.855,0.44,0.06,"Ustaw Bazę",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[8],
	function()
	    triggerServerEvent("Server:Gang-Panel:Base",resourceRoot)
	end,false)
	gang.GUI.button[9] = guiCreateButton(0.53,0.855,0.44,0.06,"Usuń Gang",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[9],
	function()
	    guiSetVisible(gang.GUI.window[4],false)
		hidePlayerCursor()
	    triggerServerEvent("Server:Gang-Panel:Delete",resourceRoot)
	end,false)
	gang.GUI.button[7] = guiCreateButton(0.03,0.62,0.94,0.06,"Odśwież",true,gang.GUI.window[4])
	addEventHandler("onClientGUIClick",gang.GUI.button[7],
	function()
	    triggerServerEvent("Server:Gang-Panel:Refresh",resourceRoot)
	end,false)
    gang.GUI.column[6] = guiGridListAddColumn(gang.GUI.gridlist[3],"Nick",0.4)
	gang.GUI.column[7] = guiGridListAddColumn(gang.GUI.gridlist[3],"Status",0.2)
	gang.GUI.column[8] = guiGridListAddColumn(gang.GUI.gridlist[3],"Rank",0.3)
	centerWindow(gang.GUI.window[4])
	guiSetVisible(gang.GUI.window[4],false)
	
	
	
    gang.GUI.window[5] = guiCreateWindow(x/2-464,y/2-197,212,371,"WYBIERZ GRACZA Z LISTY",false)
	centerWindow(gang.GUI.window[5])
    guiWindowSetMovable(gang.GUI.window[5],true)
    gang.GUI.gridlist[4] = guiCreateGridList(0.04,0.08,0.92,0.65,true,gang.GUI.window[5])
	gang.GUI.column[9] = guiGridListAddColumn(gang.GUI.gridlist[4],"Gracze",0.75)
    gang.GUI.button[8] = guiCreateButton(0.04,0.75,0.92,0.06,"Odśwież",true,gang.GUI.window[5])
	addEventHandler("onClientGUIClick",gang.GUI.button[8],
	function()
	    guiGridListClear(gang.GUI.gridlist[4])
		for i,v in pairs(getElementsByType("player")) do
		    local row = guiGridListAddRow(gang.GUI.gridlist[4])
			local r,g,b = getPlayerNametagColor(v)
			guiGridListSetItemText(gang.GUI.gridlist[4],row,gang.GUI.column[9],dbmanager:removeHEXFromString(tostring(getPlayerName(v))),false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[4],row,gang.GUI.column[9],r,g,b,255)
		end
	end,false)
    gang.GUI.button[9] = guiCreateButton(0.04,0.81,0.92,0.06,"Zaproś",true,gang.GUI.window[5])
	addEventHandler("onClientGUIClick",gang.GUI.button[9],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(gang.GUI.gridlist[4])
		local memberName = guiGridListGetItemText(gang.GUI.gridlist[4],selectedRow,selectedCol)
		if memberName and memberName ~= "" then
	        triggerServerEvent("Server:Gang-Panel:Invite",resourceRoot,memberName)
		end
	end,false)
    gang.GUI.button[10] = guiCreateButton(0.05,0.91,0.91,0.06,"Zamknij",true,gang.GUI.window[5])
	addEventHandler("onClientGUIClick",gang.GUI.button[10],
	function()
	    guiSetVisible(gang.GUI.window[5],false)
		hidePlayerCursor()
	end,false)
	guiSetVisible(gang.GUI.window[5],false)
	setElementData(localPlayer,"Gang","-")
	setTimer(function()
		triggerServerEvent("Server:loadPlayerGang",resourceRoot)
	end,2000,1)
end)

addEvent("Client:ChangePosition",true)
addEventHandler("Client:ChangePosition",localPlayer,
function(x,y,z,int,dim)
    --[[if getElementData(localPlayer,"pCommands") ~= false and isTargetClient() == true then
	    isCientInVeh()
		fadeCamera(false,0.4)
		setTimer(function()
            local theVehicle = getPedOccupiedVehicle(localPlayer)
	        if (theVehicle) then
	            triggerServerEvent("fixElementInterior",resourceRoot,theVehicle,0)
				triggerServerEvent("fixElementInterior",resourceRoot,localPlayer,0)
	        	setElementPosition(theVehicle,x,y,z)
	        else
	            triggerServerEvent("fixElementInterior",resourceRoot,localPlayer,0)
	        	setElementPosition(localPlayer,x,y,z)
	        end
			fadeCamera(true)
		end,500,1)
	end]]
	dbmanager:changePlayerPosition(localPlayer,x,y,z)
end)

addEvent("Client:Gang-Panel:Refresh",true)
addEventHandler("Client:Gang-Panel:Refresh",localPlayer,
function(gangMembers,theRank)
    guiGridListClear(gang.GUI.gridlist[3])
	for _,memberName in pairs(gangMembers) do
	    local row = guiGridListAddRow(gang.GUI.gridlist[3])
		guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[6],dbmanager:removeHEXFromString(tostring(memberName)),false,false)
		local theMember = getPlayerFromName(memberName)
		if theMember then
		    guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[7],"ONLINE",false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[3],row,gang.GUI.column[7],0,255,0,255)
		else
		    guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[7],"OFFLINE",false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[3],row,gang.GUI.column[7],255,0,0,255)
		end
		guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[8],tostring(theRank[memberName]),false,false)
	end
end)

addEvent("Client:Gang-Panel:Show",true)
addEventHandler("Client:Gang-Panel:Show",localPlayer,
function(gangMembers,theRank)
    guiGridListClear(gang.GUI.gridlist[3])
	for _,memberName in pairs(gangMembers) do
	    local row = guiGridListAddRow(gang.GUI.gridlist[3])
		guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[6],dbmanager:removeHEXFromString(tostring(memberName)),false,false)
		local theMember = getPlayerFromName(memberName)
		if theMember then
		    guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[7],"ONLINE",false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[3],row,gang.GUI.column[7],0,255,0,255)
		else
		    guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[7],"OFFLINE",false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[3],row,gang.GUI.column[7],255,0,0,255)
		end
		guiGridListSetItemText(gang.GUI.gridlist[3],row,gang.GUI.column[8],tostring(theRank[memberName]),false,false)
	end
	
	guiSetVisible(gang.GUI.window[4],true)
	showCursor(true)
end)

addEvent("Client:GangInfo",true)
addEventHandler("Client:GangInfo",localPlayer,
function(gangMembers,theRank)
    guiGridListClear(gang.GUI.gridlist[2])
	for _,memberName in pairs(gangMembers) do
	    local row = guiGridListAddRow(gang.GUI.gridlist[2])
		guiGridListSetItemText(gang.GUI.gridlist[2],row,gang.GUI.column[3],dbmanager:removeHEXFromString(tostring(memberName)),false,false)
		local theMember = getPlayerFromName(memberName)
		if theMember then
		    guiGridListSetItemText(gang.GUI.gridlist[2],row,gang.GUI.column[4],"ONLINE",false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[2],row,gang.GUI.column[4],0,255,0,255)
		else
		    guiGridListSetItemText(gang.GUI.gridlist[2],row,gang.GUI.column[4],"OFFLINE",false,false)
			guiGridListSetItemColor(gang.GUI.gridlist[2],row,gang.GUI.column[4],255,0,0,255)
		end
		guiGridListSetItemText(gang.GUI.gridlist[2],row,gang.GUI.column[5],tostring(theRank[memberName]),false,false)
	end
	
	guiSetText(gang.GUI.window[3],"LISTA CZŁONKÓW GANGU ("..#gangMembers..")")
	
	guiSetVisible(gang.GUI.window[3],true)
	showCursor(true)
end)

addEvent("Client:GangInvite",true)
addEventHandler("Client:GangInvite",localPlayer,
function(theGang,thePlayerName)
    gang.theGang = theGang
    gang.theInviterName = thePlayerName
	
	guiSetText(gang.GUI.label[1],"Otrzymałeś zaproszenie do gangu: ("..gang.theGang..").\nOd: ("..gang.theInviterName..")")
	
	guiSetVisible(gang.GUI.window[1],true)
	showCursor(true)
end)

addEvent("Client:ShowGangsList",true)
addEventHandler("Client:ShowGangsList",localPlayer,
function(gangsTable)
    guiGridListClear(gang.GUI.gridlist[1])
	local __gangsCount = 0
	for gangName,_ in pairs(gangsTable) do
	    local row = guiGridListAddRow(gang.GUI.gridlist[1])
		local __gColor = gangsTable[gangName]["color"]
		local countPlayers = #getClientAllGangPlayers(gangName,gangsTable)
		local __gLeader = dbmanager:removeHEXFromString(gangsTable[gangName]["leader"])
		guiGridListSetItemText(gang.GUI.gridlist[1],row,gang.GUI.column[1],"["..tostring(gangName).."]",false,false)
		guiGridListSetItemColor(gang.GUI.gridlist[1],row,gang.GUI.column[1],__gColor[1],__gColor[2],__gColor[3],255)
		guiGridListSetItemText(gang.GUI.gridlist[1],row,gang.GUI.column[2],tostring(countPlayers),false,false)
		guiGridListSetItemText(gang.GUI.gridlist[1],row,gang.GUI.column[11],tostring(__gLeader),false,false)
		__gangsCount = __gangsCount+1
	end
	guiSetText(gang.GUI.window[2],"LISTA GANGÓW ("..__gangsCount..")")
	guiSetVisible(gang.GUI.window[2],true)
	showCursor(true)
end)

function getClientAllGangPlayers(clientGangName,clientGangTable)
    local __clientGangPlayers = {}
	if __clientGangPlayers then
	    if clientGangTable[clientGangName]["members"] then
			for i,v in pairs(clientGangTable[clientGangName]["members"]) do
	   	 		table.insert(__clientGangPlayers,v)
			end
		end
		if clientGangTable[clientGangName]["sub_leaders"] then
			for i,v in pairs(clientGangTable[clientGangName]["sub_leaders"]) do
	    		table.insert(__clientGangPlayers,v)
			end
		end
		table.insert(__clientGangPlayers,clientGangTable[clientGangName]["leader"])
	end
	return __clientGangPlayers
end