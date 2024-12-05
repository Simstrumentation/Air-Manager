--[[
******************************************************************************************
************************ CIRRUS SF50 VISION JET START CONTROL *****************************
******************************************************************************************
    Made by SIMSTRUMENTATION in collaboration with Russ Barlow
    GitHub: https://simstrumentation.com

Start control for the Vision Jet by FlightFX

Version info:
- **v1.1** - 2022-12-
    - Graphics update
    - Added backlighting
- **v1.0** - 2022-12-11
    - Original release

NOTES: 
- Will only work with the FlightFX Vision Jet

KNOWN ISSUES:
- None

ATTRIBUTION:
-Based on code from Russ Barlow. Used with permission. 
-Sharing or re-use of any code or assets is not permitted without credit to the original authors.

******************************************************************************************

]]--

local arm_pos = 0
local lightKnob = 0
local panelLight = 0

img_add("bg.png", 1, 1, 364, 611)
bg_labels = img_add_fullscreen("bg_labels_on.png")

img_add_fullscreen("knob_base.png")
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
           msfs_event("K:SET_FUEL_VALVE_ENG1", 1)
           msfs_event("K:ELECT_FUEL_PUMP1_SET", 1)        
           msfs_event("K:STARTER1_SET", 1) 
        else
            msfs_event("K:ELECT_FUEL_PUMP1_SET", 0)
           msfs_event("K:SET_FUEL_VALVE_ENG1", 0)
           msfs_event("K:STARTER1_SET", 0) 
        end
        sound_play(press_snd)
end

button_add("start_btn.png", "start_btn_pressed.png", 35,51,227,183, start_push_pressed, release)  
start_label = img_add("start_btn_label.png", 35,51,227,183)

function ignition()
    if arm_pos == 0then
        msfs_variable_write("L:SF50_knob_stop_run", "Enum", 2)    --does nothing. temporary workaround for AM bug
        msfs_variable_write("L:SF50_knob_stop_run", "Enum", 1)
    else
        msfs_variable_write("L:SF50_knob_stop_run", "Enum", 2)    --does nothing. temporary workaround for AM bug
        msfs_variable_write("L:SF50_knob_stop_run", "Enum", 0)
    end
end

start_sw = switch_add(nil, nil, 46,290,232,232, ignition)
start_knob = img_add("start_knob.png", 56,300,232,232)
start_knob_backlight = img_add("start_knob_backlight.png", 56,300,232,232)

start_knob_group = group_add(start_knob, start_knob_backlight)
function set_start_switch_fs2020(position)
    if position == 0 then
        rotate(start_knob_group, 0, "LINEAR", 0.1)
        arm_pos = 0
    else
        rotate(start_knob_group, 41, "LINEAR", 0.1)
        arm_pos = 1
    end
end

msfs_variable_subscribe("L:SF50_knob_stop_run", "Enum", set_start_switch_fs2020)

backlight_group = group_add(bg_labels, start_label, start_knob_backlight)
opacity(backlight_group, 0)

-- backlight
function lightPot(val, panel, pot, power)
    lightKnob = val
    panelLight = panel
    if power  then
        opacity(backlight_group, (pot/100), "LOG", 0.1)  
    else
        opacity(backlight_group, 0, "LOG", 0.1)  
    end
end

msfs_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)
