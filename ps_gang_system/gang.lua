local dbmanager = exports["ps_core"]

local gangsTable = {}

__getPlayerGang = {}
__getPlayerRank = {}

addEventHandler("onResourceStop",resourceRoot,
function()
	for i,v in pairs(getElementsByType("player")) do
		if dbmanager:isPlayerLogin(v) then
			setElementData(v,"Gang","-")
		end
	end
end)

addEventHandler("onResourceStart",resourceRoot,
function()
	loadGangsFromDatabase()
end)

function loadGangsFromDatabase()
	dbmanager:zapytanie("CREATE TABLE IF NOT EXISTS gangs(gID INT, gName TEXT,gLeader TEXT,gSubLeaders TEXT,gMembers TEXT,gColor TEXT,gBase TEXT)")
	wczytajGangi()
end

function wczytajGangi()
	local data = dbmanager:pobierzTabeleWynikow("SELECT * FROM gangs")
	if data then
		for i,v in pairs(data) do
			local gangID,gangName,gangLeader,gangSubLeaders,gangMembers,gangColor,gangBase = v.gID,v.gName,v.gLeader,fromJSON(v.gSubLeaders),fromJSON(v.gMembers),fromJSON(v.gColor),fromJSON(v.gBase)
		    gangsTable[gangName] = {["id"] = gangID,["name"] = gangName,["leader"] = gangLeader,["sub_leaders"] = gangSubLeaders,["members"] = gangMembers,["color"] = gangColor,["baza"] = gangBase}
			__getPlayerGang[gangLeader] = gangName
			__getPlayerRank[gangLeader] = "Leader"
			
			if gangSubLeaders then
				for i,v in pairs(gangSubLeaders) do
			    	__getPlayerGang[v] = gangName
					__getPlayerRank[v] = "Sub Leader"
				end
			end
			
			if gangMembers then
				for i,v in pairs(gangMembers) do
			    	__getPlayerGang[v] = gangName
					__getPlayerRank[v] = "Member"
				end
			end
		end
	end
end

addEvent("Server:loadPlayerGang",true)
addEventHandler("Server:loadPlayerGang",resourceRoot,
function()
	if dbmanager:isPlayerLogin(client) then
		loadPlayerGang(client,getPlayerName(client))
	end
end)

addEventHandler("__onPlayerChangeLogin",root,
function(p,oldLogin,newLogin)
    local gangName = __getPlayerGang[oldLogin]
	if gangName then
	    local gangID = gangsTable[gangName]["id"]
	    local playerRank = __getPlayerRank[oldLogin]
		if playerRank == "Leader" then
			dbmanager:zapytanie("UPDATE gangs SET gLeader=? WHERE gID=?",newLogin,gangID)
			gangsTable[gangName]["leader"] = newLogin
			__getPlayerRank[oldLogin] = nil
			__getPlayerGang[oldLogin] = nil
			__getPlayerRank[newLogin] = "Leader"
			__getPlayerGang[newLogin] = gangName
		end
		if playerRank == "Sub Leader" then
    		for i,v in pairs(gangsTable[gangName]["sub_leaders"]) do
	    		if oldLogin == v then
		    		table.remove(gangsTable[gangName]["sub_leaders"],i)
				end
			end
			table.insert(gangsTable[gangName]["sub_leaders"],newLogin)
			__getPlayerRank[oldLogin] = nil
			__getPlayerGang[oldLogin] = nil
			__getPlayerRank[newLogin] = "Sub Leader"
			__getPlayerGang[newLogin] = gangName
			dbmanager:zapytanie("UPDATE gangs SET gSubLeaders=? WHERE gID=?",toJSON(gangsTable[gangName]["sub_leaders"]),gangID)
		end
		if playerRank == "Member" then
    		for i,v in pairs(gangsTable[gangName]["members"]) do
	    		if oldLogin == v then
		    		table.remove(gangsTable[gangName]["members"],i)
				end
			end
			table.insert(gangsTable[gangName]["members"],newLogin)
			__getPlayerRank[oldLogin] = nil
			__getPlayerGang[oldLogin] = nil
			__getPlayerRank[newLogin] = "Member"
			__getPlayerGang[newLogin] = gangName
			dbmanager:zapytanie("UPDATE gangs SET gMembers=? WHERE gID=?",toJSON(gangsTable[gangName]["members"]),gangID)
		end
	end
end)

function addGangSubLeader(gangName,memberName)
    if __getPlayerRank[memberName] == "Member" then
    	for i,v in pairs(gangsTable[gangName]["members"]) do
	    	if memberName == v then
		    	table.remove(gangsTable[gangName]["members"],i)
			end
		end
		local gangID = gangsTable[gangName]["id"]
		__getPlayerRank[memberName] = "Sub Leader"
		table.insert(gangsTable[gangName]["sub_leaders"],memberName)
		dbmanager:zapytanie("UPDATE gangs SET gMembers=?,gSubLeaders=? WHERE gID=?",toJSON(gangsTable[gangName]["members"]),toJSON(gangsTable[gangName]["sub_leaders"]),gangID)
	end
end

function removeGangSubLeader(gangName,memberName)
    if __getPlayerRank[memberName] == "Sub Leader" then
    	for i,v in pairs(gangsTable[gangName]["sub_leaders"]) do
	    	if memberName == v then
		    	table.remove(gangsTable[gangName]["sub_leaders"],i)
			end
		end
		local gangID = gangsTable[gangName]["id"]
		__getPlayerRank[memberName] = "Member"
		table.insert(gangsTable[gangName]["members"],memberName)
		dbmanager:zapytanie("UPDATE gangs SET gSubLeaders=?,gMembers=? WHERE gID=?",toJSON(gangsTable[gangName]["sub_leaders"]),toJSON(gangsTable[gangName]["members"]),gangID)
	end
end

function addGangMember(gangName,memberName)
    table.insert(gangsTable[gangName]["members"],memberName)
	local gangID = gangsTable[gangName]["id"]
	dbmanager:zapytanie("UPDATE gangs SET gMembers=? WHERE gID=?",toJSON(gangsTable[gangName]["members"]),gangID)
	__getPlayerGang[memberName] = gangName
	__getPlayerRank[memberName] = "Member"
	sendMessageToGang(gangName,"● [Gang]: Gracz ("..memberName..") dołączył do gangu.",0,255,0)
    local theMember = getPlayerFromName(memberName)
	if theMember then
        setElementData(theMember,"Gang",gangName)
		local __gColor = gangsTable[gangName]["color"]
		setPlayerNametagColor(theMember,__gColor[1],__gColor[2],__gColor[3])
	end
end

function removeGangMember(gangName,memberName)
    local gangID = gangsTable[gangName]["id"]
    if __getPlayerRank[memberName] == "Sub Leader" then
    	for i,v in pairs(gangsTable[gangName]["sub_leaders"]) do
	    	if memberName == v then
		    	table.remove(gangsTable[gangName]["sub_leaders"],i)
			end
		end
		dbmanager:zapytanie("UPDATE gangs SET gSubLeaders=? WHERE gID=?",toJSON(gangsTable[gangName]["sub_leaders"]),gangID)
	end
    if __getPlayerRank[memberName] == "Member" then
    	for i,v in pairs(gangsTable[gangName]["members"]) do
	    	if memberName == v then
		    	table.remove(gangsTable[gangName]["members"],i)
			end
		end
		dbmanager:zapytanie("UPDATE gangs SET gMembers=? WHERE gID=?",toJSON(gangsTable[gangName]["members"]),gangID)
	end
	__getPlayerRank[memberName] = nil
	__getPlayerGang[memberName] = nil
    local theMember = getPlayerFromName(memberName)
	if theMember then
		setElementData(theMember,"Gang","-")
	end
end

function removeGang(gangName)
    local gangID = gangsTable[gangName]["id"]
    local __gangPlayers = getAllGangPlayers(gangName)
	if __gangPlayers then
	    for i,v in pairs(__gangPlayers) do
		    local thePlayer = getPlayerFromName(v)
			if thePlayer then
			    setElementData(thePlayer,"Gang","-")
			end
			__getPlayerGang[v] = nil
			__getPlayerRank[v] = nil
		end
    end
    gangsTable[gangName] = nil
	dbmanager:zapytanie("DELETE FROM gangs WHERE gID=?",gangID)
end

function getAllGangPlayers(gangName)
    local __gangPlayers = {}
	if __gangPlayers then
	    if gangsTable[gangName]["members"] then
			for i,v in pairs(gangsTable[gangName]["members"]) do
	   	 		table.insert(__gangPlayers,v)
			end
		end
		if gangsTable[gangName]["sub_leaders"] then
			for i,v in pairs(gangsTable[gangName]["sub_leaders"]) do
	    		table.insert(__gangPlayers,v)
			end
		end
		table.insert(__gangPlayers,gangsTable[gangName]["leader"])
	end
	return __gangPlayers
end

function sendMessageToGang(gangName,theMessage,red,green,blue)
    local __gangPlayers = getAllGangPlayers(gangName)
	if __gangPlayers then
		for i,v in pairs(__gangPlayers) do
			local __gPlayer = getPlayerFromName(v)
			if __gPlayer then
			    local __gPlayerAccount = getPlayerAccount(__gPlayer)
				if not isGuestAccount(__gPlayerAccount) then
				    outputChatBox(tostring(theMessage),__gPlayer,red,green,blue,true)
				end
			end
		end
    end	
end

addCommandHandler("gang-quit",
function(plr,cmd)
	if dbmanager:isPlayerLogin(plr) then
		local playerName = dbmanager:getAccName(plr)
		if playerName then
		    local playerGang = __getPlayerGang[playerName]
			if playerGang then
			    if __getPlayerRank[playerName] == "Leader" then
				    sendMessageToGang(playerGang,"● [Gang]: Gang ("..playerGang..") został usunięty.",255,0,0)
					outputChatBox("● [Gang]: Gang ("..playerGang..") został usunięty.",plr,255,0,0)
				    removeGang(playerGang)
				else
				    sendMessageToGang(playerGang,"● [Gang]: Gracz ("..getPlayerName(plr)..") odszedł z gangu.",255,0,0)
				    removeGangMember(playerGang,playerName)
				end
			end
		end
	end
end)

addCommandHandler("gang-invite",
function(p,cmd,playerid)
	if dbmanager:isPlayerLogin(p) then
		local sourceName = dbmanager:getAccName(p)
		if sourceName then
		    local theGang = __getPlayerGang[sourceName]
			if theGang then
			    if __getPlayerRank[sourceName] == "Leader" or __getPlayerRank[sourceName] == "Sub Leader" then
				    local gangPlayers = getAllGangPlayers(theGang)
					if #gangPlayers ~= 20 then
				    	if playerid and tonumber(playerid) ~= tonumber(getElementData(p,"ID")) then
					    	local thePlayer = dbmanager:getPlayerByID(playerid)
							if thePlayer then
						    	if getElementData(thePlayer,"pCommands") ~= false then
									if dbmanager:isPlayerLogin(thePlayer) then
							    		local thePlayerName = dbmanager:getAccName(thePlayer)
										if not __getPlayerGang[thePlayerName] then
							    			outputChatBox("● [Gang]: Wysłałeś/aś zaproszenie do gangu dla ("..getPlayerName(thePlayer)..").",p,0,255,255,true)
											outputChatBox("● [Gang]: Otrzymałeś/aś zaproszenie do gangu ("..theGang..") od ("..getPlayerName(p)..").",thePlayer,0,255,255,true)
											triggerClientEvent(thePlayer,"Client:GangInvite",thePlayer,theGang,getPlayerName(p))
										else
								    		outputChatBox("● [Gang]: Ten gracz jest już w gangu.",p,255,0,0,true)
										end
									else
							    		outputChatBox("● [Gang]: Tylko zarejestrowani gracze mogą dołączyć do gangu.",p,255,0,0,true)
									end
								else
							    	outputChatBox("● [Gang]: Ten gracz nie może odebrać zaproszenia w tej chwili.",p,255,0,0,true)
								end
							else
						    	outputChatBox("● [Gang]: Nie ma gracza o takim ID.",p,255,0,0,true)
							end
						else
					    	outputChatBox("● [Gang]: /gang-invite <id gracza>",p,255,0,0,true)
						end
					else
					    outputChatBox("● [Gang]: W gangu może być maksymalnie 20 osób!",p,255,0,0,true)
					end
				else
				    outputChatBox("● [Gang]: Do gangu zapraszać może tylko 'Leader' i 'Sub Leader'.",p,255,0,0,true)
				end
			end
		end
	end
end)

addCommandHandler("gang-kick",
function(p,cmd,memberName)
	if dbmanager:isPlayerLogin(p) then
		local sourceName = dbmanager:getAccName(p)
		if sourceName then
		    local theGang = __getPlayerGang[sourceName]
			if theGang then
				if __getPlayerRank[sourceName] == "Leader" then
				    if __getPlayerGang[memberName] then
					    if theGang == __getPlayerGang[memberName] then
						    if __getPlayerRank[memberName] ~= "Leader" then
						    	removeGangMember(theGang,memberName)
								local thePlayer = getPlayerFromName(memberName)
								if thePlayer then
							    	outputChatBox("● [Gang]: Zostałeś wyrzucony z gangu.",thePlayer,255,0,0,true)
								end
								outputChatBox("● [Gang]: Wyrzuciłeś gracza ("..memberName..") z gangu.",p,255,0,0,true)
			    				local __gangPlayers = getAllGangPlayers(theGang)
								if __gangPlayers then triggerClientEvent(p,"Client:Gang-Panel:Refresh",p,__gangPlayers,__getPlayerRank) end
							else
							    outputChatBox("● [Gang]: Nie możesz wyrzucić Lidera(siebie) z gangu.",p,255,0,0,true)
							end
						end
					end
				else
				    outputChatBox("● [Gang]: Graczy z gangu może wyrzucać tylko 'Leader' i 'Sub Leader'.",p,255,0,0,true)
				end
			end
		end
	end
end)

addCommandHandler("gang-nazwa",
function(p,cmd,__newGangName)
    
end)

addCommandHandler("gang-kolor",
function(p,cmd,red,green,blue)
    if dbmanager:isPlayerLogin(p) then
	    local sourceName = dbmanager:getAccName(p)
	    local playerGang = __getPlayerGang[sourceName]
		if playerGang then
		    if __getPlayerRank[sourceName] == "Leader" then
	    		local __r,__g,__b = tonumber(red) or math.random(0,255),tonumber(green) or math.random(0,255),tonumber(blue) or math.random(0,255)
	    		if __r and __g and __b then
			    	setGangColor(playerGang,__r,__g,__b)
					local __gMembers = getAllGangPlayers(playerGang)
					if __gMembers then
				    	for i,v in pairs(__gMembers) do
					    	local __gMember = getPlayerFromName(v)
					    	if dbmanager:isPlayerLogin(__gMember) then
						    	setPlayerNametagColor(__gMember,__r,__g,__b)
							end
						end
					end
					outputChatBox("● [Gang]: Kolor gangu został zmieniony.",p,0,255,255,true)
				else
				    outputChatBox("● [Gang]: /gang-kolor <r> <g> <b>",p,255,0,0,true)
				end
			else
			    outputChatBox("● [Gang]: Nie możesz zmienić koloru gangu.",p,255,0,0,true)
			end
		end
	end
end)

function setGangColor(gangName,__r,__g,__b)
    gangsTable[gangName]["color"] = {__r,__g,__b}
	local gangID = gangsTable[gangName]["id"]
	dbmanager:zapytanie("UPDATE gangs SET gColor=? WHERE gID=?",toJSON(gangsTable[gangName]["color"]),gangID)
end

function createGangCallback(gangName,sourceName,__r,__g,__b)
	local __id = #gangsTable+1
	gangsTable[gangName] = {["id"] = __id,["name"] = gangName,["leader"] = sourceName,["sub_leaders"] = {},["members"] = {},["color"] = {__r,__g,__b},["baza"] = {}}
	local succes = dbmanager:zapytanie("INSERT INTO gangs(gID,gName,gLeader,gSubLeaders,gMembers,gColor,gBase) VALUES(?,?,?,?,?,?,?)",__id,gangName,sourceName,toJSON(gangsTable[gangName]["sub_leaders"]),toJSON(gangsTable[gangName]["members"]),toJSON(gangsTable[gangName]["color"]),toJSON(gangsTable[gangName]["baza"]))
	if succes then return true else return false end
end

addCommandHandler("gang-create",
function(p,cmd,gangName)
	if dbmanager:isPlayerLogin(p) then
	    if gangName then
			if not dbmanager:isPlayerVIP(p) then
				if tonumber(getElementData(p,".LVL")) < 10 then triggerClientEvent(p,"clientMsgBox",p,"● Musisz osiągnąć co najmniej 10 Level, aby stworzyć gang.") return end
	    	end
			local sourceName = dbmanager:getAccName(p)
			local __r,__g,__b = getPlayerNametagColor(p)
	    	local playerGang = __getPlayerGang[sourceName]
			if not playerGang then
	    		if not gangsTable[gangName] then
			    	if string.len(gangName) < 11 then
						local __succes = createGangCallback(gangName,sourceName,__r,__g,__b)
						if __succes then
							__getPlayerGang[sourceName] = gangName
							__getPlayerRank[sourceName] = "Leader"
							setElementData(p,"Gang",gangName)
							outputChatBox("● [Gang]: Utworzyłeś gang o nazwie: "..gangName,p,0,255,255,true)
							triggerClientEvent(p,"clientMsgBox",p,"● Naciśnij klawisz [F4], aby otworzyć panel gangu.")
						end
					else
				    	outputChatBox("● [Gang]: Nazwa gangu jest zbyt długa.",p,255,0,0,true)
					end
				else
			    	outputChatBox("● [Gang]: Już istnieje gang o takiej nazwie.",p,255,0,0,true)
				end
			else
		    	outputChatBox("● [Gang]: Jesteś już w gangu.",p,255,0,0,true)
			end
		else
		    outputChatBox("● [Gang]: /gang-create <nazwa gangu>",p,255,0,0,true)
		end
	else
		outputChatBox("● [Gang]: Tylko zarejestrowani/zalogowani gracze mogą stworzyć gang.",p,255,0,0,true)
	end
end)

addCommandHandler("g",
function(p,_,...)
    if getElementData(p,"pCommands") == false or dbmanager:isPlayerInJail(plr) == true then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",p,255,0,0)
		triggerClientEvent(p,"Client:isPlayerDamage",p,commandName)
		return
	end
	if dbmanager:isPlayerLogin(p) and ... then
		local playerName = dbmanager:getAccName(p)
		if playerName then
		    local playerGang = __getPlayerGang[playerName]
			if playerGang then
			    local __gangPlayers = getAllGangPlayers(playerGang)
				if __gangPlayers then
				    local message = table.concat({...}," ")
					if string.len(message) < 135 then
					    for i,v in pairs(__gangPlayers) do
						    local gPlayer = getPlayerFromName(v)
							if gPlayer then
						        outputChatBox("● <GANG> "..playerName..": "..string.lower(message),gPlayer,0,255,255)
							end
						end
						outputServerLog("CHAT: [GANG: "..playerGang.."] "..playerName..": "..string.lower(message))
					end
				end
			end
		end
	end
end)

addCommandHandler("gang-panel",
function(plr,cmd)
	if dbmanager:isPlayerLogin(plr) then
		local sourceName = dbmanager:getAccName(plr)
		if sourceName then
		    local playerGang = __getPlayerGang[sourceName]
			if playerGang then
			    if __getPlayerRank[sourceName] == "Leader" then
			    	local __gangPlayers = getAllGangPlayers(playerGang)
					if __gangPlayers then triggerClientEvent(plr,"Client:Gang-Panel:Show",plr,__gangPlayers,__getPlayerRank) end
				end
			end
		end
	end
end)

addEvent("Server:Gang-Panel:Base",true)
addEventHandler("Server:Gang-Panel:Base",resourceRoot,
function()
	if dbmanager:isPlayerLogin(client) then
		local sourceName = dbmanager:getAccName(client)
		if sourceName then
		    local playerGang = __getPlayerGang[sourceName]
			if playerGang then
			    local gangID = gangsTable[playerGang]["id"]
			    local posX,posY,posZ = getElementPosition(client)
				local interior = getElementInterior(client)
				local dimension = getElementDimension(client)
				if interior ~= 0 then return outputChatBox("● [Gang]: Bazę można ustawić tylko na zewnątrz.",client,255,0,0,true) end
				if dimension ~= 0 then return outputChatBox("● [Gang]: Bazę można ustawić tylko w wymiarze domyślnym.",client,255,0,0,true) end
			    gangsTable[playerGang]["baza"] = {posX,posY,posZ,interior,dimension}
				dbmanager:zapytanie("UPDATE gangs SET gBase=? WHERE gID=?",toJSON(gangsTable[playerGang]["baza"]),gangID)
				outputChatBox("● [Gang]: Baza ustawiona.",client,0,255,255,true)
				outputChatBox("● [Gang]: Wszyscy członkowie gangu mogą się do niej teleportować za pomocą komendy /gang-baza",client,0,255,255,true)
			end
		end
	end
end)

addCommandHandler("gang-baza",
function(plr,cmd)
	if dbmanager:isPlayerLogin(plr) then
    if getElementData(plr,"pCommands") == false or dbmanager:isPlayerInJail(plr) == true then
		outputChatBox("● INFO: Nie możesz w tej chwili używać komend i teleportów.",plr,255,0,0)
		triggerClientEvent(plr,"Client:isPlayerDamage",plr,commandName)
		return
	end
	    if dbmanager:isPlayerGotDamage(plr) == true then return triggerClientEvent(plr,"Client:isPlayerDamage",plr) end
		local sourceName = dbmanager:getAccName(plr)
		if sourceName then
		    local playerGang = __getPlayerGang[sourceName]
			if playerGang then
			    local g_GangBase = gangsTable[playerGang]["baza"]
				if g_GangBase[1] then
					local x,y,z,int,dim = g_GangBase[1],g_GangBase[2],g_GangBase[3],g_GangBase[4],g_GangBase[5]
					triggerClientEvent(plr,"Client:ChangePosition",plr,x,y,z,int,dim)
				else
				    outputChatBox("● [Gang]: Baza gangu nie została ustawiona przez lidera.",plr,255,0,0,true)
				end
			end
		end
	end
end)

addEvent("Server:Gang-Panel:Delete",true)
addEventHandler("Server:Gang-Panel:Delete",resourceRoot,
function()
    executeCommandHandler("gang-quit",client)
end)

addEvent("Server:Gang-Panel:Refresh",true)
addEventHandler("Server:Gang-Panel:Refresh",resourceRoot,
function()
	if dbmanager:isPlayerLogin(client) then
		local sourceName = dbmanager:getAccName(client)
		if sourceName then
		    local playerGang = __getPlayerGang[sourceName]
			if playerGang then
			    if __getPlayerRank[sourceName] == "Leader" then
			    	local __gangPlayers = getAllGangPlayers(playerGang)
					if __gangPlayers then triggerClientEvent(client,"Client:Gang-Panel:Refresh",client,__gangPlayers,__getPlayerRank) end
				end
			end
		end
	end
end)

addEvent("Server:Gang-Panel:MakeSubLeader",true)
addEventHandler("Server:Gang-Panel:MakeSubLeader",resourceRoot,
function(memberName)
    if memberName then
	    executeCommandHandler("gang-makesubleader",client,memberName)
	end
end)

addCommandHandler("gang-makesubleader",
function(p,cmd,memberName)
	if dbmanager:isPlayerLogin(p) then
		local sourceName = dbmanager:getAccName(p)
		if sourceName then
		    local theGang = __getPlayerGang[sourceName]
			if theGang then
				if __getPlayerRank[sourceName] == "Leader" then
				    if __getPlayerGang[memberName] then
					    if theGang == __getPlayerGang[memberName] then
						    if __getPlayerRank[memberName] ~= "Leader" and __getPlayerRank[memberName] ~= "Sub Leader" then
						    	addGangSubLeader(theGang,memberName)
								local thePlayer = getPlayerFromName(memberName)
								if thePlayer then
							    	outputChatBox("● [Gang]: Zostałeś dodany do grupy 'Sub Leader'.",thePlayer,0,255,255,true)
								end
								outputChatBox("● [Gang]: Gracz "..memberName.." został dodany to grupy 'Sub Leader'.",p,0,255,255,true)
			    				local __gangPlayers = getAllGangPlayers(theGang)
								if __gangPlayers then triggerClientEvent(p,"Client:Gang-Panel:Refresh",p,__gangPlayers,__getPlayerRank) end
							else
							    outputChatBox("● [Gang]: Błąd.",p,255,0,0,true)
							end
						end
					end
				else
				    outputChatBox("● [Gang]: Zarządzać gangiem może tylko 'Leader'.",p,255,0,0,true)
				end
			end
		end
	end
end)

addEvent("Server:Gang-Panel:RemoveSubLeader",true)
addEventHandler("Server:Gang-Panel:RemoveSubLeader",resourceRoot,
function(memberName)
    if memberName then
	    executeCommandHandler("gang-removesubleader",client,memberName)
	end
end)

addCommandHandler("gang-removesubleader",
function(p,cmd,memberName)
	if dbmanager:isPlayerLogin(p) then
		local sourceName = dbmanager:getAccName(p)
		if sourceName then
		    local theGang = __getPlayerGang[sourceName]
			if theGang then
				if __getPlayerRank[sourceName] == "Leader" then
				    if __getPlayerGang[memberName] then
					    if theGang == __getPlayerGang[memberName] then
						    if __getPlayerRank[memberName] ~= "Leader" and __getPlayerRank[memberName] ~= "Member" then
						    	removeGangSubLeader(theGang,memberName)
								local thePlayer = getPlayerFromName(memberName)
								if thePlayer then
							    	outputChatBox("● [Gang]: Zostałeś usunięty z grupy 'Sub Leader'.",thePlayer,255,0,0,true)
								end
								outputChatBox("● [Gang]: Gracz "..memberName.." został usunięty z grupy 'Sub Leader'.",p,255,0,0,true)
			    				local __gangPlayers = getAllGangPlayers(theGang)
								if __gangPlayers then triggerClientEvent(p,"Client:Gang-Panel:Refresh",p,__gangPlayers,__getPlayerRank) end
							else
							    outputChatBox("● [Gang]: Błąd.",p,255,0,0,true)
							end
						end
					end
				else
				    outputChatBox("● [Gang]: Zarządzać gangiem może tylko 'Leader'.",p,255,0,0,true)
				end
			end
		end
	end
end)

addEvent("Server:Gang-Panel:Kick",true)
addEventHandler("Server:Gang-Panel:Kick",resourceRoot,
function(memberName)
    if memberName then
	    executeCommandHandler("gang-kick",client,memberName)
	end
end)

addEvent("Server:Gang-Panel:Invite",true)
addEventHandler("Server:Gang-Panel:Invite",resourceRoot,
function(memberName)
    local theMember = getPlayerFromName(memberName)
    if theMember then
	    local memberID = getElementData(theMember,"ID")
	    executeCommandHandler("gang-invite",client,memberID)
	end
end)

addEvent("Server:Gang-Panel:Quit",true)
addEventHandler("Server:Gang-Panel:Quit",resourceRoot,
function()
	executeCommandHandler("gang-quit",client)
end)

addCommandHandler("gang-info",
function(p,cmd)
	if dbmanager:isPlayerLogin(p) then
		local playerName = dbmanager:getAccName(p)
		if playerName then
		    local playerGang = __getPlayerGang[playerName]
			if playerGang then
			    local __gangPlayers = getAllGangPlayers(playerGang)
				if __gangPlayers then triggerClientEvent(p,"Client:GangInfo",p,__gangPlayers,__getPlayerRank) end
			end
		end
	end
end)

addCommandHandler("gangs",
function(p,cmd)
    triggerClientEvent(p,"Client:ShowGangsList",p,gangsTable)
end)

function loadPlayerGang(plr,accName)
	local playerName = accName
	if playerName then
	    local playerGang = __getPlayerGang[playerName]
		if playerGang then
		    setElementData(plr,"Gang",playerGang)
			local __gColor = gangsTable[playerGang]["color"]
		    setPlayerNametagColor(plr,__gColor[1],__gColor[2],__gColor[3])
		end
	end
end

addEventHandler("__onPlayerLogout",root,
function(plr,accountID,accountName)
	setElementData(plr,"Gang","-")
end)

addEvent("onPlayerGangJoin",true)
addEventHandler("onPlayerGangJoin",resourceRoot,
function(theGang)
	if dbmanager:isPlayerLogin(client) then
		local sourceName = dbmanager:getAccName(client)
		if sourceName then
            addGangMember(theGang,sourceName)
	    end
	end
end)