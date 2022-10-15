--[[
******************************************************************************************
************CESSNA 414AW CHANCELLOR OXYGEN CAPACITY GAUGE****************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Oxygen capacity gauge for the  Cessna 414AW Chancellor

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414
- Front bezel glass and internal reflection can be disabled in the user properties
- Will only work with the FlySimWare C414AW.


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
local oxygenLevel

-- Color Definitions
customGreen = "green"
--local customGreen = "#00ff00"
customBrightGreen = "#E8F760"
customRed = "#B8350D"
customWhite = "white"
customYellow = "#F2CB2F"
customBlue = "#329EF6"

-- Fonts
font_maintxt = "size:28px; font:MS33558.ttf; color:"..customWhite.."; halign:center;"
font_Num = "size:50px; font:MS33558.ttf; color:"..customWhite.."; halign:left;valign:center"
font_psi = "size:28px; font:MS33558.ttf; color:"..customBlue.."; halign:center;valign:center"
font_period = "size:28px; font:inconsolata_bold.ttf; color:"..customWhite.."; halign:center;valign:center"

img_add_fullscreen("blank_face.png")
--img_add_fullscreen("bg.png")
--ref_img = img_add("oxycyl_ref.png",0,0,600,600)

draw_face()

shadow_needle_id = img_add("needle_shadow.png", 10,10,600,600)
opacity(shadow_needle_id, 0.5)
needle_id = img_add("needle.png", 20,20,560,560)

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle_id = img_add("needle.png", 25,30,560,560)   
    opacity(reflect_needle_id, 0.08)
     
      --glass glare
    glare_id=img_add("glass_glare.png", 15,15,560,560)
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

local settings = { { 0 , -18},
                   { 10, -18+(2*77) },
                   { 20, -18+(2*77) + (64*2)}}

rotate(needle_id, interpolate_linear(settings, 18))
rotate(shadow_needle_id, interpolate_linear(settings, 18))
if user_prop_get(showBezelGlare )then
    rotate(reflect_needle_id, interpolate_linear(settings, 18))
end

function setO2(o2)
    oxygenLevel = var_cap(o2, 0, 20)
        --rotation of needle and shadow
        rotate(needle_id, interpolate_linear(settings, oxygenLevel), "LOG", 0.04)
        rotate(shadow_needle_id, interpolate_linear(settings, oxygenLevel), "LOG", 0.04)
        if user_prop_get(showBezelGlare )then
            rotate(reflect_needle_id, interpolate_linear(settings, oxygenLevel), "LOG", 0.04)
        end
end

fs2020_variable_subscribe("L:OXYGEN_CYL_NEEDLE", "ENUM", setO2)