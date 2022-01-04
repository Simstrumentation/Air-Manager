--[[
******************************************************************************************
******************* MOONEY M20R OVATION (CARENADO) MASTER SWITCHES ***********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Master battery, alternator and radio (avionics) switches for the Mooney M20R
  
NOTES:
    
    - Use user properties to show or hide screws 
  
V1.0 - Released 2022-01-03
           
KNOWN ISSUES:
    - None

******************************************************************************************
--]]

--USER PROPERTIES
screws_on = user_prop_add_enum("Show Screws","Yes, No","Yes","Select whether you want to see the srews around the switches or not")     -- default is to show screws

--STATIC GRAPHICS
--Screws - only show if user property selected to "Yes"
if user_prop_get(screws_on) == "Yes" then
    --top row
    img_add("screw.png", 60, 1, 30, 30)
    img_add("screw.png", 220, 1, 30, 30)
    img_add("screw.png", 380, 1, 30, 30)
    --bottom row
    img_add("screw.png", 60, 308, 30, 30)
    img_add("screw.png", 220, 308, 30, 30)
    img_add("screw.png", 380, 308, 30, 30)
end

--SWITCHES
--Master 
function master_cb()
    fs2020_event("TOGGLE_MASTER_BATTERY")
end
master_id = switch_add("master_off.png", "master_on.png", 0, 40, 160, 262, master_cb)

function new_master_pos(master)
    switch_set_position(master_id, master)      
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool", new_master_pos)

--Alternator 
function alt_cb()
    fs2020_event("TOGGLE_MASTER_ALTERNATOR")
end
alt_id = switch_add("alt_off.png", "alt_on.png", 160, 40, 160, 262, alt_cb)

function new_alt_pos(alt)
    switch_set_position(alt_id, alt)      
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1", "Bool", new_alt_pos)

--Radio Master
function radio_cb()
    fs2020_event("TOGGLE_AVIONICS_MASTER")
end
radio_id = switch_add("radio_off.png", "radio_on.png", 320, 40, 160, 262, radio_cb)

function new_radio_pos(radio)
    switch_set_position(radio_id, radio)      
end
fs2020_variable_subscribe("AVIONICS MASTER SWITCH", "Bool", new_radio_pos)