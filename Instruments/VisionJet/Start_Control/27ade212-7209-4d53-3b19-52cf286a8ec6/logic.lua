--[[
******************************************************************************************
************************ CIRRUS SF50 VISION JET STAR CONTROL *****************************
******************************************************************************************
    Made by SIMSTRUMENTATION in collaboration with Russ Barlow
    GitHub: https://simstrumentation.com

Start control for the Vision Jet by FlightFX

Version info:
- **v1.0** - 2022-12-11

NOTES: 
- Will only work with the FlightFX Vision Jet

KNOWN ISSUES:
- None

ATTRIBUTION:
-Based on code and graphics from Russ Barlow. Used with permission. 
-Sharing or re-use of any code or assets is not permitted without credit to the original authors.

******************************************************************************************

]]--

local arm_pos = 0

img_add_fullscreen("eng_start_background.png")
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

-- play sound
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    click_snd = sound_add("click.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    click_snd = sound_add("silence.wav")
end
-- end play sound


function release()
    sound_play(release_snd)
end

function start_push_pressed()
    --MSFS
        if arm_pos == 1 then
           fs2020_event("K:SET_FUEL_VALVE_ENG1", 1)
           fs2020_event("K:ELECT_FUEL_PUMP1_SET", 1)        
           fs2020_event("K:STARTER1_SET", 1) 
        else
            fs2020_event("K:ELECT_FUEL_PUMP1_SET", 0)
           fs2020_event("K:SET_FUEL_VALVE_ENG1", 0)
           fs2020_event("K:STARTER1_SET", 0) 
        end
        sound_play(press_snd)
end

button_add(nil, "eng_start_button_push.png", 25,41,229,196, start_push_pressed, release)  

function ignition()
    if arm_pos == 0then
        fs2020_variable_write("L:SF50_knob_stop_run", "Enum", 2)    --does nothing. temporary workaround for AM bug
        fs2020_variable_write("L:SF50_knob_stop_run", "Enum", 1)
    else
        fs2020_variable_write("L:SF50_knob_stop_run", "Enum", 2)    --does nothing. temporary workaround for AM bug
        fs2020_variable_write("L:SF50_knob_stop_run", "Enum", 0)
    end
end

start_sw = switch_add(nil, nil, 46,290,232,232, ignition)
start_knob = img_add("start_knob.png", 46,290,232,232)

function set_start_switch_fs2020(position)
    if position == 0 then
        rotate(start_knob, 0, "LINEAR", 0.1)
        arm_pos = 0
    else
        rotate(start_knob, 45, "LINEAR", 0.1)
        arm_pos = 1
    end
end

fs2020_variable_subscribe("L:SF50_knob_stop_run", "Enum", set_start_switch_fs2020)