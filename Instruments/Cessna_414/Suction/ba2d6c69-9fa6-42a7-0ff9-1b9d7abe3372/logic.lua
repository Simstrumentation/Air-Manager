--[[
**************************************************************************************
***********C414AW Chancellor (FlySimWare) Suction Gauge*****************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Version info:

- **v1.0** - 2022-10-15
    - Original release
    
NOTES: 
- Designed to match the appearance of the C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

ATTRIBUTION
- Code and graphics by Simstrumentation
- Sharing or re-use of any code or assets is not permitted without credit to the original authors.

******************************************************************************************
]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

    --add graphics
--img_add_fullscreen("suction_face.png")
img_add_fullscreen("blank_face.png")
--ref_face = img_add("suction_screenshot.png", 0,0,600,600)
--opacity(ref_face, 0.6)


-- Color Definitions
customGreen = "green"
--local customGreen = "#00ff00"
customRed = "#B8350D"
customWhite = "white"
customYellow = "#F2CB2F"
customBlue = "#329EF6"

-- Fonts
font_Num = "size:50px; font:MS33558.ttf; color:"..customWhite.."; halign:left;valign:center"
font_suction = "size:36px; font:MS33558.ttf; color:"..customWhite.."; halign:center;valign:center"
font_inhg = "size:28px; font:MS33558.ttf; color:"..customBlue.."; halign:center;valign:center"
font_LR = "size:44px; font:MS33558.ttf; color:"..customBlue.."; halign:center;valign:center"
font_source = "size:36px; font:MS33558.ttf; color:"..customBlue.."; halign:center;valign:center"
font_equals = "size:44px; font:inconsolata_bold.ttf; color:"..customWhite.."; halign:left;valign:center"


draw_face()


shadow_needle_id = img_add("needle_shadow.png", 10, 10, 600, 600)
opacity(shadow_needle_id, 0.5)
needle_id = img_add_fullscreen("needle.png")
left_indicator = img_add("left_indicator.png", 42,32,520,520)
right_indicator = img_add("right_indicator.png", 52,32,520,520)
rotate(shadow_needle_id,-90)
rotate(needle_id,-90)

    -- if bezel glass and reflection user property selected
if user_prop_get(showBezelGlare )then
    reflect_needle_id = img_add("needle.png", -5, -5, 600, 600)
    opacity(reflect_needle_id, 0.08)
    rotate(reflect_needle_id,-90)
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    
    --    bezel glass glare
    rotate(glare_id, -100)
    opacity(glare_id, .3)    
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


local settings = { { -10, -90 },
                   { 0, -90 },
                   { 3, -90+54 },
                   { 6, -90+54+75 },
                   { 100, -90+75 }}

    -- update gauge
function new_suction_FS2020(suction, rpm1, rpm2)
    visible(left_indicator, rpm1 < 100)
    visible(right_indicator, rpm2 < 100)
       
    if suction >= 1 then
        rotate(needle_id, interpolate_linear(settings, var_cap(suction, 0, 6)), "LOG", 0.04)
        rotate(shadow_needle_id, interpolate_linear(settings, var_cap(suction, 0, 6)), "LOG", 0.04)
         --    if bezel glass and reflection user property selected 
        if user_prop_get(showBezelGlare )then
             rotate(reflect_needle_id, interpolate_linear(settings, var_cap(suction, 0, 6)), "LOG", 0.04)
        end
    else
        rotate(needle_id, -90, "LOG", 0.04)
        rotate(shadow_needle_id, -90, "LOG", 0.04)
        --    if bezel glass and reflection user property selected 
        if user_prop_get(showBezelGlare )then
            rotate(reflect_needle_id, -90, "LOG", 0.04)
        end
    end    
end


msfs_variable_subscribe("SUCTION PRESSURE", "inHg",
                          "GENERAL ENG RPM:1", "RPM", 
                          "GENERAL ENG RPM:2", "RPM", new_suction_FS2020)                       