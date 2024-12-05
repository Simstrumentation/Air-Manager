--[[
******************************************************************************************
*********************CESSNA 414AW CHANCELLOR ALTIMETER************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Altimeter for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed


KNOWN ISSUES:
- None

ATTRIBUTION:
- Based on code by flyatr
- Graphics created by Simstrumentation. 
- Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--

--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

--LOCAL VARIABLES
local runningTextTop = 162
local runningTextHeight = 70
local viewportOffset = 10
local numberLatSpacing = 52
local lastDigitX = 183 -- THIS IS THE NUMBER YOU CHANGE TO WHOLESALE OFFSET THE ALTITUDE DIGITS LEFT/RIGHT
local alt_width = 43
local alt_height = 74

-- IMAGES AND TEXT

    -- basic background graphic added here. Other graphics added near end of the functions section
    -- to maintain proper z-order
img_add("barrels.png", 1,1, 600, 611)


    -- Fonts
font_alt = "size:60px; font:MS33558.ttf; color: white; halign:center;"
font_baro = "size:26px; font:MS33558.ttf; color: white; halign:center;"
    
      -- Altimeter drum
function alt_10000_value_callback(i)
  return tostring(-i % 10)
end

alt_10000_running_txt_id = running_txt_add_ver(lastDigitX,runningTextTop,3,alt_width,alt_height,alt_10000_value_callback,font_alt)
lastDigitX = lastDigitX + numberLatSpacing

--   
function alt_1000_value_callback(i)
  return tostring(-i % 10)
end 

alt_1000_running_txt_id = running_txt_add_ver(lastDigitX,runningTextTop,3,alt_width,alt_height,alt_1000_value_callback,font_alt)
lastDigitX = lastDigitX + 90 -- add for the gap

function alt_100_value_callback(i)
  return tostring(-i % 10)
end

alt_100_running_txt_id = running_txt_add_ver(lastDigitX,runningTextTop-alt_height,5,alt_width,alt_height,alt_100_value_callback,font_alt)
lastDigitX = lastDigitX + numberLatSpacing

local flagx = 176
local flagy = 234
local gf_wide = 46
local gf_tall = 63


ground_flag_id = canvas_add(flagx, flagy, gf_wide, gf_tall)

canvas_draw(ground_flag_id, function()
    _rect(0,0, gf_wide, gf_tall)
    _fill("white")
    _move_to(-10, gf_tall)
    _line_to(10+gf_tall, -12)
    _translate(0,gf_tall*1/2)
    _move_to(-10, gf_tall)
    _line_to(10+gf_tall, -12)
    _translate(0,-gf_tall)
    _move_to(-10, gf_tall)
    _line_to(10+gf_tall, -12)
    _stroke("black", 10)
end)

    -- baro drum
function baro_1_value_callback(i)
  return "" .. i % 10
end

    --resetting locals from above for baro digits
runningTextTop = 416
runningTextHeight = 30
viewportOffset = 45
numberLatSpacing = 26
lastDigitX = 327

        -- baro first digit
drum_baro_1 = running_txt_add_ver(lastDigitX,runningTextTop,3,numberLatSpacing,runningTextHeight,baro_1_value_callback,font_baro)
lastDigitX = lastDigitX - numberLatSpacing

    -- baro second digit
function baro_2_value_callback(i)
  return "" ..  i % 10
end

drum_baro_2 = running_txt_add_ver(lastDigitX,runningTextTop,3,numberLatSpacing,runningTextHeight,baro_2_value_callback,font_baro)
lastDigitX = lastDigitX - numberLatSpacing

        -- baro third digit
function baro_3_value_callback(i)
  return "" .. i % 10
end


drum_baro_3 = running_txt_add_ver(lastDigitX,runningTextTop,3,numberLatSpacing,runningTextHeight,baro_3_value_callback,font_baro)
lastDigitX = lastDigitX - numberLatSpacing

    --baro fourth digit
function baro_4_value_callback(i)
  return "" ..  i % 10
end
drum_baro_4 = running_txt_add_ver(lastDigitX,runningTextTop,3,numberLatSpacing,runningTextHeight,baro_4_value_callback,font_baro)
---------------------------------------------

function setData(altitude, baro, battery, volts)
    if volts >= 3 then
        altitude = var_cap(altitude,0,99999)
        rotate(needle_id, (altitude)*0.36, "LOG", 0.04)
        rotate(reflect_needle_id, (altitude)*0.36, "LOG", 0.04)
        rotate(shadow_needle_id, (altitude)*0.36, "LOG", 0.04)
        move(candy_cane_id, nil, 150, nil, nil, "LOG", 0.04)
    else
        rotate(needle_id,0, "LOG", 0.04)
        rotate(reflect_needle_id,0, "LOG", 0.04)
        rotate(shadow_needle_id,0, "LOG", 0.04)
        altitude = 0
        move(candy_cane_id, nil, 260, nil, nil, "LOG", 0.04)
    end
    
     
    -- altimeter drum values
    drum_10_moving = (altitude / 20) + 20
    drum_100_moving = altitude/100
    drum_1000_stationary = math.floor(altitude / 1000)
    drum_1000_moving = drum_1000_stationary + drum_100_moving +1
    drum_10000_stationary = math.floor(altitude / 10000)
    drum_10000_moving = drum_10000_stationary + drum_1000_moving + 1 
  
        running_txt_move_carot(alt_100_running_txt_id, drum_100_moving * -1)

    if (altitude % 1000) > 900 then
        running_txt_move_carot(alt_1000_running_txt_id, drum_1000_moving * -1)
    else 
        running_txt_move_carot(alt_1000_running_txt_id, drum_1000_stationary * -1)
    end

    local value=0
    if (altitude % 10000) > 9900 then
        value=drum_10000_moving * -1 
    else 
        value= drum_10000_stationary * -1
    end
    running_txt_move_carot(alt_10000_running_txt_id,value)
    
    if altitude > 9900 and altitude < 10000 then
        move(ground_flag_id, nil, flagy + (drum_100_moving-99)*alt_height, nil, nil, "LOG", 0.04)
    elseif altitude > 10000 then
        move(ground_flag_id, nil, flagy + alt_height, nil, nil, "LOG", 0.04)
    else
        move(ground_flag_id, nil, flagy, nil, nil, "LOG", 0.04)        
    end   
    --print(flagy + (drum_100_moving-99)*90)
--local flagx = 172
--local flagy = 234
--ground_flag_id = img_add("atr_alt_ground_flag.png", flagx,flagy,90,180)
--groung_flag_viewport_id = viewport_rect(ground_flag_id, flagx,flagy,46,64)
    
        
    --baro drums
    ------------------------------
    baro_integer = baro * 100
    baro1_moving = baro_integer % 10
    baro2_stationary = math.floor(baro_integer / 10)
    baro2_moving = baro2_stationary + baro1_moving + 1
    baro3_stationary = math.floor(baro_integer / 100)
    baro3_moving =  baro3_stationary + baro2_moving + 1
    baro4_stationary = math.floor(baro_integer / 1000)
    baro4_moving =  baro4_stationary + baro1_moving + 1
    running_txt_move_carot(drum_baro_1, var_round(baro1_moving,0))

    if (baro_integer % 10) > 9 then
        running_txt_move_carot(drum_baro_2, baro2_moving)
    else
        running_txt_move_carot(drum_baro_2, baro2_stationary)
    end
    
    if (baro_integer % 100) > 99 then
        running_txt_move_carot(drum_baro_3, baro3_moving)
    else
        running_txt_move_carot(drum_baro_3, baro3_stationary)
    end
    
    if (baro_integer % 1000)  > 999 then
        running_txt_move_carot(drum_baro_4, baro4_moving)
    else
        running_txt_move_carot(drum_baro_4, baro4_stationary)
    end
end

    --add graphics
candy_cane_id = img_add("red_white_flag.png",160,260,210,12)  
img_add_fullscreen("dial_face.png")
shadow_needle_id = img_add("needle_shadow.png", 40, 40, 540, 540)
opacity(shadow_needle_id, 0.5)
needle_id = img_add("needle.png", 30, 30, 540, 540)                       

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    -- glass glare
    reflect_needle_id = img_add("needle.png", 35, 35, 540, 540)
    opacity(reflect_needle_id, 0.08)
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)       
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
--    screw_bl_id = img_add("screw.png", 12, 535, 50, 50)
--    math.randomseed(os.clock()*300000000000)
--    rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 496, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end                                                                                            
 -- Barometric pressure set knob
---------------------------------------------
function setBaro(direction)  
    if direction == 1 then
        msfs_event("KOHLSMAN_INC")
    elseif direction == -1 then
        msfs_event("KOHLSMAN_DEC")
    end
end
knob_shadow_id = img_add("knob_shadow.png", 22, 494,118, 100)
rotate(knob_shadow_id, 45)
opacity(knob_shadow_id, 0.5)
img_add("baro_knob.png", 16,476,100, 100)
baro_dial = dial_add("knob_mark.png", 4, 468, 114, 114, setBaro)
dial_click_rotate(baro_dial, 5)
                                                                                           
msfs_variable_subscribe("INDICATED ALTITUDE", "Feet",
                          "KOHLSMAN SETTING HG", "inHg", 
                          "ELECTRICAL MASTER BATTERY", "BOOLEAN",
                          "ELECTRICAL MAIN BUS VOLTAGE", "VOLTS", 
                          setData)                    
