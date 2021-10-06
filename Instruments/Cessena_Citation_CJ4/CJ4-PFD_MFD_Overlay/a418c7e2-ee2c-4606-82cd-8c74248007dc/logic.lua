--[[
******************************************************************************************
******************Cessna Citation CJ4 PFD MFD Overlay Bezel**************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-07-2021 Rob "FlightLevelRob" Verdon
    - Original Panel Created
- **v2.0** 08-29-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker
    - Replaced Graphic with custom built graphic
    - Added User Prop to set overlay as PFD or MFD      
    - Added PFD & MFD dimming as set by user prop
    - Added Ambient Light Dimming
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status

##Left To Do:
    - 
	
##Notes:
    - There is a userprop to set overlay as PFD or MFD. This is only used for display dimming by Light Panel or Virtural Cockpit Light Panel.  

******************************************************************************************
--]]

 
--User Prop to set overlay as PFD or MFD   
prop_display_type = user_prop_add_enum("Display unit function","PFD,MFD","PFD","Select bezel type")
--Check to see if PFD, else is MFD and set black overlay 
if user_prop_get(prop_display_type) == "PFD" then
    img_pfd_dim = img_add("background_Dim.png", 0, 0, 810, 1070)
    opacity(img_pfd_dim, 0.0, "LOG", 0.04)
else
    img_mfd_dim = img_add("background_Dim.png", 0, 0, 810, 1070)
    opacity(img_mfd_dim, 0.0, "LOG", 0.04)
end

--User Prop to use trimmed overlay 
prop_trimmed_overlay = user_prop_add_boolean ("Use Smaller Overlay",false,"Use smaller overlay/bezel for smaller screens to take up less space.")

if user_prop_get(prop_trimmed_overlay) == false then
    img_add_fullscreen("background.png")
    img_bg_night = img_add_fullscreen("background_night.png")
else
    img_add_fullscreen("background_slim.png")
    img_bg_night = img_add_fullscreen("background_night_slim.png")
end


-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
--=======PFD MFD Screen Dimming=======================================
--Test if PFD or MFD and set opacity for brightness
function ss_pfd1_dim(value) 
    if user_prop_get(prop_display_type) == "PFD" then
        opacity(img_pfd_dim, value, "LOG", 0.04)
    end
end
si_variable_subscribe("sivar_overlay_pfd1_dim", "FLOAT", ss_pfd1_dim)

function ss_mfd1_dim(value) 
    if user_prop_get(prop_display_type) == "MFD" then
            opacity(img_mfd_dim, value, "LOG", 0.04)
    end
end
si_variable_subscribe("sivar_overlay_mfd1_dim", "FLOAT", ss_mfd1_dim)
