--[[
******************************************************************************************
****************** CIRRUS SF50 VISION JET FLAP ACTUATOR **************************
******************************************************************************************
    Made by SIMSTRUMENTATION in collaboration with Russ Barlow
    GitHub: https://simstrumentation.com

Flap actuator for the Vision Jet by FlightFX

Version info:
- **v1.0** - 2022-12-11

NOTES: 
- Made for the FlightFX Vision Jet
- Should work in most MSFS aircraft, but compatibility not guaranteed. 

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code and graphics from Russ Barlow. Used with permission. 

Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

--images
img_add_fullscreen("flaps_background.png")
shadow_img = img_add("Shadow_handle.png", 5, 20, 673, 604 )
opacity(shadow_img, 0.75)
flap_up_img = img_add_fullscreen("flaps_handle_up.png")


-- move flap handle and shadow to follow simvars
function handle_position_set_fs2020( pos)
	if pos == 0 then
	rotate(shadow_img, 0, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	rotate(flap_up_img, 0, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	
	elseif pos == 1 then
	    rotate(shadow_img, 25, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	    rotate(flap_up_img, 25, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	else
	    rotate(shadow_img, 60, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	    rotate(flap_up_img, 60, 130, 235, 0, "LINEAR", 0.1, "DIRECT") 
	end
end
fs2020_variable_subscribe("A:FLAPS HANDLE INDEX", "ENUM", handle_position_set_fs2020)

 --activate flaps 
function flap_callback(direction)
    if direction == 1 then
        fs2020_event("FLAPS_INCR")
    else
        fs2020_event("FLAPS_DECR")
    end
end

-- Create an invisible slider (nil image references)
flap_scroll = scrollwheel_add_ver( nil, 120 , 40, 450, 460, 450 , 50, flap_callback)
mouse_setting(flap_scroll , "CURSOR", "grab_hand.png")