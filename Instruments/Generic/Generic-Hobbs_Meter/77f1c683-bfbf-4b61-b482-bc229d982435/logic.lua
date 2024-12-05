--[[
******************************************************************************************
*******************************GENERIC HOBBS METER*********************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

Hobbs meter for MSFS. Includes 2 styles - round and rectangular

Version info:
- **v1.0** (9/21/2022)

NOTES: 
- Select Instrument Style  user property to select the color of your text labels based on your panel background color

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code from David Chambers
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--background image
img_add_fullscreen("bg.png")

--***********************************************USER PROPERTY CONFIG***********************************************
bezel_style = user_prop_add_enum("Instrument Style","Round, Rectangular","Round","Select which type of gauge")

if user_prop_get(bezel_style) == "Round" then
    img_add_fullscreen("round_bezel.png")
else
    img_add_fullscreen("rect_bezel.png")
end
--*********************************************END USER PROPERTY CONFIG*********************************************

-- Parameter selection and background image display
    FONT_SIZE = 32
    YSTART = 249
    XSTART = 133
    XINC = 42
    XSIZE = 30
    YSIZE = 30
    
local NUM_DIGITS = 6
-- Fonts
font_white = "size:"..tostring(FONT_SIZE).."px; font:MS33558.ttf; color: white; halign:center;"
font_red = "size:"..tostring(FONT_SIZE).."px; font:MS33558.ttf; color: red; halign:center;"

-- Generate running text (i.e. scrolling numbers to be displayed) Right to left
-- array index [1] maps to rightmost digit
function callback_mod10(i)
  return tostring(-i % 10)
end

local gbl_running_txt = {nil,nil,nil,nil,nil,nil}

for i=1,NUM_DIGITS do
    this_xstart = XSTART+XINC*(NUM_DIGITS-i)
    gbl_running_txt[i] = running_txt_add_ver(this_xstart,YSTART,3,XSIZE,YSIZE,callback_mod10,fif(i==1,font_red,font_white))
    viewport_rect(gbl_running_txt[i],this_xstart,YSTART,XSIZE,YSIZE)
end

-- update the drum position for each cylinder
-- unless the previous digits are within 1 unit of the current digit value, display static number
-- otherwise rotate the drum proportionally in sync with least significant digit moving 9 to 0
-- position is set using running_txt_ove_carot
--- number is converted negative so that cylinder rotation is downwards
--- number is offset by one for no particular reason
--- number is floating point so can be positioned in motion

function showTime(seconds)
 
    elapsed_time = seconds/3600

-- Tenths of hour
    running_txt_move_carot(gbl_running_txt[1], ((elapsed_time * 10) % 10-1) * -1)

-- Digits of hour up to 10000. Rolls over to 0 if larger    
    for i=2,6 do
        threshold = 10^(i-1)
        stationary = (math.floor(elapsed_time / threshold * 10) % 10) -1
        moving = stationary + (elapsed_time * 10) % 10 - 9

        if ((elapsed_time * 10) % threshold) > threshold-1 then
            running_txt_move_carot(gbl_running_txt[i], moving * -1)
        else 
            running_txt_move_carot(gbl_running_txt[i], stationary * -1)
        end
    end
end

-- reset to display all zeros by default
showTime(0)

msfs_variable_subscribe("GENERAL ENG ELAPSED TIME:1", "Seconds", showTime)
