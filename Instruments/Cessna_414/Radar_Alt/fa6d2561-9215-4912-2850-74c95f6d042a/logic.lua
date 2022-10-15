--[[
******************************************************************************************
***************CESSNA 414AW CHANCELLOR RADAR ALTIMETER*********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Radar altimeter for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Will only work with the FlySimWare Cessna 414AW for Microsoft Flight Simulator
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- None

ATTRIBUTION:
Code, graphics and sounds by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")  

-- Set global user prop options
    --     sounds
if user_prop_get(play_sounds) then
    dial_snd = sound_add("dial.wav")
    sound_volume(dial_snd, 0.4)
    press_snd = sound_add("press.wav")
    sound_volume(press_snd, 0.5)
    release_snd = sound_add("release.wav")
    sound_volume(release_snd, 0.5)
else
    dial_snd = sound_add("silence.wav")
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
end

    --    user prop for glass front set below to maintain image z-order
    
--********************************************* END USER PROPERTY CONFIG*********************************************

-- VARIABLES
local flagAnimationSpeed = 0.07
local flagAnimationType = "LINEAR"
local needle_speed = 0.05
local needle_increment = 10
local timer_period = 53
local radiobug = 0
local bus_volts = 0
local decisionHeight = 0
local test_active = false
local radio_alt = 0 -- value from sim
local test_alt = 0 -- feeder value for needle test animation
local alt = 0 -- display value on gauge


-- LOAD IMAGES

        --    Dial face
img_add_fullscreen("face.png")
img_add("face_shadow.png", -15, -10, 600, 600)

    --    Needle
shadow_needle = img_add("needle_shadow.png", 10, 10, 600, 600)
opacity(shadow_needle, 0.5)
img_needle = img_add_fullscreen("needle.png")

    --    Altitude bug
shadow_bug = img_add("shadow_bug.png", 5, 5, 600, 600)
opacity(shadow_bug, 0.5)
img_bug = img_add_fullscreen("radar_bug.png")
new_flag = img_add_fullscreen("flag.png")
img_add_fullscreen("inner_bezel_cover.png")

    --    Glass front - only show if user prop
if user_prop_get(showBezelGlare )then
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)       
end   

    -- bezel
img_add_fullscreen("bezel_frame.png")

    --    DH indicator light
dh_ind_light_id = img_add_fullscreen("indicator_light_on.png")
opacity(dh_ind_light_id, 0)

    --    Desicion altitude knob
knob_shadow_id = img_add("knob_shadow.png", 478,488,96,76)
opacity(knob_shadow_id, 0.5)
rotate(knob_shadow_id, 45)
knob_body_id = img_add("knob_body.png", 475,475,76,76)

    -- test button shadow
test_shadow_id = img_add("knob_shadow.png", 58, 493, 53, 47)
opacity(test_shadow_id, 0.5)
rotate(test_shadow_id, 45)

-- END LOAD IMAGES

--FUNCTIONS
    --    convert decision altitude to degrees
function alt_to_degrees(altitude)
    if altitude <= 500 then
        degrees = altitude * (180 / 500)
    elseif altitude > 500 then
        degrees = 180 + ((altitude - 500) * (70 / 1500))
    end
    return degrees
end

    --    set decision height bug
function setBug(radiobug)  
    radiobug = var_cap(radiobug, -20,2500)    -- constrain value range from -20 to 2500 feet
    decisionHeight = radiobug
    degrees = alt_to_degrees(radiobug)
    rotate(img_bug, degrees)
    rotate(shadow_bug, degrees)
end

    -- Set decision altitude with knob
function setDecisionAlt(direction)
    if direction == 1 then
        fs2020_event("INCREASE_DECISION_HEIGHT")
    elseif direction == -1 then
        fs2020_event("DECREASE_DECISION_HEIGHT")
    end 
    sound_play(dial_snd)
end
dh_knob_id = dial_add("knob_face.png",475,475,76,76, setDecisionAlt)

    --    rotate altitude needle
function setAltitude(radioalt)
    if test_active then 
        alt = test_alt 
        needle_speed = 0.05
    else
        alt = radioalt
        radio_alt = radioalt 
        if radioalt <= decisionHeight and radioalt > 50 and bus_volts > 3 then
            opacity(dh_ind_light_id, 0.8)
        else
            opacity(dh_ind_light_id, 0.05)  
        end
        needle_speed = 0.1 
    end
    alt = var_cap(alt, -20,3000)
    degrees = alt_to_degrees(alt)
    rotate(img_needle, degrees, "LINEAR", needle_speed)
    rotate(shadow_needle, degrees,  "LINEAR", needle_speed)
end

    --    test button
function testSwitchPress()
    if bus_volts > 3 then
        test_active = true
        fs2020_variable_write("L:GROUND_RADAR_TEST_SWITCH", "ENUM", 1)
        opacity(dh_ind_light_id, 0.8)
        sound_play(press_snd)
        visible(test_shadow_id, false)
        timer_stop(incrementTimer)
        timer_stop(incrementTimer2)
        test_alt = radio_alt
        incrementTimer = timer_start(0,timer_period, function() 
            test_alt = test_alt + needle_increment 
            if test_alt >= 3000 then
                timer_stop(incrementTimer) 
            end
            setAltitude(test_alt)
            end)
    end
end

function testSwitchRelease()
    fs2020_variable_write("L:GROUND_RADAR_TEST_SWITCH", "ENUM" , 0)
    opacity(dh_ind_light_id, 0.05)
    visible(test_shadow_id, true)
    sound_play(release_snd)
    timer_stop(incrementTimer)
    timer_stop(incrementTimer2)
    incrementTimer2 = timer_start(0,timer_period, function() 
        test_alt = test_alt - needle_increment
        if test_alt <= 0 or test_alt <= radio_alt then
            timer_stop(incrementTimer2) 
            test_active = false
        end
        setAltitude(test_alt)
        end)
end
testButton = button_add("test_btn.png", "test_btn_pressed.png", 58, 490, 45, 45, testSwitchPress, testSwitchRelease)

        -- Animate power flag
function activateFlag(power)
    if power == 1 then
        move(new_flag, -150, 0, 600, 600, flagAnimationType , flagAnimationSpeed )         
        rotate(new_flag, -20, flagAnimationType , flagAnimationSpeed )
    else
        move(new_flag, 0, 0, 600, 600, flagAnimationType ,flagAnimationSpeed )         
        rotate(new_flag, 0, flagAnimationType , flagAnimationSpeed )
    end
end

        -- Set Bus Volts local
function new_busvolts(volts)
    bus_volts = volts
    if volts > 0 then
        activateFlag(1)
    else
        activateFlag(0)
    end
end

--END FUNCTIONS
--VARIABLE SUBSCRIPTIONS
fs2020_variable_subscribe("A:DECISION HEIGHT", "FEET", setBug)
fs2020_variable_subscribe("A:RADIO HEIGHT", "FEET", setAltitude)
fs2020_variable_subscribe("A:ELECTRICAL MAIN BUS VOLTAGE", "VOLTS", new_busvolts)
