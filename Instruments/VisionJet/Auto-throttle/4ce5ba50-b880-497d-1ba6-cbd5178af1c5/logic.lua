--[[
******************************************************************************************
*********************** CIRRUS SF50 VISION JET AUTO THROTTLE CONTROL *********************
******************************************************************************************
    Made by SIMSTRUMENTATION - http://simstrumentation.com

Auto throttle for the Vision Jet by FlightFX

Version info:
- **v1.1** - 2022-12-
    - Added backlighting
- **v1.0** - 2022-12-11
    - Original release

NOTES: 
    -Contains user-selectable properties for:
        - Sounds
        - using Knobster for the speed thumb wheel
        - show / hide label for TOGA
            * Hidden TOGA button was added to the nub to the left of the AT 
               button for those who don't have a button available on their
               throttle quadrant. By default the label is shown. If you wish to hide
               it since it isn't in the real aircraft, select this option



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
 local backlight = 0
 local power = false
 local lightKnob = 0
local panelLight = 0

--GRAPHICS
img_add_fullscreen("bg.png")

--TOGA TEXT

if user_prop_get(toga_prop) then
    txt_toga_static = txt_add("TOGA", "font:MS33558.ttf; size:20; color: white; halign:center;",80, 26, 180, 30)
    opacity(txt_toga_static, 0.5)
    txt_toga_backlit = txt_add("TOGA", "font:MS33558.ttf; size:20; color: white; halign:center;",80, 26, 180, 30)
    opacity(txt_toga_backlit, 0)  
end

--BUTTONS

function release()
    sound_play(release_snd)
end
function toggleToga()
    fs2020_event("K:AUTO_THROTTLE_TO_GA")
    sound_play(press_snd)
end

toga_btn = button_add(nil, nil, 140, 56, 50, 50, toggleToga, release)

function atSelect()
     fs2020_event("K:AP_PANEL_SPEED_SET")
     fs2020_event("K:AUTO_THROTTLE_ARM")
    sound_play(press_snd)
end
at_btn = button_add(nil, "btn_pressed.png", 205, 95, 113, 90, atSelect, release)

function manSelect()
    currentIAS = math.floor(ias)
    fs2020_variable_write("L:SF50_push_at_fms_man", "Number", 1)
    fs2020_event("AP_SPD_VAR_SET", currentIAS)
    sound_play(press_snd)
end
man_btn = button_add(nil, "btn_pressed.png", 100, 265, 113, 90, manSelect, release)
function setIAS(val)
    ias = val
end
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", setIAS )

function fmsSelect()
    fs2020_variable_write("L:SF50_push_at_fms_man", "Number", 0)
    sound_play(press_snd)
end

function fmsRelease()
    sound_play(release_snd)
end
fms_btn = button_add(nil, "btn_pressed.png", 320, 265, 113, 90, fmsSelect, release)

function setSpeed(direction)
    if direction == 1 then
        fs2020_event("AP_SPD_VAR_DEC")            
    else
        fs2020_event("AP_SPD_VAR_INC")
    end
end

vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 153, 442, 23, 208, 23, 30, setSpeed)
    
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

img_add("thumbwheel_shadow.png", 153, 442, 23, 208)

--annunciator graphics
at_annun = img_add("annunciator.png", 230, 60, 62, 26, "visible:false")
man_annun = img_add("annunciator.png", 120, 235, 62, 26, "visible:false")
fms_annun = img_add("annunciator.png", 342, 235, 62, 26, "visible:false")

--set auto throttle states and annunciators
function setFMSAn(manFMS, atActive)
    atArmed = atActive
    print(atArmed)
    print(manFMS)
   --    set state of manual FMS mode
     if manFMS == 1 and power then
        atManual = true        
    else
        atManual = false
    end
      
    if atActive and atManual and power then
        atFMS = false
    elseif atActive and atManual == false and power then
        atFMS = true
    end

--    auto throttle annunciator
    if atArmed and power then
        visible(at_annun, true)
    else
        visible(at_annun, false)
    end

--    fms annunciator
    if atFMS then
    print(atFMS)
        visible(fms_annun, true)
    else
        visible(fms_annun, false)
    end
--    manual annunciator    
    if atManual then
        print(atManual)
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

function moveThrottle(pos)
        slider_set_position(throttle_id, 1-(pos/100))    
end
fs2020_variable_subscribe("GENERAL ENG THROTTLE LEVER POSITION:1", "Percent", moveThrottle)

-- backlight
backlight_labels = img_add_fullscreen("backlight_labels.png")

backlight_group = group_add(backlight_labels)
opacity(backlight_labels, 0)
function lightPot(val, panel, pot, masterBattery)
    lightKnob = val
    panelLight = panel
    backlight = pot
    power = masterBattery
    
    if power  then
        opacity(backlight_group, (pot/100), "LOG", 0.1)  
        if user_prop_get(toga_prop) then
            opacity(txt_toga_backlit, (pot/100), "LOG", 0.1)
        end    
    else
        opacity(backlight_group, 0, "LOG", 0.1)  
        if user_prop_get(toga_prop) then
            opacity(txt_toga_backlit, 0, "LOG", 0.1)
        end 
    end
end

fs2020_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)



throttle_id = slider_add_ver(nil, 420, 50, 850, 750, "Handle.png", 465, 428, throttle_position)

