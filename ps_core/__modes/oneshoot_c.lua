oneshoot = {}
oneshoot.GUI = {
    gridlist = {},
    window = {},
    button = {},
	column = {},
}
oneshoot.weapons = {
    "Deagle",
	"Shotgun",
	"Rifle",
	"Sniper",
}

addEvent("Client:OneShootWeapon",true)
addEventHandler("Client:OneShootWeapon",localPlayer,
function()
    guiSetVisible(oneshoot.GUI.window[1],true)
	showCursor(true)
end)

addEventHandler("onClientResourceStart", resourceRoot,
function()
    oneshoot.GUI.window[1] = guiCreateWindow(610,290,181,253,"WYBIERZ BROŃ",false)
	centerWindow(oneshoot.GUI.window[1])
    guiWindowSetSizable(oneshoot.GUI.window[1],false)
    oneshoot.GUI.gridlist[1] = guiCreateGridList(0.06,0.10,0.87,0.65,true,oneshoot.GUI.window[1])
	guiSetFont(oneshoot.GUI.gridlist[1],"default-bold-small")
	oneshoot.GUI.column[1] = guiGridListAddColumn(oneshoot.GUI.gridlist[1],"Bronie",0.7)
	for i,v in pairs(oneshoot.weapons) do
	    local row = guiGridListAddRow(oneshoot.GUI.gridlist[1])
		--guiGridListSetItemText(oneshoot.GUI.gridlist[1],row,oneshoot.GUI.column[1],string.upper(tostring(v)),false,false)
		guiGridListSetItemText(oneshoot.GUI.gridlist[1],row,oneshoot.GUI.column[1],tostring(v),false,false)
	end
    oneshoot.GUI.button[1] = guiCreateButton(0.07,0.79,0.87,0.08,"OK",true,oneshoot.GUI.window[1])
    guiSetProperty(oneshoot.GUI.button[1],"NormalTextColour","FFAAAAAA")
	guiSetFont(oneshoot.GUI.button[1],"default-bold-small")
    addEventHandler("onClientGUIClick",oneshoot.GUI.button[1],
    function()
        local selectedRow,selectedCol = guiGridListGetSelectedItem(oneshoot.GUI.gridlist[1])
	    local weaponName = guiGridListGetItemText(oneshoot.GUI.gridlist[1],selectedRow,selectedCol)
		if weaponName == "" then return end
		triggerServerEvent("Server:OneShootJoin",resourceRoot,getWeaponIDFromName(string.lower(weaponName)))
	    guiSetVisible(oneshoot.GUI.window[1],false)
		hidePlayerCursor()
    end,false)
    oneshoot.GUI.button[2] = guiCreateButton(0.07,0.88,0.87,0.08,"Anuluj",true,oneshoot.GUI.window[1])
    guiSetProperty(oneshoot.GUI.button[2],"NormalTextColour","FFAAAAAA")
	guiSetFont(oneshoot.GUI.button[2],"default-bold-small")
    addEventHandler("onClientGUIClick",oneshoot.GUI.button[2],
    function()
	    guiSetVisible(oneshoot.GUI.window[1],false)
		hidePlayerCursor()
    end,false)
	guiSetVisible(oneshoot.GUI.window[1],false)
end)

bindKey("enter","down",
function()
	local playerTeam = getPlayerTeam(localPlayer)
	if playerTeam and getTeamName(playerTeam) == "OneShoot" then
		triggerServerEvent("Server:OneShootExit",resourceRoot)
	end
end)