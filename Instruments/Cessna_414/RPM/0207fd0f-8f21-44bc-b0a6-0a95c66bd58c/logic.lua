--[[
******************************************************************************************
***********CESSNA 414AW CHANCELLOR RPM GUAGE WITH PROP SYNC*************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

RPM gauge for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** (TBD)

NOTES: 
- Select Text Color user property to select the color of your text labels based on your panel background color
- Front bezel glass and internal reflection can be disabled in the user properties
- Will only work with the Flysimware Cessna 414 Chancellor

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code from Snake Stack Simulations (RPM gauge) and Sim Innovations (prop sync indicator)
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
font_color = user_prop_add_enum("Text Color","White, Black","White","Select color of labels")    -- user selects font color based on their background
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")


if user_prop_get(font_color ) == "White" then
   COLOR = "WHITE"
else
    COLOR = "BLACK"
end
--********************************************* END USER PROPERTY CONFIG*********************************************

--**********************************************************LOCAL VARS**********************************************************
local gbl_rotation = 0
local switch_position = 0
local phase_val
local phase_knob_position 
local phase_knob_convert
local phase_switch_on

--********************************************************END LOCAL VARS********************************************************

--***********************************************ADD BASE IMAGES AND LABELS***********************************************
--prop sync indicator
img_prop = img_add("prop.png", 226, 414, 150, 150)

--gauge background
img_add("bezel_face.png",  0, 6, 600, 600)


--needles
img_shadow_left = img_add("shadow_needle_l.png", 10, 10, 600, 600)
img_needle_left = img_add_fullscreen("needle_l.png")
opacity(img_shadow_left, 0.5)

img_shadow_right = img_add("shadow_needle_r.png", 10, 10, 600, 600)
img_needle_right = img_add_fullscreen("needle_r.png")
opacity(img_shadow_right, 0.5)

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare ) then
    reflect_needle_left = img_add("needle_l.png", -10, -10, 600, 600)   
    opacity(reflect_needle_left, 0.08)
    
    reflect_needle_right = img_add("needle_r.png", -10, -10, 600, 600)
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
end    
    --add text labels
prop_id = txt_add("PROP", "font:MS33558.ttf; size:18; color: "..tostring(COLOR).."; halign:center;",456, 20, 100, 30)  
sync_id = txt_add("SYNC", "font:MS33558.ttf; size:18; color: "..tostring(COLOR).."; halign:center;",456, 45, 100, 30)  
phasing_id = txt_add("PHASING", "font:MS33558.ttf; size:18; color: "..tostring(COLOR).."; halign:center;",88, 572, 100, 30)  
phase_id = txt_add("PHASE", "font:MS33558.ttf; size:18; color: "..tostring(COLOR).."; halign:center;",470, 522, 100, 30)    
off_id = txt_add("OFF", "font:MS33558.ttf; size:18; color: "..tostring(COLOR).."; halign:center;",480, 560, 100, 30)    

--sync light
light_off_id = img_add("phase_light_off.png", 535, 10, 60, 60)
light_on_id = img_add("phase_light_on.png", 535, 10, 60,60)

--phase knob
knob_bg_id = img_add("phase_knob_bg.png", 10, 490, 110, 110)
knob_dot_id = img_add("phase knob dot.png", 10, 490, 86, 86)

--*********************************************END ADD BASE IMAGES AND LABELS*********************************************

-- RPM gauge and prop sync indicator
function new_RPM(eRPM)
    -- RPM gauge
    rpm1 = var_cap(eRPM[1], 0, 3400)
    rpm2 = var_cap(eRPM[2], 0, 3400)
    rotate(img_shadow_left,((245/3400) * rpm1) - 108)
    rotate(img_needle_left,((245/3400) * rpm1) - 108)
    
    rotate(img_needle_right, ((245/3400) * rpm2) - 108)
    rotate(img_shadow_right,((245/3400) * rpm2) - 108)
    
    if user_prop_get(showBezelGlare ) then
        rotate(reflect_needle_left,((245/3400) * rpm1) - 108)
        rotate(reflect_needle_right,((245/3400) * rpm2) - 108)
    end
    
    
    --Prop sync indicator    
    if rpm1 ~= 0 and rpm2 ~= 0 then
        sync = (((rpm2 / rpm1) - 1) * 3 )
    else
        sync = 0
    end
    
    if not timer_running(sync_timer) then
        sync_timer = timer_start(0, 5, function()
            gbl_rotation = gbl_rotation + sync
            rotate(img_prop, gbl_rotation)
        end)
    end
end

function set_RPM(rpm1, rpm2)
    new_RPM({rpm1, rpm2})
end
 
 -- prop sync indicator light control
function phase_cb(switch, switch_pos)
    switch_position = switch
    print (switch_position)
    if switch_position == 1 then
        visible(light_on_id, true)
    else
        visible(light_on_id, false)    
    end
end  
fs2020_variable_subscribe("L:PHASE_SWITCH", "Number", 
                                            "L:PHASE_SWITCH_ON", "Number", phase_cb)
-- phase switch
function switch_cb()
    if switch_position == 1 then
        fs2020_variable_write("L:PHASE_SWITCH", "ENUM", 0)         
    else
        fs2020_variable_write("L:PHASE_SWITCH", "ENUM", 1)    
    end        
end    
phase_switch_id = switch_add("white_down.png", "white_up.png", 548, 500, 50, 92, switch_cb)  

function switch_pos(pos)
    switch_set_position(phase_switch_id, pos) 
end
fs2020_variable_subscribe("L:PHASE_SWITCH_ON", "Number", switch_pos) 


-- phase knob positon follows lvar to match cockpit setting
function phase_knob(convert, pos)
    phase_knob_convert = convert
    phase_knob_position = pos   
    if phase_knob_position >=2 or phase_knob_position <=2 then
        phase_val = phase_knob_convert * 30
        rotate(knob_dot_id, (phase_val * 2.5), "LINEAR", 0.04)
    end
end

-- phase knob adjustment
function phase_adjust(direction)
      if direction == 1 and phase_knob_position < 200 then
                fs2020_variable_write("L:XMLVAR_PHASE_KNOB_Position", "Number", phase_knob_position + 10)
                fs2020_variable_write("L:PHASE_KNOB_CONVERT", "Number", phase_knob_convert + 0.2) 
      elseif  direction == -1 and phase_knob_position > 0  then
                fs2020_variable_write("L:XMLVAR_PHASE_KNOB_Position", "Number", phase_knob_position - 10)
                fs2020_variable_write("L:PHASE_KNOB_CONVERT", "Number",  phase_knob_convert - 0.2) 
    end
end
phase_dial = dial_add(nil, 10, 500, 86, 86, phase_adjust)

-- annunciator test

    -- monitors state of the annunciator panel test switch and turns on indicator
    -- light if annunciator switch is held in.
function testmode(testing)
    if testing == 1 then
        visible(light_on_id, true)    
    else
        visible(light_on_id, false)
    end
end


--***********************************************VARIABLE SUBSCRIPTIONS***********************************************
fs2020_variable_subscribe("PROP RPM:1", "RPM",
                                          "PROP RPM:2", "RPM", 
                                          set_RPM)      
fs2020_variable_subscribe("L:ANUNNCIATOR_TEST_SWITCH", "Number", 
                                           testmode)   
   
fs2020_variable_subscribe("L:PHASE_KNOB_CONVERT", "Number", 
                                            "L:XMLVAR_PHASE_KNOB_Position","Number", 
                                            phase_knob)
                                                                                                                
--*********************************************END VARIABLE SUBSCRIPTIONS*********************************************