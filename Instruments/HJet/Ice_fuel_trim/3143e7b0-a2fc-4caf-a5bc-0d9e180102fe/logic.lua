--[[
******************************************************************************************
**************** HJet (MG FlightFX) ICE, FUEL AND TRIM PANEL ***********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Ice, fuel and trim panel and baro knob for the HJet

- **v1.0** - 2023-04-07
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
    --switch states
local powerState = false
local engIceLState = 0
local engIceRState = 0
local pitchState = 0
local rollState = 0
local yawState = 0
local windLState = 0
local windRState = 0
local flowLState = 0
local flowRState = 0
local bleedLState = 0
local bleedRState = 0

	--other states
local batteryState = 0
local gpowerState = 0
local electState = 0

    --knob states
local iceState = 0
local flowState = 0
local tailState = 0
local fuelLState = 0
local fuelRState  = 0
local fuelXFState = 0
local yawTrimState = 0
local thumbState = 0

img_add_fullscreen("background.png")


--    knobs and levers

    --    ice protection
function wingIceAction(direction)
    fs2020_variable_write("L:WINGAI_KNOB", "ENUM", 3)  
    if direction == 1 then
        if iceState == 0 then
            fs2020_variable_write("L:WINGAI_KNOB", "ENUM", 1)     
        elseif iceState == -1 then
            fs2020_variable_write("L:WINGAI_KNOB", "ENUM", 0)
        end
    else
         if iceState == 1 then
            fs2020_variable_write("L:WINGAI_KNOB", "ENUM", 0)     
        elseif iceState == 0 then
            fs2020_variable_write("L:WINGAI_KNOB", "ENUM", -1)
        end
    end
end
wing_ice_img = img_add("knob.png", 85, 111, 90, 90)   
wing_ice_id = dial_add(nil, 85, 111, 90, 90, wingIceAction)

        --    wing flow
function wingFlowAction(direction)
   fs2020_variable_write("L:WINGFLOW_KNOB", "ENUM", 3)  
    if direction == 1 then
        if flowState == 0 then
            fs2020_variable_write("L:WINGFLOW_KNOB", "ENUM", 1)     
        elseif flowState == -1 then
            fs2020_variable_write("L:WINGFLOW_KNOB", "ENUM",  0)
        end
    else
         if flowState == 1 then
            fs2020_variable_write("L:WINGFLOW_KNOB", "ENUM", 0)     
        elseif flowState == 0 then
            fs2020_variable_write("L:WINGFLOW_KNOB", "ENUM", -1)
        end
        end
end
wing_flow_img = img_add("knob.png", 101, 261, 90, 90)    
wing_flow_id =  dial_add(nil, 101, 261, 90, 90, wingFlowAction)    

    --    Tail de-ice
function tailIceAction(direction)
    fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", 3)  
    if direction == 1 then
        if tailState == 0 then
            fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", 1)
        elseif tailState == -1 then
            fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", 0)
        else
            fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", 1)
        end        
    else
        if tailState == 0 then
            fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", -1)
        elseif tailState == 1 then
            fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", 0)
      else
            fs2020_variable_write("L:TAILDEICE_KNOB", "ENUM", -1)  
        end 
    end
end
tail_ice_img = img_add("knob.png", 122, 514, 90, 90)   
tail_ice_id = dial_add(nil, 122, 514, 90, 90, tailIceAction)   

    --    fuel pump L
function fuelLeftAction(direction)
    fs2020_variable_write("L:FUELPL_KNOB", "ENUM", 3)  
    if direction == 1 then
        if fuelLState == 0 then
            fs2020_variable_write("L:FUELPL_KNOB", "ENUM", 1)
        elseif fuelLState == -1 then
            fs2020_variable_write("L:FUELPL_KNOB", "ENUM", 0)
        else
            fs2020_variable_write("L:FUELPL_KNOB", "ENUM", 1)
        end 
    else
        if fuelLState == 0 then
            fs2020_variable_write("L:FUELPL_KNOB", "ENUM", -1)
        elseif fuelLState == 1 then
            fs2020_variable_write("L:FUELPL_KNOB", "ENUM", 0)
      else
            fs2020_variable_write("L:FUELPL_KNOB", "ENUM", -1)
        end 
    end
end
fuel_left = img_add("knob.png", 269, 161, 90, 90)  
fuel_left_id = dial_add(nil, 269, 161, 90, 90, fuelLeftAction)    

    --    fuel pump R
function fuelRightAction(direction)
    fs2020_variable_write("L:FUELPR_KNOB", "ENUM", 3)  
    if direction == 1 then
        if fuelRState == 0 then
            fs2020_variable_write("L:FUELPR_KNOB", "ENUM", 1)
        elseif fuelRState == -1 then
            fs2020_variable_write("L:FUELPR_KNOB", "ENUM", 0)
        else
            fs2020_variable_write("L:FUELPR_KNOB", "ENUM", 1)
        end 
    else
        if fuelRState == 0 then
            fs2020_variable_write("L:FUELPR_KNOB", "ENUM", -1)
        elseif fuelRState == 1 then
            fs2020_variable_write("L:FUELPR_KNOB", "ENUM", 0)
      else
            fs2020_variable_write("L:FUELPR_KNOB", "ENUM", -1)
        end 
    end
end
fuel_right = img_add("knob.png", 563, 161, 90, 90)  
fuel_right_id = dial_add(nil, 563, 161, 90, 90, fuelRightAction)  

    --    fuel xfeed
function xfeedAction(direction)
    fs2020_variable_write("L:FUELXF_KNOB", "ENUM",3)  
    if direction == 1 then
        if fuelXFState == 0 then
            fs2020_variable_write("L:FUELXF_KNOB", "ENUM", 1) 
        elseif fuelXFState == -1 then
            fs2020_variable_write("L:FUELXF_KNOB", "ENUM", 0) 
        else
            fs2020_variable_write("L:FUELXF_KNOB", "ENUM", 1) 
        end 
    else
        if fuelXFState == 0 then
            fs2020_variable_write("L:FUELXF_KNOB", "ENUM", -1) 
        elseif fuelXFState == 1 then
            fs2020_variable_write("L:FUELXF_KNOB", "ENUM", 0) 
      else
            fs2020_variable_write("L:FUELXF_KNOB", "ENUM", -1) 
        end 
    end   
end
crossfeed_img = img_add("knob.png", 388, 126, 140, 140)  
crossfeed_id = dial_add(nil, 388, 126, 140, 140, xfeedAction)  

    --    yaw trim
function yawReleaseAction()
    rotate(yaw_img, 0, "LINEAR", 0.1)
end
function yawLAction()
    fs2020_event("K:RUDDER_TRIM_LEFT")
    rotate(yaw_img, -90, "LINEAR", 0.1)
end    
yaw_l_id = button_add(nil, nil, 450, 450, 80, 170, yawLAction, yawReleaseAction)  

function yawRAction()
    fs2020_event("K:RUDDER_TRIM_RIGHT")
    rotate(yaw_img, 90, "LINEAR", 0.1)
end    
yaw_r_id = button_add(nil, nil, 590, 450, 80, 170, yawRAction, yawReleaseAction)     
yaw_img = img_add("knob.png", 490, 474, 140, 140)  


--    buttons
function releaseAction()
    sound_play(release_snd)
end
    -- pitch

pitch_trim_img = img_add("trim.png", 278, 484, 138, 94)

function pitchRelease()
    --fs2020_variable_write("L:TRIM_THUMB", "ENUM", 0)
end

function pitchDownAction()
    fs2020_variable_write("L:TRIM_THUMB", "ENUM", 3)
    fs2020_variable_write("L:TRIM_THUMB", "ENUM", -1)
end

function pitchUpAction()
    fs2020_variable_write("L:TRIM_THUMB", "ENUM", 3)
    fs2020_variable_write("L:TRIM_THUMB", "ENUM", 1)
end
pitch_dn_id = button_add(nil, nil, 300, 450, 100, 54, pitchDownAction, pitchRelease)
pitch_up_id = button_add(nil, nil, 300, 560, 100, 54, pitchUpAction)


-- eng anti ice
function iceLeftAction ()
    sound_play(press_snd)
    fs2020_variable_write("L:HJET_ENGINEAI_L", "NUMBER", 3)
    if engIceLState == 1 then
        fs2020_variable_write("L:HJET_ENGINEAI_L", "NUMBER", 0)
    else
        fs2020_variable_write("L:HJET_ENGINEAI_L", "NUMBER", 1)
    end
end
ice_left_id = button_add(nil, "pressed.png", 72, 410, 60, 60, iceLeftAction, releaseAction)   

 function iceRightAction ()
    sound_play(press_snd)
    fs2020_variable_write("L:HJET_ENGINEAI_R", "NUMBER", 3)
    if engIceRState == 1 then
        fs2020_variable_write("L:HJET_ENGINEAI_R", "NUMBER", 0)
    else
        fs2020_variable_write("L:HJET_ENGINEAI_R", "NUMBER", 1)
    end
end
ice_right_id = button_add(nil, "pressed.png", 164, 410, 60, 60, iceRightAction, releaseAction)     

--    pitch mode
function pitchAction()
    sound_play(press_snd)
    --fs2020_variable_write("L:PITCHTRIM PUSHED", "NUMBER", 3)
    fs2020_event("K:ELEVATOR_TRIM_DISABLED_TOGGLE")
    if pitchState == 1 then
        --fs2020_variable_write("L:PITCHTRIM PUSHED", "NUMBER", 0)
    else
        --fs2020_variable_write("L:PITCHTRIM PUSHED", "NUMBER", 1)
    end 
end
pitch_id = button_add(nil, "pressed.png", 332, 358, 64, 64, pitchAction, releaseAction)    

--    roll power
function powerRollAction()
    sound_play(press_snd)
    --fs2020_variable_write("L:ROLLTRIM PUSHED", "NUMBER", 3)
    fs2020_event("K:AILERON_TRIM_DISABLED_TOGGLE")
    if rollState == 1 then
    --    fs2020_variable_write("L:ROLLTRIM PUSHED", "NUMBER", 0)
    else
    --    fs2020_variable_write("L:ROLLTRIM PUSHED", "NUMBER", 1)
    end
end
power_roll_id = button_add(nil, "pressed.png", 488, 358, 64, 64, powerRollAction, releaseAction)     

--    yaw power
function powerYawAction()
    sound_play(press_snd)
    fs2020_event("K:RUDDER_TRIM_DISABLED_TOGGLE")
    --fs2020_variable_write("L:YAWTRIM PUSHED", "NUMBER", 3)
    if yawState == 1 then
    --    fs2020_variable_write("L:YAWTRIM PUSHED", "NUMBER", 0)
    else
    --    fs2020_variable_write("L:YAWTRIM PUSHED", "NUMBER", 1)
    end 
end
 power_yaw_id = button_add(nil, "pressed.png", 588, 358, 64, 64, powerYawAction, releaseAction)   
 
 --    windshield heat L
 function windLAction()
     sound_play(press_snd)
     fs2020_variable_write("L:HJET_WINDSHEILDHEAT_L", "NUMBER", 3)
     if windLState == 1 then
         fs2020_variable_write("L:HJET_WINDSHEILDHEAT_L", "NUMBER", 0)
     else
         fs2020_variable_write("L:HJET_WINDSHEILDHEAT_L", "NUMBER", 1)
     end
 end
 wnd_l_id = button_add(nil, "pressed.png", 702, 128, 64, 64, windLAction, releaseAction)
 
 --    windshield heat R
  function windRAction()
     sound_play(press_snd)
     fs2020_variable_write("L:HJET_WINDSHEILDHEAT_R", "NUMBER", 3)
     if windRState == 1 then
         fs2020_variable_write("L:HJET_WINDSHEILDHEAT_R", "NUMBER", 0)
     else
         fs2020_variable_write("L:HJET_WINDSHEILDHEAT_R", "NUMBER", 1)
     end  
 end
 wnd_r_id = button_add(nil, "pressed.png", 794, 128, 64, 64, windRAction, releaseAction)
 
 --    inflow L
  function inflowLAction()
     sound_play(press_snd)
     fs2020_variable_write("L:HJET_CFLOWL", "NUMBER", 3)
     if flowLState == 0 then
         fs2020_variable_write("L:HJET_CFLOWL", "NUMBER", 1)
     else
         fs2020_variable_write("L:HJET_CFLOWL", "NUMBER", 0)
     end
 end
inflow_l_id = button_add(nil, "pressed.png", 702, 296, 64, 64, inflowLAction, releaseAction)

 --    inflow R
  function inflowRAction()
     sound_play(press_snd)
     fs2020_variable_write("L:HJET_CFLOWR", "NUMBER", 3)
     if flowRState == 0 then
         fs2020_variable_write("L:HJET_CFLOWR", "NUMBER", 1)
     else
         fs2020_variable_write("L:HJET_CFLOWR", "NUMBER", 0)
     end
 end
inflow_r_id = button_add(nil, "pressed.png", 794, 296, 64, 64, inflowRAction, releaseAction)

--    bleed L
  function bleedLAction()
    sound_play(press_snd)
    fs2020_event("K:ENGINE_BLEED_AIR_SOURCE_TOGGLE", 1) 
 end
bleed_l_id = button_add(nil, "pressed.png", 685, 460, 64, 64, bleedLAction, releaseAction)

--    bleed R
  function bleedRAction()
     sound_play(press_snd)
     fs2020_event("K:ENGINE_BLEED_AIR_SOURCE_TOGGLE", 2)
 end
bleed_R_id = button_add(nil, "pressed.png", 776, 460, 64, 64, bleedRAction, releaseAction)

function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
        visible(annun_ice_l_on, true)
        visible(annun_ice_l_off, true)
        visible(annun_ice_r_on, true)
        visible(annun_ice_r_off, true)
        visible(annun_pitch_norm, true)
        visible(annun_pitch_stby, true)
        visible(annun_roll_norm, true)
        visible(annun_roll_off, true)
        visible(annun_yaw_norm, true)
        visible(annun_yaw_off, true)
        visible(annun_ws_l_norm, true)
        visible(annun_ws_l_off, true)
        visible(annun_ws_r_norm, true)
        visible(annun_ws_r_off, true)
        visible(annun_cf_l_norm, true)
        visible(annun_cf_l_off, true)
        visible(annun_cf_r_norm, true)
        visible(annun_cf_r_off, true)
        visible(annun_bleed_l_norm, true)
        visible(annun_bleed_l_off, true)
        visible(annun_bleed_r_norm, true)
        visible(annun_bleed_r_off, true)
		
		opacity(annun_ice_l_on, 1)
		opacity(annun_ice_l_off, 1)
		opacity(annun_ice_r_on, 1)
		opacity(annun_ice_r_off, 1)
		opacity(annun_pitch_norm, 1)     
		opacity(annun_pitch_stby, 1)
		opacity(annun_roll_norm, 1)
		opacity(annun_roll_off, 1)
		opacity(annun_yaw_norm, 1)
		opacity(annun_yaw_off, 1) 
		opacity(annun_ws_l_norm, 1)
		opacity(annun_ws_l_off, 1)
		opacity(annun_ws_r_norm, 1)       
		opacity(annun_ws_r_off, 1)
		opacity(annun_cf_l_norm, 1)      
		opacity(annun_cf_l_off, 1)
		opacity(annun_cf_r_norm, 1)  
		opacity(annun_cf_r_off, 1)
		opacity(annun_bleed_l_norm, 1) 
		opacity(annun_bleed_l_off, 1)
		opacity(annun_bleed_r_norm, 1)
		opacity(annun_bleed_r_off, 1)

    else
        visible(annun_ice_l_on, false)
        visible(annun_ice_l_off, false)
        visible(annun_ice_r_on, false)
        visible(annun_ice_r_off, false)
        visible(annun_pitch_norm, false)
        visible(annun_pitch_stby, false)
        visible(annun_roll_norm, false)
        visible(annun_roll_off, false)
        visible(annun_yaw_norm, false)
        visible(annun_yaw_off, false)
        visible(annun_ws_l_norm, false)
        visible(annun_ws_l_off, false)
        visible(annun_ws_r_norm, false)
        visible(annun_ws_r_off, false)
        visible(annun_cf_l_norm, false)
        visible(annun_cf_l_off, false)
        visible(annun_cf_r_norm, false)
        visible(annun_cf_r_off, false)
        visible(annun_bleed_l_norm, false)
        visible(annun_bleed_l_off, false)
        visible(annun_bleed_r_norm, false)
        visible(annun_bleed_r_off, false)
		
		opacity(annun_ice_l_on, 0)
		opacity(annun_ice_l_off, 0)
		opacity(annun_ice_r_on, 0)
		opacity(annun_ice_r_off, 0)
		opacity(annun_pitch_norm, 0)     
		opacity(annun_pitch_stby, 0)
		opacity(annun_roll_norm, 0)
		opacity(annun_roll_off, 0)
		opacity(annun_yaw_norm, 0)
		opacity(annun_yaw_off, 0) 
		opacity(annun_ws_l_norm, 0)
		opacity(annun_ws_l_off, 0)
		opacity(annun_ws_r_norm, 0)       
		opacity(annun_ws_r_off, 0)
		opacity(annun_cf_l_norm, 0)      
		opacity(annun_cf_l_off, 0)
		opacity(annun_cf_r_norm, 0)  
		opacity(annun_cf_r_off, 0)
		opacity(annun_bleed_l_norm, 0) 
		opacity(annun_bleed_l_off, 0)
		opacity(annun_bleed_r_norm, 0)
		opacity(annun_bleed_r_off, 0)

        setValues(iceState, flowState, tailState,fuelLState, fuelRState, fuelXFState, engIceLState,engIceRState,pitchState,rollState,yawState,thumbState,windLState,windRState,flowLState,flowRState,bleedLState,bleedRState,batteryState,gpowerState,electState)

    end

end

function setValues(wingice, wingflow, tail, pump_l, pump_r, xfeed, ice_l, ice_r, pitchmode, roll, yaw, trimthumb, wind_l, wind_r, cflow_l, cflow_r, bleed_l, bleed_r, battery, gpower, elecST)
    if battery or gpower == 1 or elecST == 1 then
        powerState = true
    else
        powerState = false
    end
    -- set variable values
    iceState = wingice
    flowState = wingflow
    tailState = tail
    fuelLState = pump_l
    fuelRState  = pump_r
    fuelXFState = xfeed
    engIceLState = ice_l
    engIceRState = ice_r
    pitchState = pitchmode
    rollState = roll
    yawState = yaw
    thumbState = trimthumb
    windLState = wind_l
    windRState = wind_r
    flowLState = cflow_l
    flowRState = cflow_r
	bleedLState = bleed_l
	bleedRState = bleed_r
	batteryState = battery
	gpowerState = gpower
	electState = elecST
    
    
--     set knob positions   
    --    wing ice      
    if wingice == 0 then
        rotate(wing_ice_img, 0, "LINEAR", 0.1)
    elseif wingice == 1 then
        rotate(wing_ice_img, 45, "LINEAR", 0.1)
    elseif wingice == -1 then
        rotate(wing_ice_img, -45, "LINEAR", 0.1)
    end
    --    wing flow
    if wingflow == 0 then
        rotate(wing_flow_img, 0, "LINEAR", 0.1)
    elseif wingflow == 1 then
        rotate(wing_flow_img, 90, "LINEAR", 0.1)
    elseif wingflow == -1 then
        rotate(wing_flow_img, -90, "LINEAR", 0.1)
    end    
    
    --    tail ice
     if tail == 0 then
        rotate(tail_ice_img, 0, "LINEAR", 0.1)
    elseif tail == 1 then
        rotate(tail_ice_img, 45, "LINEAR", 0.1)
    elseif tail == -1 then
        rotate(tail_ice_img, -45, "LINEAR", 0.1)
    end     
 
    --    left pump
      if pump_l == 0 then
        rotate(fuel_left, 0, "LINEAR", 0.1)
    elseif pump_l == 1 then
        rotate(fuel_left, 45, "LINEAR", 0.1)
    elseif pump_l == -1 then
        rotate(fuel_left, -45, "LINEAR", 0.1)
    end      
    
    --    right pump
      if pump_r == 0 then
        rotate(fuel_right, 0, "LINEAR", 0.1)
    elseif pump_r == 1 then
        rotate(fuel_right, 45, "LINEAR", 0.1)
    elseif pump_r == -1 then
        rotate(fuel_right, -45, "LINEAR", 0.1)
    end     

    --    crossfeed
      if xfeed == 0 then
        rotate(crossfeed_img, 0, "LINEAR", 0.1)
    elseif xfeed == 1 then
        rotate(crossfeed_img, 90, "LINEAR", 0.1)
    elseif xfeed == -1 then
        rotate(crossfeed_img, -90, "LINEAR", 0.1)
    end     
    
    --trim thumblever
    if trimthumb == 0 then                                                
        move(pitch_trim_img, 278, 484, 138, 94, "LINEAR", 0.5)
    elseif trimthumb == 1 then
         move(pitch_trim_img, 278, 514, 138, 94, "LINEAR", 0.5)
    elseif trimthumb == -1 then
        move(pitch_trim_img, 278, 454, 138, 94, "LINEAR", 0.5)
    end
        --Annunciator states
		
    if powerState then
        --    engine ice L
        if ice_l == 1 then
            visible(annun_ice_l_on, true)
            visible(annun_ice_l_off, false)
			opacity(annun_ice_l_on, 1)
			opacity(annun_ice_l_off, 0)
        else
           visible(annun_ice_l_on, false)
           visible(annun_ice_l_off, true)
			opacity(annun_ice_l_on, 0)
			opacity(annun_ice_l_off, 1)
        end
        --    engine ice R
        if ice_r == 1 then
            visible(annun_ice_r_on, true)
            visible(annun_ice_r_off, false)
			opacity(annun_ice_r_on, 1)
			opacity(annun_ice_r_off, 0)
        else
           visible(annun_ice_r_on, false)
           visible(annun_ice_r_off, true)
			opacity(annun_ice_r_on, 0)
			opacity(annun_ice_r_off, 1)
        end
        --    pitch
        if pitchmode == 0 then
            visible(annun_pitch_norm, true)
            visible(annun_pitch_stby, false)
			opacity(annun_pitch_norm, 1)
			opacity(annun_pitch_stby, 0)
        else
            visible(annun_pitch_norm, false)
            visible(annun_pitch_stby, true)
			opacity(annun_pitch_norm, 0)
			opacity(annun_pitch_stby, 1)
        end
        
        --    roll
        if roll == 0 then
            visible(annun_roll_norm, true)
            visible(annun_roll_off, false)
			opacity(annun_roll_norm, 1)
			opacity(annun_roll_off, 0)
        else
            visible(annun_roll_norm, false)
            visible(annun_roll_off, true)
			opacity(annun_roll_norm, 0)
			opacity(annun_roll_off, 1)
        end
        
        --    yaw
        if yaw == 0 then
            visible(annun_yaw_norm, true)
            visible(annun_yaw_off, false)
			opacity(annun_yaw_norm, 1)
			opacity(annun_yaw_off, 0)
        else
            visible(annun_yaw_norm, false)
            visible(annun_yaw_off, true)
			opacity(annun_yaw_norm, 0)
			opacity(annun_yaw_off, 1)
        end
        
        -- windshield L
        if wind_l == 0 then
            visible(annun_ws_l_norm, true)
            visible(annun_ws_l_off, false)
			opacity(annun_ws_l_norm, 1)
			opacity(annun_ws_l_off, 0)
        else
            visible(annun_ws_l_norm, false)
            visible(annun_ws_l_off, true)
			opacity(annun_ws_l_norm, 0)
			opacity(annun_ws_l_off, 1)
        end
        
        -- windshield R
        if wind_r == 0 then
            visible(annun_ws_r_norm, true)
            visible(annun_ws_r_off, false)
			opacity(annun_ws_r_norm, 1)
			opacity(annun_ws_r_off, 0)
        else
            visible(annun_ws_r_norm, false)
            visible(annun_ws_r_off, true)
			opacity(annun_ws_r_norm, 0)
			opacity(annun_ws_r_off, 1)
        end
        
                -- cabin flow L
        if cflow_l == 0 then
            visible(annun_cf_l_norm, true)
            visible(annun_cf_l_off, false)
			opacity(annun_cf_l_norm, 1)
			opacity(annun_cf_l_off, 0)
        else
            visible(annun_cf_l_norm, false)
            visible(annun_cf_l_off, true)
			opacity(annun_cf_l_norm, 0)
			opacity(annun_cf_l_off, 1)
        end
        
                -- cabin flow r
        if cflow_r== 0 then
            visible(annun_cf_r_norm, true)
            visible(annun_cf_r_off, false)
			opacity(annun_cf_r_norm, 1)
			opacity(annun_cf_r_off, 0)
        else
            visible(annun_cf_r_norm, false)
            visible(annun_cf_r_off, true)
			opacity(annun_cf_r_norm, 0)
			opacity(annun_cf_r_off, 1)
        end   
        
             --    bleed l
        if bleed_l  then
            visible(annun_bleed_l_norm, true)
            visible(annun_bleed_l_off, false)
			opacity(annun_bleed_l_norm, 1)
			opacity(annun_bleed_l_off, 0)
        else
            visible(annun_bleed_l_norm, false)
            visible(annun_bleed_l_off, true)                 
			opacity(annun_bleed_l_norm, 0)
			opacity(annun_bleed_l_off, 1)
        end

             --    bleed r
        if bleed_r  then
            visible(annun_bleed_r_norm, true)
            visible(annun_bleed_r_off, false)
			opacity(annun_bleed_r_norm, 1)
			opacity(annun_bleed_r_off, 0)
        else
            visible(annun_bleed_r_norm, false)
            visible(annun_bleed_r_off, true)                 
			opacity(annun_bleed_r_norm, 0)
			opacity(annun_bleed_r_off, 1)
        end                                              
    else
        --    set all annunciators off if no power
        visible(annun_ice_l_on, false)
        visible(annun_ice_l_off, false)
        visible(annun_ice_r_on, false)
        visible(annun_ice_r_off, false)
        visible(annun_pitch_norm, false)
        visible(annun_pitch_stby, false)
        visible(annun_roll_norm, false)
        visible(annun_roll_off, false)
        visible(annun_yaw_norm, false)
        visible(annun_yaw_off, false)
        visible(annun_ws_l_norm, false)
        visible(annun_ws_l_off, false)
        visible(annun_ws_r_norm, false)
        visible(annun_ws_r_off, false)
        visible(annun_cf_l_norm, false)
        visible(annun_cf_l_off, false)
        visible(annun_cf_r_norm, false)
        visible(annun_cf_r_off, false)
        visible(annun_bleed_l_norm, false)
        visible(annun_bleed_l_off, false)
        visible(annun_bleed_r_norm, false)
        visible(annun_bleed_r_off, false)
		
		opacity(annun_ice_l_on, 0)
		opacity(annun_ice_l_off, 0)
		opacity(annun_ice_r_on, 0)
		opacity(annun_ice_r_off, 0)
		opacity(annun_pitch_norm, 0)     
		opacity(annun_pitch_stby, 0)
		opacity(annun_roll_norm, 0)
		opacity(annun_roll_off, 0)
		opacity(annun_yaw_norm, 0)
		opacity(annun_yaw_off, 0) 
		opacity(annun_ws_l_norm, 0)
		opacity(annun_ws_l_off, 0)
		opacity(annun_ws_r_norm, 0)       
		opacity(annun_ws_r_off, 0)
		opacity(annun_cf_l_norm, 0)      
		opacity(annun_cf_l_off, 0)
		opacity(annun_cf_r_norm, 0)  
		opacity(annun_cf_r_off, 0)
		opacity(annun_bleed_l_norm, 0) 
		opacity(annun_bleed_l_off, 0)
		opacity(annun_bleed_r_norm, 0)
		opacity(annun_bleed_r_off, 0)

    end
end

--    annunciators
    --    engine ice
annun_ice_l_on = img_add("annun_on_white.png", 86, 418, 32, 23)
annun_ice_l_off = img_add("annun_off_yellow.png", 84, 440, 39, 23)

annun_ice_r_on = img_add("annun_on_white.png", 178, 418, 32, 23)
annun_ice_r_off = img_add("annun_off_yellow.png", 176, 440, 39, 23)
    
    --    pitch mode
annun_pitch_norm   = img_add("annun_norm_white.png", 338, 366, 55, 23)     
annun_pitch_stby = img_add("annun_stby_yellow.png", 342, 394, 46, 23)     

    --    roll
annun_roll_norm   = img_add("annun_norm_white.png", 493, 366, 55, 23)     
annun_roll_off = img_add("annun_off_yellow.png", 498, 394, 46, 23)    

     --    yaw
annun_yaw_norm   = img_add("annun_norm_white.png", 593, 366, 55, 23)     
annun_yaw_off = img_add("annun_off_yellow.png", 598, 394, 46, 23)   

    --    windshield L
annun_ws_l_norm = img_add("annun_norm_white.png", 706, 136, 55, 23)         
annun_ws_l_off = img_add("annun_off_yellow.png", 714, 160, 39, 23)

    --    windshield R
annun_ws_r_norm = img_add("annun_norm_white.png", 800, 136, 55, 23)         
annun_ws_r_off = img_add("annun_off_yellow.png", 808, 160, 39, 23)

    --    cabin flow L
annun_cf_l_norm = img_add("annun_norm_white.png", 706, 304, 55, 23)         
annun_cf_l_off = img_add("annun_off_yellow.png", 714, 330, 39, 23)

    --    cabin flow R
annun_cf_r_norm = img_add("annun_norm_white.png", 800, 304, 55, 23)         
annun_cf_r_off = img_add("annun_off_yellow.png", 808, 330, 39, 23)

    --    bleed L
annun_bleed_l_norm = img_add("annun_norm_white.png", 690, 468, 55, 23)         
annun_bleed_l_off = img_add("annun_off_yellow.png", 698, 494, 39, 23)

    --    bleed R
annun_bleed_r_norm = img_add("annun_norm_white.png", 782, 468, 55, 23)         
annun_bleed_r_off = img_add("annun_off_yellow.png", 790, 494, 39, 23)
--------------------------
local rate = 0.02

opacity(annun_ice_l_on, 1.0, "LOG", rate)
opacity(annun_ice_l_off, 1.0, "LOG", rate)
opacity(annun_ice_r_on, 1.0, "LOG", rate)
opacity(annun_ice_r_off, 1.0, "LOG", rate)
opacity(annun_pitch_norm, 1.0, "LOG", rate)     
opacity(annun_pitch_stby, 1.0, "LOG", rate)
opacity(annun_roll_norm, 1.0, "LOG", rate)
opacity(annun_roll_off, 1.0, "LOG", rate)
opacity(annun_yaw_norm, 1.0, "LOG", rate)
opacity(annun_yaw_off, 1.0, "LOG", rate) 
opacity(annun_ws_l_norm, 1.0, "LOG", rate)
opacity(annun_ws_l_off, 1.0, "LOG", rate)
opacity(annun_ws_r_norm, 1.0, "LOG", rate)       
opacity(annun_ws_r_off, 1.0, "LOG", rate)
opacity(annun_cf_l_norm, 1.0, "LOG", rate)      
opacity(annun_cf_l_off, 1.0, "LOG", rate)
opacity(annun_cf_r_norm, 1.0, "LOG", rate)  
opacity(annun_cf_r_off, 1.0, "LOG", rate)
opacity(annun_bleed_l_norm, 1.0, "LOG", rate) 
opacity(annun_bleed_l_off, 1.0, "LOG", rate)
opacity(annun_bleed_r_norm, 1.0, "LOG", rate)
opacity(annun_bleed_r_off, 1.0, "LOG", rate)
---------------------

fs2020_variable_subscribe("L:WINGAI_KNOB", "ENUM", 
                                              "L:WINGFLOW_KNOB", "ENUM", 
                                              "L:TAILDEICE_KNOB", "ENUM",
                                              "L:FUELPL_KNOB", "ENUM", 
                                              "L:FUELPR_KNOB", "ENUM", 
                                              "L:FUELXF_KNOB", "ENUM", 
                                              "L:HJET_ENGINEAI_L", "NUMBER", 
                                              "L:HJET_ENGINEAI_R", "NUMBER", 
                                              --"L:PITCHTRIM PUSHED", "NUMBER",   
                                              "A:ELEVATOR TRIM DISABLED","NUMBER",
                                              --"L:ROLLTRIM PUSHED", "NUMBER",
                                              "A:AILERON TRIM DISABLED","NUMBER",
                                              --"L:YAWTRIM PUSHED", "NUMBER", 
                                              "A:RUDDER TRIM DISABLED","NUMBER",
                                              "L:TRIM_THUMB", "ENUM", 
                                              "L:HJET_WINDSHEILDHEAT_L", "NUMBER", 
                                              "L:HJET_WINDSHEILDHEAT_R", "NUMBER", 
                                              "L:HJET_CFLOWL", "NUMBER", 
                                              "L:HJET_CFLOWR", "NUMBER", 
                                              "A:BLEED AIR ENGINE:1", "BOOL",
                                              "A:BLEED AIR ENGINE:2", "BOOL",
                                              "A:ELECTRICAL MASTER BATTERY", "BOOL", 
                                              "L:GROUNDPOWER", "Number",  
                                              "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",                                   
                                              setValues)

fs2020_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
							"L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)