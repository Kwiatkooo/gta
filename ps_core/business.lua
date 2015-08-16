local businesses = {
    {
	    ["name"] = "Four Dragons",
		["pos"] = "2026.4136962891,996.92034912109,9.8203125",
		["cost"] = "215000",
		["payout"] = "10500",
	},
    {
	    ["name"] = "Stacja Paliw Xoomer",
		["pos"] = "2114.2014160156,898.37646484375,10.1796875",
		["cost"] = "21000",
		["payout"] = "2500",
	},
    {
	    ["name"] = "Tunning Las Venturas",
		["pos"] = "2398.6218261719,1041.5013427734,9.812986373901",
		["cost"] = "75000",
		["payout"] = "3000",
	},
    {
	    ["name"] = "Royal Casino",
		["pos"] = "2088.888671875,1448.3426513672,9.8203125",
		["cost"] = "52000",
		["payout"] = "2300",
	},
    {
	    ["name"] = "Starfish Casino",
		["pos"] = "2165.9060058594,1904.939453125,9.8125",
		["cost"] = "47000",
		["payout"] = "2100",
	},
    {
	    ["name"] = "Hotel The Visage",
		["pos"] = "2019.7470703125,1933.9196777344,11.335335731506",
		["cost"] = "145000",
		["payout"] = "11500",
	},
    {
	    ["name"] = "Biuro Turystyczne",
		["pos"] = "2086.6506347656,2066.4794921875,10.057899475098",
		["cost"] = "12500",
		["payout"] = "650",
	},
    {
	    ["name"] = "Emerald Isle",
		["pos"] = "2127.4836425781,2375.7053222656,9.8203125",
		["cost"] = "125000",
		["payout"] = "9200",
	},
    {
	    ["name"] = "Zakon",
		["pos"] = "1880.7941894531,2288.3464355469,9.979915618896",
		["cost"] = "27500",
		["payout"] = "1520",
	},
    {
	    ["name"] = "Pay'N'Spray",
		["pos"] = "1940.5552978516,2184.611328125,9.8203125",
		["cost"] = "22500",
		["payout"] = "1350",
	},
    {
	    ["name"] = "Stare Lotnisko",
		["pos"] = "415.28579711914,2531.365234375,18.16775894165",
		["cost"] = "375000",
		["payout"] = "29500",
	},
    {
	    ["name"] = "Lotnisko Las Venturas",
		["pos"] = "1676.7795410156,1448.3709716797,9.783477783203",
		["cost"] = "310000",
		["payout"] = "27500",
	},
    {
	    ["name"] = "Basen",
		["pos"] = "2559.8869628906,1561.7612304688,9.8203125",
		["cost"] = "51000",
		["payout"] = "2800",
	},
    {
	    ["name"] = "Chiński Parking",
		["pos"] = "2631.1057128906,1824.5709228516,10.0234375",
		["cost"] = "500000",
		["payout"] = "20105",
	},
    {
	    ["name"] = "Pizzeria",
		["pos"] = "2539.2922363281,2152.8852539063,9.8203125",
		["cost"] = "55000",
		["payout"] = "3100",
	},
    {
	    ["name"] = "Hotel Rock",
		["pos"] = "2638.6357421875,2348.2309570313,9.671875",
		["cost"] = "115000",
		["payout"] = "5800",
	},
    {
	    ["name"] = "Baza Wojskowa",
		["pos"] = "223.48114013672,1870.3372802734,12.140625",
		["cost"] = "2500000",
		["payout"] = "115000",
	},
}

bPayoutTime = 1

addEventHandler("onResourceStart",resourceRoot,
function()
	for i,b in pairs(businesses) do
		local pos = split(businesses[i]["pos"],",")
		businesses[i]["owner"] = "Na Sprzedaż"
		--businesses[i]["buy"] = true
		businesses[i]["marker"] = createMarker(pos[1],pos[2],pos[3],"cylinder",1.2,0,255,255,150,root)
		createMarker(pos[1],pos[2],pos[3],"cylinder",2.5,0,255,255,100,root)
		businesses[i]["blip"] = createBlipAttachedTo(businesses[i]["marker"],52,2,255,0,0,255,0,220.0,root)
		setElementInterior(businesses[i]["marker"],0)
		setElementDimension(businesses[i]["marker"],0)
		setElementData(businesses[i]["marker"],"bID",i)
		setElementData(businesses[i]["marker"],"bName",businesses[i]["name"])
		setElementData(businesses[i]["marker"],"bCost",businesses[i]["cost"])
		setElementData(businesses[i]["marker"],"bPayout",businesses[i]["payout"])
		setElementData(businesses[i]["marker"],"bOwner",businesses[i]["owner"])
		addEventHandler("onMarkerHit",businesses[i]["marker"],onBusinessMarkerHit)
		addEventHandler("onMarkerLeave",businesses[i]["marker"],onBusinessMarkerLeave)
	end
	--outputServerLog("*** [Business System]: Ilosc wczytanych biznesow: ["..#businesses.."] *** ")
end)

addEventHandler("onPlayerQuit",root,
function()
    for i,b in pairs(businesses) do
	    if (businesses[i]["owner"] == source) then
		    if businesses[i]["timer"] then
				--[[if isTimer(businesses[i]["timer"]) then
				    killTimer(businesses[i]["timer"])
					businesses[i]["timer"] = nil
				end]]
				businesses[i]["timer"] = nil
			end
		    businesses[i]["owner"] = "Na Sprzedaż"
			setElementData(businesses[i]["marker"],"bOwner","Na Sprzedaż")
			setBlipIcon(businesses[i]["blip"],52)
			--businesses[i]["buy"] = true
		end
	end
end)

function businessPayOut()
    bPlayersMoney = {}
    for i,b in pairs(businesses) do
	    if businesses[i]["owner"] ~= "Na Sprzedaż" then
            local bPlayer = businesses[i]["owner"]
			setElementData(businesses[i]["marker"],"bOwner",getPlayerName(businesses[i]["owner"]))
			if not bPlayersMoney[bPlayer] then
			    bPlayersMoney[bPlayer] = {}
			    bPlayersMoney[bPlayer] = tonumber(businesses[i]["payout"])
			else
			    bPlayersMoney[bPlayer] = bPlayersMoney[bPlayer] + tonumber(businesses[i]["payout"])
			end
        end		
	end
	for i,v in pairs(getElementsByType("player")) do
	    if bPlayersMoney[v] then
	        givePlayerMoney(v,bPlayersMoney[v])
		    outputChatBox("● INFO: Otrzymałeś(aś) "..bPlayersMoney[v].."$ ze wszystkich swoich biznesów.",v,0,255,255,true)
		end
	    if getPlayerIdleTime(v) > 3*60000 then
		    if not isPedDead(v) then
                if isPlayerPlayMiniGame(v) == true then serverMiniGameQuit(v) end
			end
		end
	end
end
setTimer(businessPayOut,bPayoutTime*60000,0)

function onBusinessMarkerHit(hitElement,matchingDimension)
    if not isElement(hitElement) then return end
	if getElementType(hitElement) == "vehicle" then return end
    if getElementHealth(hitElement) > 0 and matchingDimension then
	if tonumber(getElementData(hitElement,".LVL")) < 5 then triggerClientEvent(hitElement,"clientMsgBox",hitElement,"● Musisz osiągnąć co najmniej 5 Level, aby wykupić biznes.") return end
	--if tonumber(getElementData(hitElement,"Kills")) < 24 then triggerClientEvent(hitElement,"clientMsgBox",hitElement,"● Musisz posiadać na koncie co najmniej 25 zabójstw, aby wykupić biznes.") return end
	--[[
    	local bName = getElementData(source,"bName")
		local bCost = getElementData(source,"bCost")
		local bPayout = getElementData(source,"bPayout")
		local bOwner = getElementData(source,"bOwner")
	]]
		triggerClientEvent(hitElement,"onClientBusinessMarkerHit",hitElement,source)
	end
end

function onBusinessMarkerLeave(leftElement,matchingDimension)
    if not isElement(leftElement) then return end
	if matchingDimension then
        triggerClientEvent(leftElement,"onClientBusinessMarkerLeave",leftElement)
	end
end

addEvent("onPlayerBuyBusiness",true)
addEventHandler("onPlayerBuyBusiness",resourceRoot,
function(bMarker,bID)
    if businesses[bID]["owner"] == client then return end
    --if businesses[bID]["owner"] ~= client then
	    if businesses[bID]["timer"] then
			if getTickCount() - businesses[bID]["timer"] < 600000 then outputChatBox("● INFO: Nie możesz teraz odkupić tego biznesu, wróć za "..formatMilliseconds(math.floor((601000-(getTickCount() - businesses[bID]["timer"])))).."",client,255,0,0) return end
		end
    	--if businesses[bID]["buy"] == true then
			local bName = getElementData(bMarker,"bName")
			local bCost = tonumber(getElementData(bMarker,"bCost"))
			local bPayout = tonumber(getElementData(bMarker,"bPayout"))
			local bOwner = getElementData(bMarker,"bOwner")
    		if getPlayerMoney(client) > bCost or getPlayerMoney(client) == bCost then
	    		takePlayerMoney(client,bCost)
				if bOwner == "Na Sprzedaż" then
		    
				else
				    local g_Owner = getPlayerFromName(bOwner)
					if g_Owner then
						outputChatBox("● INFO: Gracz ["..getPlayerName(client).."], odkupił twój biznes ["..bName.."].",g_Owner,255,0,0,false)
						givePlayerMoney(g_Owner,bCost)
					end
				end
				setElementData(bMarker,"bOwner",getPlayerName(client))
				--businesses[bID]["buy"] = false
				--businesses[bID]["timer"] = setTimer(bEnableBuy,10*60000,1,bID)
				businesses[bID]["timer"] = getTickCount()
				businesses[bID]["owner"] = client
				triggerClientEvent(client,"onClientBuyBusiness",client)
				setBlipIcon(businesses[bID]["blip"],36)
				--outputChatBox("● INFO: Kupiłeś(aś) biznes za ["..bCost.."$], będziesz otrzymywał(a) co 1min. ["..bPayout.."$].",client,0,255,255,true)
				outputChatBox("● INFO: Kupiłeś(aś) "..businesses[bID]["name"]..".",client,0,255,255,true)
			else
	    		outputChatBox("● INFO: Nie posiadasz wystarczającej ilości pieniędzy.",client,255,0,0,true)
			end
		--else
		    --local remaining,executesRemaining,totalExecutes = getTimerDetails(businesses[bID]["timer"])
		    --outputChatBox("● INFO: Nie możesz teraz odkupić tego biznesu, wróć za ["..formatMilliseconds(remaining).."].",client,255,0,0,true)
		--end
	--end
end)

function formatMilliseconds(milliseconds)
    local totalseconds = math.floor(milliseconds/1000)
    milliseconds = milliseconds % 1000
    local seconds = totalseconds % 60
    local minutes = math.floor(totalseconds/60)
    local hours = math.floor(minutes/60)
    local days = math.floor(hours/24)
    minutes = minutes % 60
    hours = hours % 24
    return string.format("%02d:%02d",minutes,seconds)
end

--[[function bEnableBuy(business_id)
    businesses[business_id]["buy"] = true
	businesses[business_id]["timer"] = nil
end]]

addEvent("onPlayerSellBusiness",true)
addEventHandler("onPlayerSellBusiness",resourceRoot,
function(bMarker,bID)
	if businesses[bID]["owner"] == client then
		local bCost = tonumber(getElementData(bMarker,"bCost"))
		if bCost then
		    if businesses[bID]["timer"] then
			    --[[if isTimer(businesses[bID]["timer"]) then
				    killTimer(businesses[bID]["timer"])
					businesses[bID]["timer"] = nil
				end]]
				businesses[bID]["timer"] = nil
			end
			businesses[bID]["owner"] = "Na Sprzedaż"
			setBlipIcon(businesses[bID]["blip"],52)
			--businesses[bID]["buy"] = true
	    	setElementData(businesses[bID]["marker"],"bOwner","Na Sprzedaż")
			local newCost = zmniejszCene(bCost)
			if newCost then
	    		givePlayerMoney(client,newCost)
        		triggerClientEvent(client,"onClientBuyBusiness",client)
				outputChatBox("● INFO: Sprzedałeś(aś) biznes za "..newCost.."$",client,0,255,255,true)
			end
		end
	end
end)

function zmniejszCene(cena)
    local liczba = cena
	local nowaliczba = math.floor((liczba/1.5))
	return nowaliczba
end