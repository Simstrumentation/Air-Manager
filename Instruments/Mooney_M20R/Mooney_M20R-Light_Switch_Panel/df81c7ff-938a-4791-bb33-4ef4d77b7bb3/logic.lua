--[[
******************************************************************************************
******************** MOONEY M20R OVATION (CARENADO) LIGHT SWITCHES ***********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    External light switches for the Mooney M20R
  
NOTES:
    - None
      
V1.0 - Released 2022-01-04
           
KNOWN ISSUES:
    - None

******************************************************************************************
--]]

--STATIC GRAPHICS

--background
img_add_fullscreen("bg.png")

--SWITCHES

--strobe
function strobe_cb()
    fs2020_event("STROBES_TOGGLE")
end
strobe_id = switch_add("strobe_off.png", "strobe_on.png", 110, 85, 61, 148, strobe_cb)

function new_strobe_pos(strobe)
    switch_set_position(strobe_id, strobe)
end 
fs2020_variable_subscribe("LIGHT STROBE ON", "Bool", new_strobe_pos)

--nav
function nav_cb()
    fs2020_event("TOGGLE_NAV_LIGHTS")
end
nav_id = switch_add("nav_off.png", "nav_on.png", 193, 85, 61, 148, nav_cb)

function new_nav_pos(nav)
    switch_set_position(nav_id, nav)
end 
fs2020_variable_subscribe("LIGHT NAV ON", "Bool", new_nav_pos)

--beacon
function beacon_cb()
    fs2020_event("TOGGLE_BEACON_LIGHTS")
end
beacon_id = switch_add("beacon_off.png", "beacon_on.png", 276, 85, 61, 148, beacon_cb)

function new_beacon_pos(beacon)
    switch_set_position(beacon_id, beacon)
end 
fs2020_variable_subscribe("LIGHT BEACON", "Bool", new_beacon_pos)


--Recog
function recog_cb()
    fs2020_event("TOGGLE_RECOGNITION_LIGHTS")
end
recog_id = switch_add("recog_off.png", "recog_on.png", 358, 85, 61, 148, recog_cb)

function new_recog_pos(recog)
    switch_set_position(recog_id, recog)
end 
fs2020_variable_subscribe("LIGHT RECOGNITION", "Bool", new_recog_pos)


--Taxi L
function taxi_l_cb()
    fs2020_event("TOGGLE_TAXI_LIGHTS")
end
taxi_l_id = switch_add("taxi_l_off.png", "taxi_l_on.png", 446, 85, 31, 148, taxi_l_cb)

function new_taxi_l_pos(taxi_l)
    switch_set_position(taxi_l_id, taxi_l)
end 
fs2020_variable_subscribe("LIGHT TAXI", "Bool", new_taxi_l_pos)

--Taxi R
function taxi_r_cb()
    fs2020_event("TOGGLE_TAXI_LIGHTS")
end
taxi_r_id = switch_add("taxi_r_off.png", "taxi_r_on.png", 477, 85, 31, 148, taxi_r_cb)

function new_taxi_r_pos(taxi_r)
    switch_set_position(taxi_r_id, taxi_r)
end 
fs2020_variable_subscribe("LIGHT TAXI", "Bool", new_taxi_r_pos)


--landing L
function landing_l_cb()
    fs2020_event("LANDING_LIGHTS_TOGGLE")
end
landing_l_id = switch_add("landing_l_off.png", "landing_l_on.png", 540, 85, 31, 148, landing_l_cb)

function new_landing_l_pos(landing_l)
    switch_set_position(landing_l_id, landing_l)
end 
fs2020_variable_subscribe("LIGHT LANDING", "Bool", new_landing_l_pos)

--landing R
function landing_r_cb()
    fs2020_event("LANDING_LIGHTS_TOGGLE")
end
landing_r_id = switch_add("landing_r_off.png", "landing_r_on.png", 571, 85, 31, 148, landing_r_cb)

function new_landing_r_pos(landing_r)
    switch_set_position(landing_r_id, landing_r)
end 
fs2020_variable_subscribe("LIGHT LANDING", "Bool", new_landing_r_pos)

