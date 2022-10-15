--[[
******************************************************************************************
**********************CESSNA 414AW CHANCELLOR AIRSPEED INDICATOR**************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Airspeed indicator gauge for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Modelled after the instrument in the Flysimware C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code from Sim Innovations (lookup table). Graphics original work by Simstrumentation.

Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

-- Color Definitions
customGreen = "green"
--local customGreen = "#00ff00"
customRed = "#B8350D"
customWhite = "white"
customYellow = "#F2CB2F"
customBlue = "#329EF6"

-- Fonts
font_ias = "size:28px; font:MS33558.ttf; color:"..customWhite.."; halign:center;"
font_tas = "size:24px; font:MS33558.ttf; color:"..customWhite.."; halign:left;valign:center;"
font_knots = "size:28px; font:MS33558.ttf; color:"..customBlue.."; halign:center;"

--add graphics

img_add_fullscreen("blank_face.png") -- blank background behind TAS card

draw_tas_face() -- Draw the TAS card that will rotate.  Call function in tas_ticks.lua lib file
rotate(tas_ticks_id, 10, 300, 300, nil) -- start initially rotated for effect ;)
rotate(tas_ticks_id, 0, 300, 300, nil, "LOG", 0.02, "DIRECT") -- rotate back to zero offset with animation
--visible(tas_ticks_id,0)  -- hide the TAS tick marks for development

img_add_fullscreen("inner_card.png") -- Add the gauge face with the cutout for TAS card

draw_static_face() -- Draw the static stuff on the face of the gauge that's static.  Call function in ias_ticks.lua lib file

-- Reference VC screenshot
--screenshot_id = img_add("414_ASI_Screenshot.png", 4,4,600,600)  -- uncomment to see VC gauge overlaid
--opacity(screenshot_id, 0.4) -- uncomment for opacity

small_screw_id = img_add("small_screw.png", 294, 536, 26,26)
small_screw_id2 = img_add("small_screw.png", 220, 60, 26,26)
rotate(small_screw_id2, 64.1)
small_screw_id3 = img_add("small_screw.png", 365, 60, 26,26)
rotate(small_screw_id3, 22.7)

shadow_needle_id = img_add("needle_shadow.png", 40, 40, 540, 540)
opacity(shadow_needle_id, 0.5)
needle_id = img_add("needle.png", 30, 30, 540, 540)

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    -- glass glare
    reflect_needle_id = img_add("needle.png", 25, 25, 540, 540)
    opacity(reflect_needle_id, 0.08)
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)       
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)     
end    

--Initialize needle rotation
rotate(needle_id, 24)
rotate(shadow_needle_id, 24)
if user_prop_get(showBezelGlare)then
    rotate(reflect_needle_id, 24)
end

img_add_fullscreen("bezel.png")

    -- show bezel screws if user prop selected. Screw rotation is randomized
if user_prop_get(showScrews ) then  
    screw_tl_id = img_add("screw.png", 34, 34, 70, 70)
    math.randomseed(os.clock()*100000000000)
    rotate(screw_tl_id, math.random(1,360))
    screw_tr_id = img_add("screw.png", 496, 34, 70, 70)
    math.randomseed(os.clock()*200000000000)
    rotate(screw_tr_id, math.random(1,360))
    screw_bl_id = img_add("screw.png", 34, 500, 70, 70)
    math.randomseed(os.clock()*300000000000)
    rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end    

    -- lookup tables for non-linear gauges
local ias_settings = { { -1000 , 25 },
                            { 0, 25 },
                            { 40, 31.5 },
                            { 50, 46 },
                            { 100, 137.5 },
                            { 110, 154.5 },
                            { 140, 202.5 },
                            { 160, 230.5 },
                            { 180, 255.5 },
                            { 200, 278.5 },
                            { 260, 335 },
                            { 1000, 400 },}

local tas_settings = { { -1000 , 25 },
                            { 0, 25 },
                            { 40, 31.5 },
                            { 50, 46 },
                            { 100, 137.5 },
                            { 110, 154.5 },
                            { 140, 202.5 },
                            { 160, 230.5 },
                            { 180, 255.5 },
                            { 200, 278.5 },
                            { 250, 325.5 },
                            { 350, 325.5 + 48 },
                            { 1000, 400 },}

local airspeed
function setAirspeed(as)
    airspeed = as
    rotate(needle_id, interpolate_linear(ias_settings, var_cap(as, 0, 260)), "LOG", 0.04, "DIRECT")
    rotate(shadow_needle_id, interpolate_linear(ias_settings, var_cap(as, 0, 260)), "LOG", 0.04, "DIRECT")
    if user_prop_get(showBezelGlare )then
        rotate(reflect_needle_id, interpolate_linear(ias_settings, var_cap(as, 0, 260)), "LOG", 0.04, "DIRECT")
    end
end

fs2020_variable_subscribe("AIRSPEED INDICATED", "Knots", setAirspeed)

function setTAScard(tas)
    val = interpolate_linear(ias_settings, var_cap(airspeed, 0, 260)) - interpolate_linear(tas_settings, var_cap(tas, 0, 350))
    rotate(tas_ticks_id, val, 300, 300, nil, "LOG", 0.005, "DIRECT")
end

fs2020_variable_subscribe("AIRSPEED TRUE", "Knots", setTAScard)
