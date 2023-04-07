--[[
******************************************************************************************
********* HJet (MG FlightFX) AUTOMATIC FLIGHT CONTROL SYSTEM *****************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Automatic Flight Control System (autopilot) for the HJet

- **v1.0** - 2022-12-11
    - Original Release
    
NOTES: 
- Designed for the HJet by Marwan Gharib. Will not work with any other aircraft.

KNOWN ISSUES:
- None

ATTRIBUTION:
All graphics, sounds and code original work by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--
-- User Properties
knobster_prop = user_prop_add_boolean("Use Knobster for thumbwheel", false, "Choose whether to use Knobster or touch control for the thumb wheel")
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

--    variables

local atActive = 0
local vnvMode = 0
local fmsMode = 0
local altValue = 0
local currentHeading = 0
local vnvActive = 0
local vnvArmed = 0
local elecState = 0


--    sound config
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end


img_add_fullscreen("background.png")
function releaseAction()
    sound_play(release_snd)
end

--KNOBS
--    crs 1
function crs1KnobAction(direction)
    if direction == 1 then
        fs2020_event("H:AS3000_PFD_1_CRS_INC")
    elseif direction == -1 then
        fs2020_event("H:AS3000_PFD_1_CRS_DEC")
    end
    sound_play(dial_snd)
end
function crs1PressAction()
    sound_play(press_snd)
    fs2020_event("H:AS3000_PFD_1_CRS_PUSH")
end
crs1_id = dial_add(nil, 30, 118, 60, 60, crs1KnobAction)
crs1_press_id = button_add(nil, nil, 40, 128, 40,40, crs1PressAction, releaseAction)

--    hdg
function hdgKnobAction(direction)
    if direction == 1 then
        fs2020_event("HEADING_BUG_INC")
    elseif direction == -1 then
        fs2020_event("HEADING_BUG_DEC")
    end
    sound_play(dial_snd)
end
function hdgPressAction()
    sound_play(press_snd)
    -- fs2020_event("H:AS1000_PFD_HEADING_SYNC")
    fs2020_event("HEADING_BUG_SET", currentHeading)	
end
hdg_id = dial_add("heading_dial.png", 195, 118, 56, 56, hdgKnobAction)
hdg_press_id = button_add(nil, nil, 202, 123, 40, 40, hdgPressAction, releaseAction)

--    alt
function altKnobInnerAction(direction)
    if direction == 1 then
        newAlt = altValue + 100
        
    elseif direction == -1 then
        newAlt = altValue - 100
    end
    fs2020_variable_write("L:HJET_AP_ALT_VAR", "NUMBER",  newAlt)
    sound_play(dial_snd)
end

function altKnobOuterAction(direction)
    if direction == 1 then
        newAlt = altValue + 1000
        
    elseif direction == -1 then
        newAlt = altValue - 1000
    end
    fs2020_variable_write("L:HJET_AP_ALT_VAR", "NUMBER",  newAlt)
    sound_play(dial_snd)
end
alt_outer_id = dial_add(nil, 415, 118, 60, 60, altKnobOuterAction)

alt_inner_id = dial_add(nil, 425, 128, 40, 40, altKnobInnerAction)


--    spd
function spdKnobAction(direction)
    if direction == 1 then
        fs2020_event("AP_SPD_VAR_INC")
    elseif direction == -1 then
        fs2020_event("AP_SPD_VAR_DEC")
    end
    sound_play(dial_snd)
end
function spdPressAction()
    sound_play(press_snd)
     fs2020_event("AP_MANAGED_SPEED_IN_MACH_TOGGLE")
end
spd_id = dial_add(nil, 642, 118, 60, 60, spdKnobAction)
spd_press_id = button_add(nil, nil, 652, 128, 40, 40, spdPressAction, releaseAction)

--    crs 2
function crs2KnobAction(direction)
    if direction == 1 then
        fs2020_event("H:AS3000_PFD_2_CRS_INC")
    elseif direction == -1 then
        fs2020_event("H:AS3000_PFD_2_CRS_DEC")
    end
    sound_play(dial_snd)
end

function crs2PressAction()
    sound_play(press_snd)
    fs2020_event("H:AS3000_PFD_2_CRS_PUSH")
end
crs2_id = dial_add(nil, 773, 118, 60, 60, crs2KnobAction)

crs2_press_id = button_add(nil, nil, 783, 128, 40, 40, crs2PressAction, releaseAction)

--THUMBWHEEL

function thumbwheelAction(direction)
    if direction == 1 then
        fs2020_event("AP_VS_VAR_INC")
    else
        fs2020_event("AP_VS_VAR_DEC")
    end 
end

vs_scrollwheel = scrollwheel_add_ver("thumbwheel.png", 557, 72, 25, 120, 25, 19, thumbwheelAction)

if user_prop_get(knobster_prop) then
    thumbwheel_dial_id = dial_add(nil, 557, 72, 25, 120, thumbwheelAction)
end


tw_shadow_id = img_add("thumbwheel_shadow.png", 557, 72, 25, 120)
--BUTTONS
--    fd
function fdAction()
    sound_play(press_snd)
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")   
end
fd1_id = button_add(nil, "pressed.png", 41, 23, 44, 28, fdAction, releaseAction)

--    nav
function navAction()
    sound_play(press_snd)
    fs2020_event("AP_NAV1_HOLD")
end
nav_id = button_add(nil, "pressed.png", 125, 23, 44, 28, navAction, releaseAction)

--    apr
function aprAction()
    sound_play(press_snd)
    fs2020_event("K:AP_APR_HOLD")
end

apr_id = button_add(nil, "pressed.png", 125, 87, 44, 28, aprAction, releaseAction)

--    bank
function bankAction()
    sound_play(press_snd)
    fs2020_event("AP_MAX_BANK_INC")
end

bank_id = button_add(nil, "pressed.png", 125, 159, 44, 28, bankAction, releaseAction)

--    hdg
function hdgAction()
    sound_play(press_snd)
    fs2020_event("AP_PANEL_HEADING_HOLD")
end
hdg_id = button_add(nil, "pressed.png", 202, 23, 44, 28, hdgAction, releaseAction)

--    ap
function apAction()
    sound_play(press_snd)
    fs2020_event("AP_MASTER")  
end
ap_id = button_add(nil, "pressed.png", 278, 23, 44, 28, apAction, releaseAction)

--    yd
function ydAction()
    sound_play(press_snd)
    fs2020_event("YAW_DAMPER_TOGGLE")
end
yd_id = button_add(nil, "pressed.png", 340, 23, 44, 28, ydAction, releaseAction)

--    at
function atAction()
    sound_play(press_snd)
    if atActive == 1 then
        fs2020_variable_write("L:CSC PUSHED", "NUMBER", 3)
        fs2020_variable_write("L:CSC PUSHED", "NUMBER", 0)
    else
        fs2020_variable_write("L:CSC PUSHED", "NUMBER", 3)
        fs2020_variable_write("L:CSC PUSHED", "NUMBER", 1)
    end
    
end
at_id = button_add(nil, "pressed.png", 307, 89, 44, 28, atAction, releaseAction)

--    cpl
function cplAction()
    sound_play(press_snd)
    
end
cpl_id = button_add(nil, "pressed.png", 307, 159, 44, 28, cplAction, releaseAction)

--    alt
function altAction()
    sound_play(press_snd)
    fs2020_event("AP_PANEL_ALTITUDE_HOLD")
end
alt_id = button_add(nil, "pressed.png", 414, 23, 44, 28, altAction, releaseAction)

--    vnav        
function vnvAction()
    sound_play(press_snd)
    if vnvMode == 1 then
        fs2020_variable_write("L:XMLVAR_VNAVButtonValue", "Number", 3)
        fs2020_variable_write("L:XMLVAR_VNAVButtonValue", "Number", 0)
    else
        fs2020_variable_write("L:XMLVAR_VNAVButtonValue", "Number", 3)
        fs2020_variable_write("L:XMLVAR_VNAVButtonValue", "Number", 1)
    end
end
vnv_id = button_add(nil, "pressed.png", 480, 23, 44, 28, vnvAction, releaseAction)

--    vs
function vsAction()
    sound_play(press_snd)
    fs2020_event("AP_PANEL_VS_HOLD")
end
vs_id = button_add(nil, "pressed.png", 554, 23, 44, 28, vsAction, releaseAction)

--    flc
function flcAction()
    sound_play(press_snd)
    fs2020_event("K:FLIGHT_LEVEL_CHANGE")
    
end
flc_id = button_add(nil, "pressed.png", 650, 23, 44, 28, flcAction, releaseAction)

--    fd2
fd2_id = button_add(nil, "pressed.png", 782, 23, 44, 28, fdAction, releaseAction)

--    fms
function fmsAction()
    sound_play(press_snd)
    fs2020_variable_write("L:HJET_THROTTLE_MAN", "NUMBER", 3)  
    fs2020_variable_write("L:HJET_THROTTLE_MAN", "NUMBER", 0)  
end

fms_id = button_add(nil, nil, 600, 100, 40, 22, fmsAction, releaseAction)

--    man
function manAction()
    sound_play(press_snd)
    fs2020_variable_write("L:HJET_THROTTLE_MAN", "NUMBER", 3)  
    fs2020_variable_write("L:HJET_THROTTLE_MAN", "NUMBER", 1)  
end
spd_id = button_add(nil, nil, 702, 100, 40, 22, manAction, releaseAction)

at_mode_ind_id = img_add("at_mode_selector.png", 630, 106, 80, 80)


function setVars(atModeVar, vnav, fms, alt, heading, vnvAct, vnvArm, elecSt)
    atActive = atModeVar
    vnvMode = vnav
    fmsMode = fms
    altValue = alt
    currentHeading = heading
    vnvActive = vnvAct
    vnvArmed = vnvArm
    elecState = elecSt
    if fmsMode == 1 then
        rotate(at_mode_ind_id, 90, "LINEAR", 0.1)
    else
        rotate(at_mode_ind_id, 0, "LINEAR", 0.1)
    end
    
    if  (vnvActive ~= 1 and vnvArmed ~=1) and elecState == 1 then
        opacity(vnv_annunciator_white_id, 0.7)
    else
        opacity(vnv_annunciator_white_id, 0)
    end
    if  vnvActive == 1 and elecState == 1 then
        opacity(vnv_annunciator_green_id, 0.7)
    else
        opacity(vnv_annunciator_green_id, 0)
    end
    if  vnvArmed == 1 and elecState == 1 then
        opacity(vnv_annunciator_yellow_id, 0.7)
    else
        opacity(vnv_annunciator_yellow_id, 0)
    end
end
function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
		visible(vnv_annunciator_green_id, true)
		opacity(vnv_annunciator_green_id, 1)
    else
		visible(vnv_annunciator_green_id, false)
		opacity(vnv_annunciator_green_id, 0)

        setVars(atActive,vnvMode,fmsMode,altValue,currentHeading,vnvActive,vnvArmed,elecState)
    end
end
fs2020_variable_subscribe("L:CSC PUSHED", "NUMBER", 
                                               "L:XMLVAR_VNAVButtonValue", "NUMBER",
                                               "L:HJET_THROTTLE_MAN", "NUMBER", 
                                               "L:HJET_AP_ALT_VAR", "NUMBER", 
                                               "PLANE HEADING DEGREES MAGNETIC", "Degrees",
                                               "L:VNAV_ACTIVE", "NUMBER",
                                               "L:VNAV_ARMED", "NUMBER",
                                               "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",
                                               setVars)
-- #fee960
fs2020_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
			"L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)
vnv_annunciator_gray_id = canvas_add(493, 61, 20, 20, function()
  _circle(7, 7, 7)
  _fill("#2e2e2b")
end)
opacity(vnv_annunciator_gray_id, 1)
vnv_annunciator_white_id = canvas_add(493, 61, 20, 20, function()
  _circle(7, 7, 7)
  _fill("white")
end)
opacity(vnv_annunciator_white_id, 0,"LOG", 0.2)
vnv_annunciator_yellow_id = canvas_add(493, 61, 20, 20, function()
  _circle(7, 7, 7)
  _fill("#fee960")
end)
opacity(vnv_annunciator_yellow_id, 0,"LOG", 0.2)
vnv_annunciator_green_id = canvas_add(493, 61, 20, 20, function()
  _circle(7, 7, 7)
  _fill("#42f563")
end)
opacity(vnv_annunciator_green_id, 0,"LOG", 0.2)
