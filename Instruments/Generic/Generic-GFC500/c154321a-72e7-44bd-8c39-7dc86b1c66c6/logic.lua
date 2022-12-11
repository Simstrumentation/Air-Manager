--[[
******************************************************************************************
************************ GENERIC CARMIN GFC500 AUTOPILOT ***********************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

GFC 500 Autopilot module

Version info:
- **v1.0** - 2022-12-11

NOTES: 
- Should work in most aircraft with a GFC500 or similar autopilot. 
- Yaw Damper button can be hidden or shown to match your plane's AP module via user property

KNOWN ISSUES:
- None

TO DO LIST:
- Make thumbwheel Knobster-accessible. Offer user property to use as either a touch wheel or Knobster.

ATTRIBUTION:
Based on an instrument from Russ Barlow / Sim Innovations.

Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

-- User Properties
up_yd_shown = user_prop_add_boolean("Show Yaw Damper", true, "Show YD button and annunciator")                           -- Use sounds in Air Manager    

-- Global variables
local scroll_vs_mode = true -- Should the scroll wheel control vertical speed (true) or should it control IAS (false)?
local currentHeading = 0
local currentAltitude = 0
local power = false
-- Add images
img_add_fullscreen("ap_background.png")

-- Button callbacks
function callback_hdg()

   fs2020_event("AP_PANEL_HEADING_HOLD")

end

function callback_nav()

    fs2020_event("AP_NAV1_HOLD")
end

function callback_trk()

end

function callback_ap()
     fs2020_event("AP_MASTER")   
 end

function callback_lvl()
	fs2020_event("AP_WING_LEVELER_ON")
end

-- Required code for proper FLC speed capture and set

        function callback_flc(flcstate)
            FLCState = flcstate 
            return FLCState    
        end
        
        function vs_callback(vsenabled)
            VSenabled = vsenabled  
        return VSenabled    
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
    end

	function aspd_callback(asindicated)
		AirspeedIndicated = asindicated  
		return AirspeedIndicated    
	end

fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)
-- End required code for proper FLC speed capture and set

function callback_alt()
    fs2020_event("AP_PANEL_ALTITUDE_HOLD")
end

function callback_apr()
   fs2020_event("AP_APR_HOLD")
end

function callback_fd()
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")   
end

function callback_vs()
      fs2020_event("AP_PANEL_VS_HOLD")
 end

function callback_vnv()
	fs2020_event("H:AS1000_VNAV_TOGGLE")
end

function callback_yd()
    fs2020_event("YAW_DAMPER_TOGGLE")
end

function altitude_input(direction)
    if direction == 1 then
		fs2020_event("AP_ALT_VAR_INC")
	else
 		fs2020_event("AP_ALT_VAR_DEC")
	end
end

function heading_input(direction)
    if direction == 1 then
		fs2020_event("HEADING_BUG_INC")
    else
 		fs2020_event("HEADING_BUG_DEC")
    end
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
end

-- Create a new scroll wheel
vs_scrollwheel = scrollwheel_add_ver("vs_thumb.png", 424, 62, 28, 122, 28, 32, vs_callback)
img_add("shadow.png", 424,62,28,122)

-- Add the buttons
button_hdg = button_add(nil , "autopilot_button_in.png", 63, 173, 60, 43, callback_hdg)
button_nav = button_add(nil , "autopilot_button_in.png", 147, 173, 60, 43, callback_nav)
button_ap = button_add(nil , "autopilot_button_in.png", 230, 66, 60, 43,  callback_ap)
button_lvl = button_add(nil , "autopilot_button_in.png", 310, 66, 60, 43,  callback_lvl)
button_flc = button_add(nil , "autopilot_button_in.png", 477, 34, 60, 43,  callback_flc)
button_alt = button_add(nil , "autopilot_button_in.png", 567, 175, 60, 43,  callback_alt)
button_apr = button_add(nil , "autopilot_button_in.png", 147, 39, 60, 43, callback_apr)
button_fd = button_add(nil , "autopilot_button_in.png", 232, 139, 60, 43,  callback_fd)
button_vs = button_add(nil , "autopilot_button_in.png", 477, 175, 60, 43, callback_vs)
button_vnv = button_add(nil , "autopilot_button_in.png", 477, 105, 60, 43, callback_vnv)

if user_prop_get(up_yd_shown) then
    img_add_fullscreen("YD_Button.png")
    button_yd= button_add(nil , "autopilot_button_in.png", 310, 139, 60, 43, callback_yd)
    img_yd_active   = img_add("white_triangle_lit.png", 328, 120, 26, 16, "visible:false")
end 

hdg_dial_shadow = img_add("knob_shadow.png", 52,50,130,130)

opacity(hdg_dial_shadow, 0.75)
heading_dial = dial_add("heading_dial.png", 57,50,68,68,3, heading_input)
alt_dial_shadow = img_add("knob_shadow.png", 555,50,130,130)
opacity(alt_dial_shadow, 0.75)
altitude_dial = dial_add("alt_dial.png", 560,50,68,68,3, altitude_input)


function sync_heading_pressed()
	fs2020_event("HEADING_BUG_SET", currentHeading)	
end
button_add( nil,nil,78,71,31,31, sync_heading_pressed)

function sync_altitude_pressed()
 	fs2020_event("AP_ALT_VAR_SET_ENGLISH", currentAltitude)	
end

button_add( nil,nil,580,71,31,31, sync_altitude_pressed)

-- Active mode lights
img_hdg_active  = img_add("white_triangle_lit.png", 78, 153, 26, 16, "visible:false")
--img_trk_active  = img_add("white_triangle_lit.png", 165, 153, 26, 16, "visible:false")
img_nav_active  = img_add("white_triangle_lit.png", 165, 153, 26, 16, "visible:false")
img_apr_active  = img_add("white_triangle_lit.png", 165, 17, 26, 16, "visible:false")
img_ap_active   = img_add("white_triangle_lit.png", 245, 47, 26, 16, "visible:false")
img_fd_active   = img_add("white_triangle_lit.png", 245, 120, 26, 16, "visible:false")
img_lvl_active  = img_add("white_triangle_lit.png", 327, 47, 26, 16, "visible:false")
img_ias_active  = img_add("white_triangle_lit.png", 495, 16, 26, 16, "visible:false")
img_vnav_active = img_add("white_triangle_lit.png", 495, 84, 26, 16, "visible:false")
img_vs_active   = img_add("white_triangle_lit.png", 495, 155, 26, 16, "visible:false")
img_alt_active  = img_add("white_triangle_lit.png", 583, 155, 26, 16, "visible:false")



function ap_cb (hdg,  nav, apr, ap_mode, fd_mode,  yaw, ias,  vs, alt, heading, altitude, avionics, battery,generator, vnv)
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
	if (battery >= 1 or generator == true ) then
		power = true
	else
		power = false
	end
    power = true
    visible(img_hdg_active, hdg and power)
    visible(img_nav_active, nav and power )
    visible(img_apr_active, apr and power)
    visible(img_ap_active, ap_mode and power )
    visible(img_fd_active, fd_mode and power)
    visible(img_ias_active, ias and power )
    scroll_vs_mode = vs and power
    visible(img_vs_active, vs and power)
    visible(img_alt_active, alt  and power)
    visible(img_vnav_active, vnv_on  and power)
    
    
    
 --if yd enabled
     visible(img_yd_active, yd_on  and power and user_prop_get(up_yd_shown))
 --end if yd enabled
 
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
						    ap_cb)


function aspd_callback(asindicated)
	AirspeedIndicated = asindicated  
end
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)