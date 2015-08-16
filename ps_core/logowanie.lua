--[[
Obsluga baz danych, interfejs do bazy MySQL realizowany za pomoca wbudowanych w MTA funkcji db...
@author Lukasz Biegaj <wielebny@bestplay.pl>
@author WUBE <wube@lss-rp.pl>
@copyright 2011-2013 Lukasz Biegaj <wielebny@bestplay.pl>
@license Dual GPLv2/MIT
@package MTA-XyzzyRP
@link https://github.com/lpiob/MTA-XyzzyRP GitHub
]]--

local SQL

addEventHandler("onResourceStart",resourceRoot,
function()
	SQL = dbConnect("sqlite","__db/baza_danych.db")
	zapytanie("CREATE TABLE IF NOT EXISTS accounts(aID INT,aLogin TEXT,aPassword TEXT,aSerial TEXT,aMoney TEXT,aBank TEXT,aSkin TEXT,aKills TEXT,aDeaths TEXT,aVIP TEXT,aPacks TEXT,aEXP TEXT,aLVL TEXT)")
	updateTop100()
end)

function pobierzTabeleWynikow(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	return rows
end

function pobierzWyniki(...)
	local h=dbQuery(SQL,...)
	if (not h) then 
		return nil
	end
	local rows = dbPoll(h, -1)
	if not rows then return nil end
	return rows[1]
end

function zapytanie(...)
	local h=dbQuery(SQL,...)
	local result,numrows=dbPoll(h,-1)
	return numrows
end

--[[
function insertID()
	return mysql_insert_id(SQL)
end
function affectedRows()
	return mysql_affected_rows(SQL)
end
]]--

function fetchRows(query)
	local result=mysql_query(SQL,query)
	if (not result) then return nil end
	local tabela={}

	while true do
    	local row = mysql_fetch_row(result)
	    if (not row) then break end
	    table.insert(tabela,row)
	end
	mysql_free_result(result)
	return tabela
end









local kodowanie_hasel = true
__serverAccounts = {}
__isPlayerLogin = {}
__isPlayerVIP = {}

addEvent("Server:OnShowLoginPanel",true)
addEventHandler("Server:OnShowLoginPanel",resourceRoot,
function()
	local __playerName = getPlayerName(client)
	local data = pobierzWyniki("SELECT aID FROM accounts WHERE aLogin=? LIMIT 1;",__playerName)
	if data then
		--triggerClientEvent(client,"clientMsgBox",client,"● Nick "..__playerName.." jest już zarejestrowany.")
		exports.ps_mass:showBox("● Nick "..__playerName.." jest już zarejestrowany.", client, 20, 255, 20, 5000)
	else
		triggerClientEvent(client,"Client:GuestButton",client)
	end
end)

addEventHandler("onResourceStop",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
	    if __isPlayerLogin[v] then
            triggerEvent("__onPlayerLogout",root,v,__serverAccounts[v]["id"],__serverAccounts[v]["login"])
		end
	end
end)

addEvent("__onPlayerChangeLogin",true)
addEvent("__onPlayerLogout",true)
addEventHandler("__onPlayerLogout",root,
function(plr,accountID,accountName,isPlayerQuit)
	local player_skin = getElementModel(plr)
	local player_money = getPlayerMoney(plr)
	local player_kills = getElementData(plr,"Kills")
	local player_deaths = getElementData(plr,"Deaths")
	local player_packs = getPlayerUsedPacks(plr)
	local player_exp = getElementData(plr,".EXP")
	local player_lvl = getElementData(plr,".LVL")
	local player_bank = __bank.players[plr]
	zapytanie("UPDATE accounts SET aSkin=?,aMoney=?,aKills=?,aDeaths=?,aPacks=?,aEXP=?,aLVL=?,aBank=? WHERE aID=?",player_skin,player_money,player_kills,player_deaths,player_packs,player_exp,player_lvl,player_bank,accountID)
	setPlayerMoney(plr,0)
	pack_system.used[plr] = nil
    __isPlayerLogin[plr] = nil
	__serverAccounts[plr] = nil
	__bank.players[plr] = nil
	if isPlayerQuit == true then 
		removePlayerAllData(plr)
	else
		setElementDimension(plr,math.random(2321,6000))
		if respawnTimer[plr] and isTimer(respawnTimer[plr]) then killTimer(respawnTimer[plr]) end
		respawnTimer[plr] = nil
		if serverData.blips[plr] then
			destroyElement(serverData.blips[plr])
			serverData.blips[plr] = nil
		end
    	if serverData.customVeh[plr] then
			removeElementData(serverData.customVeh[plr],"vehOwner")
	   		destroyElement(serverData.customVeh[plr])
			serverData.customVeh[plr] = nil
		end
		triggerClientEvent(plr,"Client:ShowLoginPanel",plr)
		setElementData(plr,"pCommands",false)
		setElementData(plr,"Kills",0)
		setElementData(plr,"Deaths",0)
		setElementData(plr,"Gang","-")
		setElementData(plr,".EXP",0)
		setElementData(plr,".LVL",0)
		setPlayerMoney(plr,0)
	end
	updateTop100()
end)

function isPlayerLogin(plr)
	return __isPlayerLogin[plr]
end

function getAccIDByName(__accountName)
	local data = pobierzWyniki("SELECT aID FROM accounts WHERE aLogin=? LIMIT 1;",__accountName)
	if data then
		return data.aID
	else
		return nil
	end
end

function getAccNameByID(__accountID)
	local data = pobierzWyniki("SELECT aLogin FROM accounts WHERE aID=? LIMIT 1;",__accountID)
	if data then
		return data.aLogin
	else
		return nil
	end
end

function getAccName(plr)
    if not __isPlayerLogin[plr] then return nil end
	return __serverAccounts[plr]["login"]
end

function getAccID(plr)
    if not __isPlayerLogin[plr] then return nil end
	return __serverAccounts[plr]["id"]
end

function setAccData(id_konta,table,value)
	local succes = dbExec(SQL,"UPDATE accounts SET "..table.."=? WHERE aID=?",value,id_konta)
	if succes then return true else return false end
end

function createAcc(plr,login,password)
	local h = dbQuery(SQL,"SELECT * FROM accounts")
	local result,numrows = dbPoll(h,-1)
    local plrSerial = getPlayerSerial(plr)
	local plrIP = getPlayerIP(plr)
    if __isPlayerLogin[plr] then triggerClientEvent(plr,"clientMsgBox",plr,"● Jesteś już zalogowany(a).") return end
	if getPlayerName(plr) ~= login then
		local zmianaNicka = setPlayerName(plr,login)
	    if zmianaNicka == false then return end
	end
	local password = password
    if kodowanie_hasel == true then password = hash("md5",password) end
	local accID
	if numrows then
	    accID = numrows+1
	end
	local succes = zapytanie("INSERT INTO accounts(aID,aLogin,aPassword,aSerial,aMoney,aBank,aSkin,aKills,aDeaths,aVIP,aPacks,aEXP,aLVL) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)",accID,login,password,plrSerial,0,0,nil,0,0,"NIE",nil,0,0)
	if succes then
		triggerClientEvent(plr,"clientMsgBox",plr,"● Konto "..login.." zarejestrowane.")
		outputServerLog("* INFO: GRACZ ["..login.."] ZAREJESTROWAL SIE ["..plrSerial.."]")
		triggerClientEvent(plr,'Client:HideLoginPanel',plr)
		outputChatBox("● INFO: Gracz ["..login.."] zalogował się.",root,0,255,255,false)
		outputServerLog("* INFO: GRACZ ["..login.."] ZALOGOWAL SIE ["..plrSerial.."] ["..plrIP.."]")
		__isPlayerLogin[plr] = true
		__serverAccounts[plr] = {["id"] = accID,["login"] = login}
		setPlayerName(plr,login)
		outputChatBox("● INFO: Chcesz kupić konto VIP? Wpisz /vipinfo",plr,255,255,0)
		setElementData(plr,"isPlayerVIP","NIE")
		return true
	end
end

local incorrect = {}
function logInAcc(plr,login,password,md5)
    if __isPlayerLogin[plr] then triggerClientEvent(plr,"clientMsgBox",plr,"● Jesteś już zalogowany(a).") return false end
    local login = login
	local password = password
	if md5 then if kodowanie_hasel == true then password = hash("md5",password) end end
    if not incorrect[plr] then incorrect[plr] = 0 end
    if plr then
	    local plrSerial = getPlayerSerial(plr)
    	local plrID,plrPassword,plrLogin,plrBank,plrMoney,plrKills,plrDeaths,plrPacks,plrEXP,plrLVL,plrVIP,plrSkin
		local plrIP = getPlayerIP(plr)
		local data = pobierzWyniki("SELECT aID,aPassword,aBank,aMoney,aKills,aDeaths,aPacks,aEXP,aLVL,aVIP,aSkin FROM accounts WHERE aLogin=? LIMIT 1;",login)
		if data then
			plrID = data.aID
			plrPassword = data.aPassword
			plrLogin = login
		    plrBank = data.aBank
			plrMoney = data.aMoney
			plrKills = data.aKills
			plrDeaths = data.aDeaths
			plrPacks = data.aPacks
			plrEXP = data.aEXP
			plrLVL = data.aLVL
			plrVIP = data.aVIP
			plrSkin = data.aSkin
			if plrPassword == password then
				outputChatBox("● INFO: Gracz ["..login.."] zalogował się.",root,0,255,255,false)
				outputServerLog("* INFO: GRACZ ["..login.."] ZALOGOWAL SIE ["..plrSerial.."] ["..plrIP.."]")
				__isPlayerLogin[plr] = true
				__serverAccounts[plr] = {["id"] = plrID,["login"] = plrLogin}
				setPlayerName(plr,login)
				if plrBank then 
					outputChatBox("● INFO: Twój aktualny stan konta: "..plrBank.."$.",plr,0,255,255)
					__bank.players[plr] = plrBank
				end
				if plrMoney then setPlayerMoney(plr,plrMoney) end
				if plrKills then setElementData(plr,"Kills",plrKills) end
				if plrDeaths then setElementData(plr,"Deaths",plrDeaths) end
				if plrPacks then
				    local split_packs = split(plrPacks,";")
					if not pack_system.used[plr] then pack_system.used[plr] = {} end
					for i,v in pairs(split_packs) do
					    pack_system.used[plr][tonumber(v)] = true
					end
				end
				if plrEXP then setElementData(plr,".EXP",tonumber(plrEXP)) end
				if plrLVL then setElementData(plr,".LVL",tonumber(plrLVL)) end
				if plrVIP == "TAK" then
					__isPlayerVIP[plr] = true
					setElementData(plr,"isPlayerVIP","TAK")
					setPlayerNametagColor(plr,124,252,0)
				else
				    outputChatBox("● INFO: Chcesz kupić konto VIP? Wpisz /vipinfo",plr,255,255,0)
					setElementData(plr,"isPlayerVIP","NIE")
				end
				--if isPedDead(plr) then spawnPlayer(plr,0,0,0) end
				if plrSkin and tonumber(plrSkin) then setElementModel(plr,plrSkin) end
				exports["ps_gang_system"]:loadPlayerGang(plr,plrLogin)
				exports["ps_privcar"]:loadPlayerPrivCar(plr,plrID)
				return true
			else
				triggerClientEvent(plr,"clientMsgBox",plr,"● Podałeś(aś) nieprawidłowe hasło.")
				outputServerLog("* INFO: GRACZ ["..login.."] WPROWADZIL NIEPRAWIDLOWE HASLO ["..plrSerial.."] ["..plrIP.."]")
				incorrect[plr] = incorrect[plr]+1
				if incorrect[plr] == 5 then kickPlayer(plr,"Server","Wpisałeś(aś) błędny Login lub Hasło 5 razy.") end
				return false
			end
		else
			triggerClientEvent(plr,"clientMsgBox",plr,"● Podałeś(aś) nieprawidłowy login.")
			outputServerLog("* INFO: GRACZ ["..login.."] WPROWADZIL NIEPRAWIDLOWY LOGIN ["..plrSerial.."] ["..plrIP.."]")
			incorrect[plr] = incorrect[plr]+1
			if incorrect[plr] == 5 then kickPlayer(plr,"Server","Wpisałeś(aś) błędny Login lub Hasło 5 razy.") end
			return false
		end
	end
end

addCommandHandler("zarejestruj",
function(plr,cmd,login,password)
    if login and password then
	    if __isPlayerLogin[plr] then return triggerClientEvent(plr,"clientMsgBox",plr,"● Jesteś już zalogowany(a).") end
		if string.len(login) < 1 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Login] musi zawierać przynajniej jedną literę.") end
		if string.len(login) > 22 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Login] może skłądać się maksymalnie z 22 znaków.") end
		if string.len(password) < 5 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Hasło] musi zawierać przynajniej 5 znaków.") end
		if string.len(password) > 10 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Hasło] może skłądać się maksymalnie z 10 znaków..") end
        --[[dbQuery(createAcc,{plr,login,password},SQL,"SELECT * FROM accounts")]]
		local accID = getAccIDByName(login)
		if accID then triggerClientEvent(plr,"clientMsgBox",plr,"● Nick "..login.." jest już zarejestrowany.") return end
		createAcc(plr,login,password)
	else
	    outputChatBox("● INFO: /zarejestruj <login> <hasło>",plr,255,0,0,true)
	end
end)

addCommandHandler("zaloguj",
function(plr,cmd,login,password)
    if login and password then
	    if __isPlayerLogin[plr] then return triggerClientEvent(plr,"clientMsgBox",plr,"● Jesteś już zalogowany(a).") end
		if string.len(login) < 1 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Login] musi zawierać przynajniej jedną literę.") end
		if string.len(login) > 22 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Login] może skłądać się maksymalnie z 22 znaków.") end
		if string.len(password) < 5 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Hasło] musi zawierać przynajniej 5 znaków.") end
		if string.len(password) > 10 then return triggerClientEvent(plr,"clientMsgBox",plr,"● [Hasło] może skłądać się maksymalnie z 10 znaków..") end
		logInAcc(plr,login,password,true)
	else
	    outputChatBox("● INFO: /zaloguj <login> <hasło>",plr,255,0,0,true)
	end
end)

addCommandHandler("wyloguj",
function(plr,cmd)
    if getElementData(plr,"pCommands") == false or getPlayerTeam(plr) == jail.team then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr,commandName)
		return
	end
	if __isPlayerLogin[plr] then 
	    triggerEvent("__onPlayerLogout",root,plr,__serverAccounts[plr]["id"],__serverAccounts[plr]["login"])
	    __isPlayerLogin[plr] = nil 
		__serverAccounts[plr] = nil
		outputChatBox("● INFO: Wylogowałeś się.",plr,255,0,0,true)
	end
end)

addCommandHandler("zmiennick",
function(plr,cmd,nowy_nick)
    if __isPlayerLogin[plr] then
	    if not isPlayerAdmin(plr) then
		    if tonumber(getElementData(plr,".LVL")) < 30 then
				if not __isPlayerVIP[plr] then outputChatBox("● INFO: Komenda /zmiennick dostępna jest tylko dla VIP lub graczy którzy osiągneli co najmniej 30 Level.",plr,255,0,0,true) return end
			end
		end
	    if nowy_nick then
		    if string.len(nowy_nick) > 22 then return outputChatBox("● INFO: Nick może składać się maksymlnie z 22 znaków.",plr,255,0,0,true) end
		    local oldLogin = getPlayerName(plr)
			local newLogin = nowy_nick
			local __accID = getAccIDByName(newLogin)
			
    		if __accID then return triggerClientEvent(plr,"clientMsgBox",plr,"● Nick "..newLogin.." jest już zarejestrowany.") end
			local zmianaNicku = setPlayerName(plr,nowy_nick)
			if zmianaNicku == false then return outputChatBox("● INFO: Zmiana nicku nieudana.",plr,255,0,0,true) end
			local ID = __serverAccounts[plr]["id"]
			local succes = setAccData(ID,"aLogin",newLogin)
			if succes then
				__serverAccounts[plr]["login"] = nowy_nick
			    outputChatBox("● INFO: Gracz ["..oldLogin.."] zmienił nick na ["..nowy_nick.."].",root,255,165,0,true)
				outputServerLog("* INFO: GRACZ ["..oldLogin.."] ZMIENIL NICK NA ["..nowy_nick.."]")
			    triggerEvent("__onPlayerChangeLogin",root,plr,oldLogin,newLogin)
			end
		end
	else
	    outputChatBox("● INFO: Tylko zalogowani gracze mogą zmienić nick.",plr,255,0,0,true)
	end
end)

addCommandHandler("zmienhaslo",
function(plr,cmd,aktualne_haslo,nowe_haslo)
    if __isPlayerLogin[plr] then
		if aktualne_haslo and nowe_haslo then
		    if aktualne_haslo == nowe_haslo then return end
	    	local __accountID = getAccID(plr)
			if __accountID then
				local aktualne_haslo = aktualne_haslo
				if kodowanie_hasel == true then aktualne_haslo = hash("md5",aktualne_haslo) end
				local data = pobierzWyniki("SELECT aPassword FROM accounts WHERE aID=? LIMIT 1;",__accountID)
		        local __accountPassword = data.aPassword
				if __accountPassword then
			    	if __accountPassword == aktualne_haslo then
						if string.len(nowe_haslo) < 5 then return triggerClientEvent(plr,"clientMsgBox",plr,"● Hasło musi zawierać przynajniej 5 znaków.") end
						if string.len(nowe_haslo) > 10 then return triggerClientEvent(plr,"clientMsgBox",plr,"● Hasło może skłądać się maksymalnie z 10 znaków.") end
						local nowe_haslo = nowe_haslo
						if kodowanie_hasel == true then nowe_haslo = hash("md5",nowe_haslo) end
						local succes = setAccData(__accountID,"aPassword",nowe_haslo)
						if succes then
				        	outputChatBox("● INFO: Hasło do konta zostało zmienione.",plr,0,255,255,true)
							outputServerLog("* INFO: GRACZ ["..getPlayerName(plr).."] ZMIENIL HASLO.")
						else
					    	outputChatBox("● INFO: Wystąpił błąd.",plr,255,0,0,true)
						end
					else
				    	outputChatBox("● INFO: Podałeś(aś) złe hasło.",plr,255,0,0,true)
					end
				end
			end
		else
		    outputChatBox("● INFO: /zmienhaslo <aktualne haslo> <nowe haslo>",plr,255,0,0,true)
		end
	end
end)

addEventHandler("onPlayerQuit",root,
function()
    if __isPlayerLogin[source] then
        triggerEvent("__onPlayerLogout",root,source,__serverAccounts[source]["id"],__serverAccounts[source]["login"],true)
	end
	incorrect[source] = nil
end)

addEventHandler("onPlayerChangeNick",root,
function()
    cancelEvent()
end)

--[[addEvent("Server:SetSkin",true)
addEventHandler("Server:SetSkin",resourceRoot,
function(skinID)
    setElementModel(client,tonumber(skinID))
end)]]

--[[addEvent("Server:SkinSelect",true)
addEventHandler("Server:SkinSelect",resourceRoot,
function(bool)
    local g_Skin = tonumber(getElementModel(client))
	if bool == 1 then
		if g_Skin == 0 then setElementModel(client,312) return end
		if g_Skin == 290 then setElementModel(client,288) return end
		if g_Skin == 274 then setElementModel(client,272) return end
		if g_Skin == 240 then setElementModel(client,238) return end
		if g_Skin == 209 then setElementModel(client,207) return end
		if g_Skin == 150 then setElementModel(client,148) return end
		if g_Skin == 120 then setElementModel(client,118) return end
		if g_Skin == 87 then setElementModel(client,85) return end
		if g_Skin == 75 then setElementModel(client,73) return end
		if g_Skin == 66 then setElementModel(client,64) return end
		if g_Skin == 43 then setElementModel(client,41) return end
		if g_Skin == 9 then setElementModel(client,7) return end
		if g_Skin == 7 then setElementModel(client,2) return end
		setElementModel(client,g_Skin-1)
	end
	if bool == 2 then
		if g_Skin == 312 then setElementModel(client,0) return end
		if g_Skin == 288 then setElementModel(client,290) return end
		if g_Skin == 272 then setElementModel(client,274) return end
		if g_Skin == 238 then setElementModel(client,240) return end
		if g_Skin == 207 then setElementModel(client,209) return end
		if g_Skin == 148 then setElementModel(client,150) return end
		if g_Skin == 118 then setElementModel(client,120) return end
		if g_Skin == 85 then setElementModel(client,87) return end
		if g_Skin == 73 then setElementModel(client,75) return end
		if g_Skin == 64 then setElementModel(client,66) return end
		if g_Skin == 41 then setElementModel(client,43) return end
		if g_Skin == 7 then setElementModel(client,9) return end
		if g_Skin == 2 then setElementModel(client,7) return end
		setElementModel(client,g_Skin+1)
	end
end)]]

addEvent("clientLoginRegister",true)
addEventHandler("clientLoginRegister",root,
function(login,password)
    local theAccountID = getAccIDByName(login)
	if theAccountID then
	    local succes =  logInAcc(client,login,password,true)
		if succes then
		    triggerClientEvent(client,'Client:HideLoginPanel',client)
		end
	else
	    --[[dbQuery(createAcc,{client,login,password},SQL,"SELECT * FROM accounts")]]
		createAcc(client,login,password)
	end
end)

addCommandHandler("id",
function(plr,cmd)
    local id_konta = getAccID(plr)
	if id_konta then
	    outputChatBox("● INFO: ID twojego konta: ["..id_konta.."]",plr,0,255,255,true)
	end
end)

addEventHandler("__onPlayerLogout",root,
function(plr,accountID,accountName)
	if __isPlayerVIP[plr] then __isPlayerVIP[plr] = nil end
end)

function isPlayerVIP(plr)
	if __isPlayerVIP[plr] then return true else return false end
end

addCommandHandler("vippanel",
function(plr,cmd)
    if getElementData(plr,"pCommands") == false or isPlayerInJail(plr) == true then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr,commandName)
		return
	end
    if not __isPlayerVIP[plr] then return end
	if isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
	triggerClientEvent(plr,"Client:VIP-Panel",plr)
end)

addCommandHandler("asetvip",
function(plr,cmd,id_konta,vip_status)
    if not id_konta and not getAccNameByID(id_konta) then return end
    if not vip_status then return end
	local vip_status = string.upper(vip_status)
	if vip_status == "TAK" or vip_status == "NIE" then
    	if isPlayerAdmin(plr) then
	    	setAccData(id_konta,"aVIP",vip_status)
			local playerName = getAccNameByID(id_konta)
			if playerName then
		    	local playerSource = getPlayerFromName(playerName)
				if playerSource then
			    	if tostring(vip_status) == "TAK" then __isPlayerVIP[playerSource] = true outputChatBox("● INFO: Otrzymałeś(aś) konto VIP [Naciśnij F5, aby otworzyć VIP Panel].",playerSource,0,255,255,true) setElementData(playerSource,"isPlayerVIP","TAK") end
					if tostring(vip_status) == "NIE" then __isPlayerVIP[playerSource] = nil outputChatBox("● INFO: Usunięto Ci konto VIP",playerSource,255,0,0,true) setElementData(playerSource,"isPlayerVIP","NIE") end
				end
			end
		end
	end
end)

addEvent("Server:VIP-Panel",true)
addEventHandler("Server:VIP-Panel",resourceRoot,
function(wybrana_opcja,nowy_nick)
    if wybrana_opcja == "Zmień nick" then if nowy_nick then executeCommandHandler("zmiennick",client,nowy_nick) end return end
    if wybrana_opcja == "Uzupełnij życie" then 
		if isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
		if getElementData(client,"pCommands") == false or getPlayerTeam(client) == jail.team then
			outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
			triggerClientEvent(client,"Client:isPlayerDamage",client)
			return
		end
		if math.floor(getElementHealth(client)) > 99 then return end
		local g_Cost
		if __isPlayerVIP[client] then
			g_Cost = 3800
		else
			g_Cost = 6500
		end
		if getPlayerMoney(client) > g_Cost-1 then
			takePlayerMoney(client,g_Cost)
			setElementHealth(client,100)
			outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] uzdrowił się za "..g_Cost.."$.",root,0,255,255)
		else
			outputChatBox("● INFO: Aby kupic życie potrzebujesz "..g_Cost.."$.",client,255,0,0)
		end
	return end
	if wybrana_opcja == "Uzupełnij kamizelkę" then
		if isPlayerGotDamage(client) == true then return triggerClientEvent(client,"Client:isPlayerDamage",client) end
		if getElementData(client,"pCommands") == false or getPlayerTeam(client) == jail.team then
			outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",client,255,0,0)
			triggerClientEvent(client,"Client:isPlayerDamage",client)
			return
		end
		if math.floor(getPedArmor(client)) > 99 then return end
		local g_Cost
		if __isPlayerVIP[client] then
			g_Cost = 6500
		else
			g_Cost = 15000
		end
		if getPlayerMoney(client) > g_Cost-1 then
			takePlayerMoney(client,g_Cost)
			setPedArmor(client,100)
			outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] kupił kamizelkę za "..g_Cost.."$.",root,0,255,255)
		else
			outputChatBox("● INFO: Aby kupić kamizelkę potrzebujesz "..g_Cost.."$.",client,255,0,0)
		end	
	return end
	if wybrana_opcja == "Nieskończona amunicja" then 
	    for slot=0,12 do
		    local weapon = getPedWeapon(client,slot)
			if weapon > 0 then
			    setWeaponAmmo(client,weapon,99999)
			end
		end
	return end
	if wybrana_opcja == "VIP bronie" then 
	    giveWeapon(client,9,1)
		giveWeapon(client,24,9999)
		giveWeapon(client,26,9999)
		giveWeapon(client,28,9999)
		giveWeapon(client,31,9999)
		giveWeapon(client,34,9999)
		giveWeapon(client,41,9999)
		giveWeapon(client,44,1)
		giveWeapon(client,46,1)
	return end
	if wybrana_opcja == "Napraw pojazd" then
		executeCommandHandler("napraw",client)
	return end
	if wybrana_opcja == "Dodaj Nitro" then 
        executeCommandHandler("nitro",client)
	return end
	if wybrana_opcja == "Automatyczny Tuning" then 
    	executeCommandHandler("tune",client)
	return end
	if wybrana_opcja == "Jetpack" then 
        if doesPedHaveJetPack(client) then removePedJetPack(client) return end
		executeCommandHandler("jetp",client)
	return end
end)

addEventHandler("onPlayerSpawn",root,
function()
    
end)

addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart,stealth)
    if killer then
	    if killer ~= source then
		    if __isPlayerVIP[killer] then givePlayerMoney(killer,2500) end
		end
	end
end)

addCommandHandler("sms",
function(p,_)
    if __isPlayerVIP[p] then return end
	triggerClientEvent(p,"Client:ShowSMSGUI",p)
end)

addEvent("Server:VerifyCode",true)
addEventHandler("Server:VerifyCode",resourceRoot,
function(kod)
	local wprowadzony_kod = tostring(kod)
	local bledny_kod = true
	local xml = getResourceConfig("__xml/codes.xml")
    local codes = xmlNodeGetChildren(xml)
    for i,node in pairs(codes) do
		if xmlNodeGetValue(node) == wprowadzony_kod then 
		    bledny_kod = false
			if wprowadzony_kod ~= "PROMOCJA123" then xmlDestroyNode(node) end
		end
    end
	xmlSaveFile(xml)
	xmlUnloadFile(xml)
	if bledny_kod == true then outputChatBox("● INFO: Wpisałeś(aś) błędny kod.",client,255,0,0) return end
	if bledny_kod == false then 
	    outputChatBox("● INFO: Wpisany kod jest poprawny.",client,0,255,255)
		local id_konta = getAccID(client)
		setAccData(id_konta,"aVIP","TAK")
		__isPlayerVIP[client] = true
		outputChatBox("● INFO: Otrzymałeś(aś) konto VIP [Wpisz /vippanel].",client,0,255,255,true)
	end
end)

local function round(num,idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5)/mult
end

addCommandHandler("stats",
function(plr,_,playerid)
    local plrID
    local plrID = tonumber(playerid)
    if not plrID then plrID = tonumber(getElementData(plr,"ID")) end
	local player = getPlayerByID(plrID)
	if player then
		if __isPlayerLogin[player] then
			local account_id = getAccID(player)
			local login = getPlayerName(player)
			local kills = tonumber(getElementData(player,"Kills"))
			local deaths = tonumber(getElementData(player,"Deaths"))
			local bank = __bank.players[player]
			local vip = getElementData(player,"isPlayerVIP")
			local gang = getElementData(player,"Gang")
			local ratio
			if deaths > 0 then ratio = string.format("%.2f",kills/deaths) else ratio = kills end
			triggerClientEvent(plr,"Client:MyScore",plr,login,kills,deaths,bank,vip,ratio,gang)
		else
			outputChatBox("● INFO: Ten gracz nie jest zalogowany.",plr,255,0,0)
		end
	else
		outputChatBox("● INFO: Nieprawidłowe ID.",plr,255,0,0)
	end
end)

local __top100 = {}

addCommandHandler("top100",
function(plr,cmd)
	triggerClientEvent(plr,"Client:TopPlayers",plr,__top100)
end)

function updateTop100()
	outputServerLog("* INFO: Trwa aktualizowanie listy 100 najlepszych graczy...")
	outputChatBox("● INFO: Trwa aktualizowanie listy 100 najlepszych graczy...",root,0,255,255)
	updateTop100Callback()
end
--setTimer(updateTop100,30*60000,0)

function updateTop100Callback()
	__top100 = {}
	local data = pobierzTabeleWynikow("SELECT * FROM accounts")
	for i,v in pairs(data) do
		local account_login = v["aLogin"]
		local account_kills = tonumber(v["aKills"])
		local account_deaths = tonumber(v["aDeaths"])
		local account_bank = tonumber(v["aBank"])
		local account_ratio = string.format("%.2f",account_kills/account_deaths)
		local account_exp = tonumber(v["aEXP"])
		local account_lvl = tonumber(v["aLVL"])
		if account_exp > 0 then
			wasAdded = false
			for i=1,#__top100 do
				if account_exp > __top100[i].exp then
					table.insert(__top100,i,
						{
							login = account_login,
							kills = account_kills,
							deaths = account_deaths,
							ratio = account_ratio,
							bank = account_bank,
							exp = account_exp,
							lvl = account_lvl,
						}
					)
					if #__top100 > 100 then
						table.remove(__top100)
					end
					wasAdded = true
					break
				end
			end
			if not wasAdded and #__top100 < 100 then
				table.insert(__top100,
					{
						login = account_login,
						kills = account_kills,
						deaths = account_deaths,
						ratio = account_ratio,
						bank = account_bank,
						exp = account_exp,
						lvl = account_lvl,
					}
				)
			end
		end
	end
	outputServerLog("* INFO: Aktualizacja listy 100 najlepszych graczy zakończona...")
	outputChatBox("● INFO: Aktualizacja listy 100 najlepszych graczy zakończona.",root,0,255,255)
end

level_system = {}
level_system.exprequired = {
    [1] = 25,
    [2] = 50,
    [3] = 100,
    [4] = 250,
    [5] = 500,
    [6] = 750,
    [7] = 1000,
    [8] = 1250,
    [9] = 1500,
    [10] = 1750,
    [11] = 2000,
    [12] = 3000,
    [13] = 4000,
    [14] = 5000,
    [15] = 6000,
    [16] = 7000,
    [17] = 8000,
    [18] = 9000,
    [19] = 10000,
    [20] = 12500,
    [21] = 15000,
    [22] = 17500,
    [23] = 20000,
    [24] = 30000,
    [25] = 40000,
    [26] = 50000,
    [27] = 60000,
    [28] = 70000,
    [29] = 80000,
    [30] = 90000,
    [31] = 100000,
    [32] = 200000,
    [33] = 300000,
    [34] = 400000,
    [35] = 500000,
    [36] = 600000,
    [37] = 700000,
    [38] = 800000,
    [39] = 900000,
    [40] = 1000000,
}

function formatEXP(exp)
	local __exp = tonumber(exp)
	local __lvl = 0
	for i,v in ipairs(level_system.exprequired) do
		if tonumber(exp) >= tonumber(v) then 
			__lvl = __lvl+1
		else
			return __lvl
		end
	end
	return __lvl
end

addCommandHandler("lvl",
function(plr,cmd)
	local player_exp = getElementData(plr,".EXP")
	local player_lvl = getElementData(plr,".LVL")
	if player_exp and player_lvl then
		outputChatBox("● INFO: EXP: "..player_exp.."/"..level_system.exprequired[player_lvl+1].." LEVEL: "..player_lvl,plr,0,255,255)
	end
end)

function addPlayerEXP(plr,exp)
	local player_lvl = tonumber(getElementData(plr,".LVL"))
	local player_exp = tonumber(getElementData(plr,".EXP"))
	if player_exp and player_lvl then
		setElementData(plr,".EXP",player_exp+exp)
		local currentEXP = player_exp+exp
		local new_level = formatEXP(currentEXP)
		if new_level > player_lvl then
			setElementData(plr,".LVL",new_level)
			outputChatBox("● INFO: ["..getPlayerName(plr).."] osiągnął(eła) "..new_level.." Level!",root,0,255,255)
			triggerClientEvent(plr,"Client:onLevelUp",plr)
		end
	end
end

function removePlayerEXP(plr,exp)
	local player_lvl = tonumber(getElementData(plr,".LVL"))
	local player_exp = tonumber(getElementData(plr,".EXP"))
	if player_exp and player_lvl then
		setElementData(plr,".EXP",player_exp-exp)
		local currentEXP = tonumber(getElementData(plr,".EXP"))
		if player_lvl == 0 then return end
		local new_level = formatEXP(currentEXP)
		if new_level ~= player_lvl then
			setElementData(plr,".LVL",new_level)
		end
	end
end

function getAccountEXP(id)
	local d = pobierzWyniki("SELECT aEXP FROM accounts WHERE aID=? LIMIT 1;",id)
	if d then
		return tonumber(d.aEXP)
	end
end

function getAccountLevel(id)
	local d = pobierzWyniki("SELECT aLVL FROM accounts WHERE aID=? LIMIT 1;",id)
	if d then
		return tonumber(d.aLVL)
	end
end

function removeAccountEXP(id,exp)
	local aEXP = getAccountEXP(id)
	local aLVL = getAccountLevel(id)
	if aEXP and aLVL then
		setAccData(id,"aEXP",aEXP-exp)
		local currentEXP = tonumber(aEXP-exp)
		if aLVL == 0 then return end
		local new_level = formatEXP(currentEXP)
		if new_level ~= aLVL then
			setAccData(id,"aLVL",new_level)
		end
	end
end

addEventHandler("onPlayerWasted",root,
function(totalAmmo,killer,killerWeapon,bodypart,stealth)
	if killer and killer ~= source then
		local dodatkoweEXP = 0
		if bodypart == 4 then dodatkoweEXP = dodatkoweEXP+3 end
		if bodypart == 9 then dodatkoweEXP = dodatkoweEXP+5 end
		addPlayerEXP(killer,math.random(1,5)+dodatkoweEXP)
	end
	if source then
		local exp = math.random(1,3)
		removePlayerEXP(source,exp)
	end
end)


