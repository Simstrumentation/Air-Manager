--[[
--******************************************************************************************
-- ************************* GARMIN GMC 710 AUTOPILOT ******************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

   Gamin GMC 710 autopilot module. Will work in various aircraft such at the TBM, King Air
   Longitude, or SWS Daher Kodiak
    
    NOTE:
        V1.3 Released 2023-02-19
            - Added PIT Pitch  
        V1.2 - Released 2023-01-05
            AAU I COMPATIBILITY  with TBM 930
            - Bank mode now operational
            - SPD mode now operational
            - added option to use dual encoder on Knobster for ALT knob via user property
            - added option to use Knobster for thumbwheel
            - fixed annunciator lights for SPD and Bank 
            - XFR button / mode now active
            - updated some sound events
            
 
        V1.11 - Released 2022-12-11
            -added acceleration to knobs. 
        V1.1 - Released 2022-01-29
        V1.0 - Released 2022-01-05
           
    KNOWN ISSUES: 
        - Several buttons are INOP due to lacking SDK functionality. Said functionality will be
		  added once said SDK functions are available. INOP buttons and knobs will play a "fail"
		  sound when used to indicate their INOP status.
        - CRS1 knob currently tied to G1000 CRS1 function. May not function in planes not equipped
           with a G1000. CRS2 is INOP
        - XFER button INOP
        - Bank switch INOP
           
   --******************************************************************************************
--]]

-- USER PROPERTIES
knobster_prop = user_prop_add_boolean("Use Knobster for speed thumbwheel", false, "Choose whether to use Knobster or touch control for the thumb wheel")
altitude_prop = user_prop_add_boolean("Use dual encoder for altitude knob", false, "Choose whether to use alt knob as dual encoder with both 100 and 1000 ft increments.")
sound_prop = user_prop_add_boolean("Sound", true, "Play sounds when activating buttons and knobs")
    
if user_prop_get(sound_prop) then
   buttonClick = sound_add("buttonpress.wav")
   buttonRelease = sound_add("buttonrelease.wav")
   knobClick = sound_add("knobpress.wav")
   knobRelease = sound_add("knobrelease.wav")
   knobScroll = sound_add("knobscroll.wav")
   errorSound = sound_add("beepfail.wav")
else
     buttonClick = sound_add("silence.wav")
     buttonRelease = sound_add("silence.wav")
     knobClick = sound_add("silence.wav")
     knobRelease = sound_add("silence.wav")
     knobScroll = sound_add("silence.wav")
end

--BEZEL GRAPHICS
img_add("bg.png",0,0,1316,230)

-- LOCAL VARS
local current_alt = 0
local current_hdg = 0
local FLCState = false
local VSState = false
local bankState = false
local xfrMode = 0


-- Initialize local variables with sim values
fs2020_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR", "Feet", 
                          "PLANE HEADING DEGREES MAGNETIC", "Degrees", 
                          function(ap_alt, heading)
                            current_alt = ap_alt
                            current_hdg = math.floor(heading + 0.5)
                          end
                        )
                        
--Get VS State
function vsstate_callback(state)
    VSState = state  
end
fs2020_variable_subscribe("AUTOPILOT VERTICAL HOLD", "bool", vsstate_callback)

--Get FLC State
function flcstate_callback(state)
    FLCState = state   
end
fs2020_variable_subscribe("AUTOPILOT FLIGHT LEVEL CHANGE", "bool", flcstate_callback)                        

--release functions
function cbKnobRelease()
    sound_play(knobRelease)
end

function cbButtonRelease()
    sound_play(buttonRelease)
end
                                                                                                
--ADD BUTTONS AND KNOBS

--hdg
function click_press_callback_btn_HDG()
	fs2020_event("AP_PANEL_HEADING_HOLD")
	sound_play(buttonClick)
end

button_add("hdg.png", "hdg.png", 85 , 20 , 60 , 40, click_press_callback_btn_HDG, cbButtonRelease)

--apr
function click_press_callback_btn_APR()
	fs2020_event("AP_APR_HOLD")
	sound_play(buttonClick)
end

button_add("apr.png", "apr.png", 180 , 20 , 60 , 40, click_press_callback_btn_APR, cbButtonRelease)

--nav
function click_press_callback_btn_NAV()
	fs2020_event("AP_NAV1_HOLD")
	sound_play(buttonClick)
end

button_add("nav.png", "nav.png", 290 , 20 , 60 , 40, click_press_callback_btn_NAV, cbButtonRelease)

--bc
function click_press_callback_btn_BC()
	fs2020_event("AP_BC_HOLD_ON")
	sound_play(buttonClick)
end

button_add("bc.png", "bc.png", 180 , 126 , 60 , 40, click_press_callback_btn_BC, cbButtonRelease)

--hdg knob
function dial_HDG_turned(direction)
	if direction ==  1 then
        fs2020_event("HEADING_BUG_INC")
    elseif direction == -1 then
        fs2020_event("HEADING_BUG_DEC")
    end
    sound_play(knobScroll)
end

dial_HDG = dial_add("knob_hdg.png" , 81 ,97 , 70 , 70 , 3, dial_HDG_turned)

--hdg knob press
function click_press_callback_HDG_PUSH()
	fs2020_event("HEADING_BUG_SET", current_hdg)
	sound_play(knobClick)
end

button_add(nil, nil, 95 , 120 , 30 , 30, click_press_callback_HDG_PUSH, cbKnobRelease)


-- Crs 1 knob
function dial_CRS1_turned(direction)
	if direction ==  1 then
        fs2020_event("H:AS1000_PFD_CRS_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_PFD_CRS_DEC")
    end
	sound_play(knobScroll)
end

dial_CRS1 = dial_add("knob_basic.png" , 289 , 97 , 70 , 70 , 3, dial_CRS1_turned)

--Crs 1 knob press
function click_press_callback_CRS1()
	sound_play(errorSound)
	sound_play(knobClick)
end

button_add(nil, nil, 303 , 122 , 30 , 30, click_press_callback_CRS1, cbKnobRelease)


--FD
function click_press_callback_btn_FD()
	fs2020_event("TOGGLE_FLIGHT_DIRECTOR")   
	sound_play(buttonClick)
end

button_add("fd.png", "fd.png", 405 , 20 , 60 , 40, click_press_callback_btn_FD, cbButtonRelease)


--Bank
function click_press_callback_btn_BANK()
    if bankState then
        fs2020_event("K:AP_MAX_BANK_SET", 0)
    else
        fs2020_event("K:AP_MAX_BANK_SET", 0)
    end
    sound_play(buttonClick)
end

button_add("bank.png", "bank.png", 405 , 125 , 60 , 40, click_press_callback_btn_BANK, cbButtonRelease)


--XFR
function click_press_callback_btn_XFR()
	if xfrMode then
	    fs2020_variable_write("L:XMLVAR_PushXFR", "Number", 0)
	else
	    fs2020_variable_write("L:XMLVAR_PushXFR", "Number", 1)
	end
	sound_play(buttonClick)
end

button_add("xfr.png", "xfr.png", 560 , 20 , 60 , 40, click_press_callback_btn_XFR,  cbButtonRelease)


--AP Master
function click_press_callback_btn_AP()
	fs2020_event("AP_MASTER")   
	sound_play(buttonClick)
end

button_add("ap.png", "ap.png", 510 , 125 , 60 , 40, click_press_callback_btn_AP,  cbButtonRelease)


--YD
function click_press_callback_btn_YD()
	fs2020_event("YAW_DAMPER_TOGGLE")
	sound_play(buttonClick)
end

button_add("yd.png", "yd.png", 605 , 125 , 60 , 40, click_press_callback_btn_YD, cbButtonRelease)


--Alt
function click_press_callback_btn_ALT()
	fs2020_event("AP_PANEL_ALTITUDE_HOLD")
	sound_play(buttonClick)
end

button_add("alt.png", "alt.png", 730 , 20 , 60 , 40, click_press_callback_btn_ALT, cbButtonRelease)

--VS Button
function click_press_callback_btn_VS()
    fs2020_event("AP_PANEL_VS_HOLD")
    sound_play(buttonClick)
end
button_add("vs.png", "vs.png", 830 , 20 , 60 , 40, click_press_callback_btn_VS, cbButtonRelease)

--FLC Button
function click_press_callback_btn_FLC()
	if FLCState then  --check if FLC is currently on
		fs2020_event("FLIGHT_LEVEL_CHANGE_OFF")    --if true, toggle off
	else    -- if FLC currently off
		AirspeedDecimal = math.floor(AirspeedIndicated)        -- read current airspeed and convert variable
		fs2020_event("FLIGHT_LEVEL_CHANGE_ON")                --enable FLC
		fs2020_event("AP_SPD_VAR_SET", AirspeedDecimal)    -- set FLC speed to current airspeed
	end
	sound_play(buttonClick)
end
button_add("flc.png", "flc.png", 1040 , 20 , 60 , 40, click_press_callback_btn_FLC)

--VNAV
function click_press_callback_btn_VNV()
	fs2020_event("GPS_VNAV_BUTTON")				-- for other GPS systems EXCEPT WT G1000 NXi
	fs2020_event("H:AS1000_VNAV_TOGGLE")		-- for WT G1000 NXi VNAV
	sound_play(buttonClick)
end
button_add("vnv.png", "vnv.png", 830 , 125 , 60 , 40, click_press_callback_btn_VNV, cbButtonRelease)

--Spd
function click_press_callback_btn_SPD()
        fs2020_event("K:AP_MANAGED_SPEED_IN_MACH_TOGGLE")
	sound_play(buttonClick)
end

button_add("spd.png", "spd.png", 1040 , 125 , 60 , 40, click_press_callback_btn_SPD, cbButtonRelease)

--ALT knob
function dialSingle(direction)
	if direction == 1 then
           fs2020_event("AP_ALT_VAR_INC")
        elseif direction == -1 then
           fs2020_event("AP_ALT_VAR_DEC")
        end
end

function dialDualOuter( direction)
    if direction ==  1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt + 1000)
    elseif direction == -1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt - 1000)
    end
    sound_play(knobScroll)
end

function dialDualInner( direction)
    if direction ==  1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt + 100)
    elseif direction == -1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt - 100)
    end
    sound_play(knobScroll)
end


if user_prop_get(altitude_prop) then
    knobOuter = dial_add("knob_basic.png" , 729 , 97 , 70 , 70 , 3, dialDualOuter) 
    knobInner = dial_add(nil , 739 , 107 , 50 , 50 , 3, dialDualInner) 
    dial_click_rotate(knobOuter, 6)   
else
    dial_ALT = dial_add("knob_basic.png" , 729 , 97 , 70 , 70 , 3, dialSingle)
    dial_click_rotate(dial_ALT, 6)
end

--Alt button
function click_press_callback_ALT()
	fs2020_event("AP_PANEL_ALTITUDE_HOLD")
	sound_play(knobClick)
end

button_add(nil, nil, 742 , 122 , 40 , 30, click_press_callback_ALT, cbButtonRelease)


--VS / FLC / Pitch scroll wheel
function vs_callback(direction)
    if direction == -1 then
        if VSState then fs2020_event("AP_VS_VAR_DEC")
        elseif FLCState then fs2020_event("AP_SPD_VAR_INC")
        else fs2020_event("AP_PITCH_REF_INC_DN")
        end
    else
        if VSState then fs2020_event("AP_VS_VAR_INC")
        elseif FLCState then fs2020_event("AP_SPD_VAR_DEC")
        else fs2020_event("AP_PITCH_REF_INC_UP")
        end
    end
end

--Check if UserProp is true to make VS ScrollWheel to a dial to use with Knobster
if user_prop_get(knobster_prop) then
    speedDial = dial_add(nil, 949, 37, 28, 154, vs_callback)
else
    vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 949, 37, 28, 154, 34, 34, vs_callback)
end
img_add("shadow.png", 948, 37,28,162)

--CRS 2
function dial_CRS2_turned(direction)
	if direction == 1 then 
		--INOP
		sound_play(errorSound)
	elseif direction == -1 then 
		--INOP
		sound_play(errorSound)
	end
end

dial_CRS2 = dial_add("knob_basic.png" , 1167 , 98 , 70 , 70 , 3, dial_CRS2_turned)


--Indicator lights
img_hdg_active   = img_add("led.png", 145, 16, 18, 45)	
img_apr_active   = img_add("led.png", 245, 16, 18, 45)		
img_nav_active   = img_add("led.png", 355, 16, 18, 45)	
img_BC_active = img_add("led.png", 245, 127, 18, 45)
img_FD_active = img_add("led.png", 470, 16, 18, 45)
img_BANK_active = img_add("led.png", 470, 126, 18, 45)
img_AP_pilot_active = img_add("ledl.png", 523, 19, 40, 38)
img_AP_copilot_active = img_add("ledr.png", 620, 19, 40, 38)
img_ap_active    = img_add("led.png", 575, 126, 18, 45)			
img_yd_active    = img_add("led.png", 670, 126, 18, 45)
img_alt_active   = img_add("led.png", 795, 16, 18, 45)			--
img_vs_active    = img_add("led.png", 890, 16, 18, 45)			--
img_vnav_active  = img_add("led.png", 890, 126, 18, 45)		--
img_ias_active   = img_add("led.png", 1105, 16, 18, 45)		--
img_spd_active   = img_add("led.png", 1105, 126, 18, 45)

function ap_cb (hdg,  nav, apr, ap_mode, fd_mode,  yaw, ias,  vs, alt, heading, altitude, avionics, battery,generator, vnv, bank, bc, spd, xfr)
	--set vnv state
	if (vnv == 1) then
	    vnv_on = true
	else
	    vnv_on = false
	end 
	--set aircraft power state
	if (battery >= 1 or generator == true ) then
		power = true
	else
		power = false
	end
	if bank == 1 then
	    bankState = true
	else
	    bankState = false
	end
	
	if xfr == 1 then
	    xfrMode = true
            visible(img_AP_pilot_active, false)
            visible(img_AP_copilot_active, true)
	else
	    xfrMode = false
	    visible(img_AP_pilot_active, true)
            visible(img_AP_copilot_active, false)
	end
    
    visible(img_hdg_active, hdg and power)
    visible(img_nav_active, nav and power )
    visible(img_apr_active, apr and power)
    visible(img_ap_active, ap_mode and power )
    visible(img_yd_active, yaw  and power)
    visible(img_ias_active, ias and power )
    visible(img_vs_active, vs and power)
    visible(img_alt_active, alt  and power)
    visible(img_vnav_active, vnv_on  and power)
    visible(img_FD_active, fd_mode and power)
    visible(img_BANK_active, bankState  and power)
    visible(img_BC_active, bc  and power)
    visible(img_spd_active, spd  and power)
    currentHeading = heading
    currentAltitude = altitude
end

-- Subscriptions				
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
					        "A:AUTOPILOT MAX BANK ID", "Number", 
					        "AUTOPILOT BACKCOURSE HOLD", "Bool",
					        "A:AUTOPILOT MANAGED SPEED IN MACH", "Bool",
					        "L:XMLVAR_PushXFR", "Number",
						ap_cb)

--"AUTOPILOT BANK HOLD", "Bool", 
function aspd_callback(asindicated)
	AirspeedIndicated = asindicated  
end
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)