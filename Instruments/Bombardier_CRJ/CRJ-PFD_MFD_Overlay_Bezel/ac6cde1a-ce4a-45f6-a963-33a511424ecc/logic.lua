--[[
******************************************************************************************
******************Bombardier CRJ PFD MFD Overlay Bezel**************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 02-06-2022
    - Original Panel Created


##Left To Do:
    - Graphics
	
##Notes:
    - There is a user prop to set position to Pilot or CoPilot or Both.
    - There is a user prop to show or hide a dimmer knob to control the PFD/MFD brightness. You must have the Position user prop set to control one side or both sides.
******************************************************************************************
--]]

local controlside =  0
snd_dial=sound_add("dial.wav")

--User prop to set position side.
prop_position_side = user_prop_add_enum("Position to control", "Pilot,CoPilot,Both", "Pilot", "You can choose to control Pilot, CoPilot or both display brightness when the dimmer knob is shown.")
if user_prop_get(prop_position_side) == ("Pilot" or "Both") then
        controlside = "L:ASCRJ_LSP_"
 elseif user_prop_get(prop_position_side) == "CoPilot" then 
        controlside = "L:ASCRJ_RSP_"
end  
--User prop to show or hide dimmer knob.
prop_dimmer_knob = user_prop_add_boolean("Show Dimmer Knob", true, "You can choose to hide the dimmer knob. Useful if you don't wan to show the Side Panel Lighting Row.")

img_overlay_dim = img_add("background_night.png", 0, 0, 810, 1070)
opacity(img_overlay_dim, 0.0, "LOG", 0.04)

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
    if user_prop_get(prop_dimmer_knob) == true then
            opacity(img_light_dspl_night, value, "LOG", 0.04)
    end
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
--=======PFD MFD Screen Dimming=======================================
if user_prop_get(prop_dimmer_knob) == true then

local local_light_dspl = 0
img_light_dspl = img_add("smallknob_inner.png", 20, 70, 57, 57)
img_light_dspl_night = img_add("smallKnob_inner_night.png",20, 70, 57, 57)
fs2020_variable_subscribe(controlside.."DSPL", "Number",     
        function (state)
            local_light_dspl = state
             rotate(img_light_dspl, local_light_dspl*10)
             rotate(img_light_dspl_night, local_light_dspl*10)
        end) 

function cb_light_dspl(direction) 
    sound_play(snd_dial)
    if direction == 1 then fs2020_variable_write(controlside.."DSPL", "Number", var_cap(local_light_dspl+2,0,26) ) if user_prop_get(prop_position_side) == "Both" then fs2020_variable_write("L:ASCRJ_RSP_DSPL", "Number", var_cap(local_light_dspl+2,0,26) ) end
    else fs2020_variable_write(controlside.."DSPL", "Number", var_cap(local_light_dspl-2,0,26) ) if user_prop_get(prop_position_side) == "Both" then fs2020_variable_write("L:ASCRJ_RSP_DSPL", "Number", var_cap(local_light_dspl-2,0,26) ) end
    end 
end
dial_light_dspl = dial_add(nil, 20, 70, 57, 57, cb_light_dspl)


end  
