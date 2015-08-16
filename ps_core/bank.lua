__bank = {}
__bank.interiors = {
    {
	    ["marker"] = "-19.1330078125,-55.34296875,1002.546875",
		["blip"] = "2200.109375,1990.4541015625,16.913011550903",
		["dimension"] = "5",
		["interior"] = "6",
	},
    {
	    ["marker"] = "-19.1330078125,-55.34296875,1002.546875",
		["blip"] = "2099.623046875,2224.2978515625,11.0234375",
		["dimension"] = "6",
		["interior"] = "6",
	},
    {
	    ["marker"] = "-19.1330078125,-55.34296875,1002.546875",
		["blip"] = "2453.724609375,2065.1845703125,10.8203125",
		["dimension"] = "4",
		["interior"] = "6",
	},
    {
	    ["marker"] = "-19.1330078125,-55.34296875,1002.546875",
		["blip"] = "2247.7607421875,2396.98828125,19.659206390381",
		["dimension"] = "3",
		["interior"] = "6",
	},
    {
	    ["marker"] = "-24.3466796875,-90.6416015625,1002.546875",
		["blip"] = "2546.67578125,1971.482421875,10.450658798218",
		["dimension"] = "2",
		["interior"] = "18",
	},
    {
	    ["marker"] = "362.416015625,173.689453125,1007.3828125",
		["blip"] = "2414.0869140625,1123.8984375,14.878396987915",
		["dimension"] = "0",
		["interior"] = "3",
	},
}
__bank.players = {}

addEventHandler("onResourceStart",resourceRoot,
function()
	__bank.players = {}
	for i,b in pairs(__bank.interiors) do
		local marker_pos = split(__bank.interiors[i]["marker"], ",")
		local blip_pos = split(__bank.interiors[i]["blip"], ",")
		local bMarker = createMarker (marker_pos[1],marker_pos[2],marker_pos[3],"cylinder",1.4,255,255,0,150,root)
		local bMarker_2 = createMarker (marker_pos[1],marker_pos[2],marker_pos[3],"cylinder",2.4,255,255,0,100,root)
		local bBlip = createBlip(blip_pos[1],blip_pos[2],blip_pos[3],35,2,255,0,0,255,0,200.0,root)
		setElementInterior(bMarker,tonumber(__bank.interiors[i]["interior"]))
		setElementDimension(bMarker,tonumber(__bank.interiors[i]["dimension"]))
		setElementInterior(bMarker_2,tonumber(__bank.interiors[i]["interior"]))
		setElementDimension(bMarker_2,tonumber(__bank.interiors[i]["dimension"]))
		setElementData(bMarker,"isBankMarker",true)
		addEventHandler("onMarkerHit",bMarker,onBankMarkerHit)
		addEventHandler("onMarkerLeave",bMarker,onBankMarkerLeave)
	end
end)

function onBankMarkerHit(hitElement,matchingDimension)
    if getElementHealth(hitElement) > 0 and matchingDimension then
		if __isPlayerLogin[hitElement] then
			local playerBank = __bank.players[hitElement]
			if playerBank then
    	        triggerClientEvent(hitElement,"Client:BankMarkerHit",hitElement,{playerBank,getAccName(hitElement)})
			end
		else
		    outputChatBox("● INFO: Aby korzystać z banku musisz być zalogowany.",hitElement,255,0,0,true)
		end
	end
end

function onBankMarkerLeave(leftElement,matchingDimension)
    if matchingDimension then
	    triggerClientEvent(leftElement,"Client:BankMarkerLeave",leftElement)
	end
end

addEvent("Server:BankWplac",true)
addEventHandler("Server:BankWplac",resourceRoot,
function(ilosc)
	if not tonumber(ilosc) then return end
	if getPlayerMoney(client) >= ilosc then
	    if __isPlayerLogin[client] then
		    takePlayerMoney(client,ilosc)
			local playerBank = __bank.players[client]
			local draw = playerBank+ilosc
			__bank.players[client] = draw
			triggerClientEvent(client,"Client:BankUpdateGUI",client,{draw,getAccName(client)})
			outputChatBox("● INFO: Twój aktualny stan konta: "..draw.."$.",client,0,255,255)
			outputServerLog("* INFO: GRACZ ["..getPlayerName(client).."] WPLACIL ["..ilosc.."$] NA SWOJE KONTO W BANKU.")
		else
		    outputChatBox("● INFO: Aby wpłacić pieniądze do banku musisz być zalogowany.",client,255,0,0,true)
		end
	else
	    outputChatBox("● INFO: Nie masz tyle pieniędzy.",client,255,0,0,true)
	end
end)

addEvent("Server:BankWyplac",true)
addEventHandler("Server:BankWyplac",resourceRoot,
function(ilosc)
	if not tonumber(ilosc) then return end
	if __isPlayerLogin[client] then
		local account_id = getAccID(client)
		local playerBank = __bank.players[client]
		local draw = playerBank-ilosc
		if playerBank >= ilosc then
			__bank.players[client] = draw
			givePlayerMoney(client,ilosc)
			triggerClientEvent(client,"Client:BankUpdateGUI",client,{draw,getAccName(client)})
			outputChatBox("● INFO: Twój aktualny stan konta: "..draw.."$.",client,0,255,255)
			outputServerLog("* INFO: GRACZ ["..getPlayerName(client).."] WYPLACIL ["..ilosc.."$] Z BANKU.")
		end
	else
	    outputChatBox("● INFO: Aby wpłacić pieniądze do banku musisz być zalogowany.",client,255,0,0,true)
	end
end)

addEvent("Server:BankWyplacAll",true)
addEventHandler("Server:BankWyplacAll",resourceRoot,
function(ilosc)
	if not tonumber(ilosc) then return end
	if __isPlayerLogin[client] then
		local account_id = getAccID(client)
		local playerBank = __bank.players[client]
		if playerBank then
		    givePlayerMoney(client,playerBank)
			__bank.players[client] = 0
			triggerClientEvent(client,"Client:BankUpdateGUI",client,{0,getAccName(client)})
			outputChatBox("● INFO: Twój aktualny stan konta: 0$.",client,0,255,255)
			outputServerLog("* INFO: GRACZ ["..getPlayerName(client).."] WYPLACIL WSZYSTKIE OSZCZEDNOSCI [W SUMIE "..playerBank.."$] Z BANKU.")
		end
	else
	    outputChatBox("● INFO: Aby wpłacić pieniądze do banku musisz być zalogowany.",client,255,0,0,true)
	end
end)

addEvent("Server:BankRob",true)
addEventHandler("Server:BankRob",resourceRoot,
function(number)
	if __isPlayerLogin[client] then
	    if number == 1 then
	    	local nagroda = math.random(30000,150000)
			givePlayerMoney(client,nagroda)
			outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] napadł na bank i wyznaczono za niego nagrodę ["..nagroda.."$].",root,255,0,0,true)
			if not playerAward[client] then
				playerAward[client] = tonumber(nagroda)
			else
				playerAward[client] = tonumber(playerAward[client]) + tonumber(nagroda)
			end
		end
		if number == 2 then
		    outputChatBox("● INFO: Bank jest pusty.",client,255,0,0,true)
		end
		if number == 3 then
		    outputChatBox("● INFO: Gracz ["..getPlayerName(client).."] napadł na bank i został zabity przez ochronę.",root,255,0,0,true)
			killPed(client,client)
		end
	else
	    
	end
end)