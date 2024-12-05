--[[
**************************************************************************************
********C414AW Chancellor (FlySimWare) Manifold Pressure Gauge***************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Manifold Pressure Gauge for the Cessna 414AW Chancellor

Version info:

- **v1.0** - 2022-10-15
    - Original release
    
NOTES: 
- Designed to match the appearance of the C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- May work on other MSFS aircraft but compatibility not guaranteed
******************************************************************************************
]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************
-------------------------------------
--     Load and display images     --
-------------------------------------
img_add("bezel_face.png" , 0, 6, 600, 600)
img_shadow_left = img_add("shadow_needle_l.png", 10, 10, 600, 600)
opacity(img_shadow_left, 0.5)
img_needle_left = img_add_fullscreen("needle_l.png")
img_shadow_right = img_add("shadow_needle_r.png", 10, 10, 600, 600)
opacity(img_shadow_right, 0.5)
img_needle_right = img_add_fullscreen("needle_r.png")

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle_left = img_add("needle_l.png", -10, -10, 600, 600)   
    opacity(reflect_needle_left, 0.08)
    reflect_needle_right = img_add("needle_r.png", -10, -10, 600, 600)
    opacity(reflect_needle_right, 0.08)
     --glass glare
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)    
end    

    --outer bezel frame 
img_add("bezel.png", -1, -1, 600, 600)

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
---------------
-- Functions --
---------------
function new_ManifoldPx(ePx)
    Px1 = var_cap(ePx[1], 10, 45)
    Px2 = var_cap(ePx[2], 10, 45)
    rotate(img_shadow_left,(254/35) * Px1 - 105)
    rotate(img_needle_left,(254/35) * Px1 - 105)
    rotate(img_shadow_right, (254/35) * Px2 - 105)
    rotate(img_needle_right, (254/35) * Px2 - 105)
    
        if user_prop_get(showBezelGlare )then
        rotate(reflect_needle_left,(254/35) * Px1 - 105)
        rotate(reflect_needle_right,(254/35) * Px2 - 105)
    end
end

function new_ManifoldPx_FS2020(man1, man2)
    new_ManifoldPx({man1, man2})
end

-------------------
-- Bus subscribe --
-------------------

msfs_variable_subscribe("ENG MANIFOLD PRESSURE:1", "inHG",
                          "ENG MANIFOLD PRESSURE:2", "inHG", new_ManifoldPx_FS2020)                       