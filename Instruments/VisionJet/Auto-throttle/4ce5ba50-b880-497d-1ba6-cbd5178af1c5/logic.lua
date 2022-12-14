--[[
******************************************************************************************
*********************** CIRRUS SF50 VISION JET AUTO THROTTLE CONTROL *********************
******************************************************************************************
    Made by SIMSTRUMENTATION - http://simstrumentation.com

Auto throttle for the Vision Jet by FlightFX

Version info:
- **v1.0** - 2022-12-14

INSTRUCTIONS:


NOTES: 
- Will only work with the FlightFX Vision Jet. Compatibility with other aircraft not 
  supported or guaranteed. 
  
  

KNOWN ISSUES:
- None

ATTRIBUTION:
Original code, graphics and sound by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--


--USER PROPERTIES
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    
toga_prop = user_prop_add_boolean("Show TOGA Label", true, "Show or hide the bonus TOGA button label")
knobster_prop = user_prop_add_boolean("Use Knobster for speed thumbwheel", true, "Choose whether to use Knobster or touch control for the thumb wheel")


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

--LOCAL VARS
local ias = 0
local atManual = false
local atFMS = false
local atArmed = false

--GRAPHICS
img_add_fullscreen("bg.png")

--TOGA TEXT

if user_prop_get(toga_prop) then
    txt_press = txt_add("TOGA", "font:MS33558.ttf; size:20; color: white; halign:center;",80, 26, 180, 30)
end

function toggleToga()
    fs2020_event("K:AUTO_THROTTLE_TO_GA")
end

button_add(nil, nil, 140, 56, 50, 50, toggleToga)

--BUTTONS

function atSelect()
     fs2020_event("K:AP_PANEL_SPEED_SET")
     fs2020_event("K:AUTO_THROTTLE_ARM")
    sound_play(press_snd)
end

function release()
    sound_play(release_snd)
end
at_btn = button_add("at_btn.png", "at_btn_pressed.png", 205, 95, 113, 90, atSelect, release)

function manSelect()
    currentIAS = math.floor(ias)
    fs2020_variable_write("L:SF50_push_at_fms_man", "Number", 1)
    fs2020_event("AP_SPD_VAR_SET", currentIAS)
    sound_play(press_snd)
end
man_btn = button_add("man_btn.png", "man_btn_pressed.png", 100, 265, 113, 90, manSelect, release)
function setIAS(val)
    ias = val
    print(ias)
end
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", setIAS )

function fmsSelect()
    fs2020_variable_write("L:SF50_push_at_fms_man", "Number", 0)
    sound_play(press_snd)
end

function fmsRelease()
    sound_play(release_snd)
end
fms_btn = button_add("fms_btn.png", "fms_btn_pressed.png", 320, 265, 113, 90, fmsSelect, release)


function setSpeed(direction)
    if direction == 1 then
        fs2020_event("AP_SPD_VAR_DEC")            
    else
        fs2020_event("AP_SPD_VAR_INC")
    end
end

vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 150, 440, 30, 225, 30, 30, setSpeed)
    
function setSpeedKnobster(direction)
    if direction == 1 then
        fs2020_event("AP_SPD_VAR_INC")            
    else
        fs2020_event("AP_SPD_VAR_DEC")
    end
end
if user_prop_get(knobster_prop) then
speedDial = dial_add(nil, 150, 440, 30, 225, setSpeedKnobster)

end
img_add("shadow.png", 150, 440, 30, 225)
--annunciators

at_annun = img_add("annunciator.png", 230, 60, 62, 26)
visible(at_annun, false)
man_annun = img_add("annunciator.png", 120, 235, 62, 26)
visible(man_annun, false)
fms_annun = img_add("annunciator.png", 342, 235, 62, 26)
visible(fms_annun, false)


--set auto throttle states and annunciators
function setFMSAn(manFMS, atActive)

    atArmed = atActive
   --    set state of manual FMS mode
     if manFMS == 1 then
        atManual = true        
    else
        atManual = false
    end
      
    if atActive and atManual then
        atFMS = false
    elseif atActive and atManual == false then
        atFMS = true
    end

--    auto throttle annunciator
    if atArmed then
        visible(at_annun, true)
    else
        visible(at_annun, false)
    end

--    fms annunciator
    if atFMS then
        visible(fms_annun, true)
    else
        visible(fms_annun, false)
    end
--    manual annunciator    
    if atManual then
        visible(man_annun, true)
    else
        visible(man_annun, false)
    end        
                 

end
fs2020_variable_subscribe("L:SF50_push_at_fms_man", "Number",
                                              "A:AUTOPILOT THROTTLE ARM", "Bool",
                                              setFMSAn)

--THROTTLE
function throttle_position(pos)
    slider_set_position(throttle_id, pos)
    if pos == 0 then
        sliderVal = 100
    else
        sliderVal = 100 -(pos * 100)
    end  
    fs2020_variable_write("GENERAL ENG THROTTLE LEVER POSITION:1", "Percent", sliderVal)
end

throttle_id = slider_add_ver(nil, 420, 50, 850, 750, "Handle.png", 465, 428, throttle_position)

function moveThrottle(pos)
        slider_set_position(throttle_id, 1-(pos/100))    
end

fs2020_variable_subscribe("GENERAL ENG THROTTLE LEVER POSITION:1", "Percent", moveThrottle)


