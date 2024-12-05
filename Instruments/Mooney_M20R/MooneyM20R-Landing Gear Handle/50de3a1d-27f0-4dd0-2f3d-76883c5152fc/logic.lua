--[[
Landing gear handle for Carenado Mooney M20R
Based on original code from Sim Innovations

Modified code and graphics by Joe "Crunchmeister" Gilker
]]--
-- User property to show or hide background

showBG = user_prop_add_boolean("Display Background", true, "Display grey background for gear lever") -- Show or hide the unit type onscreen
local bg = user_prop_get(showBG)

-- Add images

if bg  then        -- show or hide grey background depending on user property
   img_add_fullscreen("backdrop.png")
end

img_add_fullscreen("bg.png")

-- Functions 

function gear_switch(state, direction)
      msfs_event( fif(state == 0, "GEAR_DOWN", "GEAR_UP") )
end

function new_gear_deploy(deployratio, handle, bus_volts)
    
    local power = bus_volts[1] >= 5
    -- Check state of landing gear
    gear_total = deployratio[1] + deployratio[2] + deployratio[3]
    switch_set_position(gear_lever, handle)
 end

function gear_deploy_FS2020(center, left, right, handle, bus_volts)
   
    new_gear_deploy({left, center, right}, handle, {bus_volts})
end

-- Add main lever handle
gear_lever = switch_add("up.png", "down.png", 0, 0, 212, 614, gear_switch)

-- Bus subscription
msfs_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                          "GEAR LEFT POSITION", "Percent", 
                          "GEAR RIGHT POSITION", "Percent", 
                          "GEAR HANDLE POSITION", "Bool", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", gear_deploy_FS2020)	

