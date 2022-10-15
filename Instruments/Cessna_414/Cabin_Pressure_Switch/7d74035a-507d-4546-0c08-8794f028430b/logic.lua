--[[
******************************************************************************************
**********CESSNA 414AW CHANCELLOR CABIN PRESSURIZATION SWITCH************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Cabin Pressurization Switch for the FlySimWare Cessna 414AW

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Will only work with the FSW C414AW

KNOWN ISSUES:
- None

ATTRIBUTION:
Original code and graphics by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--

local switch_position

text_color_prop = user_prop_add_enum("Text Color", "White, Black", "White", "You can choose a text color for labels")

local text_color = "#DDDDDDFF"
if user_prop_get(text_color_prop) == "White" then
    text_color = "#DDDDDDFF"
else
    text_color = "#020202FF"
end

--TEXT LABELS
txt_press = txt_add("PRESSURIZE", "font:MS33558.ttf; size:20; color: ".. text_color.. "; halign:center;",0, 6, 180, 30)
txt_depress = txt_add("DEPRESSURIZE", "font:MS33558.ttf; size:20; color: ".. text_color.. "; halign:center;",0, 134, 180, 30)
txt_cabin = txt_add("CABIN", "font:MS33558.ttf; size:20; color: ".. text_color.. "; halign:center;", 70, 64, 180, 30)

--SWITCH CONTROL
function pressure_switch()
    if switch_position == 0 then
        fs2020_variable_write("L:CABIN_PRESSURIZATION_SWITCH", "ENUM", 1)
    else
        fs2020_variable_write("L:CABIN_PRESSURIZATION_SWITCH", "ENUM", 0)
    end
end

pressure_switch_id = switch_add("white_up.png", "white_down.png", 50, 8, 75, 141, pressure_switch)

--ANIMATION  CONTROL
function switch_pos(pos)
   switch_set_position(pressure_switch_id, pos)
   switch_position = pos
end
fs2020_variable_subscribe("L:CABIN_PRESSURIZATION_SWITCH", "ENUM", switch_pos)

