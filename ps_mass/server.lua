function showBox(str, player, r, g, b, t)
	if isElement(player) then
		triggerClientEvent(player, "showBox", root, str, r, g, b, t)
	end
end


function consoleCreateMarker ( playerSource )
	exports.ps_mass:showBox("testsahd", playerSource, 255, 255, 255, 10000)
	
end
-- Attach the 'consoleCreateMarker' function to the "createmarker" command
addCommandHandler ( "mass", consoleCreateMarker )
