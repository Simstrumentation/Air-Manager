--[[
--******************************************************************************************
-- ******************************** GARMIN GFC 700 AUTOPILOT *******************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

   Gamin GFC 700 autopilot module. Will work in various aircraft such at the TBM, King Air
   Longitude, or SWS Daher Kodiak
    
    NOTE:
    
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
sound_prop = user_prop_add_boolean("Sound", true, "Play sounds when activating buttons and knobs")
    
if user_prop_get(sound_prop) then
   buttonClick = sound_add("ButtonClick.wav")
   knobClick = sound_add("KnobClick.wav")
   knobScroll = sound_add("KnobScroll.wav")
   errorSound = sound_add("beepfail.wav")
else
     buttonClick = sound_add("knobclick_silent.wav")
     knobClick = sound_add("knobclick_silent.wav")
     knobScroll = sound_add("knobclick_silent.wav")
end

--BEZEL GRAPHICS
img_add("bg.png",0,0,1316,230)

-- LOCAL VARS
local scroll_vs_mode = true -- Should the scroll wheel control vertical speed (true) or should it control IAS (false)?
local current_alt = 0
local current_hdg = 0
local FLCState
local VSenabled


-- Initialize local variables with sim values
fs2020_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR", "Feet", 
                          "PLANE HEADING DEGREES MAGNETIC", "Degrees", 
                          function(ap_alt, heading)
                            current_alt = ap_alt
                            current_hdg = math.floor(heading + 0.5)
                          end
                        )
                        
                        
--ADD BUTTONS AND KNOBS

--hdg
function click_press_callback_btn_HDG()
	fs2020_event("AP_PANEL_HEADING_HOLD")
	sound_play(buttonClick)
end

button_add("hdg.png", "hdg.png", 85 , 20 , 60 , 40, click_press_callback_btn_HDG, click_release_callback_btn_HDG)

--apr
function click_press_callback_btn_APR()
	fs2020_event("AP_APR_HOLD")
	sound_play(buttonClick)
end

button_add("apr.png", "apr.png", 180 , 20 , 60 , 40, click_press_callback_btn_APR, click_release_callback_btn_APR)

--nav
function click_press_callback_btn_NAV()
	fs2020_event("AP_NAV1_HOLD")
	sound_play(buttonClick)
end

button_add("nav.png", "nav.png", 290 , 20 , 60 , 40, click_press_callback_btn_NAV, click_release_callback_btn_NAV)

--bc
function click_press_callback_btn_BC()
	fs2020_event("AP_BC_HOLD_ON")
	sound_play(buttonClick)
end

button_add("bc.png", "bc.png", 180 , 126 , 60 , 40, click_press_callback_btn_BC, click_release_callback_btn_BC)

--hdg knob
function dial_HDG_turned(direction)
	if direction ==  1 then
        fs2020_event("HEADING_BUG_INC")
    elseif direction == -1 then
        fs2020_event("HEADING_BUG_DEC")
    end
    sound_play(knobScroll)
end

dial_HDG = dial_add("knob_hdg.png" , 81 ,97 , 70 , 70 , dial_HDG_turned)

--hdg knob press
function click_press_callback_HDG_PUSH()
	fs2020_event("HEADING_BUG_SET", current_hdg)
	sound_play(knobClick)
end

button_add(nil, nil, 95 , 120 , 30 , 30, click_press_callback_HDG_PUSH)


-- Crs 1 knob
function dial_CRS1_turned(direction)
	if direction ==  1 then
        fs2020_event("H:AS1000_PFD_CRS_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_PFD_CRS_DEC")
    end
	sound_play(knobScroll)
end

dial_CRS1 = dial_add("knob_basic.png" , 289 , 97 , 70 , 70 , dial_CRS1_turned)

--Crs 1 knob press
function click_press_callback_CRS1()
	sound_play(errorSound)
	sound_play(knobClick)
end

button_add(nil, nil, 303 , 122 , 30 , 30, click_press_callback_CRS1, click_release_callback_CRS1)


--FD
function click_press_callback_btn_FD()
	fs2020_event("TOGGLE_FLIGHT_DIRECTOR")   
	sound_play(buttonClick)
end

button_add("fd.png", "fd.png", 405 , 20 , 60 , 40, click_press_callback_btn_FD, click_release_callback_btn_FD)


--Bank
function click_press_callback_btn_BANK()
	--INOP
	sound_play(errorSound)
end

button_add("bank.png", "bank.png", 405 , 125 , 60 , 40, click_press_callback_btn_BANK, nil)


--XFR
function click_press_callback_btn_XFR()
	-- INOP
	sound_play(errorSound)
end

button_add("xfr.png", "xfr.png", 560 , 20 , 60 , 40, click_press_callback_btn_XFR, click_release_callback_btn_XFR)


--AP Master
function click_press_callback_btn_AP()
	fs2020_event("AP_MASTER")   
	sound_play(buttonClick)
end

button_add("ap.png", "ap.png", 510 , 125 , 60 , 40, click_press_callback_btn_AP, click_release_callback_btn_AP)


--YD
function click_press_callback_btn_YD()
	fs2020_event("YAW_DAMPER_TOGGLE")
	sound_play(buttonClick)
end

button_add("yd.png", "yd.png", 605 , 125 , 60 , 40, click_press_callback_btn_YD, click_release_callback_btn_YD)


--Alt
function click_press_callback_btn_ALT()
	fs2020_event("AP_PANEL_ALTITUDE_HOLD")
	sound_play(buttonClick)
end

button_add("alt.png", "alt.png", 730 , 20 , 60 , 40, click_press_callback_btn_ALT, click_release_callback_btn_ALT)


--VS
function click_press_callback_btn_VS()
    scroll_vs_mode = true
    fs2020_event("AP_PANEL_VS_HOLD")
    sound_play(buttonClick)
end

button_add("vs.png", "vs.png", 830 , 20 , 60 , 40, click_press_callback_btn_VS, click_release_callback_btn_VS)

--FLC
function flc_callback(flcstate)
	FLCState = flcstate 
	return FLCState    
end

function vs_callback(vsenabled)
	VSenabled = vsenabled  
	return VSenabled    
end

fs2020_variable_subscribe("AUTOPILOT FLIGHT LEVEL CHANGE", "bool", flc_callback)  

function click_press_callback_btn_FLC()
	if FLCState then  --check if FLC is currently on
		scroll_vs_mode = true
		fs2020_event("FLIGHT_LEVEL_CHANGE_OFF")    --if true, toggle off
	else    -- if FLC currently off
		scroll_vs_mode = false
		AirspeedDecimal = math.floor(AirspeedIndicated)        -- read current airspeed and convert variable
		fs2020_event("FLIGHT_LEVEL_CHANGE_ON")                --enable FLC
		fs2020_event("AP_SPD_VAR_SET", AirspeedDecimal)    -- set FLC speed to current airspeed
	end
	sound_play(buttonClick)
end

function aspd_callback(asindicated)
	AirspeedIndicated = asindicated  
	return AirspeedIndicated    
end

button_add("flc.png", "flc.png", 1040 , 20 , 60 , 40, click_press_callback_btn_FLC, click_release_callback_btn_FLC)


--VNAV
function click_press_callback_btn_VNV()
	fs2020_event("GPS_VNAV_BUTTON")				-- for other GPS systems EXCEPT WT G1000 NXi
	fs2020_event("H:AS1000_VNAV_TOGGLE")		-- for WT G1000 NXi VNAV
	sound_play(buttonClick)
end

button_add("vnv.png", "vnv.png", 830 , 125 , 60 , 40, click_press_callback_btn_VNV, click_release_callback_btn_VNV)


--Spd
function click_press_callback_btn_SPD()
        AirspeedDecimal = math.floor(AirspeedIndicated)        -- read current airspeed and convert variable
        fs2020_event("AP_SPD_VAR_SET", AirspeedDecimal)    -- set FLC speed to current airspeed
	sound_play(buttonClick)
end

button_add("spd.png", "spd.png", 1040 , 125 , 60 , 40, click_press_callback_btn_SPD, click_release_callback_btn_SPD)

--ALT knob

local ap_altitude = 0

function dial_ALT_turned(direction)
	if direction == 1 then
           fs2020_event("AP_ALT_VAR_INC")
        elseif direction == -1 then
           fs2020_event("AP_ALT_VAR_DEC")
        end

end

dial_ALT = dial_add("knob_basic.png" , 729 , 97 , 70 , 70 , dial_ALT_turned)
dial_click_rotate(dial_ALT, 6)


--Alt button
function click_press_callback_ALT()
	fs2020_event("AP_PANEL_ALTITUDE_HOLD")
	sound_play(knobClick)
end

button_add(nil, nil, 742 , 122 , 40 , 30, click_press_callback_ALT, click_release_callback_ALT)


--VS / FLC scroll wheel
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
end

vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 949, 37, 28, 154, 34, 34, vs_callback)
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

dial_CRS2 = dial_add("knob_basic.png" , 1167 , 98 , 70 , 70 , dial_CRS2_turned)


--Indicator lights
img_hdg_active   = img_add("led.png", 145, 16, 18, 45)	
img_apr_active   = img_add("led.png", 245, 16, 18, 45)		
img_nav_active   = img_add("led.png", 355, 16, 18, 45)	
img_BC_active = img_add("led.png", 245, 127, 18, 45)
img_BANK_active = img_add("led.png", 470, 126, 18, 45)
img_AP_pilot_active = img_add("ledL.png", 523, 19, 40, 38)
img_AP_copilot_active = img_add("ledR.png", 620, 19, 40, 38)
visible (img_AP_copilot_active, false)
img_ap_active    = img_add("led.png", 575, 126, 18, 45)			
img_yd_active    = img_add("led.png", 670, 126, 18, 45)
img_alt_active   = img_add("led.png", 795, 16, 18, 45)			--
img_vs_active    = img_add("led.png", 890, 16, 18, 45)			--
img_vnav_active  = img_add("led.png", 890, 126, 18, 45)		--
img_ias_active   = img_add("led.png", 1105, 16, 18, 45)		--


function ap_cb (hdg,  nav, apr, ap_mode, fd_mode,  yaw, ias,  vs, alt, heading, altitude, avionics, battery,generator, vnv, bank, bc)
	
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
	
    --power = true
    visible(img_hdg_active, hdg and power)
    visible(img_nav_active, nav and power )
    visible(img_apr_active, apr and power)
    visible(img_ap_active, ap_mode and power )
    visible(img_yd_active, yaw  and power)
    visible(img_ias_active, ias and power )
    scroll_vs_mode = vs and power
    visible(img_vs_active, vs and power)
    visible(img_alt_active, alt  and power)
    visible(img_vnav_active, vnv_on  and power)
    visible(img_BANK_led, bank  and power)
    visible(img_BC_active, bc  and power)
    
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
					        "AUTOPILOT BANK HOLD", "Bool", 
					        "AUTOPILOT BACKCOURSE HOLD", "Bool",
						ap_cb)


function aspd_callback(asindicated)
	AirspeedIndicated = asindicated  
end
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)
