--[[
******************************************************************************************
-- ********************** CIRRUS SR22 MAIN SWITCH PANEL **************************
******************************************************************************************
    Made by SIMSTRUMENTATION  with code contribution by IronCropTop for light dials
     
    "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
    Switch panel for Asobo Cirrus SR22

- **v1.0** (2022-05-20)
    
    
KNOWN ISSUES:
- None

]]--

--local variables
local inst_light_dim_pct 
local panel_light_dim_pct 
local ohd_light_dim_pct 

--Background image
img_add_fullscreen("bg.png")

--Battery 2

function bat2_cb()
    fs2020_event("K:TOGGLE_MASTER_BATTERY", 2)
end
bat2_id = switch_add("tog_off.png", "tog_on.png", 36,50, 50, 100, bat2_cb) 

function  new_bat2_pos(batt2)    
    switch_set_position(bat2_id , batt2)
end

fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:2", "Bool", new_bat2_pos)

-- Battery 1
function bat1_cb()
    fs2020_event("K:TOGGLE_MASTER_BATTERY", 1)
end
bat1_id = switch_add("tog_off.png", "tog_on.png", 93,50, 50, 100, bat1_cb) 

function  new_bat1_pos(batt1)
    switch_set_position(bat1_id , batt1)
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:1", "Bool", new_bat1_pos)


--Alt 1

function alt1_cb()
    fs2020_event("TOGGLE_ALTERNATOR1")
end

alt1_id = switch_add("tog_off.png", "tog_on.png", 144,50, 50, 100, alt1_cb) 

function new_alt1_pos(alt1)
    switch_set_position(alt1_id , alt1)
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1", "BOOL", new_alt1_pos)

--Alt 2
function alt2_cb()
    fs2020_event("TOGGLE_ALTERNATOR2")
end

alt2_id = switch_add("tog_off.png", "tog_on.png", 200,50, 50, 100, alt2_cb) 

function new_alt2_pos(alt2)
    switch_set_position(alt2_id , alt2)
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:2", "BOOL", new_alt2_pos)

--Avionics
function av_cb()
    fs2020_event("TOGGLE_AVIONICS_MASTER")
end

av_id = switch_add("tog_off.png", "tog_on.png", 258,50, 50, 100, av_cb) 

function new_av_pos(av)
    switch_set_position(av_id , av)
end

fs2020_variable_subscribe("AVIONICS MASTER SWITCH:1", "BOOL", new_av_pos)


--Ice Toggle
function ice_cb()
    fs2020_event("TOGGLE_STRUCTURAL_DEICE")
end

ice_id = switch_add("tog_off.png", "tog_on.png", 342,50, 50, 100, ice_cb) 

function new_ice_pos(ice)
    switch_set_position(ice_id , ice)
end

fs2020_variable_subscribe("STRUCTURAL DEICE SWITCH", "BOOL", new_ice_pos)

--Ice power
function icep_cb()
    --INOP
end

icep_id = switch_add("tog_off.png", "tog_on.png", 392,50, 50, 100, icep_cb) 

--Pitot
function pitot_cb()
    fs2020_event("PITOT_HEAT_TOGGLE")
end

pitot_id = switch_add("tog_off.png", "tog_on.png", 456,50, 50, 100, pitot_cb) 

function new_pitot_pos(pitot)
    switch_set_position(pitot_id , pitot)
end
fs2020_variable_subscribe("PITOT HEAT", "BOOL", new_pitot_pos)

--LIGHTS

--Nav
function nav_cb()
    fs2020_event("TOGGLE_NAV_LIGHTS")
end

nav_id = switch_add("tog_off.png", "tog_on.png", 526,50, 50, 100, nav_cb)

function new_nav_pos(nav)
    switch_set_position(nav_id, nav)
end

fs2020_variable_subscribe("LIGHT NAV", "BOOL", new_nav_pos)

 --Strobe
function strobe_cb()
    fs2020_event("STROBES_TOGGLE")
end

strobe_id = switch_add("tog_off.png", "tog_on.png", 576,50, 50, 100, strobe_cb)  

function new_strobe_pos(strobe)
    switch_set_position(strobe_id, strobe)
end
fs2020_variable_subscribe("LIGHT STROBE", "BOOL", new_strobe_pos)

 --Landing Light
function ldg_cb()
    fs2020_event("LANDING_LIGHTS_TOGGLE")
end

ldg_id = switch_add("tog_off.png", "tog_on.png", 626,50, 50, 100, ldg_cb)  

function new_land_pos(land)
    switch_set_position(ldg_id, land)
end

fs2020_variable_subscribe("LIGHT LANDING", "BOOL", new_land_pos)


--Instrument Dial

function set_inst_lights(direction)
      if direction == 1 then
        if inst_light_dim_pct < 100.0 then
            inst_light_dim_pct = inst_light_dim_pct + 5
        end
    else
        if inst_light_dim_pct > 0.0 then
            inst_light_dim_pct = inst_light_dim_pct - 5
        end
    end
    fs2020_event("K:PANEL_LIGHTS_POWER_SETTING_SET", 1, var_round(inst_light_dim_pct,1))
    request_callback(inst_dial_change(inst_light_dim_pct))
end

inst_dial_image = img_add("light_knob.png", 736, 60, 75, 75)
inst_dial = dial_add(nil, 736, 60, 75, 75, set_inst_lights)

function inst_dial_change(inst_dial)
    inst_light_dim_pct = inst_dial
    rotate(inst_dial_image, (inst_dial * 2.5) - 40, "LINEAR", 0.04)
end

fs2020_variable_subscribe("A:LIGHT PANEL POWER SETTING:1", "PERCENT", inst_dial_change)

--Panel / Glareshield Dial

function set_panel_lights(direction)
      if direction == 1 then
        if panel_light_dim_pct < 100.0 then
            panel_light_dim_pct = panel_light_dim_pct + 5
        end
    else
        if panel_light_dim_pct > 0.0 then
            panel_light_dim_pct = panel_light_dim_pct - 5
        end
    end

    fs2020_event("K:GLARESHIELD_LIGHTS_POWER_SETTING_SET", 1, var_round(panel_light_dim_pct,1))
    request_callback(panel_dial_change(panel_light_dim_pct))
end

panel_dial = dial_add(nil, 832, 60, 75, 75, set_panel_lights)
panel_dial_image = img_add("light_knob.png", 832, 60, 75, 75)

function panel_dial_change(pan_dial)
    panel_light_dim_pct = pan_dial
    rotate(panel_dial_image, (pan_dial * 2.5) - 40, "LINEAR", 0.04)
end

fs2020_variable_subscribe("A:LIGHT GLARESHIELD POWER SETTING:1", "PERCENT", panel_dial_change)

--overhead dial

function set_ohd_lights(direction)
      if direction == 1 then
        if ohd_light_dim_pct < 100.0 then
            ohd_light_dim_pct = ohd_light_dim_pct + 5
        end
    else
        if ohd_light_dim_pct > 0.0 then
            ohd_light_dim_pct = ohd_light_dim_pct - 5
        end
    end
    fs2020_event("K:CABIN_LIGHTS_POWER_SETTING_SET", 5, var_round(ohd_light_dim_pct,1))
    
    request_callback(ohd_dial_change(ohd_light_dim_pct))
end
ovh_dial = dial_add("light_knob.png", 936, 60, 75, 75, set_ohd_lights)
ohd_dial_image = img_add("light_knob.png", 936, 60, 75, 75)

function ohd_dial_change(ohd_dial)
    ohd_light_dim_pct = ohd_dial
    rotate(ohd_dial_image, (ohd_dial * 2.5) - 40, "LINEAR", 0.04)
end
fs2020_variable_subscribe("A:LIGHT CABIN POWER SETTING:5", "PERCENT", ohd_dial_change)