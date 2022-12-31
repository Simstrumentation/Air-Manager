--[[
******************************************************************************************
************************ GENERIC GARMIN GFC500 AUTOPILOT ***********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

GFC 500 Autopilot module

Version info:
- **v1.13** - 2022-12-31
    - Minor graphic correction
- **v1.12** - 2022-12-21
    - Minor graphic correction
- **v1.11** - 2022-12-21
    - VNAV for Vision Jet added    
- **v1.1** - 2022-12-20
    - Graphics update
    - Added backlighting
    - Added optional sounds
- **v1.0** - 2022-12-11
    - Original Release
    
NOTES: 
- Should work in most aircraft with a GFC500 or similar autopilot. 
- Yaw Damper button can be hidden or shown to match your plane's AP module via user property
- Thumb wheel can be selected to work with Knobster from user property

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on an instrument from Russ Barlow / Sim Innovations.

Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

-- User Properties
up_yd_shown = user_prop_add_boolean("Show Yaw Damper", true, "Show YD button and annunciator")                           -- Use sounds in Air Manager    
knobster_prop = user_prop_add_boolean("Use Knobster for thumbwheel", false, "Choose whether to use Knobster or touch control for the thumb wheel")
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

--local variables
local isVisionJet = false
local vnav_enable = 0

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

-- Global variables
local scroll_vs_mode = true -- Should the scroll wheel control vertical speed (true) or should it control IAS (false)?
local currentHeading = 0
local currentAltitude = 0
local power = false

-- Add images
img_add("blackback.png",1, 1, 650, 230)
img_backlight = img_add("whiteback.png",10, 10, 630, 200)
opacity(img_backlight, 0)
img_add_fullscreen("ap_background.png")

hdg_dial_shadow = img_add("knob_shadow.png", 52,50,130,130)
alt_dial_shadow = img_add("knob_shadow.png", 555,50,130,130)
opacity(hdg_dial_shadow, 0.75)
opacity(alt_dial_shadow, 0.75)


-- Button callbacks

function release()
    sound_play(release_snd)
end
function callback_hdg()
   fs2020_event("AP_PANEL_HEADING_HOLD")
   sound_play(press_snd)
end

function callback_nav()
    fs2020_event("AP_NAV1_HOLD")
    sound_play(press_snd)
end


function callback_ap()
     fs2020_event("AP_MASTER")   
     sound_play(press_snd)
 end

function callback_lvl()
    fs2020_event("AP_WING_LEVELER_ON")
    sound_play(press_snd)
end

-- Required code for proper FLC speed capture and set

function callback_flc(flcstate)
    FLCState = flcstate 
end
        
function vs_callback(vsenabled)
    VSenabled = vsenabled  
end
-- flc current state variable
fs2020_variable_subscribe("AUTOPILOT FLIGHT LEVEL CHANGE", "bool", callback_flc)  

function callback_flc()
       if FLCState then  --check if FLC is currently on
            fs2020_event("FLIGHT_LEVEL_CHANGE_OFF")    --if true, toggle off
        else    -- if FLC currently off
            AirspeedDecimal = math.floor(AirspeedIndicated)        -- read current airspeed and convert variable
            fs2020_event("FLIGHT_LEVEL_CHANGE_ON")                --enable FLC
            fs2020_event("AP_SPD_VAR_SET", AirspeedDecimal)    -- set FLC speed to current airspeed
        end
        sound_play(press_snd)
end

function aspd_callback(asindicated)
    AirspeedIndicated = asindicated  
    return AirspeedIndicated    
end

fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)
-- End required code for proper FLC speed capture and set

function callback_alt()
    fs2020_event("AP_PANEL_ALTITUDE_HOLD")
    sound_play(press_snd)
end

function callback_apr()
   fs2020_event("AP_APR_HOLD")
   sound_play(press_snd)
end

function callback_fd()
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")   
    sound_play(press_snd)
end

function callback_vs()
      fs2020_event("AP_PANEL_VS_HOLD")
      sound_play(press_snd)
 end

function callback_vnv()

    if isVisionJet then
        if vnav_enable == 1 then
            fs2020_variable_write("L:SF50_vnav_enable", "Int", 0)
        else
            fs2020_variable_write("L:SF50_vnav_enable", "Int", 1)
        end
    else
        fs2020_event("H:AS1000_VNAV_TOGGLE")
    end   
    sound_play(press_snd)
end

function callback_yd()
    fs2020_event("YAW_DAMPER_TOGGLE")
    sound_play(press_snd)
end

function altitude_input(direction)
    if direction == 1 then
		fs2020_event("AP_ALT_VAR_INC")
	else
 		fs2020_event("AP_ALT_VAR_DEC")
	end
	sound_play(dial_snd)
end

function heading_input(direction)
    if direction == 1 then
		fs2020_event("HEADING_BUG_INC")
    else
 		fs2020_event("HEADING_BUG_DEC")
    end
    sound_play(dial_snd)
end

function vs_callback(direction)
    if direction == 1 then
        if scroll_vs_mode then
	    fs2020_event("AP_VS_VAR_INC")
        else
            fs2020_event("AP_SPD_VAR_INC")
        end
    else
        if scroll_vs_mode then
 	    fs2020_event("AP_VS_VAR_DEC")
         else
            fs2020_event("AP_SPD_VAR_DEC")
         end
    end
    sound_play(dial_snd)
end

-- Add the buttons
button_hdg = button_add(nil , "autopilot_button_in.png", 63, 173, 60, 43, callback_hdg, release)
button_nav = button_add(nil , "autopilot_button_in.png", 147, 173, 60, 43, callback_nav, release)
button_ap = button_add(nil , "autopilot_button_in.png", 230, 66, 60, 43,  callback_ap, release)
button_lvl = button_add(nil , "autopilot_button_in.png", 310, 66, 60, 43,  callback_lvl, release)
button_flc = button_add(nil , "autopilot_button_in.png", 477, 34, 60, 43,  callback_flc, release)
button_alt = button_add(nil , "autopilot_button_in.png", 567, 175, 60, 43,  callback_alt, release)
button_apr = button_add(nil , "autopilot_button_in.png", 147, 39, 60, 43, callback_apr, release)
button_fd = button_add(nil , "autopilot_button_in.png", 232, 139, 60, 43,  callback_fd, release)
button_vs = button_add(nil , "autopilot_button_in.png", 477, 175, 60, 43, callback_vs, release)
button_vnv = button_add(nil , "autopilot_button_in.png", 477, 105, 60, 43, callback_vnv, release)

if user_prop_get(up_yd_shown) then
    img_add("YD_Button.png", 310, 136, 63, 40)
    button_yd= button_add(nil , "autopilot_button_in.png", 310, 139, 60, 43, callback_yd, release)
    img_yd_active   = img_add("white_triangle_lit.png", 328, 120, 26, 16, "visible:false")
    yd_label = img_add("yd_label.png", 310, 136, 63, 40)
    opacity(yd_label, 0)
end 

function sync_heading_pressed()
	fs2020_event("HEADING_BUG_SET", currentHeading)	
	sound_play(press_snd)
end

function sync_altitude_pressed()
 	fs2020_event("AP_ALT_VAR_SET_ENGLISH", currentAltitude)
 	sound_play(press_snd)	
end

-- Annunciator
img_hdg_active  = img_add("white_triangle_lit.png", 78, 153, 26, 16, "visible:false")
img_nav_active  = img_add("white_triangle_lit.png", 165, 153, 26, 16, "visible:false")
img_apr_active  = img_add("white_triangle_lit.png", 165, 17, 26, 16, "visible:false")
img_ap_active   = img_add("white_triangle_lit.png", 245, 47, 26, 16, "visible:false")
img_fd_active   = img_add("white_triangle_lit.png", 245, 120, 26, 16, "visible:false")
img_lvl_active  = img_add("white_triangle_lit.png", 327, 47, 26, 16, "visible:false")
img_ias_active  = img_add("white_triangle_lit.png", 495, 16, 26, 16, "visible:false")
img_vnav_active = img_add("white_triangle_lit.png", 495, 84, 26, 16, "visible:false")
img_vs_active   = img_add("white_triangle_lit.png", 495, 155, 26, 16, "visible:false")
img_alt_active  = img_add("white_triangle_lit.png", 583, 155, 26, 16, "visible:false")


-- set local variable values based on subscriptions. 
function ap_cb (hdg,  nav, apr, ap_mode, fd_mode,  yaw, ias,  vs, alt, heading, altitude, avionics, battery,generator, vnv, mainbus, battpower)
	if (vnv == 1) then
	    vnv_on = true
	else
	    vnv_on = false
	end 
	if (yaw == 1) then
	    yd_on = true
	else
	    yd_on = false
	end
	if (mainbus >= 12 or generator == true ) then
		power = true
	else
		power = false
	end
    --power = true
    visible(img_hdg_active, hdg and power)
    visible(img_nav_active, nav and power )
    visible(img_apr_active, apr and power)
    visible(img_ap_active, ap_mode and power )
    visible(img_fd_active, fd_mode and power)
    visible(img_ias_active, ias and power )
    scroll_vs_mode = vs and power
    if isVisionJet then
        --    correct behaviour for Vision Jet
        visible(img_vs_active, (vs and power) and vnav_enable ==0) 
    else
        -- correct behaviour for other planes
        visible(img_vs_active, vs and power) 
    end
    visible(img_alt_active, alt  and power)
    visible(img_vnav_active, (vnv_on or vnav_enable ==1)  and power)
    
 --if yd enabled
     visible(img_yd_active, yd_on  and power and user_prop_get(up_yd_shown))
 --end if yd enabled
 
 if battpower then
     opacity(img_backlight, 1,  "LOG", 0.1)
     opacity(backlit_labels, 1,  "LOG", 0.1)
     opacity(yd_label, 1, "LOG", 0.1)
 else
 opacity(img_backlight, 0,  "LINEAR", 0.05)
     opacity(backlit_labels, 0,  "LINEAR", 0.05)
     opacity(yd_label, 0, "LINEAR", 0.05)
 end
 
     currentHeading = heading
    currentAltitude = altitude
end



-- Bus subscribe
						
fs2020_variable_subscribe("AUTOPILOT HEADING LOCK", "Bool",
						    "AUTOPILOT NAV1 LOCK", "Bool",
						    "AUTOPILOT APPROACH HOLD", "Bool",
						    "AUTOPILOT MASTER", "Bool",
						    "AUTOPILOT FLIGHT DIRECTOR ACTIVE", "Bool",
						    "AUTOPILOT YAW DAMPER", "Bool",
						    "AUTOPILOT FLIGHT LEVEL CHANGE", "Bool",
						    "AUTOPILOT VERTICAL HOLD", "Bool",
						    "AUTOPILOT ALTITUDE LOCK", "Bool",
						    "PLANE HEADING DEGREES MAGNETIC", "Degrees",
						    "INDICATED ALTITUDE", "Feet",
						    "ELECTRICAL AVIONICS BUS VOLTAGE", "Volts",
					            "ELECTRICAL BATTERY BUS VOLTAGE", "Volts",
					            "GENERAL ENG GENERATOR SWITCH:1", "BOOL",
					            "L:XMLVAR_VNAVBUTTONVALUE", "Number",
					            "A:ELECTRICAL MAIN BUS VOLTAGE", "Volts",
					            "A:ELECTRICAL MASTER BATTERY", "Bool",
						    ap_cb)


function aspd_callback(asindicated)
	AirspeedIndicated = asindicated  
end
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)

--backlight labels and knobs added at the end to maintain z-order
backlit_labels = img_add_fullscreen("backlight_labels.png")
opacity(backlit_labels, 0)

heading_dial = dial_add("heading_dial.png", 48,44,84,84,3, heading_input)

altitude_dial = dial_add("alt_dial.png", 561,49,74,74,3, altitude_input)
alt_top = img_add("knob_top.png", 560,49,75,75)
hdg_top = img_add("knob_top.png", 49,46,82,82)
opacity(hdg_top, 0.5)
opacity(alt_top, .5)

vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 423, 61, 34, 124, 30, 30, vs_callback)


function setSpeedKnobster(direction)
    if direction == 1 then
        if scroll_vs_mode then
			fs2020_event("AP_VS_VAR_INC")
      else
            fs2020_event("AP_SPD_VAR_INC")
        end
    else
        if scroll_vs_mode then
 			fs2020_event("AP_VS_VAR_DEC")
         else
            fs2020_event("AP_SPD_VAR_DEC")
         end
    end
    sound_play(dial_snd)
end

if user_prop_get(knobster_prop) then
speedDial = dial_add(nil,  423, 61, 34, 124, setSpeedKnobster)
end

img_add("thumbwheel_shadow.png", 424,61,28,124)
button_add( nil,nil,78,71,31,31, sync_heading_pressed, release)
button_add( nil,nil,580,71,31,31, sync_altitude_pressed, release)

-- possibly temporary code to determine if this is the Vision Jet or another plane
-- for proper VNAV functionality.

function showType(type)
    testPlaneType= string.find(type, "Vision")
    if testPlaneType == nil then         
        isVisionJet = false
    else
        isVisionJet = true
    end
end
fs2020_variable_subscribe("TITLE", "STRING", showType)

function getVnavState(state)
    vnav_enable = state
end
fs2020_variable_subscribe("L:SF50_vnav_enable", "Int", getVnavState)
