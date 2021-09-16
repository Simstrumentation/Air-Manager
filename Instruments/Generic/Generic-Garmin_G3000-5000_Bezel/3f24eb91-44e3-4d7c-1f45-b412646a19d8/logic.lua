--[[
-- G3000 Overlay
--Original design by Yves Levesque

Changelog:
*V1.1 - 9-16-2021 by Joe "Crunchmeister" Gilker
    - User property to hide softkeys to use the bezel for a G5000
    - Removed the requirement for Mobiflight in order to use
]]--


display_type = user_prop_add_enum("Display Unit Type","G3000, G5000","G3000","Select between G3000 and G5000")

if user_prop_get(display_type)  == "G3000" then
    bezel = "G3000 background.png"
else
     bezel = "G5000 background.png"
 end
 
img_add_fullscreen(bezel)

display_pos = user_prop_add_enum("Display unit function","PFD,MFD","PFD","Select unit functional position")
local display_type = "PFD"
local pos = user_prop_get(display_pos)
click_snd = sound_add("knobclick.wav")

function sc_1_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_1")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 130,886,62,44, sc_1_click)

function sc_2_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_2")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 230,886,62,44, sc_2_click)

function sc_3_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_3")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 330,886,62,44, sc_3_click)

function sc_4_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_4")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 430,886,62,44, sc_4_click)

function sc_5_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_5")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 529,886,62,44, sc_5_click)

function sc_6_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_6")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 629,886,62,44, sc_6_click)

function sc_7_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_7")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 728,886,62,44, sc_7_click)

function sc_8_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_8")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 828,886,62,44, sc_8_click)

function sc_9_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_9")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png",927,886,62,44, sc_9_click)

function sc_10_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_10")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 1027,886,63,44, sc_10_click)

function sc_11_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_11")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 1125,886,63,44, sc_11_click)

function sc_12_click()
	fs2020_event("H:AS3000_"..pos.."_SOFTKEYS_12")
    sound_play(click_snd)
end
button_add(nil,"G3000Button.png", 1225,886,63,44, sc_12_click)


