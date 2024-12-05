--[[
******************************************************************************************
***************** GENERIC GARMIN G3000 / 5000 Bezel Overlay **********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

G3000 / 5000  Bezel Overlay

Version info:
- **v2.01** - 2024-03-31
    - added copilot PFD button functionality.

- **v2.0** - 2022-12-11

NOTES: 
The following options are available and can be set via user properties in the instrument once
placed in your panel layout:

- Select Pilot PFD or MFD
- Show / hid softkeys
- Display a raised metallic or inset Garmin logo 
- show light glare on the screen.

KNOWN ISSUES:
- None


ATTRIBUTION:
Graphics and code by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

unit_type = user_prop_add_enum("Display Unit Type","G3000, G5000","G3000","Select between G3000 and G5000")
logo_style = user_prop_add_enum("Style of Garmin Logo","Metallic, Inset","Metallic","Select between G3000 and G5000")
display_pos = user_prop_add_enum("Display unit function","Pilot,MFD,Copilot","Pilot", "Select unit functional position")
screen_glare = user_prop_add_boolean("Show screen glare", true, "Show glare on the screen")


if user_prop_get(screen_glare) then
    img_add_fullscreen("glare.png")
end

press_snd = sound_add("press.wav")
release_snd = sound_add("release.wav")

local pos = user_prop_get(display_pos)


if pos == "Pilot" then
    display_type = "PFD_1"
elseif pos == "Copilot" then
    display_type = "PFD_2"
else
    display_type = "MFD"
end

function release()
    sound_play(release_snd)
end

if user_prop_get(unit_type)  == "G3000" then
    bezel = "G3000 background.png"
else
     bezel = "G5000 background.png"
 end
 
img_add_fullscreen(bezel)

if user_prop_get(logo_style)  == "Metallic" then
   img_add("metal_logo.png", 630, 15, 200, 23) 
else
    img_add("inset_logo.png", 630, 10, 200, 32)                 
end
if user_prop_get(unit_type)  == "G3000" then
    function sc_1_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_1")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 130,886,62,44, sc_1_click, release)
    
    function sc_2_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_2")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 230,886,62,44, sc_2_click, release)
    
    function sc_3_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_3")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 330,886,62,44, sc_3_click, release)
    
    function sc_4_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_4")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 430,886,62,44, sc_4_click, release)
    
    function sc_5_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_5")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 529,886,62,44, sc_5_click, release)
    
    function sc_6_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_6")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 629,886,62,44, sc_6_click, release)
    
    function sc_7_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_7")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 728,886,62,44, sc_7_click, release)
    
    function sc_8_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_8")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 828,886,62,44, sc_8_click, release)
    
    function sc_9_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_9")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png",927,886,62,44, sc_9_click, release)
    
    function sc_10_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_10")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 1027,886,63,44, sc_10_click, release)
    
    function sc_11_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_11")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 1125,886,63,44, sc_11_click, release)
    
    function sc_12_click()
    	msfs_event("H:AS3000_"..display_type.."_SOFTKEYS_12")
        sound_play(press_snd)
    end
    button_add(nil,"G3000Button.png", 1225,886,63,44, sc_12_click, release)


end