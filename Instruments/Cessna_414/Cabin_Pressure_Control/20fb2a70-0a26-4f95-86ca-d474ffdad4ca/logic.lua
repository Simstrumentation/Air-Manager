--[[
******************************************************************************************
**********CESSNA 414AW CHANCELLOR CABIN PRESSURIZATION CONTROL***********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Cabin presure control knob for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Only guaranteed to work with the Flysimware C414AW Chancellor

KNOWN ISSUES:
- None

ATTRIBUTION:
Code and graphics by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--

--***********************************************USER PROPERTY CONFIG***********************************************
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

img_add_fullscreen("bg.png")
dial_base_shadow_id=img_add("dial_base_shadow.png", 3, 3, 600, 600)
opacity(dial_base_shadow_id, 0.5)
dial_base_id=img_add_fullscreen("dial_base.png")
dial_knob_base_shadow_id = img_add("dial_knob_base_shadow.png", 3, 3, 600, 600)
opacity(dial_knob_base_shadow_id, 0.5)
dial_knob_base_id = img_add_fullscreen("dial_knob_base.png")

    -- show bezel screws if user prop selected. Screw rotation is randomized
if user_prop_get(showScrews ) then  
    screw_tl_id = img_add("screw.png", 34, 34, 70, 70)
    math.randomseed(os.clock()*100000000000)
    rotate(screw_tl_id, math.random(1,360))
    screw_tr_id = img_add("screw.png", 496, 34, 70, 70)
    math.randomseed(os.clock()*200000000000)
    rotate(screw_tr_id, math.random(1,360))
    --screw_bl_id = img_add("screw.png", 34, 500, 70, 70)
    --math.randomseed(os.clock()*300000000000)
    --rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end    

--LOCAL VARIABLES
local targetAltitude
local simAlt 

local adjustmentTable = { { -1000, 0   },
                          { 0   , 0   },
                          { 1007, 259 },
                          { 2014, 483 },
                          { 3020, 564 },
                          { 4026, 616 },
                          { 4987, 798 },
                          { 5996, 790 },
                          { 7007, 790 },
                          { 8018, 683 },
                          { 9029, 652 },
                          { 10047, 500 },
                          { 13000, 80 }}

function setPressure(direction)
    if direction == 1 then
        if targetAltitude >= -150 and targetAltitude <= 11950 then
            fs2020_event("K:PRESSURIZATION_PRESSURE_ALT_INC")
        else
            --play error sound
        end
        
    elseif direction == -1 then
        if targetAltitude >= 50 and targetAltitude <= 12500 then
            fs2020_event("K:PRESSURIZATION_PRESSURE_ALT_DEC")
        else
            --play error sound
        end
    end
end

pressure_knob = dial_add("dial_knob.png", 202, 202, 196, 196, setPressure)

function setPosition(goal)
    targetAltitude = goal + interpolate_linear(adjustmentTable, goal)
    print("adustedAlt:" ..targetAltitude)
    if targetAltitude >= -100 and targetAltitude <= 12100 then
        rotate(dial_base_id, ((targetAltitude-44)*(242/12000)), "LINEAR", 0.4, "FASTEST")
        rotate(dial_base_shadow_id, ((targetAltitude-44)*(242/12000)), "LINEAR", 0.4, "FASTEST")
    end
    
end

function setSimTarget(val)
    simAlt = val
    print("simAlt:"..val)
    setPosition(val)
end
fs2020_variable_subscribe("A:PRESSURIZATION CABIN ALTITUDE GOAL", "feet", 
                                            setSimTarget)

function adjustRate(direction)
    if direction == 1 then
        fs2020_event("PRESSURIZATION_CLIMB_RATE_INC")
        fs2020_event("H:KNOB_PRESSURIZATION_Knob_ClimbRate_INC")
    elseif direction == -1 then
        fs2020_event("PRESSURIZATION_CLIMB_RATE_DEC")
        fs2020_event("H:KNOB_PRESSURIZATION_Knob_ClimbRate_DEC")
    end
end
rate_adjustment_shadow_id = img_add("small_shadow.png", 10, 498,130,120)
rotate(rate_adjustment_shadow_id, 45)
opacity(rate_adjustment_shadow_id, 0.5)
rate_adjustment_id = dial_add("small_knob.png", 17,498,80,80, adjustRate)                                                                                        
