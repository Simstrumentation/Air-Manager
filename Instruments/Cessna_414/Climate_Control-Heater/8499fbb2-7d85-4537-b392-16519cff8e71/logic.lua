--[[
******************************************************************************************
*************CESSNA 414AW CHANCELLOR CABIN HEAT CONTROLS*************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Cabin heat controls for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Will only work with the Flysimware Cessna 414 Chancellor

KNOWN ISSUES:
- None

ATTRIBUTION:
Original code and graphics by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]-- 


warning_prop = user_prop_add_boolean("Show heater warning text", true, "Hide or show warning message to save space")
text_color_prop = user_prop_add_enum("Text Color", "White, Black", "White", "You can choose a text color for labels")
hardware_type = user_prop_add_enum("Hardware Type", "Customized, Hard Coded", "Customized", "Select the type of hardware to use")
                                                    
local knob_width = 150
local second_row_y = 210 
local knob_spacing = 180
local cabinAir_text_y = 8
local top_text_y = 160
local below_top_text_y = 183
local pull_text_y = 36

local rotation_scalar = 2.75
                                                                              
local hExchDumpL_percent
local hExchDumpR_percent
local aircon_percent
local cabinHeatTemp_percent
local hExchTempL_percent
local hExchTempR_percent

local led_brightness = 0.3

local pullSize = 130
local pullY = 44
local pullX = 80
local pullDeltaX = knob_spacing -- space between pulls
local pullShadowOffsetX = pullSize * 1 / 30
local pullShadowOffsetY = pullSize * 1 / 30
local pullMoveOffsetX = -(pullSize * 2 / 30) -- amount to move animation sideways
local pullMoveOffsetY = (pullSize * 2 / 30) -- amount to move animation down
local pullShadowMoveOffsetX = 0 -- amount to move animation sideways
local pullShadowMoveOffsetY = 0 -- amount to move animation down
local shadowXgrow = 1.133 -- percent to grow shadow
local shadowYgrow = 1.0 -- don't grow shadow in Y
local pullXgrow = 1.1
local pullYgrow = 1.1

local defrostLeverPos
local aftLeverPos
local fwdLeverPos

local text_color = "#DDDDDDFF"
if user_prop_get(text_color_prop) == "White" then
    text_color = "#DDDDDDFF"
else
    text_color = "#020202FF"
end

canvas_vert_lines_id = canvas_add(0, 0, 780,400)
    canvas_draw(canvas_vert_lines_id, function()
        local x0 = 72
        local x1 = 242
        local x2 = 396
        local x3 = 570
        _move_to(x0, 60)
        _line_to(x0, 18)
        _line_to(x1, 18)
        _move_to(x2, 18)
        _line_to(x3, 18)
        _line_to(x3, 60)
        _stroke(text_color, 6)
        _stroke(text_color, 6)
            
        _translate(102,125)
        _scale(1.66,1.66)
        _arc(59, 100, 315,225, 51, false)
        _stroke(text_color, 4)
        _triangle(100, 60, 102, 72, 90,68)
        _fill(text_color)
            
        _translate(knob_spacing/1.66,0)
        _arc(59, 100, 315,225, 51, false)
        _stroke(text_color, 4)
        _triangle(100, 60, 102, 72, 90,68)
        _fill(text_color)
            
        _translate(knob_spacing/1.66,0)
        _arc(59, 100, 315,225, 51, false)
        _stroke(text_color, 4)
        _triangle(100, 60, 102, 72, 90,68)
        _fill(text_color)       
end)


local text_format_string = "font:MS33558.ttf; size:24; color:"..text_color.."; halign:center;"
local text_format_string_med = "font:MS33558.ttf; size:22; color:"..text_color.."; halign:center;"
local text_format_string_small = "font:MS33558.ttf; size:20; color:"..text_color.."; halign:center;"
local text_format_string_warning = "font:MS33558.ttf; size:18; color:"..text_color.."; halign:left;"
local x_set = 6

if user_prop_get(warning_prop) then
    local warning_initY = 148
    local warning_vertSpace = 20
    warning_text1 = txt_add("OPEN ONE", text_format_string_warning, x_set,warning_initY, 200, 25)
    warning_text2 = txt_add("CONTROL", text_format_string_warning, x_set,warning_initY + warning_vertSpace, 200, 25)
    warning_text3 = txt_add("MINIMUM FOR", text_format_string_warning, x_set,warning_initY + warning_vertSpace * 2, 200, 25)
    warning_text4 = txt_add("HEATER", text_format_string_warning, x_set,warning_initY + warning_vertSpace * 3, 200, 25)
    warning_text5 = txt_add("OPERATION", text_format_string_warning, x_set,warning_initY + warning_vertSpace * 4, 200, 25)
end
    
x_set = x_set +36

cabin_air_text = txt_add("CABIN AIR", text_format_string, x_set + knob_spacing,cabinAir_text_y, 200, 25)

defrost_text = txt_add("DEFROST", text_format_string_small, x_set,pull_text_y, 200, 25)
aft_text = txt_add("AFT", text_format_string_small, x_set + (1 * knob_spacing),pull_text_y, 200, 25)
fwd_text = txt_add("FWD", text_format_string_small, x_set + (2 * knob_spacing),pull_text_y, 200, 25)

x_set = x_set + 62

cabin_text = txt_add("CABIN", text_format_string_small, x_set,below_top_text_y - 18, 200, 25)
cabin_text = txt_add("HEAT", text_format_string_small, x_set,below_top_text_y, 200, 25)
cabin_press_air_text = txt_add("CABIN PRESS AIR", text_format_string_med, x_set + (1.5* knob_spacing) -50,top_text_y, 300, 25)
press_air_LH_text = txt_add("LH WARM", text_format_string_small, x_set + (1 * knob_spacing),below_top_text_y, 200, 25)
press_air_RH_text = txt_add("RH WARM", text_format_string_small, x_set + (2 * knob_spacing),below_top_text_y, 200, 25)

--DEFROST PULL
defrost_shadow_id = img_add("pull_shadow.png",pullX + pullShadowOffsetX, pullY + pullShadowOffsetY, pullSize, pullSize)
opacity(defrost_shadow_id, 0.5)
defrost_id = img_add("pull.png",pullX, pullY, pullSize, pullSize)

function toggleDefrost(dir)
print(defrostLeverPos)
    if defrostLeverPos == 1 then
        fs2020_variable_write("L:XMLVAR_CABIN_AIR_DEFROST_Position", "Number", 100)
    else
        fs2020_variable_write("L:XMLVAR_CABIN_AIR_DEFROST_Position", "Number", 0)    
    end
end

defrost_button_id = button_add(nil, nil, pullX, pullY, pullSize, pullSize, toggleDefrost)

function defrost_switch(pos)
    if pos > 50 then
        move(defrost_id, pullX + pullMoveOffsetX, pullY  + pullMoveOffsetY, pullSize * pullXgrow , pullSize * pullYgrow, "LINEAR", 0.1)
        move(defrost_shadow_id, pullX + pullShadowMoveOffsetX, pullY + pullShadowMoveOffsetY, pullSize * shadowXgrow, pullSize * shadowYgrow, "LINEAR", 0.1)
        opacity(defrost_shadow_id, 0.3, "LINEAR", 0.1)
        defrostLeverPos = 0
    else
        move(defrost_id, pullX, pullY, pullSize, pullSize, "LINEAR", 0.1)
        move(defrost_shadow_id, pullX + pullShadowOffsetX, pullY + pullShadowOffsetY, pullSize, pullSize, "LINEAR", 0.1)
        opacity(defrost_shadow_id, 0.5, "LINEAR", 0.1)
        defrostLeverPos = 1
    end
end

fs2020_variable_subscribe("L:XMLVAR_CABIN_AIR_DEFROST_Position", "Number", defrost_switch)

--AFT PULL

aft_shadow_id = img_add("pull_shadow.png",pullX + pullShadowOffsetX + (pullDeltaX * 1), pullY + pullShadowOffsetY, pullSize, pullSize)
opacity(aft_shadow_id, 0.5)
aft_id = img_add("pull.png",pullX + (pullDeltaX * 1), pullY, pullSize, pullSize)

function toggleAft(dir)
print(aftLeverPos)
    if aftLeverPos == 1 then
        fs2020_variable_write("L:XMLVAR_CABIN_AIR_AFT_Position", "Number", 100)
    else
        fs2020_variable_write("L:XMLVAR_CABIN_AIR_AFT_Position", "Number", 0)    
    end
end

aft_button_id = button_add(nil, nil, pullX + (pullDeltaX * 1), pullY, pullSize, pullSize, toggleAft)

function aft_switch(pos)
    if pos > 50 then
        move(aft_id, pullX + (pullDeltaX * 1) + pullMoveOffsetX, pullY  + pullMoveOffsetY, pullSize * pullXgrow , pullSize * pullYgrow, "LINEAR", 0.1)
        move(aft_shadow_id, pullX + (pullDeltaX * 1) + pullShadowMoveOffsetX, pullY + pullShadowMoveOffsetY, pullSize * shadowXgrow, pullSize * shadowYgrow, "LINEAR", 0.1)
        opacity(aft_shadow_id, 0.3, "LINEAR", 0.1)
        aftLeverPos = 0
    else
        move(aft_id, pullX + (pullDeltaX * 1), pullY, pullSize, pullSize, "LINEAR", 0.1)
        move(aft_shadow_id, pullX + pullShadowOffsetX + (pullDeltaX * 1), pullY + pullShadowOffsetY, pullSize, pullSize, "LINEAR", 0.1)
        opacity(aft_shadow_id, 0.5, "LINEAR", 0.1)
        aftLeverPos = 1
    end
end

fs2020_variable_subscribe("L:XMLVAR_CABIN_AIR_AFT_Position", "Number", aft_switch)

--FWD PULL

fwd_shadow_id = img_add("pull_shadow.png",pullX + pullShadowOffsetX + (pullDeltaX * 2), pullY + pullShadowOffsetY, pullSize, pullSize)
opacity(fwd_shadow_id, 0.5)
fwd_id = img_add("pull.png",pullX + (pullDeltaX * 2), pullY, pullSize, pullSize)

function toggleFwd(dir)
print(fwdLeverPos)
    if fwdLeverPos == 1 then
        fs2020_variable_write("L:XMLVAR_CABIN_AIR_FWD_Position", "Number", 100)
    else
        fs2020_variable_write("L:XMLVAR_CABIN_AIR_FWD_Position", "Number", 0)    
    end
end

fwd_button_id = button_add(nil, nil, pullX + (pullDeltaX * 2), pullY, pullSize, pullSize, toggleFwd)

function fwd_switch(pos)
    if pos > 50 then
        move(fwd_id, pullX + (pullDeltaX * 2) + pullMoveOffsetX, pullY  + pullMoveOffsetY, pullSize * pullXgrow , pullSize * pullYgrow, "LINEAR", 0.1)
        move(fwd_shadow_id, pullX + (pullDeltaX * 2) + pullShadowMoveOffsetX, pullY + pullShadowMoveOffsetY, pullSize * shadowXgrow, pullSize * shadowYgrow, "LINEAR", 0.1)
        opacity(fwd_shadow_id, 0.3, "LINEAR", 0.1)
        fwdLeverPos = 0
    else
        move(fwd_id, pullX + (pullDeltaX * 2), pullY, pullSize, pullSize, "LINEAR", 0.1)
        move(fwd_shadow_id, pullX + pullShadowOffsetX + (pullDeltaX * 2), pullY + pullShadowOffsetY, pullSize, pullSize, "LINEAR", 0.1)
        opacity(fwd_shadow_id, 0.5, "LINEAR", 0.1)
        fwdLeverPos = 1
    end
end

fs2020_variable_subscribe("L:XMLVAR_CABIN_AIR_FWD_Position", "Number", fwd_switch)


local xpos = 126
--START CABIN HEAT
function cabinHeatTemp_cb(direction)
    if direction == 1 then
        if cabinHeatTemp_percent < 100.0 then
            cabinHeatTemp_percent = cabinHeatTemp_percent + 5
        end
    else
        if cabinHeatTemp_percent > 0.0 then
            cabinHeatTemp_percent = cabinHeatTemp_percent - 5
        end
    end 
    fs2020_variable_write("L:XMLVAR_CABIN_AIR_HEAT_Position", "Number", var_round(cabinHeatTemp_percent, 1))
--    fs2020_variable_write("L:CLIMATE_HEATER_LOW_KNOB", "Number", var_round(cabinHeatTemp_percent, 1)*0.6)
--    fs2020_variable_write("L:CLIMATE_HEATER_HIGH_KNOB", "Number", var_round(cabinHeatTemp_percent, 1)*0.8)
    request_callback(cabinHeatTemp_dial(cabinHeatTemp_percent))
end
cabinHeatTemp_id = dial_add(nil, xpos, second_row_y, knob_width, knob_width, cabinHeatTemp_cb)
cabinHeatTemp_image = img_add("triangle_knob.png", xpos, second_row_y, knob_width, knob_width)

function cabinHeatTemp_dial(cabinHeatTemp_dial)
    cabinHeatTemp_percent = cabinHeatTemp_dial
    rotate(cabinHeatTemp_image, (cabinHeatTemp_dial * rotation_scalar), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:XMLVAR_CABIN_AIR_HEAT_Position", "NUMBER", cabinHeatTemp_dial)
--END CABIN HEAT

--START HEAT EXCHANGER TEMP CONTROLS

--H.E. Left Temp control
function hExchTempL_cb(direction)
    if direction == 1 then
        if hExchTempL_percent < 100.0 then
            hExchTempL_percent = hExchTempL_percent + 5
        end
    else
        if hExchTempL_percent > 0.0 then
            hExchTempL_percent = hExchTempL_percent - 5
        end
    end 
    fs2020_variable_write("L:XMLVAR_HEAT_EXCHANGER_HANDLE_LEFT_Position", "Number", var_round(hExchTempL_percent, 1))
--    fs2020_variable_write("L:CLIMATE_EXCHANGER_LEFT_KNOB", "Number", var_round(hExchTempL_percent, 1)*0.7)
    request_callback(hExchTempL_dial(hExchTempL_percent))
end
hExchTempL_id = dial_add(nil, xpos + (1*knob_spacing), second_row_y, knob_width, knob_width, hExchTempL_cb)
hExchTempL_image = img_add("triangle_knob.png", xpos + (1*knob_spacing), second_row_y, knob_width, knob_width)

function hExchTempL_dial(hExchTempL_dial)
    hExchTempL_percent = hExchTempL_dial
    rotate(hExchTempL_image, (hExchTempL_dial * rotation_scalar), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:XMLVAR_HEAT_EXCHANGER_HANDLE_LEFT_Position", "NUMBER", hExchTempL_dial)
                                            
--H.E. Right Temp control
function hExchTempR_cb(direction)
    if direction == 1 then
        if hExchTempR_percent < 100.0 then
            hExchTempR_percent = hExchTempR_percent + 5
        end
    else
        if hExchTempR_percent > 0.0 then
            hExchTempR_percent = hExchTempR_percent - 5
        end
    end 
    fs2020_variable_write("L:XMLVAR_HEAT_EXCHANGER_HANDLE_RIGHT_Position", "Number", var_round(hExchTempR_percent, 1))
    --fs2020_variable_write("L:CLIMATE_EXCHANGER_RIGHT_KNOB", "Number", var_round(hExchTempR_percent, 1)*0.7)
    request_callback(hExchTempR_dial(hExchTempR_percent))
end
hExchTempR_id = dial_add(nil, xpos + (2*knob_spacing), second_row_y, knob_width, knob_width, hExchTempR_cb)
hExchTempR_image = img_add("triangle_knob.png", xpos + (2*knob_spacing), second_row_y, knob_width, knob_width)

function hExchTempR_dial(hExchTempR_dial)
    hExchTempR_percent = hExchTempR_dial
    rotate(hExchTempR_image, (hExchTempR_dial * rotation_scalar), "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:XMLVAR_HEAT_EXCHANGER_HANDLE_RIGHT_Position", "NUMBER", hExchTempR_dial)
--END HEAT EXCHANGER TEMP CONTROLS

function press_air_warm_turn(direction)
        hExchTempL_cb(direction)
        hExchTempR_cb(direction)
end
                        

function press_air_dump_button()
    fs2020_variable_write("L:XMLVAR_PRESSURIZATION_CONTROL_LEFT_Position", "Number", 100)
    fs2020_variable_write("L:XMLVAR_PRESSURIZATION_CONTROL_RIGHT_Position", "Number", 100)
end


if user_prop_get(hardware_type) == "Customized" then
    press_air_war_hw_knob    = hw_dial_add("Press Air Warm -both knobs move together", "TYPE_1_DETENT_PER_PULSE", 1, 1, press_air_warm_turn)
else 
    press_air_war_hw_knob    = hw_dial_add("ARDUINO_MEGA2560_D_D36", "ARDUINO_MEGA2560_D_D35", "TYPE_1_DETENT_PER_PULSE", 1,1, press_air_warm_turn)
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        