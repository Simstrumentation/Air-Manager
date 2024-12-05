--[[
***************************Garmin GTC580 Overlay Bezel*******************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    http://www.simstrumentation.com

This GTC580 bezel is specifically designed for use with 

INSTRUCTIONS:

THIS INSTRUMENT IS ONLY AN OVERLAY. It does not generate the GTC580 screen content. It must be used
in conjunction with pop out instrument from Microsoft Flight Simulator. Right Alt + Click on the GTC580 
screen in MSFS to pop out the windows. 

Version info:
- **v1.0** (August 31 2022)
    - Original release
- **V2.0-- (Dec 7, 2022)
    - Updated to work with AAU I.
    - Supports up to 3 units selectable by user property
    - New graphics and sounds
    - Currently supports Asobo TBM 930 (AAU I and newer )and FlightFX Vision Jet    
      
NOTES: 
- Select which position the unit will occupy via user properties. Can be placed in positions 1, 2, or 3.

KNOWN ISSUES:
- WILL NOT WORK with pre-AAU I TBM 930
    - Once AAU I is released in Jan 2023, this will no longer be an issue. 

ATTRIBUTION:
Artwork and sound effects are original creations by Simstrumentation
Code by Simstrumentation in collaboration with Russ Barlow. Based on work by Yves Levesque
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
***************************************************************************************************************************************************************
]]--


unit_pos = user_prop_add_enum("Position", "1,2,3", "1", "Choose bezel position")

local bezel_pos

--  unit position

if user_prop_get(unit_pos) == "1" then
	bezel_pos = 1
elseif user_prop_get(unit_pos) == "2" then
	bezel_pos = 2
elseif user_prop_get(unit_pos) == "3" then
	bezel_pos = 3
end
print(bezel_pos)
--  end unit position

--background images
img_add_fullscreen("bg.png")
img_add_fullscreen("knob_shadows.png")
knob_lights_id = img_add_fullscreen("lights.png")
opacity(knob_lights_id, 0)  --set initial state to off

--sounds
press_snd = sound_add("press.wav")
release_snd = sound_add("release.wav")
dial_snd = sound_add("dial.wav")

--local variables
local comMode = 1
power_state = 0

function sc_1_click()
    msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_SoftKey_1")
    sound_play(press_snd)
end
function sc_release()
    sound_play(release_snd)
end

button_add("softkey.png","softkey_pressed.png", 1060,273,112,77, sc_1_click, sc_release)

function sc_2_click()
    msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_SoftKey_2")
    sound_play(press_snd)
end

button_add("softkey.png","softkey_pressed.png", 1060,358,112,77, sc_2_click, sc_release)

function sc_3_click()
    msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_SoftKey_3")
    sound_play(press_snd)
end

button_add("softkey.png","softkey_pressed.png", 1060,441,112,77, sc_3_click, sc_release)


-- top knob

function big_dial_top_callback(direction)
    if direction ==  1 then
        msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_TopKnob_Large_INC")
    elseif direction == -1 then
	msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_TopKnob_Large_DEC")
    end
    sound_play(dial_snd)
end
dial_big_top = dial_add("dialbig.png", 1057,103,116,116, big_dial_top_callback)
img_add("dialbig_cap.png", 1065,115,100,100)

function small_dial_top_callback(direction)
    if direction ==  1 then
        msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_TopKnob_Small_INC")
    elseif direction == -1 then
	msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_TopKnob_Small_DEC")
    end
    sound_play(dial_snd)
end
dial_small_top = dial_add("dialsmall.png", 1079,126,74,74, small_dial_top_callback)
img_add("dialsmall_cap.png", 1080,127,72,72)

function timer_top_cb()
    --if the com timer has not been cancelled, trigger the long push event
    --msfs_event("AS3000_TSC_Horizontal_TopKnob_Push_Long")
	if comMode==1 then
		msfs_event("COM_STBY_RADIO_SWAP")
	else	
		msfs_event("COM2_RADIO_SWAP")
	end
end

function dial_top_release()
	if  timer_running (timer_top) then  -- if the timer is still running, then it is a short push
        timer_stop(timer_top)
	    msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_TopKnob_Push")
		if comMode==1 then
			comMode = 2
		else	
			comMode= 1
		end
	end
	sound_play(release_snd)
end

function dial_top_click()
    timer_top = timer_start(2000, timer_top_cb)
    sound_play(press_snd)
end
button_add(nil, nil,  1090,138,50,50,dial_top_click, dial_top_release)

--Bottom Knob

function small_dial_bottom_callback(direction)
    if direction ==  1 then
        msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_BottomKnob_Small_INC")
    elseif direction == -1 then
	msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_BottomKnob_Small_DEC")
    end
    sound_play(dial_snd)
end
dial_small_bottom = dial_add("dialsmall.png",1079,562,76,76, small_dial_bottom_callback)
img_add("dialsmall_cap.png",1081,564,72,72)

function dial_bottom_click()
    msfs_event("H:AS3000_TSC_Horizontal_" .. bezel_pos .. "_BottomKnob_Push")
    sound_play(press_snd)
end
button_add(nil,nil,  1092,575,50,50,dial_bottom_click, sc_release)


-- make knob LED backlights turn on when unit is powered on
function power_on(avionics, mainbus, generator)
    --set aircraft main bus power state
    if (mainbus >= 1 or generator == true ) then
      power_state = true
    else
      power_state = false
    end
  
  --set LED power state
    if (power_state and avionics) then
        opacity(knob_lights_id, 1, "LOG", 0.01)
    else
        opacity(knob_lights_id, 0,  "LINEAR", .05)
    end
end

msfs_variable_subscribe("CIRCUIT AVIONICS ON", "BOOL",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                          "GENERAL ENG GENERATOR SWITCH:1", "BOOL",
                          power_on)
-- end make knob backlights turn on when unit is powered on