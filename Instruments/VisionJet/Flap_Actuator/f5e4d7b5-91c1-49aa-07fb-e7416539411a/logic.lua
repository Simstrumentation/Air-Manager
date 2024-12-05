--[[
******************************************************************************************
****************** CIRRUS SF50 VISION JET FLAP ACTUATOR **************************
******************************************************************************************
    Made by SIMSTRUMENTATION in collaboration with Russ Barlow
    GitHub: https://simstrumentation.com

Flap actuator for the Vision Jet by FlightFX

Version info:
- **v1.1** - 2022-12-
    - Graphics update
    - Added backlighting
- **v1.0** - 2022-12-11
    - Original release

NOTES: 
- Made for the FlightFX Vision Jet
- Should function in most MSFS aircraft, but compatibility not guaranteed. 
- Backlighting will only work in the FlightFX Vision Jet


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
    click_snd = sound_add("click.wav")
else
    click_snd = sound_add("silence.wav")
end
-- end play sound
--images
img_add_fullscreen("bg.png")
backlight_labels = img_add_fullscreen("backlight_labels.png")
opacity(backlight_labels, 0)
shadow_img = img_add("Shadow_handle.png", 5, 20, 673, 604 )
opacity(shadow_img, 0.75)
flap_up_img = img_add_fullscreen("flaps_handle.png")

handle_group = group_add(shadow_img, flap_up_img)
-- move flap handle and shadow to follow simvars
function handle_position_set_fs2020( pos)
	if pos == 0 then
	rotate(handle_group, 0, 130, 235, 0, "LINEAR", 0.1, "DIRECT")	
	elseif pos == 1 then
	    rotate(handle_group, 25, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	else
	    rotate(handle_group, 60, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	end
end
msfs_variable_subscribe("A:FLAPS HANDLE INDEX", "ENUM", handle_position_set_fs2020)

 --activate flaps 
function flap_callback(direction)
    if direction == 1 then
        msfs_event("FLAPS_INCR")
    else
        msfs_event("FLAPS_DECR")
    end
    sound_play(click_snd)
end

-- Create an invisible slider (nil image references)
flap_scroll = scrollwheel_add_ver( nil, 120 , 40, 450, 460, 450 , 50, flap_callback)
mouse_setting(flap_scroll , "CURSOR", "grab_hand.png")

-- backlight
function lightPot(val, panel, pot, power)
    lightKnob = val
    panelLight = panel
    if power  then
        opacity(backlight_labels, (pot/100), "LOG", 0.1)  
    else
        opacity(backlight_labels, 0, "LOG", 0.1)  
    end
end

msfs_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)