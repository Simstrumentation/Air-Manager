--[[
**************************************************************************************
***********CESSNA 414 CHANCELLOR GARMIN GFC 600 OVERLAY*****************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

Garmin GC 600 autopilot OVERLAY for the Cessna 414 Chancellow by FlySimware

Version info:

- **v1.0** (24 April, 2022)
    - Original release
    
NOTES: 
- Will only work with the Flysimware Cessna 414 Chancellor
- Requires the use of the popout from the autopilot screen in MSFS (Right Alt + click) for its display. 

KNOWN ISSUES:
- None

ATTRIBUTION:
All code, artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

img_add_fullscreen("bg.png")
ap_id = img_add("indicator.png", 34, 34, 22, 22)
ap_amber_id = img_add("light_amber.png", 34, 34, 22, 22)
fd_id = img_add("indicator.png", 34, 118, 22, 22)
yd_id = img_add("indicator.png", 34, 194, 22, 22)
yd_amber_id = img_add("light_amber.png", 34, 194, 22, 22)
opacity(ap_id, 0)
opacity(ap_amber_id, 0)
opacity(fd_id, 0)
opacity(yd_id, 0)
opacity(yd_amber_id, 0)

local ap_mode
local apbtn
local fd_mode
local yd_mode
local hdg_mode
local nav_mode
local apr_mode
local bc_mode
local ias_mode
local vs_mode
local alt_mode
local lvl_mode

local scroll_vs_mode = false -- Should the scroll wheel control vertical speed (true) or should it control IAS (false)?
local currentHeading = 0
local currentAltitude = 0
local power = false
local FLCState = false
local VSenabled = false
--add buttons
function cb_set_ap()
    fs2020_event("AP_MASTER")
end

--
ap_btn = button_add(nil, nil, 64, 29,  56, 40, cb_set_ap)

function cb_set_fd()
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")   
end
fd_btn = button_add(nil, nil, 64, 110,  56, 40, cb_set_fd)

function cb_set_yd()
    fs2020_event("YAW_DAMPER_TOGGLE")
end
yd_btn= button_add(nil, nil, 64, 189,  56, 40, cb_set_yd)

function cb_set_hdg()
    fs2020_event("AP_PANEL_HEADING_HOLD")
end
hdg_btn = button_add(nil, nil, 161, 189,  56, 40, cb_set_hdg)

function cb_set_nav()
    fs2020_event("AP_NAV1_HOLD")
end
nav_btn = button_add(nil, nil, 256, 189,  56, 40, cb_set_nav)

function cb_set_apr()
    fs2020_event("AP_APR_HOLD") 
end
apr_btn = button_add(nil, nil, 344, 189,  56, 40, cb_set_apr)

function cb_set_bc()

end
bc_btn = button_add(nil, nil, 440, 189,  56, 40, cb_set_bc)

-- Required code for proper FLC speed capture and set
-- Code added by Joe Gilker to read the FLC / VS current state


        function callback_flc(flcstate)
            FLCState = flcstate 
            return FLCState    
        end
        
        function vs_callback(vsenabled)
            VSenabled = vsenabled  
            print(VSenabled)
        return VSenabled    
        end
-- flc current state variable
fs2020_variable_subscribe("AUTOPILOT FLIGHT LEVEL CHANGE", "bool", callback_flc)  

function callback_flc()
    print(FLCState)
    scroll_vs_mode = false
    
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

ias_btn = button_add(nil, nil, 632, 189,  56, 40, callback_flc)

function cb_set_vs()
    scroll_vs_mode = true
    fs2020_event("AP_PANEL_VS_HOLD")
end
vs_btn = button_add(nil, nil, 752, 189,  56, 40, cb_set_vs)

function cb_set_lvl()
    fs2020_event("H:GFC605_LVL")
end
lvl_btn = button_add(nil, nil, 752, 9,  56, 40, cb_set_lvl)

function cb_set_alt()
    fs2020_event("AP_PANEL_ALTITUDE_HOLD")
end
alt_btn = button_add(nil, nil, 752, 109,  56, 40, cb_set_alt)

function wheel_cb(direction)
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
ap_wheel = dial_add(nil, 870, 40, 47, 183, wheel_cb)


function set_vars(ap, apbtn,  fd, yd, lvl, hdg, nav, apr, bc, ias, vs, alt, ap_state)
    ap_mode = ap
--    print(ap_mode)
    ap_btn = apbtn
    fd_mode = fd
--    print("FD Mode = " .. fd)
    yd_mode = yd
--    print("YD Mode = " .. yd)
    hdg_mode = hdg
    ---print("HDG Mode = " .. hdg)
    nav_mode = nav
    --print("Nav Mode = " .. nav)
    apr_mode = apr
    --print("APR Mode = " .. apr)
    bc_mode = bc
    ias_mode = ias
    vs_mode = vs
    alt_mode = alt
    ap_master = ap_state
end

 fs2020_variable_subscribe("A:AUTOPILOT MASTER", "BOOL",  
                                               "L:AP_BTN", "Number",  
                                               "L:FD_MODE", "Number",
                                               "L:YD_MODE", "Number",
                                               "L:LVL_MODE", "Number",
                                               "L:HDG_MODE", "Number",
                                               "L:NAV_MODE", "Number",
                                               "L:APR_MODE", "Number",
                                               "L:BC_MODE", "Number",
                                               "L:IAS_MODE", "Number",
                                               "L:VS_MODE", "Number",
                                               "L:ALT_MODE", "Number",
                                               "A:AUTOPILOT MASTER", "BOOL",
                                                 set_vars)
                                                 
                                                 
                                                 
                                                 
                                                 
                                                 function ap_cb (hdg,  nav, apr, ap_mode, fd_mode,  yaw, ias,  vs, alt, heading, altitude, avionics, battery,generator, vnv)
	if (vnv == 1) then
	    vnv_on = true
	else
	    vnv_on = false
	end 
	        
	if (battery >= 1 or generator == true ) then
		power = true
		
	else
		power = false
	end
power = true
--	visible (img_ap_on, power)
   -- visible(img_hdg_active, hdg and power)
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

function set_indicators(ap, ap_blink, fd, yd, yd_blink)
    if ap == 1 and ap_blink == 0 then
        opacity(ap_id, 1, "LOG", 0.3)
        opacity(ap_amber_id, 0, "LOG", 0.3)
    elseif ap == 1 and ap_blink == 1 then
        local ap_on_off = 1
        opacity(ap_id, 0, "LOG", 0.3)
        timer_start(0, 500, 8, function()
            opacity(ap_amber_id, ap_on_off, "LOG", 0.3)
            if ap_on_off == 1 then 
                ap_on_off = 0
            else 
                ap_on_off = 1
            end
        end)
    else
        opacity(ap_id, 0, "LOG", 0.3)
        opacity(ap_amber_id, 0, "LOG", 0.3)
    
    end
    
    if fd then
        opacity(fd_id, 1, "LOG", 0.3)
    else
        opacity(fd_id, 0, "LOG", 0.3)
    end
    
    if yd == 1 and yd_blink == 0 then
        opacity(yd_id, 1, "LOG", 0.3)
        opacity(yd_amber_id, 0, "LOG", 0.3)
    elseif yd == 1 and yd_blink == 1 then
        local yd_on_off = 1
        opacity(yd_id, 0, "LOG", 0.3)
        timer_start(0, 500, 8, function()
            opacity(yd_amber_id, yd_on_off, "LOG", 0.3)
            if yd_on_off == 1 then 
                yd_on_off = 0
            else 
                yd_on_off = 1
            end
        end)
    else
        opacity(ap_id, 0, "LOG", 0.3)
        opacity(ap_amber_id, 0, "LOG", 0.3)
    
    end
end

function timer_callback(count, max)
    print("Timer callback " .. count .. " of " .. max)
end

ap_blink_timer = timer_start(0, 500, 5, ap_blink_timer_cb)
--timer_stop(ap_blink_timer)
fs2020_variable_subscribe(--"AUTOPILOT MASTER", "Bool",
                          "L:AP_MEM","Number",
                          "L:AP_BLINK_ENABLE", "Number",
                          "AUTOPILOT FLIGHT DIRECTOR ACTIVE","Bool",
                          --"AUTOPILOT YAW DAMPER", "Bool",
                          "L:YAW_DAMPER_MEM","Number",
                          "L:YAW_BLINK_ENABLE","Number",
                                           set_indicators)
                                            
                                       
                                            
                                            
                                            
                                            
                                            