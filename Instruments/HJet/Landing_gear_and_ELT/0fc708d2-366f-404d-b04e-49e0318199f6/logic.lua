--[[
******************************************************************************************
************** HJet (MG FlightFX) LANDING GEAR AND ELT PANEL ********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Landing gear and ELT panel for the HJet

- **v1.0** - 2023-04-07
    - Original Release
    
NOTES: 
- Designed for the HJet by Marwan Gharib. Will not work with any other aircraft.


KNOWN ISSUES:
- ELT knob will not control the knob in the virtual cockpit. This is a limitation of 
  the plane itself and the knob being controls by inaccessible B vars.

ATTRIBUTION:
All graphics, sounds and code original work by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--
-- User Properties

play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

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

--    variables
local gearState = false
local eltState = 0
local noseWheelState = 0
local eltActive = 0
local elecState = 0


--    images
img_add_fullscreen("background.png")

eltIndicatorOutline = canvas_add(180, 26, 30, 30, function()
  _circle(15, 15, 7)

  _stroke("white",1)
end)
eltIndicatorOff = canvas_add(190, 36, 10, 10, function()
  _circle(5, 5, 6)
  _fill_gradient_radial(5,5, 4, 6, "gray", "yellow")
  _fill("gray")
end)

eltIndicatorOn = canvas_add(190, 36, 10, 10, function()
  _circle(5, 5, 6)
  _fill("red")
end)
visible(eltIndicatorOn, 0)

function eltAction(direction)
    sound_play(dial_snd)
    if direction == 1 then
        if eltState ==1 then
          fs2020_event("K:ELT_ON")
          fs2020_variable_write("L:XMLVAR_ELT_STATE", "ENUM", 2)
        elseif eltState ==3 then
            fs2020_event("K:ELT_OFF")
            fs2020_variable_write("L:XMLVAR_ELT_STATE", "ENUM", 1)        
        end
    elseif direction == -1 then
        if eltState ==2 then
            fs2020_event("K:ELT_OFF")
          fs2020_variable_write("L:XMLVAR_ELT_STATE", "ENUM", 1)
        elseif eltState ==1 then
            fs2020_event("K:ELT_OFF")
          fs2020_variable_write("L:XMLVAR_ELT_STATE", "ENUM", 3) 
          fs2020_variable_write("L:XMLVAR_ELT_STATE", "ENUM", 3) 
            
        end
    end
end

elt_id = img_add("knob.png", 50, 70, 100, 100)
elt_knob_id = dial_add(nil, 50, 70, 100, 100, eltAction)

local flasherState = false

function releaseAction()
    sound_play(release_snd)
end 

function noseWheelAction()
    sound_play(press_snd)
    fs2020_variable_write("L:NWS PUSHED", "NUMBER", 3)    -- added to get around an Air Manager bug
    if noseWheelState == 1 then
        fs2020_variable_write("L:NWS PUSHED", "NUMBER", 0)
    else
        fs2020_variable_write("L:NWS PUSHED", "NUMBER", 1)
    end
end
nsw_id = button_add(nil, "pressed.png", 288, 84, 62, 56, noseWheelAction, releaseAction)

function gearAction()
    fs2020_event("TOGGLE LANDING GEAR")
end
gear_switch_id = switch_add(nil, nil, 460, 30, 60, 140, gearAction )
gear_id = img_add("gear.png", 448, 60, 87, 161 )

--    annunciators

norm_id = img_add("annun_norm_white.png", 292, 90, 55, 23, "visible:false")
off_id = img_add("annun_off_yellow.png", 299, 110, 39, 23, "visible:false")

rate = 0.02
opacity(norm_id, 1.0, "LOG", rate)
opacity(off_id, 1.0, "LOG", rate)
visible(norm_id, false)
visible(off_id, false)

function setValues(gear, elt, nose, eltAct, eltSt)
    gearState = gear
    eltState = elt
    noseWheelState = nose
    eltActive = eltAct
    elecState = eltSt
    --print(elt)
     --set states
     --    landing gear
     if gearState then
         move(gear_id, 448, 60, 87, 161, "LINEAR", 0.05)
     else
         move(gear_id, 448, 10, 87, 161, "LINEAR", 0.05)   
     end
    --    nose wheel steering
    if noseWheelState == 1 then
        visible(norm_id, false)
        visible(off_id, true)
        opacity(norm_id, 0)
        opacity(off_id, 1)
    else
        visible(norm_id, true)
        visible(off_id, false)
        opacity(norm_id, 1)
        opacity(off_id, 0)
    end           
    
    --    ELT
    if eltState == 3 then
        rotate(elt_id, -40, "LINEAR", 0.05)
    elseif eltState == 1 and eltActive ~= 1 then
        rotate(elt_id, 0, "LINEAR", 0.05)
    elseif eltState == 2  or eltActive ~= 0 then
        rotate(elt_id, 40, "LINEAR", 0.05)
    end
    
    if eltActive == 1 and eltState == 2 then
        flasher_timer = timer_start(0,200,flasher_timer_callback)
    elseif eltState == 3 then
        visible(eltIndicatorOn, 1)
        flasher_timer = timer_start(1000,5,flasher_timer_callback)
        timer_stop(flasher_timer)
    else
        timer_stop(flasher_timer)
        visible(eltIndicatorOn, 0)
        flasherState = false
    end
end

function flasher_timer_callback ()
    flasherState = not flasherState
    visible(eltIndicatorOn, flasherState)
end

function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
	visible(norm_id, true)
	visible(off_id, true)
        opacity(norm_id, 1)
        opacity(off_id, 1)
    else
	visible(norm_id, false)
	visible(off_id, false)
        opacity(norm_id, 0)
        opacity(off_id, 0)

        setValues(gearState, eltState, noseWheelState,eltActive, elecState)
    end

end

fs2020_variable_subscribe("A:GEAR HANDLE POSITION", "BOOL",
                                              "L:XMLVAR_ELT_STATE", "ENUM",
                                              "L:NWS PUSHED", "NUMBER",
                                              "A:ELT ACTIVATED", "NUMBER",
                                              "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",                                           
                                              setValues)
fs2020_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
							"L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)