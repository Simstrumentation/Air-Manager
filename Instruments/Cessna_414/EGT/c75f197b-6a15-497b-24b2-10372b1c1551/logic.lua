--[[
******************************************************************************************
**********************CESSNA 414AW CHANCELLOR EGT GAUGE***********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Exhaust gas temperature gauge for the Cessna 414AW Chancellor

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414, but should work with any dual engine plane in MSFS
   that requires a dual EGT gauge. 
- Front bezel glass and internal reflection can be disabled in the user properties

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on an instrument by Snake Stack Simulations. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--

--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")

--********************************************* END USER PROPERTY CONFIG*********************************************

img_add_fullscreen("bg.png")

shadow_needle_L = img_add("shadow_needle_l.png", -75, 297, 365, 43)
opacity(shadow_needle_L, 0.8)
img_needle_L = img_add("needle_l.png", -85, 287, 365, 43)
if user_prop_get(showBezelGlare )then
    reflect_needle_L = img_add("needle_l.png", -90, 282, 365, 43)
    opacity(reflect_needle_L, 0.08)
end

shadow_needle_R = img_add("shadow_needle_r.png", 340, 305, 352, 26)
opacity(shadow_needle_R, 0.5)
img_needle_R = img_add("needle_r.png", 330, 295, 352, 26)
if user_prop_get(showBezelGlare )then
    reflect_needle_r = img_add("needle_r.png", 325, 290, 352, 26)
    opacity(reflect_needle_r,0.08)
end

img_add_fullscreen("face.png")

if user_prop_get(showBezelGlare )then
    glare_id = img_add("glass_glare.png", 0, 0, 600, 600)
    rotate(glare_id, -90)
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
-----------------------------------------
-- Set default visibility and rotation --
-----------------------------------------

function new_EGT(eEGT)
    EGT1 = var_cap((9/5 *((eEGT[1]) +32)), 1200, 1700)
    EGT2 = var_cap((9/5 *((eEGT[2]) +32)), 1200, 1700)

    totalEGT1 = (EGT1 - 1200)
    totalEGT2 = (EGT2 - 1200)

    rotate1 = (-totalEGT1 * (90/500))
    rotate2 = (totalEGT2 * (90/500))
    if totalEGT1 > 0 then
        rotate(img_needle_L, rotate1 +50)
        rotate(shadow_needle_L, rotate1 +50)
    else
        rotate(img_needle_L, 50)
        rotate(shadow_needle_L, 50)
    end

    if totalEGT2 > 0 then
        rotate(img_needle_R, rotate2 - 50)
        rotate(shadow_needle_R, rotate2 - 50)
    else
        rotate(img_needle_R, -50)
        rotate(shadow_needle_R, -50)
    end
end

function new_EGT_FS2020(eEGT1, eEGT2)
    new_EGT({eEGT1, eEGT2})   
end

-------------------
-- Bus subscribe --
-------------------
msfs_variable_subscribe("GENERAL ENG EXHAUST GAS TEMPERATURE:1", "Celsius",
                          "GENERAL ENG EXHAUST GAS TEMPERATURE:2", "Celsius", 
                          
                          new_EGT_FS2020)                       