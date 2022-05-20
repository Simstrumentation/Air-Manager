--[[
--******************************************************************************************
-- ********************** Cessna 310R Heat and Cabin Air (Milviz)*************************
--******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
    Heat and cabin air panel for Cessna 130R
    
    NOTE:
        Will only work with Milviz C130
    
    V1.01 - Released 2022-05-20
        - fixed choppy movement of the dials
    V1.0 - Released 2022-05-07

    KNOWN ISSUES:
    - None
   --******************************************************************************************
--]]

--local variables
local defrost_percent
local temp_percent
local cabin_percent
local fwd_cabin_percent

--background image
img_add_fullscreen("bg.png")

--heat / fan switch
function heat_switch_cb(position, direction)
    new_pos = position - direction
    fs2020_variable_write("L:C310_SW_HEATER", "Enum", new_pos)
end
heat_id = switch_add ( "sm_sw_up.png", "sm_sw_c.png", "sm_sw_mid.png", 512, 58, 68, 68, heat_switch_cb)

function heat_pos(pos)
    switch_set_position(heat_id, pos)
end
fs2020_variable_subscribe("L:C310_SW_HEATER", "Enum", heat_pos)
 
--Overheat indicator

function overheat_cb()  
    fs2020_variable_write("L:C310_Overheat_Test", "Number", 1)
end

function overheat_release_cb()
    fs2020_variable_write("L:C310_Overheat_Test", "Number", 0)
end
overheat_id = button_add("overheat.png", "overheat_on.png", 656, 58, 64, 64, overheat_cb, overheat_release_cb)
overheat_on = img_add("overheat_on.png", 656, 58, 64, 64, "visible:false")

function overheat_set(overheat)
    if overheat == 1 then
        visible(overheat_on, true)
    else
        visible(overheat_on, false)
    end
end
fs2020_variable_subscribe("L:C310_WL_Overheat", "Number", overheat_set)

-- defrost
function defrost_cb(direction)
    if direction == 1 then
        if defrost_percent < 100.0 then
            defrost_percent = defrost_percent + 5
        end
    else
        if defrost_percent > 0.0 then
            defrost_percent = defrost_percent - 5
        end
    end 
    fs2020_variable_write("L:C310_SW_DEFROST", "Number", var_round(defrost_percent, 1))
    request_callback(defrost_dial(defrost_percent))
end
defrost_id = dial_add(nil, 42, 250, 148, 148, defrost_cb)

defrost_image = img_add("triangle_knob.png", 42, 250, 148, 148)

function defrost_dial(defrost_dial)
    defrost_percent = defrost_dial
    rotate(defrost_image, (defrost_dial * 2.75), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:C310_SW_DEFROST", "Number", defrost_dial)

--temp control
function temp_cb(direction)
    if direction == 1 then
        if temp_percent < 100.0 then
            temp_percent = temp_percent + 5
        end
    else
        if temp_percent > 0.0 then
            temp_percent = temp_percent - 5
        end
    end 
    fs2020_variable_write("L:C310_SW_TEMP_CONTROL", "Number", var_round(temp_percent, 1))
    request_callback(temp_dial(temp_percent))
end
temp_id = dial_add(nil, 222, 250, 148, 148, temp_cb)
temp_image = img_add("triangle_knob.png", 222, 250, 148, 148)

function temp_dial(temp_dial)
    temp_percent = temp_dial
    rotate(temp_image, (temp_dial * 2.75), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:C310_SW_TEMP_CONTROL", "Number", temp_dial)

--cabin air
function cabin_cb(direction)
    if direction == 1 then
        if cabin_percent < 100.0 then
            cabin_percent = cabin_percent + 5
        end
    else
        if cabin_percent > 0.0 then
            cabin_percent = cabin_percent - 5
        end
    end 
    fs2020_variable_write("L:C310_SW_CABIN_AIR", "Number", var_round(cabin_percent, 1))
    request_callback(cabin_dial(cabin_percent))
end
cabin_id = dial_add(nil, 402, 250, 148, 148, cabin_cb)
cabin_image = img_add("triangle_knob.png", 402, 250, 148, 148)

function cabin_dial(cabin_dial)
    cabin_percent = cabin_dial
    rotate(cabin_image, (cabin_dial * 2.75), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:C310_SW_CABIN_AIR", "Number", cabin_dial)

--Forward cabin air
function fwd_cabin_cb(direction)
    if direction == 1 then
        if fwd_cabin_percent < 100.0 then
            fwd_cabin_percent = fwd_cabin_percent + 5
        end
    else
        if fwd_cabin_percent > 0.0 then
            fwd_cabin_percent = fwd_cabin_percent - 5
        end
    end 
    fs2020_variable_write("L:C310_SW_FWD_CABIN_AIR", "Number", var_round(fwd_cabin_percent, 1))
    request_callback(fwd_cabin_dial(fwd_cabin_percent))
end
fwd_fwd_cabin_id = dial_add("triangle_knob.png", 582, 250, 148, 148, fwd_cabin_cb)
fwd_cabin_image = img_add("triangle_knob.png", 582, 250, 148, 148)

function fwd_cabin_dial(fwd_cabin_dial)
    fwd_cabin_percent = fwd_cabin_dial
    rotate(fwd_cabin_image, (fwd_cabin_dial * 2.75), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:C310_SW_FWD_CABIN_AIR", "Number", fwd_cabin_dial)