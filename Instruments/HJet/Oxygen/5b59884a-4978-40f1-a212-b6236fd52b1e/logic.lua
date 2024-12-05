--[[
******************************************************************************************
************** HJet (MG FlightFX) LANDING GEAR AND ELT PANEL ********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Landing gear and ELT panel for the HJet
- **v1.01** - 2023-04-07
    - Fixed an issue with the oxygen supply knob sometimes not working

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
    cover_open_snd = sound_add("cover_open.wav")
    cover_close_snd = sound_add("cover_close.wav")
    fail_snd = sound_add("fail.wav")    
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
    cover_open_snd = sound_add("silence.wav")
    cover_close_snd = sound_add("silence.wav")
    fail_snd = sound_add("silence.wav")
end

--    variables
local maskAudio = 0
local o2Supply = 0
local pressHold = 0
local pressDump = 0
local maskControl = 0
local trapCover = false
local elecState = 0

    --   background
img_add_fullscreen("background.png")

function releaseAction()
    sound_play(release_snd)
end

    --    mask audio button
function maskAction()
    sound_play(press_snd)
    msfs_variable_write("L:HJET_OXYMASKAUDIO", "NUMBER", 3)
    if maskAudio == 0 then
        msfs_variable_write("L:HJET_OXYMASKAUDIO", "NUMBER", 1)
    else
        msfs_variable_write("L:HJET_OXYMASKAUDIO", "NUMBER", 0)
    end
end
mask_id = button_add(nil, "pressed.png", 109, 91, 74, 74, maskAction, releaseAction)

    --    control mode button
function controlModeAction()
    sound_play(press_snd)
     msfs_variable_write("L:HJET_PRESSURISAITON_HOLD_ACTIVE", "NUMBER", 3)
    if pressHold == 1 then
        msfs_variable_write("L:HJET_PRESSURISAITON_HOLD_ACTIVE", "NUMBER", 0)
    else
        msfs_variable_write("L:HJET_PRESSURISAITON_HOLD_ACTIVE", "NUMBER", 1)
    end
end 

control_mode_id = button_add(nil, "pressed.png", 44, 302, 74, 74, controlModeAction, releaseAction)

    --    cabin dump
function cabinDumbAction()
    if trapCover then
        sound_play(press_snd)
       msfs_variable_write("L:PRESSURE_DUMP_PUSHED", "NUMBER", 3)
        
        if pressDump == 1 then
            msfs_variable_write("L:PRESSURE_DUMP_PUSHED", "NUMBER", 0)
        else
            msfs_variable_write("L:PRESSURE_DUMP_PUSHED", "NUMBER", 1)
        end
    else
        sound_play(fail_snd)
    end
end

function dumpReleaseAction()
    if trapCover then
        sound_play(release_snd)
    end
end
cabin_dump_id = button_add(nil, "pressed.png", 148, 312, 74, 62, cabinDumbAction, dumpReleaseAction)

    --    mask knob
mask_knob_shadow = img_add("knob_shadow.png", 280, 313, 100, 100)
mask_knob_id = img_add("knob.png", 275, 303, 90, 90)

function maskKnobAction(direction)
    if direction == 1 then
    msfs_variable_write("L:HJET_PRESSURIZATION_CABIN_OXYMASK", "ENUM", 3)
        if maskControl == 0 then
            sound_play(dial_snd)
            msfs_variable_write("L:HJET_PRESSURIZATION_CABIN_OXYMASK", "ENUM", 1)
        elseif maskControl == -1 then
            sound_play(dial_snd)
            msfs_variable_write("L:HJET_PRESSURIZATION_CABIN_OXYMASK", "ENUM", 0)
        end
    elseif direction == -1 then
        if maskControl == 1 then
            sound_play(dial_snd)
            msfs_variable_write("L:HJET_PRESSURIZATION_CABIN_OXYMASK", "ENUM", 0)
        elseif maskControl == 0 then
            sound_play(dial_snd)
            msfs_variable_write("L:HJET_PRESSURIZATION_CABIN_OXYMASK", "ENUM", -1)
        end
    end
end
mask_knob_dial = dial_add(nil, 275, 303, 90, 90, maskKnobAction)

function o2SupplyAction()
    msfs_variable_write("L:HJET_OXYSUPPLY", "NUMBER", 3)
    if o2Supply == 1 then
        msfs_variable_write("L:HJET_OXYSUPPLY", "NUMBER", 0)
    else
        msfs_variable_write("L:HJET_OXYSUPPLY", "NUMBER", 1)
    end 

end

o2_supply_id = switch_add(nil, nil, 256, 74, 110, 110, o2SupplyAction)
o2_supply_knob_shadow_id= img_add("knob_shadow.png", 270, 106, 115, 115)
o2_supply_knob_id = img_add("oxygen_knob.png", 259, 91, 95, 92)
opacity(o2_supply_knob_shadow_id, 0.85)

--    annunciator graphics

audio_annun_norm_id = img_add("annun_norm_white.png", 120, 100, 55, 23, "visible:false")
audio_annun_emer_id = img_add("annun_emer_yellow.png", 120, 134, 55, 23, "visible:false")
control_norm_annun_id = img_add("annun_norm_white.png", 56, 310, 55, 23, "visible:false")
control_hold_annun_id = img_add("annun_hold_yellow.png", 56, 346, 55, 23, "visible:false")
dump_norm_annun_id = img_add("annun_norm_white.png", 160, 310, 55, 23, "visible:false")
dump_dump_annun_id = img_add("annun_dump_yellow.png", 160, 346, 55, 23, "visible:false")

rate = 0.02
opacity(audio_annun_norm_id, 1.0, "LOG", rate)
opacity(audio_annun_emer_id, 1.0, "LOG", rate)
opacity(control_norm_annun_id, 1.0, "LOG", rate)
opacity(control_hold_annun_id, 1.0, "LOG", rate)
opacity(dump_norm_annun_id, 1.0, "LOG", rate)
opacity(dump_dump_annun_id, 1.0, "LOG", rate)

    --    trap cover
trap_cover_up_id = img_add("trap_cover_open.png", 141, 278, 90, 12, "visible:false")
trap_cover_down_id = img_add("trap_cover.png",141, 303, 90, 77)
function coverAction()
    if trapCover then
        trapCover = false
        sound_play(cover_close_snd)
        visible(trap_cover_up_id, false)
        visible(trap_cover_down_id, true) 
    else
        trapCover = true
        sound_play(cover_open_snd)
        visible(trap_cover_up_id, true)
        visible(trap_cover_down_id, false)
    end
end
trap_cover_id = switch_add(nil, nil, 140, 264, 90, 40, coverAction)

function setVals(audio, o2supply, pressure, dump, mask, elecSt )
    maskAudio = audio
    o2Supply = o2supply
    pressHold = pressure
    pressDump = dump
    maskControl = mask
    elecState = elecSt   
    print(pressHold)
    
    --set states
    --    O2 Supply
    if o2Supply == 1 then
        move(o2_supply_knob_id, 269, 86, 87, 84, "LINEAR", 0.05)
        move(o2_supply_knob_shadow_id, 270, 102, 105, 105, "LINEAR", 0.05)
        opacity(o2_supply_knob_shadow_id, 1)
    else
        move(o2_supply_knob_id, 259, 91, 95, 92, "LINEAR", 0.05)
        move(o2_supply_knob_shadow_id, 270, 106, 115, 115, "LINEAR", 0.05)
        opacity(o2_supply_knob_shadow_id, 0.85)
    end
    
    --    Mask
    if maskControl == -1 then
        rotate(mask_knob_id, -30, "LINEAR", 0.05)
    elseif maskControl == 0 then
        rotate(mask_knob_id, 0, "LINEAR", 0.05)
    elseif maskControl == 1 then
        rotate(mask_knob_id, 30, "LINEAR", 0.05)
    end
    
    --    set annunciators
    --    Mask Audio
    if maskAudio == 0 then
        visible(audio_annun_norm_id, true)
        visible(audio_annun_emer_id, false)
        opacity(audio_annun_norm_id, 1)
        opacity(audio_annun_emer_id, 0)
    else
        visible(audio_annun_norm_id, false)
        visible(audio_annun_emer_id, true)
        opacity(audio_annun_norm_id, 0)
        opacity(audio_annun_emer_id, 1)
    end
    
    --    Control Mode
    if pressHold == 0 then
        visible(control_norm_annun_id,true)
        visible(control_hold_annun_id,false)    
        opacity(control_norm_annun_id, 1)
        opacity(control_hold_annun_id, 0)
    else
        visible(control_norm_annun_id,false)
        visible(control_hold_annun_id,true)
        opacity(control_norm_annun_id, 0)
        opacity(control_hold_annun_id, 1)
    end

    --    Cabin Dump
    if pressDump == 0 then
        visible(dump_norm_annun_id, true)
        visible(dump_dump_annun_id, false)    
        opacity(dump_norm_annun_id, 1)
        opacity(dump_dump_annun_id, 0)
    else
        visible(dump_norm_annun_id, false)
        visible(dump_dump_annun_id, true)    
        opacity(dump_norm_annun_id, 0)
        opacity(dump_dump_annun_id, 1)
    end
    
end

function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
	visible(audio_annun_norm_id, true)
	visible(audio_annun_emer_id, true)
	visible(control_norm_annun_id, true)
	visible(control_hold_annun_id, true)
	visible(dump_norm_annun_id, true)
	visible(dump_dump_annun_id, true)
        opacity(audio_annun_norm_id, 1)
        opacity(audio_annun_emer_id, 1)
        opacity(control_norm_annun_id, 1)
        opacity(control_hold_annun_id, 1)
        opacity(dump_norm_annun_id, 1)
        opacity(dump_dump_annun_id, 1)

    else
	visible(audio_annun_norm_id, false)
	visible(audio_annun_emer_id, false)
	visible(control_norm_annun_id, false)
	visible(control_hold_annun_id, false)
	visible(dump_norm_annun_id, false)
	visible(dump_dump_annun_id, false)
        opacity(audio_annun_norm_id, 0)
        opacity(audio_annun_emer_id, 0)
        opacity(control_norm_annun_id, 0)
        opacity(control_hold_annun_id, 0)
        opacity(dump_norm_annun_id, 0)
        opacity(dump_dump_annun_id, 0)
        setVals(maskAudio,o2Supply,pressHold,pressDump,maskControl,elecState)
    end

end

msfs_variable_subscribe("L:HJET_OXYMASKAUDIO", "NUMBER",
                                              "L:HJET_OXYSUPPLY", "NUMBER", 
                                              "L:HJET_PRESSURISAITON_HOLD_ACTIVE", "NUMBER",
                                              "L:PRESSURE_DUMP_PUSHED", "NUMBER",
                                              "L:HJET_PRESSURIZATION_CABIN_OXYMASK", "ENUM",
                                              "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",
                                               setVals)
                                               
msfs_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
			"L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)                                               