--[[
******************************************************************************************
******CESSNA 414AW CHANCELLOR CABIN DIFFERENTIAL PRESSURE GAUGE*********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Cabin differential gauge for the  Cessna 414AW Chancellor

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- None

ATTRIBUTION:
Original code and graphics by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--

--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************
-- LOCAL VARIABLES
local cabinAltitude
local diffPressure

--reference_screenshot_id = img_add("cabinAlt_screenshot.png", -30,-30,660,660)
--opacity(reference_screenshot_id, 0.4)

-- Color Definitions
customGreen = "green"
--local customGreen = "#00ff00"
customRed = "#B8350D"
customWhite = "white"
customYellow = "#F2CB2F"
customBlue = "#329EF6"

-- Fonts
font_cabinAlt = "size:28px; font:MS33558.ttf; color:"..customWhite.."; halign:center;"
font_diffPressNum = "size:32px; font:MS33558.ttf; color:"..customWhite.."; halign:left;valign:center"
font_altNum = "size:44px; font:MS33558.ttf; color:"..customWhite.."; halign:left;valign:center"
font_diffPressWord = "size:28px; font:MS33558.ttf; color:"..customWhite.."; halign:center;valign:center"
font_x1000f = "size:28px; font:MS33558.ttf; color:"..customWhite.."; halign:center;valign:center"
font_psi = "size:28px; font:MS33558.ttf; color:"..customBlue.."; halign:center;valign:center"

-- ADD GRAPHICS AND SET STATES
bg_id = img_add_fullscreen("blank_face.png")

-- ADD STATIC GAUGE FACE ITEMS
draw_cabin_alt_face()
draw_diff_press_face()

littlescrew1 = img_add("small_screw.png", 230, 262, 30,30)
littlescrew2 = img_add("small_screw.png", 340, 262, 30,30)

        -- cabin alt needle
shadow_needle_id = img_add("needle_shadow.png", 10,10, 560, 560)
needle_id = img_add("needle.png", 20, 20, 560, 560)


    --diff needle
shadow_diff_needle_id = img_add("needle_shadow.png", 155, 155, 300, 300)
opacity(shadow_diff_needle_id, 0.5)
diff_needle_id = img_add("needle.png", 150, 150, 300,300)
opacity(diff_needle_id, 1)

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
        --alt needle
    reflect_needle_id = img_add("needle.png", 15, 15, 560, 560)
    opacity(reflect_needle_id, 0.08)

        --diff needle
    reflect_diff_needle_id =  img_add("needle.png", 145, 145, 300,300)
    opacity(reflect_diff_needle_id, 0.08)

         --glass glare
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)    
end    

    --outer bezel
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
   
local cabin_alt_settings = { { -1000 , 180 },
                            { 0, 180 },
                            { 15000, 360 },
                            { 30000, 360+(41*3) },
                            { 35000, 360+(41*3)+ 32 },
                            { 100000, 360+(41*3)+ 32 }}


function setValues(cabinAlt, diff)
    diffPressure = var_cap(diff, 0, 6)
    rotate(shadow_diff_needle_id, diffPressure *(180 / 6) + 180, "LOG", 0.04)
    rotate(diff_needle_id, diffPressure *(180 / 6) + 180, "LOG", 0.04)
    if user_prop_get(showBezelGlare )then
        rotate(reflect_diff_needle_id, diffPressure *(180 / 6) + 180, "LOG", 0.04)
    end
    rotate(shadow_needle_id, interpolate_linear(cabin_alt_settings, var_cap(cabinAlt, 0, 35000)), "LOG", 0.04)
    rotate(needle_id, interpolate_linear(cabin_alt_settings, var_cap(cabinAlt, 0, 35000)), "LOG", 0.04)
    if user_prop_get(showBezelGlare )then
        rotate(reflect_needle_id, interpolate_linear(cabin_alt_settings, var_cap(cabinAlt, 0, 35000)), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:PRESSURIZATION CABIN ALTITUDE", "Feet", 
                          "A:PRESSURIZATION PRESSURE DIFFERENTIAL", "PSI",
                                            setValues)
