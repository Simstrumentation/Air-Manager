--[[
******************************************************************************************
*************CESSNA 414AW CHANCELLOR AIR CONDITIONER CONTROL*************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Air Conditioner control for the Cessna 414AWChancellor by FlySimware

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
local knob_width = 150
local switch_width = 75
local switch_height = 141
local second_row_y = 80 
local knob_spacing = 170
local switch_spacing = 140
local cabinAir_text_y = 10
local top_text_y = 8
local below_top_text_y = 30
local switch_top_text_y = 50
local pull_text_y = 36
local switch_bottom_text_y = 210
local switch_mid_text_y = switch_top_text_y + (switch_bottom_text_y - switch_top_text_y)/2

local rotation_scalar = 2.75
                                                                              
local hExchDumpL_percent
local hExchDumpR_percent
local aircon_percent
local cabinHeatTemp_percent
local hExchTempL_percent
local hExchTempR_percent

local led_brightness = 0.3

local pullSize = 70
local pullY = 40
local pullX = 450 -394
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




text_color_prop = user_prop_add_enum("Text Color", "White, Black", "White", "You can choose a text color for labels")
hardware_type = user_prop_add_enum("Hardware Type", "Customized, Hard Coded", "Customized", "Select the type of hardware to use")

local text_color = "#DDDDDDFF"
if user_prop_get(text_color_prop) == "White" then
    text_color = "#DDDDDDFF"
else
    text_color = "#020202FF"
end

canvas_vert_lines_id = canvas_add(0, 0, 780,200)
    canvas_draw(canvas_vert_lines_id, function()
        local x0 = 10
        local x1 = 95
        local x2 = 344
        local x3 = 440
        _move_to(x0, 60)
        _line_to(x0, 18)
        _line_to(x1, 18)
        _move_to(x2, 18)
        _line_to(x3, 18)
        _line_to(x3, 60)
        _stroke(text_color, 6)
        _stroke(text_color, 6)
   
        _translate(19,14)
        _scale(1.2,1.2)
        _arc(59, 100, 315,225, 51, false)
        _stroke(text_color, 4)
        _triangle(100, 60, 102, 72, 90,68)
        _fill(text_color)
end)


local text_format_string = "font:MS33558.ttf; size:24; color:"..text_color.."; halign:center;"
local text_format_string_med = "font:MS33558.ttf; size:20; color:"..text_color.."; halign:center;"
local text_format_string_small = "font:MS33558.ttf; size:20; color:"..text_color.."; halign:center;"

local x_set = 20
aircon_text = txt_add("AIR CONDITIONING", text_format_string, x_set,top_text_y, 400, 25)
x_set = -6
aircon_cooler_text = txt_add("COOLER", text_format_string_med, x_set,below_top_text_y + 10, 200, 25)
x_set = 140
aircon_blower_text = txt_add("BLOWER", text_format_string_small, x_set,switch_bottom_text_y + 11, 200, 25)
aircon_blower_high_text = txt_add("HIGH", text_format_string_small, x_set,switch_top_text_y, 200, 25)
aircon_blower_low_text = txt_add("LOW", text_format_string_small, x_set,switch_bottom_text_y - 8, 200, 25)
x_set = x_set + switch_spacing
aircon_cool_text = txt_add("COOL", text_format_string_small, x_set,switch_top_text_y, 200, 25)
aircon_off_text = txt_add("OFF", text_format_string_small, x_set - 70,switch_mid_text_y, 200, 25)
aircon_circ_text = txt_add("CIRC", text_format_string_small, x_set,switch_bottom_text_y, 200, 25)

xpos = 40
--START AC KNOB
function aircon_cb(direction)
    if direction == 1 then
        if aircon_percent < 100.0 then
            aircon_percent = aircon_percent + 5
        end
    else
        if aircon_percent > 0.0 then
            aircon_percent = aircon_percent - 5
        end
    end 
    fs2020_variable_write("L:XMLVAR_AIRCON_COOLER_KNOB_Position", "Number", var_round(aircon_percent, 1))
    request_callback(aircon_dial(aircon_percent))
end
aircon_id = dial_add(nil, xpos, second_row_y, knob_width * 0.7, knob_width * 0.7, aircon_cb)
aircon_image = img_add("knob_dn.png", xpos, second_row_y, knob_width * 0.7, knob_width * 0.7)

function aircon_dial(aircon_dial)
    aircon_percent = aircon_dial
    rotate(aircon_image, (aircon_dial * rotation_scalar) - 10, "LINEAR", 0.04)
end
fs2020_variable_subscribe("L:XMLVAR_AIRCON_COOLER_KNOB_Position", "NUMBER",aircon_dial)
--END AC KNOB

xpos = 200
--START AC FAN SWITCH
function aircon_fan_cb(position, direction)
print(position)
    new_pos = (position + direction)
    fs2020_variable_write("L:AIRCON_HI_LOW_SWITCH", "Enum", new_pos)
end
aircon_fan_id = switch_add ( "white_down.png", "white_up.png", xpos, second_row_y -10, switch_width, switch_height, "VERTICAL", aircon_fan_cb)

function aircon_fan_pos(pos)
    switch_set_position(aircon_fan_id, pos)
    if pos == 1 then 
        hw_led_set(aircon_fan_hw_LED, led_brightness)
    else
        hw_led_set(aircon_fan_hw_LED, 0)
    end
end

fs2020_variable_subscribe("L:AIRCON_HI_LOW_SWITCH", "Enum", aircon_fan_pos)
--END AC FAN SWITCH

--START AC COMPRESSOR SWITCH
function aircon_switch_cb(position, direction)
    print(position)
    new_pos = (position + direction)
    fs2020_variable_write("L:GENERIC_Momentary_AIRCON_COOL_SWITCH_1", "Enum", new_pos)
end
aircon_sw_id = switch_add ( "white_down.png", "white_mid.png", "white_up.png", xpos + switch_spacing, second_row_y -10, switch_width, switch_height, "VERTICAL", aircon_switch_cb)

function aircon_pos(pos)
    switch_set_position(aircon_sw_id, pos)
    if pos == 2 then 
        hw_led_set(aircon_hw_LED, led_brightness)
    else
        hw_led_set(aircon_hw_LED, 0)
    end
end
fs2020_variable_subscribe("L:GENERIC_Momentary_AIRCON_COOL_SWITCH_1", "Enum", aircon_pos)
--END AC COMPRESSOR SWITCH

----
function cooler_turn(direction)
        aircon_cb(direction)
end

function aircon_switch_callback(position)
    if position == 1 then
        fs2020_variable_write("L:GENERIC_Momentary_AIRCON_COOL_SWITCH_1", "Enum", 2)
    else
        fs2020_variable_write("L:GENERIC_Momentary_AIRCON_COOL_SWITCH_1", "Enum", 1)
    end
end
function aircon_fan_switch_callback(position)
    if position == 1 then
        fs2020_variable_write("L:AIRCON_HI_LOW_SWITCH", "Enum", 1)
    else
        fs2020_variable_write("L:AIRCON_HI_LOW_SWITCH", "Enum", 0)
    end
end

if user_prop_get(hardware_type) == "Customized" then
    aircon_hw_knob           = hw_dial_add("AC Cooler", "TYPE_1_DETENT_PER_PULSE", 1,1, cooler_turn)
    aircon_fan_hw_switch  	= hw_switch_add("Aircon Fan Hi/Lo Switch", 1, aircon_fan_switch_callback)
    aircon_hw_switch  	        = hw_switch_add("Aircon Compressor Switch", 1, aircon_switch_callback)
    aircon_fan_hw_LED  	    = hw_led_add("Aircon Fan Hi/Lo LED", 0)
    aircon_hw_LED  	    = hw_led_add("Aircon Compressor LED", 0)
else 
    aircon_hw_knob           = hw_dial_add("ARDUINO_MEGA2560_D_D33", "ARDUINO_MEGA2560_D_D32", "TYPE_1_DETENT_PER_PULSE", 1,1, cooler_turn)
    aircon_fan_hw_switch  	= hw_switch_add("ARDUINO_MEGA2560_D_D27", aircon_fan_switch_callback)
    aircon_hw_switch  	        = hw_switch_add("ARDUINO_MEGA2560_D_D28", aircon_switch_callback)
    aircon_fan_hw_LED  	    = hw_led_add("ARDUINO_MEGA2560_D_D45", 0)
    aircon_hw_LED  	    = hw_led_add("ARDUINO_MEGA2560_D_D46", 0)
end

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        