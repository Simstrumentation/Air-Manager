--[[
******************************************************************************************
****************CESSNA 414AW CHANCELLOR MAIN SWITCH PANEL******************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Primary switch panel with Master, magnetos, starter, lights, fuel pumps, and de-ice controls

Version info:
- **v1.0** Nov 2, 2022

NOTES: 
- Will only work with the FlySimWare Cessna 414AW Chancellor.

KNOWN ISSUES:
- None

ATTRIBUTION:
All code and graphics original work by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--DEFINE SOUNDS
fail_snd = sound_add("beepfail.wav")



--global variables
local battery_master
local alt_left
local alt_right
local taxi_light
local landing_light
local prop_deice
local heat_switch = 0
local stall_switch
local pump_l
local primer

    --background image
img_add_fullscreen("bg.png")

---MAGNETOS---

-- left engine

function cb_l_eng_l_mag()
    fs2020_event("MAGNETO1_LEFT")
    fs2020_variable_write("L:MAGNETO_BAR", "Enum", 1)
end
mag_1_l = switch_add("red_down.png", "red_up.png", 138, 40, 60, 113, cb_l_eng_l_mag)

function cb_l_eng_r_mag()
    fs2020_event("MAGNETO1_RIGHT")
    fs2020_variable_write("L:MAGNETO_BAR", "Enum", 1)
end
mag_1_r  = switch_add("red_down.png", "red_up.png", 238, 40, 60, 113, cb_l_eng_r_mag)

-- r engine

function cb_r_eng_l_mag()
    fs2020_event("MAGNETO2_LEFT") 
    fs2020_variable_write("L:MAGNETO_BAR", "Enum", 1)
end
mag_2_l  = switch_add("red_down.png", "red_up.png", 324, 40, 60, 113, cb_r_eng_l_mag)

function cb_r_eng_r_mag()
    fs2020_event("MAGNETO2_RIGHT") 
    fs2020_variable_write("L:MAGNETO_BAR", "Enum", 1)
end
mag_2_r = switch_add("red_down.png", "red_up.png", 430, 40, 60, 113, cb_r_eng_r_mag)

-- magnetos subscription and set switch states based on lvars

function cb_set_mag_states(l_l, l_r, r_l, r_r)
    switch_set_position(mag_1_l, l_l)
    switch_set_position(mag_1_r, l_r)
    switch_set_position(mag_2_l, r_l)
    switch_set_position(mag_2_r, r_r)
end
fs2020_variable_subscribe("RECIP ENG LEFT MAGNETO:1", "Bool",
                                             "RECIP ENG RIGHT MAGNETO:1", "Bool",
                                             "RECIP ENG LEFT MAGNETO:2", "Bool",
                                             "RECIP ENG RIGHT MAGNETO:2", "Bool",
                                             cb_set_mag_states)

---PUMPS AND STARTER---                                -
-- Aux Pump Left
function cb_pump_l(position, direction)
    newpos= position + direction
    fs2020_variable_write("L:GENERIC_Momentary_AUX_LEFT_PUMP_SWITCH", "Enum", newpos)
end
pump_l_switch = switch_add("green_down.png", "green_mid.png", "green_up.png", 84, 194, 54, 108, "VERTICAL", cb_pump_l)

function set_pump_l(left)
    pump_l = left
    switch_set_position(pump_l_switch, left)
end 
fs2020_variable_subscribe("L:GENERIC_Momentary_AUX_LEFT_PUMP_SWITCH", "Enum", set_pump_l)
-- End Aux Pump Left

-- Primer

local primerPosition

-- add graphics, show off state, hide on states
primer_off_id = img_add("white_hor_mid.png",  355, 204, 113, 90)
primer_l_id = img_add("white_hor_left.png",  355, 204, 113, 90)
visible(primer_l_id, false)
primer_r_id = img_add("white_hor_right.png",  355, 204, 113, 90)
visible(primer_r_id, false)

--create hotspots left and right of switch graphic to activate
function leftPrimePress()
    --fs2020_variable_write("L:GENERIC_Momentary_PRIMER_SWITCH", "ENUM", 0)
    sound_play(fail_snd)
end

function leftPrimeRelease()
    --fs2020_variable_write("L:GENERIC_Momentary_PRIMER_SWITCH", "ENUM", 1)
    sound_play(fail_snd)
end
primer_left_btn_id = button_add(nil, nil, 355, 204, 90, 45, leftPrimePress, leftPrimeRelease)

function rightPrimePress()
    --fs2020_variable_write("L:GENERIC_Momentary_PRIMER_SWITCH", "ENUM", 2)
    sound_play(fail_snd)
end

function leftPrimeRelease()
    --fs2020_variable_write("L:GENERIC_Momentary_PRIMER_SWITCH", "ENUM", 1)
    sound_play(fail_snd)
end
primer_right_btn_id = button_add(nil, nil, 395, 204, 90, 45, rightPrimePress, rightPrimeRelease)


-- animate switch position
function setSwitchState(position)
    primerPosition = position
    if primerPosition == 0 then    --left primer
        visible(primer_off_id, false)
        visible(primer_l_id, true)
        visible(primer_r_id, false)
    elseif primerPosition == 2 then    --right primer
        visible(primer_off_id, false)
        visible(primer_l_id, false)
        visible(primer_r_id, true)
    else    --primer off
        visible(primer_off_id, true)
        visible(primer_l_id, false)
        visible(primer_r_id, false)
    end
end
fs2020_variable_subscribe("L:GENERIC_Momentary_PRIMER_SWITCH", "ENUM", setSwitchState)
-- End Primer

-- Starter L
function cb_start_l()
    fs2020_variable_write("L:STARTER1", "Enum", 1)
    fs2020_variable_write("L:TOGGLE_STARTER1", "Enum", 1)
end

function cb_start_l_release()
    fs2020_variable_write("L:STARTER1", "Enum", 0)
    fs2020_variable_write("L:TOGGLE_STARTER1", "Enum", 0)
end
start_l_btn = button_add("start_up.png", "start_dn.png", 274, 205, 88, 88, cb_start_l, cb_start_l_release)
-- End Starter L

-- Starter R
function cb_start_r()
     fs2020_variable_write("L:STARTER2", "Enum", 1)
    fs2020_variable_write("L:TOGGLE_STARTER2", "Enum", 1)
end
function cb_start_r_release()
    fs2020_variable_write("L:STARTER2", "Enum", 0)
    fs2020_variable_write("L:TOGGLE_STARTER2", "Enum", 0)
end
start_r_btn = button_add("start_up.png", "start_dn.png", 484, 205, 88, 88, cb_start_r, cb_start_r_release)
-- End Starter R


-- Aux Pump Right
function cb_pump_r(position, direction)
    newpos= position + direction
    fs2020_variable_write("L:GENERIC_Momentary_AUX_RIGHT_PUMP_SWITCH", "Enum", newpos)
end
pump_r_switch = switch_add("green_down.png", "green_mid.png", "green_up.png", 201, 194, 54, 108, "VERTICAL", cb_pump_r)

function set_pump_r(right)
    pump_r = right
    switch_set_position(pump_r_switch, right)
end 
fs2020_variable_subscribe("L:GENERIC_Momentary_AUX_RIGHT_PUMP_SWITCH", "Enum", set_pump_r)
-- End Aux Pump Right


---END PUMPS AND STARTER---
---MASTER SWITCHES---
--Master Battery
function cb_master_battery()
    fs2020_variable_write("L:MASTER_BAR", "Enum", 1)
    if battery_master == 1 then
        fs2020_variable_write("L:ELECTRICAL_Switch_Battery_Master", "Enum", 0)
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",6,0)
    else
        fs2020_variable_write("L:ELECTRICAL_Switch_Battery_Master", "Enum", 1)
        fs2020_event("ELECTRICAL_BUS_TO_BUS_CONNECTION_TOGGLE",6,1)
    end
end
master_switch = switch_add("green_down.png", "green_up.png", 274, 330, 54, 108, cb_master_battery)

function cb_set_master_switch(master,bus)
    battery_master = master
    switch_set_position(master_switch, master)
end
fs2020_variable_subscribe("L:ELECTRICAL_Switch_Battery_Master", "Enum", 
                          "BUS_CONNECTION_ON:6", "Enum", cb_set_master_switch)
--End Master Battery

--Left Alternator
function cb_alt_left()
    fs2020_variable_write("L:MASTER_BAR", "Enum", 1)
    if alt_left == 1 then
        fs2020_event("TOGGLE_ALTERNATOR1")
        fs2020_variable_write("L:ALTERNATOR_LEFT", "Enum", 0)
    else
        fs2020_event("TOGGLE_ALTERNATOR1")
        fs2020_variable_write("L:ALTERNATOR_LEFT", "Enum", 1)
    end 
end
alt_left_switch = switch_add("green_down.png", "green_up.png", 124, 330, 54, 108, cb_alt_left)

function cb_set_alt_left(left,sim_left)
    alt_left = left
    switch_set_position(alt_left_switch, left)
end
fs2020_variable_subscribe("L:ALTERNATOR_LEFT", "Enum", cb_set_alt_left)
--End Left Alternator

--Right Alternator

function cb_alt_right()
    fs2020_variable_write("L:MASTER_BAR", "Enum", 1)
        if alt_right == 1 then
        fs2020_event("TOGGLE_ALTERNATOR2")
        fs2020_variable_write("L:ALTERNATOR_right", "Enum", 0)
    else
        fs2020_event("TOGGLE_ALTERNATOR2")
        fs2020_variable_write("L:ALTERNATOR_right", "Enum", 1)
    end
end
alt_right_switch = switch_add("green_down.png", "green_up.png", 426, 330, 54, 108, cb_alt_right)

function cb_set_alt_right(right)
    alt_right = right
    switch_set_position(alt_right_switch, right)
end
fs2020_variable_subscribe("L:ALTERNATOR_right", "Enum", cb_set_alt_right)
--End Right Alternator

---END MASTER SWITCHES---

---LIGHTS---
--Anti-Collision
function strobe_toggle()
    fs2020_event("STROBES_TOGGLE")
end
strobe_switch = switch_add("white_down.png", "white_up.png", 170, 510, 60, 113, strobe_toggle)
function cb_set_strobe(strobe)
    switch_set_position (strobe_switch, strobe)
end
fs2020_variable_subscribe("LIGHT STROBE", "Bool", cb_set_strobe)
--End Anti-Collision

--Nav
function nav_toggle()
    fs2020_event("TOGGLE_NAV_LIGHTS")
end

nav_switch = switch_add("white_down.png", "white_up.png", 274, 510, 60, 113, nav_toggle)
function cb_set_nav(nav)
    switch_set_position (nav_switch, nav)
end
fs2020_variable_subscribe("LIGHT NAV", "Bool", cb_set_nav)
--End Nav

--Taxi
function  taxi_toggle()
        fs2020_event("TOGGLE_TAXI_LIGHTS")
    if taxi_light == 0 then
        fs2020_variable_write("A:LIGHT_TAXI", "Enum",1)
        fs2020_variable_write("L:LIGHT_TAXI", "Enum",1)
    else
        fs2020_variable_write("A:LIGHT_TAXI", "Enum", 0)
        fs2020_variable_write("L:LIGHT_TAXI", "Enum",0)
    end
end
taxi_switch = switch_add("white_down.png", "white_up.png", 374, 510, 60, 113, taxi_toggle)
function cb_set_taxi(taxi, taxi2)
    taxi_light = taxi
    switch_set_position(taxi_switch, taxi)
end
fs2020_variable_subscribe("LIGHT TAXI", "Number", 
                            "CIRCUIT_CONNECTION_ON:34", "Number", cb_set_taxi)
--End Taxi

--Landing Light
function landing_toggle(position, direction)
    newpos= position + direction
    fs2020_variable_write("L:GENERIC_Momentary_LIGHT_SWITCH_LANDING_1", "Enum", newpos)
end
landing_switch = switch_add("white_down.png", "white_mid.png", "white_up.png", 474, 510, 60, 113, "VERTICAL", landing_toggle)

function cb_set_landing(landing)
    landing_light = landing
    switch_set_position(landing_switch, landing)
end
fs2020_variable_subscribe("L:GENERIC_Momentary_LIGHT_SWITCH_LANDING_1", "Enum", cb_set_landing)
--End Landing Light
---END LIGHTS---

---DE-ICE---
--Anti-Ice
local elect_deice
function deice_toggle(position, direction)
    newpos= position + direction
    fs2020_variable_write("L:GENERIC_Momentary_DEICE_ELECT", "Enum", newpos)
    if elect_deice == 1 then
        fs2020_event("WINDSHIELD_DEICE_ON")
    else
        fs2020_event("WINDSHIELD_DEICE_OFF")
    end
end

deice_switch = switch_add("green_down.png", "green_mid.png", "green_up.png", 170, 730, 54, 108, "VERTICAL", deice_toggle)
function cb_set_antiice(ice)
    elect_deice = ice
    switch_set_position(deice_switch, ice)
end
fs2020_variable_subscribe("L:GENERIC_Momentary_DEICE_ELECT", "Enum", cb_set_antiice)
--End Anti-Ice

--Prop Ice
function prop_toggle()
    if prop_deice == 0 then
        fs2020_variable_write("L:DEICE_PROP", "Enum", 1)
    else
        fs2020_variable_write("L:DEICE_PROP", "Enum", 0)
    end
end
prop_switch = switch_add("green_down.png", "green_up.png", 274, 730, 54, 108, prop_toggle)
function cb_set_prop(prop)
    prop_deice = prop
    switch_set_position(prop_switch, prop)
end
fs2020_variable_subscribe("L:DEICE_PROP", "Enum", cb_set_prop)
--End Prop Ice

--Ice Light
function light_toggle()
    fs2020_event("TOGGLE_WING_LIGHTS")
end
light_switch = switch_add("green_down.png", "green_up.png", 374, 730, 54, 108, light_toggle)

function cb_set_ice_light(light)
    switch_set_position(light_switch, light)
end 
fs2020_variable_subscribe("LIGHT WING", "Bool", cb_set_ice_light)
--End Ice Light

function surface_toggle(position, direction)

     if direction == 1 then
       fs2020_variable_write("L:GENERIC_Momentary_DEICE_SURFACE", "Enum", 2)
       fs2020_variable_write("L:STRUCTURAL_DEICE_MEMORY", "Enum", 1)     
     else
        fs2020_variable_write("L:GENERIC_Momentary_DEICE_SURFACE", "Enum", 0)
        fs2020_variable_write("L:STRUCTURAL_DEICE_MEMORY", "Enum", 0) 
        fs2020_variable_write("L:STRUCTURAL_DEICE_CYCLE", "Enum", 0) 
     end

        
     
end

surface_switch = switch_add("green_down.png", "green_mid.png", "green_up.png", 474, 730, 54, 108, "VERTICAL", surface_toggle)
function cb_set_surface(surface)
    switch_set_position(surface_switch, surface)
end
fs2020_variable_subscribe("L:GENERIC_Momentary_DEICE_SURFACE", "Enum", cb_set_surface)
---END DE-ICE---

---BOTTOM ROW---
--Cabin Fan
function fan_control(position, direction)
    newpos= position + direction
    fs2020_variable_write("L:GENERIC_Momentary_CABIN_FAN", "Enum", newpos)
end
fan_switch = switch_add("white_down.png", "white_mid.png", "white_up.png", 67, 910, 60, 113, "VERTICAL", fan_control)

function cb_fan_set(fan)
    switch_set_position(fan_switch, fan)
end
fs2020_variable_subscribe("L:GENERIC_Momentary_CABIN_FAN", "Enum", cb_fan_set)
--End Cabin Fan

--Cabin Heat
function fan_control()
    if heat_switch == 0 then
        fs2020_variable_write("L:CABIN_HEAT", "Number", 1)
    else
        fs2020_variable_write("L:CABIN_HEAT", "Number", 0)
    end
end
cabin_heat_switch = switch_add("white_down.png", "white_up.png", 167, 910, 60, 113, fan_control)

function cb_heat_set(heat)
    heat_switch = heat    
    switch_set_position(cabin_heat_switch, heat)
end
fs2020_variable_subscribe("L:CABIN_HEAT", "Number", cb_heat_set)
--End Cabin Heat

--Stall Heat
function stall_set()
  
    if stall_switch == 0 then
        fs2020_variable_write("L:STALL_VENT_HEAT", "Number", 1)
    else
        fs2020_variable_write("L:STALL_VENT_HEAT", "Number", 0)
    end
end
stall_vent_switch = switch_add("green_down.png", "green_up.png", 267, 910, 54, 108, stall_set)

function cb_stall_set(stall)
    stall_switch = stall
    switch_set_position(stall_vent_switch, stall)
end
fs2020_variable_subscribe("L:STALL_VENT_HEAT", "Enum", cb_stall_set)
-- End Stall Heat

--Pitot
function pitot_toggle()
    fs2020_event("PITOT_HEAT_TOGGLE")
end

pitot_switch = switch_add("green_down.png", "green_up.png", 367, 910, 54, 108, pitot_toggle)
function pitot_set(pitot)
    switch_set_position(pitot_switch, pitot)
end
fs2020_variable_subscribe("PITOT HEAT", "Bool", pitot_set)
--End Pitot
--Avionics
function avionics_toggle()
    fs2020_event("TOGGLE_AVIONICS_MASTER")        
end
avionics_switch = switch_add("white_down.png", "white_up.png", 467, 910, 60, 113, avionics_toggle)

function avionics_set(avionics)
    switch_set_position(avionics_switch, avionics)
end

fs2020_variable_subscribe("AVIONICS MASTER SWITCH", "Bool", avionics_set)
--End Avionics

---END BOTTOM ROW---