local lang = {}
lang.localization = getLocalization()
if lang.localization["name"] == "Polish" then lang.selected = "pl_PL" else lang.selected = "en_US" end
lang.translations = {
	["PANEL LOGOWANIA"] = {"LOGIN PANEL"},
	["LOGIN:"] = {"USERNAME:"},
	["HASŁO:"] = {"PASSWORD:"},
	["Zaloguj lub\nZarejestruj"] = {"Login or\nRegister"},
	["Graj jako Gość"] = {"Play as Guest"},
	["Witaj!\n\nZarejestruj/Zaloguj Się!\n\nWiększość funkcji serwera\ndostępna jest dopiero \npo zalogowaniu."] = {"Witaj!\n\nZarejestruj/Zaloguj Się!\n\nWiększość funkcji serwera\ndostępna jest dopiero \npo zalogowaniu."},
}
function _t(text)
	if lang.selected == "pl_PL" then return text end
	if lang.selected == "en_US" then return lang.translations[text][1] end
end

logowanie = {}
logowanie.GUI = {
    staticimage = {},
    button = {},
    window = {},
    edit = {},
    label = {},
	image = {},
}

local lastLogin = getTickCount() - 5000
addEventHandler("onClientResourceStart",resourceRoot,
function()
    logowanie.GUI.image[1] = guiCreateStaticImage(0.0,0.0,1279.0,767.0,"__images/login.png",true)
	guiSetEnabled(logowanie.GUI.image[1],false)
    logowanie.GUI.window[1] = guiCreateWindow(519,203,310,284,_t("PANEL LOGOWANIA"),false)
	centerWindow(logowanie.GUI.window[1])
	guiSetAlpha(logowanie.GUI.window[1],0.7)
    guiWindowSetSizable(logowanie.GUI.window[1],false)
    logowanie.GUI.staticimage[1] = guiCreateStaticImage(0.03,0.09,0.34,0.39,"__images/lock.png",true,logowanie.GUI.window[1])
    logowanie.GUI.label[1] = guiCreateLabel(0.04,0.53,0.23,0.11,_t("LOGIN:"),true,logowanie.GUI.window[1])
    guiSetFont(logowanie.GUI.label[1],"default-bold-small")
    guiLabelSetVerticalAlign(logowanie.GUI.label[1],"center")
    logowanie.GUI.label[2] = guiCreateLabel(0.04,0.64,0.23,0.12,_t("HASŁO:"),true,logowanie.GUI.window[1])
    guiSetFont(logowanie.GUI.label[2],"default-bold-small")
    guiLabelSetVerticalAlign(logowanie.GUI.label[2],"center")
    logowanie.GUI.edit[1] = guiCreateEdit(0.28,0.54,0.66,0.11,removeHEXFromString(tostring(getPlayerName(localPlayer))),true,logowanie.GUI.window[1])
    logowanie.GUI.staticimage[2] = guiCreateStaticImage(0.85,0.13,0.13,0.87,"__images/user.png",true,logowanie.GUI.edit[1])
    guiSetAlpha(logowanie.GUI.staticimage[2],0.70)
    logowanie.GUI.edit[2] = guiCreateEdit(0.28,0.65,0.66,0.11,"",true,logowanie.GUI.window[1])
    logowanie.GUI.staticimage[3] = guiCreateStaticImage(0.84,0.07,0.14,0.93,"__images/lock.png",true,logowanie.GUI.edit[2])
    guiSetAlpha(logowanie.GUI.staticimage[3],0.70)
    logowanie.GUI.button[1] = guiCreateButton(0.03,0.81,0.46,0.15,"",true,logowanie.GUI.window[1])
    guiSetProperty(logowanie.GUI.button[1],"NormalTextColour","FFAAAAAA")
    logowanie.GUI.staticimage[4] = guiCreateStaticImage(0.03,0.02,0.25,0.98,"__images/ok.png",true,logowanie.GUI.button[1])
    logowanie.GUI.label[3] = guiCreateLabel(0.34,0.00,0.66,0.95,_t("Zaloguj lub\nZarejestruj"),true,logowanie.GUI.button[1])
    guiSetFont(logowanie.GUI.label[3],"default-bold-small")
    guiLabelSetHorizontalAlign(logowanie.GUI.label[3],"center",false)
    guiLabelSetVerticalAlign(logowanie.GUI.label[3],"center")
    logowanie.GUI.button[2] = guiCreateButton(0.51,0.81,0.46,0.15,"",true,logowanie.GUI.window[1])
    guiSetProperty(logowanie.GUI.button[2],"NormalTextColour","FFAAAAAA")
    logowanie.GUI.staticimage[5] = guiCreateStaticImage(0.00,0.00,0.27,1.00,"__images/cancel.png",true,logowanie.GUI.button[2])
    logowanie.GUI.label[4] = guiCreateLabel(0.32,0.00,0.68,0.95,_t("Graj jako Gość"),true,logowanie.GUI.button[2])
    guiSetFont(logowanie.GUI.label[4],"default-bold-small")
    guiLabelSetHorizontalAlign(logowanie.GUI.label[4],"center",false)
    guiLabelSetVerticalAlign(logowanie.GUI.label[4],"center")
    logowanie.GUI.label[5] = guiCreateLabel(0.40,0.09,0.54,0.39,_t("Witaj!\n\nZarejestruj/Zaloguj Się!\n\nWiększość funkcji serwera\ndostępna jest dopiero \npo zalogowaniu."),true,logowanie.GUI.window[1])
    guiSetFont(logowanie.GUI.label[5],"default-bold-small")    
	guiEditSetMaxLength(logowanie.GUI.edit[1],22)
	guiEditSetMaxLength(logowanie.GUI.edit[2],10)
	guiEditSetMasked(logowanie.GUI.edit[2],true)
	guiSetEnabled(logowanie.GUI.label[3],false)
	guiSetEnabled(logowanie.GUI.label[4],false)
	guiSetEnabled(logowanie.GUI.staticimage[5],false)
	guiSetEnabled(logowanie.GUI.label[5],false)
	guiSetEnabled(logowanie.GUI.label[3],false)
	guiSetEnabled(logowanie.GUI.staticimage[4],false)
	guiSetEnabled(logowanie.GUI.staticimage[3],false)
	guiSetEnabled(logowanie.GUI.staticimage[2],false)
	guiSetEnabled(logowanie.GUI.staticimage[1],false)
	guiSetEnabled(logowanie.GUI.button[2],false)
	addEventHandler("onClientGUIClick",logowanie.GUI.button[1],
	function()
		if getTickCount() - lastLogin < 5000 then createInfoBoxClient(20,"(drawY/5.0)*2","● Musisz odczekać "..math.floor((6000-(getTickCount()-lastLogin))/1000).."s. od ostatniej próby logowania.",8000) return end
        local userLogin = guiGetText(logowanie.GUI.edit[1])
        local userPassword = guiGetText(logowanie.GUI.edit[2])
	    if userLogin ~= '' and userPassword ~= '' then
			lastLogin = getTickCount()
			if string.len(userLogin) < 1 then return createInfoBoxClient(20,"(drawY/5.0)*2","● [Login] musi zawierać przynajniej jeden znak.",8000) end
			if string.len(userLogin) > 22 then return createInfoBoxClient(20,"(drawY/5.0)*2","● [Login] może skłądać się maksymalnie z 22 znaków.",8000) end
			if string.len(userPassword) < 5 then return createInfoBoxClient(20,"(drawY/5.0)*2","● [Hasło] musi zawierać przynajniej 5 znaków.",8000) end
			if string.len(userPassword) > 10 then return createInfoBoxClient(20,"(drawY/5.0)*2","● [Hasło] może skłądać się maksymalnie z 10 znaków.",8000) end
            triggerServerEvent("clientLoginRegister",resourceRoot,userLogin,userPassword)
		else
		    createInfoBoxClient(20,"(drawY/5.0)*2","● Wprowadź [Login] i [Hasło].",8000)
	    end
	end,false)
	addEventHandler("onClientGUIClick",logowanie.GUI.button[2],
	function()
	    cPoZalogowaniu()
	end,false)
    guiSetVisible(logowanie.GUI.window[1],false)
	guiSetVisible(logowanie.GUI.image[1],false)
end)

addEvent("Client:HideLoginPanel",true)
addEventHandler("Client:HideLoginPanel",localPlayer,
function()
	cPoZalogowaniu()
	local confirm_sound = playSound("__sounds/click_confirm.ogg")
	setSoundVolume(confirm_sound,0.3)
end)

addEvent("Client:GuestButton",true)
addEventHandler("Client:GuestButton",localPlayer,
function()
	guiSetEnabled(logowanie.GUI.button[2],true)
end)

function cPoZalogowaniu()
    guiSetVisible(logowanie.GUI.window[1],false)
	guiSetVisible(logowanie.GUI.image[1],false)
    fadeCamera(false,0.7)
	setTimer(startSkinSelection,1500,1)
end

local vip_info = {
    button = {},
    window = {},
    memo = {}
}
addEventHandler("onClientResourceStart",resourceRoot,
function()
    vip_info.window[1] = guiCreateWindow(463,215,436,335,"VIP INFO",false)
	centerWindow(vip_info.window[1])
	guiSetAlpha(vip_info.window[1],0.7)
    guiWindowSetSizable(vip_info.window[1],false)
    vip_info.memo[1] = guiCreateMemo(0.02,0.08,0.999,0.79,"Ile kosztuje VIP?\n- 4.92 PLN z VAT (konto VIP otrzymujesz na zawsze).\n\nCo zyskujesz kupując konto VIP?\n- Dostęp do panelu VIP w ktorym znajdziesz wiele funkcji.\nJeśli chcesz zobaczyc jak wyglada panel VIP wpisz /vippaneldemo.\n- Tańsze komendy.\n- Możliwość zmiany nicka.\n- Możliwość zmiany koloru nicka.\n- Dodatkowe 5 000$ na spawn.\n- Dodatkowe 2 500$ za zabicie gracza.\n- Bonus 2 500 000$ za kupno VIP.\n- Z czasem pojawią się inne opcje dostępne tylko dla VIPów.\n\nJak kupić VIP?\n1.Wyślij SMS o treści TC.JTDK.3826 na numer 74068 (Cena 4.92 PLN z VAT)\n[Usługa dostępna w sieciach T-mobile, Plus GSM, Orange, Play].\n2.Poinformuj Administrator [Luk4s7_] że SMS został wysłany.\n3.Po zweryfikowaniu że SMS został wysłany, Administrator przydzieli ci konto VIP.\n\nUWAGA! Przed kupnem VIP należy poinformować Admnistratora [Luk4s7_], w przeciwnym razie ranga nie zostanie przydzielona!",true,vip_info.window[1])
    vip_info.button[1] = guiCreateButton(0.68,0.90,0.30, 0.07,"Zamknij",true,vip_info.window[1])
	guiSetFont(vip_info.memo[1],"default-bold-small")
	guiSetFont(vip_info.button[1],"default-bold-small")
	guiMemoSetReadOnly(vip_info.memo[1],true)
	addEventHandler("onClientGUIClick",vip_info.button[1],
	function()
	    guiSetVisible(vip_info.window[1],false)
		hidePlayerCursor()
	end,false)
    guiSetVisible(vip_info.window[1],false)
end)

addCommandHandler("vipinfo",
function(p,_)
    guiSetVisible(vip_info.window[1],true)
	guiBringToFront(vip_info.window[1])
	showCursor(true)
end)

local vip_panel = {}
vip_panel.GUI = {
    gridlist = {},
    window = {},
    button = {},
    edit = {},
	column = {},
}
vip_panel.opcje = {"Uzupełnij życie","Uzupełnij kamizelkę","Nieskończona amunicja","VIP bronie","Napraw pojazd","Dodaj Nitro","Automatyczny Tuning","Jetpack"}
vip_panel.limit = 999
vip_panel.limits = {
    ["Uzupełnij życie"] = 0,
	["Uzupełnij kamizelkę"] = 0,
	["Nieskończona amunicja"] = 0,
	["VIP bronie"] = 0,
	["Napraw pojazd"] = 0,
	["Dodaj Nitro"] = 0,
	["Automatyczny Tuning"] = 0,
	["Jetpack"] = 0,
}

--[[setTimer(function()
	local row = 0
	for i,v in pairs(vip_panel.opcje) do
	    vip_panel.limits[v] = 0
	    row = row+1
	    guiGridListSetItemText(vip_panel.GUI.gridlist[1],row,vip_panel.GUI.column[2],"".. vip_panel.limits[v].."/"..vip_panel.limit,false,false)
	end
end,5*60000,0)]]

addEventHandler("onClientResourceStart",resourceRoot,
function()
    vip_panel.GUI.window[1] = guiCreateWindow(521,228,309,314,"VIP PANEL BETA",false)
	centerWindow(vip_panel.GUI.window[1])
    guiWindowSetSizable(vip_panel.GUI.window[1],false)
    vip_panel.GUI.edit[1] = guiCreateEdit(0.49,0.09,0.46,0.08,tostring(getPlayerName(localPlayer)),true,vip_panel.GUI.window[1])
    vip_panel.GUI.button[1] = guiCreateButton(0.03,0.09,0.44,0.08,"Zmień nick",true,vip_panel.GUI.window[1])
	addEventHandler("onClientGUIClick",vip_panel.GUI.button[1],
	function()
	    local new_nick = guiGetText(vip_panel.GUI.edit[1])
		local wybrana_opcja = "Zmień nick"
		if new_nick then triggerServerEvent("Server:VIP-Panel",resourceRoot,wybrana_opcja,new_nick) end
		guiSetEnabled(vip_panel.GUI.button[1],false)
		setTimer(guiSetEnabled,4500,1,vip_panel.GUI.button[1],true)
	end,false)
    vip_panel.GUI.button[2] = guiCreateButton(0.03,0.90,0.94,0.07,"Zamknij",true,vip_panel.GUI.window[1])
	addEventHandler("onClientGUIClick",vip_panel.GUI.button[2],
	function()
	    guiSetVisible(vip_panel.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
    vip_panel.GUI.gridlist[1] = guiCreateGridList(0.03,0.20,0.94,0.67,true,vip_panel.GUI.window[1])
	vip_panel.GUI.column[1] = guiGridListAddColumn(vip_panel.GUI.gridlist[1],"Lista opcji",0.7)
	vip_panel.GUI.column[2] = guiGridListAddColumn(vip_panel.GUI.gridlist[1],"Limit",0.2)
	for i,v in pairs(vip_panel.opcje) do
	    local row = guiGridListAddRow(vip_panel.GUI.gridlist[1])
		guiGridListSetItemText(vip_panel.GUI.gridlist[1],row,vip_panel.GUI.column[1],tostring(v),false,false)
		guiGridListSetItemText(vip_panel.GUI.gridlist[1],row,vip_panel.GUI.column[2],"0/"..vip_panel.limit,false,false)
	end
	addEventHandler("onClientGUIDoubleClick",vip_panel.GUI.gridlist[1],
	function()
	    local selectedRow,selectedCol = guiGridListGetSelectedItem(vip_panel.GUI.gridlist[1])
	    local wybrana_opcja = guiGridListGetItemText(vip_panel.GUI.gridlist[1],guiGridListGetSelectedItem(vip_panel.GUI.gridlist[1]),1)
		if wybrana_opcja == "" then return end
		if wybrana_opcja then
		    if vip_panel.limits[wybrana_opcja] == vip_panel.limit then return createInfoBoxClient(20,"(drawY/5.0)*2","● Wyczerpałeś(aś) już limit na opcje ["..wybrana_opcja.."].Limit resetuje się co 5 minut.",10000) end
			vip_panel.limits[wybrana_opcja] = vip_panel.limits[wybrana_opcja]+1
			guiGridListSetItemText(vip_panel.GUI.gridlist[1],selectedRow,vip_panel.GUI.column[2],""..vip_panel.limits[wybrana_opcja].."/"..vip_panel.limit,false,false)
		    guiSetEnabled(vip_panel.GUI.gridlist[1],false)
			setTimer(guiSetEnabled,500,1,vip_panel.GUI.gridlist[1],true)
		    triggerServerEvent("Server:VIP-Panel",resourceRoot,wybrana_opcja)
		end
	end,false)
	guiSetVisible(vip_panel.GUI.window[1],false)
end)

addEvent("Client:VIP-Panel",true)
addEventHandler("Client:VIP-Panel",localPlayer,
function()
    guiSetVisible(vip_panel.GUI.window[1],true)
	showCursor(true)
	guiSetEnabled(vip_panel.GUI.gridlist[1],true)
	guiSetEnabled(vip_panel.GUI.button[1],true)
	guiSetEnabled(vip_panel.GUI.edit[1],true)
	guiSetText(vip_panel.GUI.edit[1],tostring(getPlayerName(localPlayer)))
end)

addCommandHandler("vippaneldemo",
function(_)
    guiSetVisible(vip_panel.GUI.window[1],true)
	showCursor(true)
	guiSetEnabled(vip_panel.GUI.gridlist[1],false)
	guiSetEnabled(vip_panel.GUI.button[1],false)
	guiSetEnabled(vip_panel.GUI.edit[1],false)
	createInfoBoxClient(20,"(drawY/5.0)*2",_t("● Jest to demo panelu VIP i opcje są zablokowane."),10000)
end)

vip_aktywacja = {}
vip_aktywacja.GUI = {
    button = {},
    window = {},
    label = {},
    edit = {}
}

addEventHandler("onClientResourceStart",resourceRoot,
function()
    vip_aktywacja.GUI.window[1] = guiCreateWindow(572,300,207,130,"AKTYWACJA VIP",false)
	centerWindow(vip_aktywacja.GUI.window[1])
    guiWindowSetSizable(vip_aktywacja.GUI.window[1],false)
    vip_aktywacja.GUI.edit[1] = guiCreateEdit(0.06,0.55,0.875,0.21,"",true,vip_aktywacja.GUI.window[1])
    vip_aktywacja.GUI.button[1] = guiCreateButton(0.06,0.78,0.43,0.15,"OK",true,vip_aktywacja.GUI.window[1])
	addEventHandler("onClientGUIClick",vip_aktywacja.GUI.button[1],
	function()
	    local kod = guiGetText(vip_aktywacja.GUI.edit[1])
		if kod == "" then return end
		triggerServerEvent("Server:VerifyCode",resourceRoot,kod)
		guiSetVisible(vip_aktywacja.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
    vip_aktywacja.GUI.button[2] = guiCreateButton(0.50,0.78,0.43,0.15,"Anuluj",true,vip_aktywacja.GUI.window[1])
	addEventHandler("onClientGUIClick",vip_aktywacja.GUI.button[2],
	function()
		guiSetVisible(vip_aktywacja.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
    vip_aktywacja.GUI.label[1] = guiCreateLabel(0.05,0.15,0.87,0.32,"Wpisz otrzymany 'KOD'.\nNastępnie kliknij 'OK'.",true,vip_aktywacja.GUI.window[1])
    guiSetFont(vip_aktywacja.GUI.label[1],"default-bold-small")
    guiLabelSetHorizontalAlign(vip_aktywacja.GUI.label[1],"center",false)
    guiLabelSetVerticalAlign(vip_aktywacja.GUI.label[1],"center")
	guiSetVisible(vip_aktywacja.GUI.window[1],false)
end)

addEvent("Client:ShowSMSGUI",true)
addEventHandler("Client:ShowSMSGUI",localPlayer,
function()
    guiSetVisible(vip_aktywacja.GUI.window[1],true)
	showCursor(true)
	guiSetText(vip_aktywacja.GUI.edit[1],"")
end)

top_players = {}
top_players.GUI = {
    gridlist = {},
    window = {},
    button = {},
	column = {},
}

addEventHandler("onClientResourceStart",resourceRoot,
function()
    top_players.GUI.window[1] = guiCreateWindow(0.16,0.13,0.67,0.74,"TOP-100 Graczy",true)
	guiSetAlpha(top_players.GUI.window[1],0.7)
	centerWindow(top_players.GUI.window[1])
    guiWindowSetSizable(top_players.GUI.window[1],false)
    top_players.GUI.gridlist[1] = guiCreateGridList(0.01,0.05,0.98,0.86,true,top_players.GUI.window[1])
	guiGridListSetSortingEnabled(top_players.GUI.gridlist[1],false)
    top_players.GUI.button[1] = guiCreateButton(0.01,0.93,0.98,0.05,"Zamknij",true,top_players.GUI.window[1])
	addEventHandler("onClientGUIClick",top_players.GUI.button[1],
	function()
	    guiSetVisible(top_players.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
	top_players.GUI.column[1] = guiGridListAddColumn(top_players.GUI.gridlist[1],"-",0.05)
	top_players.GUI.column[2] = guiGridListAddColumn(top_players.GUI.gridlist[1],"NICK",0.3)
	top_players.GUI.column[7] = guiGridListAddColumn(top_players.GUI.gridlist[1],"EXP/LEVEL",0.15)
	top_players.GUI.column[3] = guiGridListAddColumn(top_players.GUI.gridlist[1],"KILLS",0.15)
	top_players.GUI.column[4] = guiGridListAddColumn(top_players.GUI.gridlist[1],"DEATHS",0.15)
	top_players.GUI.column[5] = guiGridListAddColumn(top_players.GUI.gridlist[1],"BANK",0.2)
	top_players.GUI.column[6] = guiGridListAddColumn(top_players.GUI.gridlist[1],"RATIO",0.15)
	guiSetFont(top_players.GUI.gridlist[1],"default-bold-small")
	guiSetFont(top_players.GUI.button[1],"default-bold-small")
	guiSetVisible(top_players.GUI.window[1],false)
end)

local function round(num,idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5)/mult
end

addEvent("Client:TopPlayers",true)
addEventHandler("Client:TopPlayers",localPlayer,
function(top100)
    guiGridListClear(top_players.GUI.gridlist[1])
    for i,v in pairs(top100) do
	    local row = guiGridListAddRow(top_players.GUI.gridlist[1])
		local login = v.login
		local kills = v.kills
		local deaths = v.deaths
		local bank = v.bank
		local ratio
		if deaths > 0 then ratio = string.format("%.2f",kills/deaths) else ratio = kills..".0" end
		local exp = v.exp or 0
		local lvl = v.lvl or 0
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[1],i,false,false)
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[2],removeHEXFromString(login),false,false)
		guiGridListSetItemColor(top_players.GUI.gridlist[1],row,top_players.GUI.column[2],math.random(50,255),math.random(50,255),math.random(50,255),255)
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[3],kills,false,false)
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[4],deaths,false,false)
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[5],bank.."$",false,false)
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[6],tonumber(ratio),false,false)
		guiGridListSetItemText(top_players.GUI.gridlist[1],row,top_players.GUI.column[7],exp.."/"..lvl,false,false)
	end
	guiSetVisible(top_players.GUI.window[1],true)
	showCursor(true)
end)

player_stats = {}
player_stats.GUI = {
    button = {},
    window = {},
    label = {}
}

addEventHandler("onClientResourceStart",resourceRoot,
function()
    player_stats.GUI.window[1] = guiCreateWindow(561,253,244,246,"",false)
	centerWindow(player_stats.GUI.window[1])
    guiWindowSetSizable(player_stats.GUI.window[1],false)
    player_stats.GUI.button[1] = guiCreateButton(0.04,0.89, 0.92,0.07,"Zamknij",true,player_stats.GUI.window[1])
	addEventHandler("onClientGUIClick",player_stats.GUI.button[1],
	function()
	    guiSetVisible(player_stats.GUI.window[1],false)
		hidePlayerCursor()
	end,false)
    player_stats.GUI.label[1] = guiCreateLabel(0.04,0.14,0.27,0.10,"Login:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[2] = guiCreateLabel(0.04,0.24,0.27,0.10,"Zabójstw:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[3] = guiCreateLabel(0.04,0.33,0.27,0.10,"Śmierci:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[4] = guiCreateLabel(0.04,0.43,0.27,0.10,"Ratio:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[5] = guiCreateLabel(0.04,0.53,0.27,0.10,"Bank:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[6] = guiCreateLabel(0.04,0.63,0.27,0.10,"VIP:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[7] = guiCreateLabel(0.04,0.72,0.27,0.10,"Gang:",true,player_stats.GUI.window[1])
    player_stats.GUI.label[8] = guiCreateLabel(0.31,0.14,0.65,0.10,"",true,player_stats.GUI.window[1])
	player_stats.GUI.label[9] = guiCreateLabel(0.31,0.24,0.65,0.10,"",true,player_stats.GUI.window[1])
	player_stats.GUI.label[10] = guiCreateLabel(0.31,0.33,0.65,0.10,"",true,player_stats.GUI.window[1])
	player_stats.GUI.label[11] = guiCreateLabel(0.31,0.43,0.65,0.10,"",true,player_stats.GUI.window[1])
	player_stats.GUI.label[12] = guiCreateLabel(0.31,0.53,0.65,0.10,"",true,player_stats.GUI.window[1])
	player_stats.GUI.label[13] = guiCreateLabel(0.31,0.63,0.65,0.10,"",true,player_stats.GUI.window[1])
	player_stats.GUI.label[14] = guiCreateLabel(0.31,0.72,0.65,0.10,"",true,player_stats.GUI.window[1])
    guiSetFont(player_stats.GUI.label[8],"default-bold-small")
    guiSetFont(player_stats.GUI.label[9],"default-bold-small")
    guiSetFont(player_stats.GUI.label[10],"default-bold-small")
    guiSetFont(player_stats.GUI.label[11],"default-bold-small")
    guiSetFont(player_stats.GUI.label[12],"default-bold-small")
    guiSetFont(player_stats.GUI.label[13],"default-bold-small")
    guiSetFont(player_stats.GUI.label[14],"default-bold-small")
	guiSetVisible(player_stats.GUI.window[1],false)
end)

addEvent("Client:MyScore",true)
addEventHandler("Client:MyScore",localPlayer,
function(login,kills,deaths,bank,vip,ratio,gang)
	guiSetText(player_stats.GUI.window[1],"STATYSTYKI: "..removeHEXFromString(login))
    guiSetText(player_stats.GUI.label[8],removeHEXFromString(login))
	guiSetText(player_stats.GUI.label[9],kills)
	guiSetText(player_stats.GUI.label[10],deaths)
	guiSetText(player_stats.GUI.label[11],ratio)
	guiSetText(player_stats.GUI.label[12],bank.."$")
	guiSetText(player_stats.GUI.label[13],vip)
	guiSetText(player_stats.GUI.label[14],gang)
	guiSetVisible(player_stats.GUI.window[1],true)
	showCursor(true)
end)

addEvent("Client:onLevelUp",true)
addEventHandler("Client:onLevelUp",localPlayer,
function()
	playSound("__sounds/level_up.mp3")
end)


