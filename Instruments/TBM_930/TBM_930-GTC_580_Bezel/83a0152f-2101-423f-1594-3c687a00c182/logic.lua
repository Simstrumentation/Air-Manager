--[[
***************************Garmin GTC580 Overlay Bezel*******************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    http://www.simstrumentation.com

This GTC580 bezel is specifically designed for use with Microsoft Flight Simulator (2020)
and to work with both the Asobo (stock) and Working Title G3000. DOES NOT WORK WITH
X-PLANE, FSX or P3D

INSTRUCTIONS:

THIS INSTRUMENT IS ONLY AN OVERLAY. It does not generate the GTC580 screen content. It must be used
in conjunction with pop out instrument from Microsoft Flight Simulator. Right Alt + Click on the GTC580 
screen in MSFS to pop out the windows. 

Version info:

- **v1.0** (August 31 2022)
    - Original release
      
NOTES: 
- N/A

KNOWN ISSUES:
- None

ATTRIBUTION:
Artwork and sound effects are original creations by Simstrumentation
Code by Simstrumentation in collaboration with Russ Barlow. Based on work by Yves Levesque
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
]]--

--***********************************************PLATFORM WARNING MESSAGES***********************************************

-- Message for Raspberry Pi and tablet versions
if instrument_prop("PLATFORM") == "RASPBERRY_PI" or instrument_prop("PLATFORM") == "ANDROID" or instrument_prop("PLATFORM") == "IPAD" then
    canvas_add(0, 0, 1200, 753, function()
        _rect(0,0,1034,775)
        _fill("black")
    end)
    canv_message = canvas_add(110, 110, 1034, 775, function()
        _rect(0,0,1034,775)
        _fill("blue")
        _txt("THIS FS2020 GTC 580 OVERLAY", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 298)
        _txt("WORKS ON THE DESKTOP ONLY", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 348)
        _txt("BUTTONS AND DIALS STILL WORK", "font:roboto_bold.ttf; size:70; color: white; halign:center;", 517, 398)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 548)
    end)
    butn_hide = button_add(nil, nil, 189, 47, 1034, 775, function()
        visible(canv_message, false)
        visible(butn_hide, false)
    end)
end

-- Message for desktop
pers_msg_read = persist_add("msg_read", false)
if (instrument_prop("PLATFORM") == "WINDOWS" or instrument_prop("PLATFORM") == "MAC" or instrument_prop("PLATFORM") == "LINUX") and not persist_get(pers_msg_read) then
    canv_message = canvas_add(110, 110, 1200, 753, function()
        _rect(0,0,1034,775)
        _fill("blue")
        _txt("THIS IS AN OVERLAY ONLY", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 298)
        _txt("IT REQUIRES THE GTC 580 POP OUT FROM MSFS", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 348)
        _txt("SEE SIM INNOVATIONS WIKI FOR MORE INFORMATION", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 398)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:40; color: white; halign:center;", 517, 548)
    end)
    butn_hide = button_add(nil, nil, 189, 47, 1034, 775, function()
        visible(canv_message, false)
        visible(butn_hide, false)
        persist_put(pers_msg_read, true)
    end)
end
--*********************************************END PLATFORM WARNING MESSAGES**********************************************
--background images
img_add_fullscreen("bg.png")
knob_lights_id = img_add_fullscreen("lights.png")
opacity(knob_lights_id, 0)  --set initial state to off

--sounds
click_snd = sound_add("click.wav")
dial_snd = sound_add("dial.wav")

--local variables
local comMode = 1
power_state = 0

function sc_1_click()
    fs2020_event("H:AS3000_TSC_Horizontal_SoftKey_1")
    sound_play(click_snd)
end
button_add(nil,"softkey_pressed.png", 1070,271,88,66, sc_1_click)

function sc_2_click()
    fs2020_event("H:AS3000_TSC_Horizontal_SoftKey_2")
    sound_play(click_snd)
end
button_add(nil,"softkey_pressed.png", 1070,358,88,65, sc_2_click)

function sc_3_click()
    fs2020_event("H:AS3000_TSC_Horizontal_SoftKey_3")
    sound_play(click_snd)
end
button_add(nil,"softkey_pressed.png", 1070,441,88,65, sc_3_click)


-- top knob

function big_dial_top_callback(direction)
    if direction ==  1 then
        fs2020_event("H:AS3000_TSC_Horizontal_TopKnob_Large_INC")
    elseif direction == -1 then
	fs2020_event("H:AS3000_TSC_Horizontal_TopKnob_Large_DEC")
    end
    sound_play(dial_snd)
end
dial_big_top = dial_add("dialbig.png", 1035,82,161,161, big_dial_top_callback)

function small_dial_top_callback(direction)
    if direction ==  1 then
        fs2020_event("H:AS3000_TSC_Horizontal_TopKnob_Small_INC")
    elseif direction == -1 then
	fs2020_event("H:AS3000_TSC_Horizontal_TopKnob_Small_DEC")
    end
    sound_play(dial_snd)
end
dial_small_top = dial_add("dialsmall.png", 1079,126,75,75, small_dial_top_callback)

function timer_top_cb()
    --if the com timer has not been cancelled, trigger the long push event
    --fs2020_event("AS3000_TSC_Horizontal_TopKnob_Push_Long")
		if comMode==1 then
			fs2020_event("COM_STBY_RADIO_SWAP")
		else	
			fs2020_event("COM2_RADIO_SWAP")
		end
end

function dial_top_release()
	if  timer_running (timer_top) then  -- if the timer is still running, then it is a short push
        timer_stop(timer_top)
	    fs2020_event("H:AS3000_TSC_Horizontal_TopKnob_Push")
		if comMode==1 then
			comMode = 2
		else	
			comMode= 1
		end
	end
end

function dial_top_click()
    timer_top = timer_start(2000, timer_top_cb)
    sound_play(click_snd)
end
button_add(nil,nil,  1088,156,40,40,dial_top_click, dial_top_release)

--Bottom Knob

function small_dial_bottom_callback(direction)
    if direction ==  1 then
        fs2020_event("H:AS3000_TSC_Horizontal_BottomKnob_Small_INC")
    elseif direction == -1 then
	fs2020_event("H:AS3000_TSC_Horizontal_BottomKnob_Small_DEC")
    end
    sound_play(dial_snd)
end
dial_small_bottom = dial_add("dialsmall.png",1077,567,76,76, small_dial_bottom_callback)

function dial_bottom_click()
    fs2020_event("H:AS3000_TSC_Horizontal_BottomKnob_Push")
    sound_play(click_snd)
end
button_add(nil,nil,  1077,567,46,46,dial_bottom_click)


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

fs2020_variable_subscribe("CIRCUIT AVIONICS ON", "BOOL",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                          "GENERAL ENG GENERATOR SWITCH:1", "BOOL",
                          power_on)
-- end make knob backlights turn on when unit is powered on