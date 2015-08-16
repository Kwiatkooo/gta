local allowShoot = 0

function doAllowPlayerShoot(e)
	allowShoot = e
end

addEvent("Client:DestructionDerbyPreStart",true)
addEventHandler("Client:DestructionDerbyPreStart",localPlayer,
function()
	doAllowPlayerShoot(0)
end)

addEvent("Client:DestructionDerbyStart",true)
addEventHandler("Client:DestructionDerbyStart",localPlayer,
function()
	doAllowPlayerShoot(1)
end)

addEvent("Client:DestructionDerbyEnd",true)
addEventHandler("Client:DestructionDerbyEnd",localPlayer,
function()
	doAllowPlayerShoot(0)
end)

function doPlayerVehicleShoot()
	if allowShoot == 1 then
		if not isPedDead(localPlayer) then
			local t = getPlayerTeam(localPlayer)
			if t and getTeamName(t) == "Derby" then
				doAllowPlayerShoot(0)
				local v = getPedOccupiedVehicle(localPlayer)
				local x,y,z = getElementPosition(v)
				local rX,rY,rZ = getElementRotation(v)
				local x = x+4*math.cos(math.rad(rZ+90))
				local y = y+4*math.sin(math.rad(rZ+90))
				createProjectile(v,19,x,y,z+0.8,1.0,nil)
				setTimer(doAllowPlayerShoot,3000,1,1)
			end
		end
	end
end
bindKey("mouse1","down",doPlayerVehicleShoot)
bindKey("lctrl","down",doPlayerVehicleShoot)
bindKey("rctrl","down",doPlayerVehicleShoot)
bindKey("lalt","down",doPlayerVehicleShoot)
bindKey("ralt","down",doPlayerVehicleShoot)
bindKey("f","down",doPlayerVehicleShoot)

addEventHandler("onClientRender",root,
function()
	if allowShoot == 1 then
		if not getPlayerTeam(localPlayer) then return end
		local team = getTeamName(getPlayerTeam(localPlayer))
		if team == "Derby" then
			local v = getPedOccupiedVehicle(localPlayer)
			if v then
				dxDrawText("ABY STRZELAC Z POJAZDU NACISNIJ KLAWISZ FIRE/F/LALT/RALT/LCTRL/RCTRL",drawX*0.5,drawY*0.94,drawX*0.5,drawY*0.94,tocolor(255,0,0,222),0.6*drawX/1366,"bankgothic","center","center",false,false,false,false,false,0,0,0)
			end
		end
	end
end)