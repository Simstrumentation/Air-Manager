--[[
**************************************************************************************
***********C414AW Chancellor (FlySimWare) Fuel Quantity Gauge*****************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Version info:

- **v1.0** - 2022-10-15
    - Original release
    
NOTES: 
- Designed to match the appearance of the C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- Will only work accurately with the Flysimware Cessna 414AW Chancellor. May work
    with other MSFS aircraft. Compatibility not guaranteed.

- Graphics based an instrument from Snake Stack Simulations
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

******************************************************************************************
]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

        --load graphics
img_add_fullscreen("bezel_face.png")
img_shadow_left = img_add("needle_shadow.png", 123, 198, 66, 290)
opacity(img_shadow_left, 0.5)
img_needle_left = img_add("needle.png", 113, 188, 66, 290)

img_shadow_right = img_add("needle_shadow.png", 428, 198, 66, 290)
opacity(img_shadow_right, 0.5)
img_needle_right = img_add("needle.png", 418, 188, 66, 290)

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle_left = img_add("needle.png", 108, 183, 66, 290)   
    opacity(reflect_needle_left, 0.08)
    reflect_needle_right = img_add("needle.png", 413, 183, 66, 290)
    opacity(reflect_needle_right, 0.08)
     --glass glare
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
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
    --function to calculate fuel quantity and rotate needles
function calcFuel(galL, galR, volts)
    local fuel_l = var_cap(galL, 0, 110)
    local fuel_r = var_cap(galR, 0, 110)
    local busVolts = volts
    
        --always show 0 if main bus voltage below 8v
    fuel_l  = fif(busVolts >= 8, fuel_l, 0)
    fuel_r = fif(busVolts >= 8, fuel_r, 0)
    
        --left needle
    rotate(img_needle_left, -170 / 100 * fuel_l, "LOG", 0.04)
    rotate(img_shadow_left, -170 / 100 * fuel_l, "LOG", 0.04)
    rotate(reflect_needle_left, -170 / 100 * fuel_l, "LOG", 0.04)
    
        --right needle
    rotate(img_needle_right, 170 / 100 * fuel_r, "LOG", 0.04)
    rotate(img_shadow_right, 170 / 100 * fuel_r, "LOG", 0.04)
    rotate(reflect_needle_right, 170 / 100 * fuel_r, "LOG", 0.04)
end

fs2020_variable_subscribe("FUEL LEFT QUANTITY", "Gallon", 
                          "FUEL RIGHT QUANTITY", "Gallon",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", 
                          calcFuel)