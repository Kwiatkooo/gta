local __hud = {}

local drawX,drawY = guiGetScreenSize()
local screenW, screenH = guiGetScreenSize()

__hud.scale = 0.6*drawX/1366
__hud.scale2 = 1.6*drawX/1366

__hud.GUI = {
	image = {}
}

addEventHandler("onClientResourceStart",resourceRoot,
function()
	--__hud.GUI.image[1] = guiCreateStaticImage(0.0,0.0,1279.0,767.0,"__images/hud.png",true)
	--guiSetAlpha(__hud.GUI.image[1],0.93)
    guiSetEnabled(__hud.GUI.image[1],false)
end)

addEventHandler("onClientRender",root,
function()

	dxDrawImage(-14, 663, 1280, 22, "__images/radar2.png", 0, 0, 0, tocolor(16, 87, 174, 200), false)
    dxDrawImage(-13, 688, 1279, 22, "__images/radar.png", 0, 0, 0, tocolor(16, 87, 174, 200), false)

	dxDrawText("Exp               Level               Zabić               Śmierci              Czas Gry", (screenW * 0.6219) + 1, (screenH * 0.9181) + 1, (screenW * 0.9641) + 1, (screenH * 0.9375) + 1, tocolor(0, 0, 0, 242), 1.00, "sans", "center", "center", false, false, false, false, false)
    dxDrawText("Exp               Level               Zabić               Śmierci              Czas Gry", screenW * 0.6219, screenH * 0.9181, screenW * 0.9641, screenH * 0.9375, tocolor(255, 255, 255, 200), 1.00, "sans", "center", "center", false, false, false, false, false)	
	
	
	if guiGetVisible(logowanie.GUI.image[1]) == true then return guiSetVisible(__hud.GUI.image[1],false) end
	--if isPedDead(localPlayer) then return guiSetVisible(__hud.GUI.image[1],false) end
	--if isTargetClient() ~= true then return guiSetVisible(__hud.GUI.image[1],false) end
	--guiSetVisible(__hud.GUI.image[1],true)
	local plr = {}
	plr.play = getPlayerPlayTime()
	plr.k = getElementData(localPlayer,"Kills")
	plr.d = getElementData(localPlayer,"Deaths")
	plr.exp = getElementData(localPlayer,".EXP")
	plr.lv = getElementData(localPlayer,".LVL")
	plr.l = getPlayerName(localPlayer)		
	
	local color_1 = "#00ffff"
	local color_2 = "#ffffff"
	
	dxDrawText(string.lower(""..plr.l..""), 558, 675, 708, 693, tocolor(255, 255, 255, 255), 1.50, "sans", "center", "center", false, false, false, false, false)
	dxDrawText(string.lower(""..plr.d..""), 1075, 678, 1115, 693, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
	dxDrawText(string.lower(""..plr.k..""), 975, 678, 1015, 693, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
	dxDrawText(string.lower(""..plr.play..""), 1173, 678, 1240, 693, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
	dxDrawText(string.lower(""..plr.exp..""), 880, 678, 920, 693, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
	dxDrawText(string.lower(""..plr.lv..""), 790, 678, 830, 693, tocolor(255, 255, 255, 255), 1.00, "sans", "center", "center", false, false, false, false, false)
		
	--dxDrawText(string.lower(""..color_1..""..plr.l.." "..color_1.."| Kills: "..color_2..""..plr.k.." "..color_1.."| Deaths: "..color_2..""..plr.d.." "..color_1.."| Czas gry: "..color_2..""..plr.play..""),drawX*0.5,drawY*0.985,drawX*0.5,drawY*0.985,tocolor(255,255,255,255),__hud.scale,"bankgothic","center","center",false,false,true,true,false,0,0,0)
	local playerTeam = getPlayerTeam(localPlayer)
	if playerTeam then
		if getTeamName(playerTeam) == "OneShoot" then
			dxDrawText("ABY WYJSC Z ONESHOOT NACISNIJ KLAWISZ 'ENTER'",drawX*0.5,drawY*0.94,drawX*0.5,drawY*0.94,tocolor(255,0,0,222),__hud.scale,"bankgothic","center","center",false,false,false,false,false,0,0,0)
		end
	end
end)

local table = {
	"►►► Nie wiesz od czego zacząć? Wpisz /pomoc lub nacisnij klawisz 'F9'",
	"►►► Masz jakąś propozycję dotyczącą serwera? Napisz na naszym forum: WWW.MTAPSD.XUP.PL",
	"►►► Któryś z graczy łamie regulamin? Zgłoś to na forum: WWW.MTAPSD.XUP.PL",
	"►►► Lista 100 najlepszych graczy znajduje się pod komendą /top100",
	"►►► Lubisz wyścigi i chcesz zarobić trochę kasy? Zapraszamy na /race",
	"►►► Chcesz sprawdzić statystyki któregoś z graczy lub swoje? Wpisz /stats <id gracza> (bez <>)",
	"►►► Popularne teleporty: /lv, /bank, /stuntpark",
	"►►► Popularne minigry: /hay, /mc, /race, /oneshoot",
	"►►► Chcesz stworzyć gang? Wpisz /gang-create <nazwa gangu> (najpierw musisz osiągnąć Level 10 lub wyższy).",
	"►►► Chcesz kupić prywatny pojazd? Wpisz /privcar lub nacisnij klawisz 'F3' (najpierw musisz osiągnąć Level 15 lub wyższy).",
	"►►► Chcesz szybko zdobyć pieniądze? Napadnij na /bank (najpierw musisz osiągnąć Level 10 lub wyższy).",
	"►►► Lista wszystkich biznesów znajduje się pod komendą /biznesy",
	"►►► Lista komend i teleportów znajduje się pod klawiszem 'F9' lub komendą /pomoc",
	"►►► Chcesz stworzyć pojazd? Nacisnij klawisz 'F1' lub wpisz komendę /v <nazwa pojazdu> (najpierw musisz osiągnąć Level 1 lub wyższy).",
	"►►► Zaproś gracza na pojedynek! Wpisz /solo <id gracza> następnie wybierz broń i kliknij OK.",
	"►►► Zmień kolor przednijch świateł swojego pojazdu za pomocą komendy /vskolor <r> <g> <b> (Przykład: /vskolor 255 0 0 - zmienia kolor świateł na czerwony).",
	"►►► Twój pojazd jest wolny? Dodaj nitro do swojeo pojazdu za pomocą komendy /nitro (Koszt 5000$).",
	"►►► Znudził Ci się wygląd twojego pojazdu? Odpicuj go w garażu na /tunelv, /tunels lub /tunesf",
	"►►► Chesz kupić pancerz lub dodatkową broń? Zapraszamy do sklepu (Ammu-Nation)(Sklep oznaczony jest bronią na minimapie).",
	"►►► Masz przy sobie dużo pieniędzy? Koniecznie wpłać je do banku (Banki oznaczone są dyskietką na minimapie).",
	"►►► Znudziła Ci się pogoda? Zmień ją za pomocą komendy /pogoda <id> (Przykład: /pogoda 4).",
	"►►► Chcesz mieć kamizelkę przy każdym spawnie? Wpisz komendę /spawnkamizelka (Koszt 125000$).",
	"►►► Chcesz zdobyć dodatkową kasę i exp? Odszukaj 100 ukrytych paczek porozmieszczanych w całym Las Venturas(również na terenach pustynnych).",
	"►►► Twój pojazd jest uszkodzony? Napraw go za pomocą komendy /napraw (Koszt 5000$)",
	"►►► Masz mało życia/hp? Uzupełnij je za pomocą komendy /100hp (Koszt 6500$) lub w sklepie z bronią (Ammu-Nation).",
	"►►► Pełny pasek życia/hp Ci nie wystarcza? Kup pancerz za pomocą komendy /kamizelka lub w sklepie z bronią (Ammu-Nation).",
	"►►► Chcesz szybko odpicować swój pojazd? Wpisz /tune (Koszt 5000$)",
}

setTimer(function()
	local random = math.random(1,#table)
	outputChatBox(tostring(table[random]),0,255,255,true)
end,60000*2,0)