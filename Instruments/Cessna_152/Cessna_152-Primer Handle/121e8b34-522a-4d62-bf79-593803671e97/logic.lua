--[[
Fuel Shutoff Valve

Manual primer for C152  or any single engine carburated  planes. 

by Joe 'Crunchmeister' Gilker
]]--

function pump_primer()
        fs2020_event("ENGINE_PRIMER")
end

button_add("off.png","on.png", 0,0,542,543, pump_primer)