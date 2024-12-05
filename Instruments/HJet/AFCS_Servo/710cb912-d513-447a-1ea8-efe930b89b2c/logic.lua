--[[
******************************************************************************************
************************* HJet (MG FlightFX) AFC SERVO PANEL ***********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

AFC servo panel and baro knob for the HJet

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

img_add_fullscreen("background.png")

--    VARIABLES

local pitchState = 0
local rollState = 0
local yawState = 0
local elecState = 0



--    buttons
function releaseAction()
    sound_play(release_snd)
end

function pitchAction()
    sound_play(press_snd)
    msfs_variable_write("L:AFCPITCH PUSHED", "NUMBER", 3)
    if pitchState == 1 then
        msfs_variable_write("L:AFCPITCH PUSHED", "NUMBER", 0)
    else
        msfs_variable_write("L:AFCPITCH PUSHED", "NUMBER", 1)
    end 
    
end
pitch_id = button_add(nil, "pressed.png", 31, 78, 91, 91, pitchAction, releaseAction)

function rollAction()
    sound_play(press_snd)
    msfs_variable_write("L:AFCROLL PUSHED", "NUMBER", 3)
     if rollState == 1 then
        msfs_variable_write("L:AFCROLL PUSHED", "NUMBER", 0)
    else
        msfs_variable_write("L:AFCROLL PUSHED", "NUMBER", 1)
    end 
end
roll_id = button_add(nil, "pressed.png", 136, 78, 91, 91, rollAction, releaseAction)

function yawAction()
    sound_play(press_snd)
    msfs_variable_write("L:AFCYAW PUSHED", "NUMBER", 3)
     if yawState == 1 then
        msfs_variable_write("L:AFCYAW PUSHED", "NUMBER", 0)
    else
        msfs_variable_write("L:AFCYAW PUSHED", "NUMBER", 1)
    end 
end
yaw_id = button_add(nil, "pressed.png", 241, 78, 91, 91, yawAction, releaseAction)

--    annunciators

pitch_annun = img_add("annunciator.png", 58, 108, 42, 24)
roll_annun = img_add("annunciator.png", 163, 108, 42, 24)
yaw_annun = img_add("annunciator.png", 268, 108, 42, 24)

local rate = 0.02

opacity(pitch_annun, 1.0, "LOG", rate)
opacity(roll_annun, 1.0, "LOG", rate)
opacity(yaw_annun, 1.0, "LOG", rate)
visible(pitch_annun, false)
visible(roll_annun, false)
visible(yaw_annun, false)


function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
        visible(pitch_annun, true)
        visible(roll_annun, true)
        visible(yaw_annun, true)
	opacity(pitch_annun, 1)
	opacity(roll_annun, 1)
	opacity(yaw_annun, 1)

    else
        visible(pitch_annun, false)
        visible(roll_annun, false)
        visible(yaw_annun, false)
	opacity(pitch_annun, 0)
	opacity(roll_annun, 0)
	opacity(yaw_annun, 0)

        setStates(pitchState,rollState,yawState)
    end

end


function setStates(pitch, roll, yaw,elecSt)
    pitchState = pitch
    rollState = roll
    yawState = yaw
	elecState = elecSt
    
    -- set annunciators
    if pitchState == 1 then
        visible(pitch_annun, true)
		opacity(pitch_annun, 1)
    else
        visible(pitch_annun, false)
		opacity(pitch_annun, 0)
    end
    
    if rollState == 1 then
        visible(roll_annun, true)
		opacity(roll_annun, 1)
    else
        visible(roll_annun, false)
		opacity(roll_annun, 0)
    end
    
    if yawState == 1 then
        visible(yaw_annun, true)
		opacity(yaw_annun, 1)
    else
        visible(yaw_annun, false)
		opacity(yaw_annun, 0)
    end

end

msfs_variable_subscribe("L:AFCPITCH PUSHED", "NUMBER", 
                          "L:AFCROLL PUSHED", "NUMBER", 
                          "L:AFCYAW PUSHED", "NUMBER", 
			  "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",
                                              setStates)

msfs_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
			  "L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)