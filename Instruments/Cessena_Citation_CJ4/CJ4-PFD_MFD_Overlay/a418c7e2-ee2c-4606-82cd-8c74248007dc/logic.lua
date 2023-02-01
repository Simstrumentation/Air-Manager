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
- **v2.0** 10-5-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-16-2022 SIMSTRUMENTATION
    - Resource folder file capitials renamed for SI Store submittion  
- **v2.2** 12-06-2022 SIMSTRUMENTATION    
   - Updated code to reflect AAU1 being released in 2023Q1
   - Added PFD2 & MFD2 as user prop options.
   - Added screen power affect based on circuit power.
   
## Left To Do:
  - N/A
	
## Notes:
  - There is a userprop to set overlay as PFD1, PFD2, MFD1, or MFD2. This is only used for display dimming by Light Panel or Virtural Cockpit Light Panel.  

******************************************************************************************
--]]

--Set Screenoff
screenoff = img_add("background_Dim.png", 7, 0, 810, 1070)
 
--User Prop to set overlay as PFD or MFD   
prop_display_type = user_prop_add_enum("Display unit function","PFD1,MFD1,PFD2,MFD2","PFD1","Select bezel type")
--Check to see and set black overlay 
if user_prop_get(prop_display_type) == "PFD1" then
    img_pfd1_dim = img_add("background_Dim.png", 7, 0, 810, 1070)
    opacity(img_pfd1_dim, 0.0, "LOG", 0.04)
elseif user_prop_get(prop_display_type) == "MFD1" then
    img_mfd1_dim = img_add("background_Dim.png", 7, 0, 810, 1070)
    opacity(img_mfd1_dim, 0.0, "LOG", 0.04)
elseif user_prop_get(prop_display_type) == "PFD2" then
    img_pfd2_dim = img_add("background_Dim.png", 7, 0, 810, 1070)
    opacity(img_pfd2_dim, 0.0, "LOG", 0.04)
elseif user_prop_get(prop_display_type) == "MFD2" then
    img_mfd2_dim = img_add("background_Dim.png", 7, 0, 810, 1070)
    opacity(img_mfd2_dim, 0.0, "LOG", 0.04)    
end

function ss_screenpower(Cir41, Cir39)
        if user_prop_get(prop_display_type) == "MFD1" and  Cir41== true then
            visible(screenoff, false)
        elseif user_prop_get(prop_display_type) ~= "MFD1" and  Cir39== true then
            visible(screenoff, false)
        else
            visible(screenoff, true)
        end        
end
fs2020_variable_subscribe(
                          "CIRCUIT ON:41","bool",
                          "CIRCUIT ON:39","bool", ss_screenpower)



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
function ss_dim(pfd1_value,mfd1_value,pfd2_value,mfd2_value) 
    if (user_prop_get(prop_display_type) == "PFD1" )then
        opacity(img_pfd1_dim, pfd1_value, "LOG", 0.04)
    end
    
    if user_prop_get(prop_display_type) == "MFD1" then
            opacity(img_mfd1_dim, mfd1_value, "LOG", 0.04)
    end

    if user_prop_get(prop_display_type) == "PFD2" then
        opacity(img_pfd2_dim, pfd2_value, "LOG", 0.04)
    end

    if user_prop_get(prop_display_type) == "MFD2" then
            opacity(img_mfd2_dim, mfd2_value, "LOG", 0.04)
    end
end
si_variable_subscribe("sivar_overlay_pfd1_dim", "FLOAT", 
                                    "sivar_overlay_mfd1_dim", "FLOAT", 
                                    "sivar_overlay_pfd2_dim",  "FLOAT", 
                                    "sivar_overlay_mfd2_dim", "FLOAT", ss_dim)
                                    
                                    