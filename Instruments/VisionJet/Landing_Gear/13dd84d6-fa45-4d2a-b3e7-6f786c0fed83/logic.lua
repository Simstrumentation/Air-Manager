--[[
******************************************************************************************
********************* CIRRUS SF50 VISION JET LANDING GEAR ************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Landing gear panel for the Vision Jet by FlightFX

Version info:
- **v1.1** - 2022-12-
    - Graphics update
    - Added backlighting
- **v1.0** - 2022-12-11
    - Original release

NOTES: 
- Compatible with the FlightFX SF50 Vision Jet. Compatibility with other aircraft possible but not guaranteed.

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code and graphics from Russ Barlow. Used with permission. 

Sharing or re-use of any code or assets is not permitted without credit to the original authors.

******************************************************************************************

]]--


play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

-- play sound
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    fail_snd = sound_add("beepfail.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    fail_snd = sound_add("silence.wav")
end
-- end play sound
--sounds
fail_snd = sound_add("beepfail.wav")
press_snd = sound_add("press.wav")
release_snd = sound_add("release.wav")

--background image
img_add_fullscreen("bg.png")


--Revert Display Knob
function revert_display()
    --INOP
    sound_play(fail_snd)
end
button_add( nil, "ldg_gear_display_bu.png", 71,183,61,61, revert_display)

--baro knob dial events
function set_baro(direction)
    if direction == 1 then
        fs2020_event("KOHLSMAN_INC")
    else
        fs2020_event("KOHLSMAN_DEC")
    end
end

--baro knob click / release events
function set_baro_std()
    fs2020_event("K:BAROMETRIC_STD_PRESSURE")
    sound_play(press_snd)
end

function set_baro_release()
    sound_play(release_snd)
end
img_add("knob_shadow.png", 63,354,130,130)
dial_add( "ldg_gear_baro_knob.png", 63,344,72,72, 2, set_baro, set_baro_release)
button_add( nil, nil, 69, 350, 60, 60, set_baro_std)


--    gear handle
function cycle_gear( state, direction)
    fs2020_event( fif(state == 0, "GEAR_DOWN", "GEAR_UP") )
end
shadow_up = img_add( "shadow_gear_up.png", 17,493,166,541, "visible:false")
opacity(shadow_up, 0.75)
shadow_dn=img_add("shadow_gear_down.png", 17,493,166,541, "visible:false; opacity:10")
opacity(shadow_dn, 0.75)
labels_backlight = img_add_fullscreen("labels_backlight.png")
opacity(labels_backlight, 0)
gear_switch = switch_add( "gear_up.png", "gear_down.png", 17,493,166,541, cycle_gear)
function gear_change(position)
    switch_set_position(gear_switch , position )
    if position == 1 then
        visible(shadow_up, false)
        visible(shadow_dn, true)
    else
        visible(shadow_up, true)
        visible(shadow_dn, false)
    end
end

fs2020_variable_subscribe("L:LANDING_GEAR_Gear", "Number", gear_change)

-- backlight
function lightPot(val, panel, pot, power)
    lightKnob = val
    panelLight = panel
    if power  then
        opacity(labels_backlight, (pot/100), "LOG", 0.1)  
    else
        opacity(labels_backlight, 0, "LOG", 0.1) 
    end
end

fs2020_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)
