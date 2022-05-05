--[[
--******************************************************************************************
--******************* Cessna 310R Electrical and Starter Switch Panel*********************
--******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
    Main electrical and engine starter switch panel
    
    NOTE:
        Will only work with Milviz C130
    
    V1.0 - Released 2022-05-05

    KNOWN ISSUES:
    - None
   --******************************************************************************************
--]]

--local variables
local l_pump
local r_pump
--background image
img_add_fullscreen("bg.png")

--l aux pump

function pump_l_cb(position, direction)
    new_pos = position + direction
    fs2020_variable_write("L:C310_SW_FUEL_PUMP_LEFT", "Enum", new_pos)
end

pump_l_id = switch_add("lg_switch_up.png", "lg_switch_mid.png", "lg_switch_dn.png", 9, 20, 80, 151, pump_l_cb)

function l_pump_cb(pos)
    switch_set_position(pump_l_id, pos)
    l_pump = pos
end

fs2020_variable_subscribe("L:C310_SW_FUEL_PUMP_LEFT", "Enum", l_pump_cb)

-- r aux pump
function pump_r_cb(position, direction)
    new_pos = position + direction
    fs2020_variable_write("L:C310_SW_FUEL_PUMP_RIGHT", "Enum", new_pos)
end

pump_r_id = switch_add("lg_switch_up.png", "lg_switch_mid.png", "lg_switch_dn.png", 108, 20, 80, 151, pump_r_cb)

function r_pump_cb(pos)
    switch_set_position(pump_r_id, pos)
    r_pump = pos
end

fs2020_variable_subscribe("L:C310_SW_FUEL_PUMP_RIGHT", "Enum", r_pump_cb)

--primer 
function primer_cb(position, direction)
    new_pos = position + direction
    fs2020_variable_write("L:C310_SW_PRIMER", "Enum", new_pos)
end

primer_id = switch_add("sm_sw_l.png", "sm_sw_c.png", "sm_sw_r.png",  288, 60, 80, 81, primer_cb)

function set_primer(pos)
    switch_set_position(primer_id, pos)
end

fs2020_variable_subscribe("L:C310_SW_PRIMER", "Enum", set_primer)


--Starter L
function start_l_press_cb()
    fs2020_event("SET_STARTER1_HELD")
end
function start_l_release_cb()
    fs2020_event("TOGGLE_STARTER1")
end
start_l_id = button_add("start_up.png", "start_dn.png", 188, 50, 88, 88, start_l_press_cb, start_l_release_cb)

--Starter R
function start_r_press_cb()
    fs2020_event("SET_STARTER2_HELD")
end
function start_r_release_cb()
    fs2020_event("TOGGLE_STARTER2")
end
start_r_id = button_add("start_up.png", "start_dn.png", 384, 50, 88, 88, start_r_press_cb, start_r_release_cb)

-- Alt L
function alt_l_cb()
    fs2020_event("TOGGLE_ALTERNATOR1")
end

alt_l_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 486, 60, 80, 81, alt_l_cb)

function set_alt_l(pos)
    switch_set_position(alt_l_id, pos)
end
fs2020_variable_subscribe("L:C310_SW_ALTERNATOR_LEFT", "Number", set_alt_l)

--Master battery
function master_cb()
    fs2020_event("TOGGLE_MASTER_BATTERY")
end
master_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 574, 60, 80, 81, master_cb)
function set_master(pos)
    switch_set_position(master_id, pos)
end

fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool", set_master)


--Alt R
function alt_r_cb()
    fs2020_event("TOGGLE_ALTERNATOR2")
end
alt_r_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 666, 60, 80, 81, alt_r_cb)

function set_alt_r(pos)
    switch_set_position(alt_r_id, pos)
end
fs2020_variable_subscribe("L:C310_SW_ALTERNATOR_RIGHT", "Number", set_alt_r)

--Magneto L eng L
function mag_l_l_cb()
    fs2020_event("MAGNETO1_LEFT")   
end
mag_l_l_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 790, 60, 80, 81, mag_l_l_cb)

function set_mag_l_l(pos)
    switch_set_position(mag_l_l_id, pos)
end 

fs2020_variable_subscribe("L:C310_SW_MAG_LEFT_1", "Number", set_mag_l_l)

--Magneto L eng R
function mag_l_r_cb()
    fs2020_event("MAGNETO1_RIGHT")   
end    
mag_l_r_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 876, 60, 80, 81, mag_l_r_cb)

function set_mag_l_r(pos)
    switch_set_position(mag_l_r_id, pos)
end 

fs2020_variable_subscribe("L:C310_SW_MAG_RIGHT_1", "Number", set_mag_l_r)


--Magneto R eng L
function mag_r_l_cb()
    fs2020_event("MAGNETO2_LEFT")   
end    
mag_r_l_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 970, 60, 80, 81, mag_r_l_cb)

function set_mag_r_l(pos)
    switch_set_position(mag_r_l_id, pos)
end 

fs2020_variable_subscribe("L:C310_SW_MAG_LEFT_2", "Number", set_mag_r_l)

--Magneto R eng R
function  mag_r_r_cb()
    fs2020_event("MAGNETO2_RIGHT")   
end
mag_r_r_id = switch_add("sm_sw_mid.png", "sm_sw_up.png", 1058, 60, 80, 81, mag_r_r_cb)

function set_mag_r_r(pos)
    switch_set_position(mag_r_r_id, pos)
end 

fs2020_variable_subscribe("L:C310_SW_MAG_RIGHT_2", "Number", set_mag_r_r)
