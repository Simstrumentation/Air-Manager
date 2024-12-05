--[[
******************************************************************************************
******************Bombardier CRJ PFD MFD EICAS Overlay****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 02-06-2022
    - Original Panel Created
- **v1.1** 10-26-2022
    - Renamed to also include EICAS
    - Fixed Dimmer Knob to also include either EICAS display
- **v1.2** 12-22-2022
    - Replaced Graphics
    - Added Pop Warning
    
## Left To Do:
  - N/A
	
## Notes:
  - There is a user prop to set position to Pilot or CoPilot or EICAS.
  - There is a user prop to show or hide a dimmer knob to control the PFD/MFD brightness.
    
******************************************************************************************
--]]
--***********************************************PLATFORM WARNING MESSAGES***********************************************

-- Message for Raspberry Pi and tablet versions
if instrument_prop("PLATFORM") == "RASPBERRY_PI" or instrument_prop("PLATFORM") == "ANDROID" or instrument_prop("PLATFORM") == "IPAD" then
    canvas_add(50, 100, 750, 950, function()
        _rect(0,0,830, 1000)
        _fill("black")
    end)
    canv_message = canvas_add(50, 100, 750, 950, function()
        _rect(0,0,830,1000)
        _fill("blue")
        _txt("THIS IS AN OVERLAY ONLY", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 298)
        _txt("IT REQUIRES THE FLIGHTSIM POP OUT", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 348)
        _txt("SEE OUR WIKI FOR MORE INFORMATION", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 398)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 548)
    end)
    butn_hide = button_add(nil, nil, 100, 150, 700, 800, function()
        visible(canv_message, false)
        visible(butn_hide, false)
    end)
end

-- Message for desktop
pers_msg_read = persist_add("msg_read", false)
if (instrument_prop("PLATFORM") == "WINDOWS" or instrument_prop("PLATFORM") == "MAC" or instrument_prop("PLATFORM") == "LINUX") and not persist_get(pers_msg_read) then
    canv_message = canvas_add(50, 100, 750, 950, function()
        _rect(0,0,830,1000)
        _fill("blue")
        _txt("THIS IS AN OVERLAY ONLY", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 298)
        _txt("IT REQUIRES THE FLIGHTSIM POP OUT", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 348)
        _txt("SEE OUR WIKI FOR MORE INFORMATION", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 398)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 350, 548)
    end)
    butn_hide = button_add(nil, nil, 100, 150, 700, 800, function()
        visible(canv_message, false)
        visible(butn_hide, false)
        persist_put(pers_msg_read, true)
    end)
end

local controlside =  0
snd_dial=sound_add("dial.wav")

--User prop to set position side.
prop_position_side = user_prop_add_enum("Position to control", "Pilot,CoPilot,EICAS", "Pilot", "You can choose to control Pilot, CoPilot or EICAS display brightness when the dimmer knob is shown.")
if user_prop_get(prop_position_side) == ("Pilot") then
        controlside = "L:ASCRJ_LSP_DSPL"
 elseif user_prop_get(prop_position_side) == "CoPilot" then 
        controlside = "L:ASCRJ_RSP_DSPL"
 elseif user_prop_get(prop_position_side) == "EICAS" then 
        controlside = "L:ASCRJ_INTL_DSPL_BRT"        
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
--=======PFD MFD EICAS Screen Dimming=======================================
if user_prop_get(prop_dimmer_knob) == true then
    local local_light_dspl = 0
    img_light_dspl = img_add("smallknob_inner.png", 20, 70, 57, 57)
    img_light_dspl_night = img_add("smallKnob_inner_night.png",20, 70, 57, 57)
    msfs_variable_subscribe(controlside, "Number",     
            function (state)
                local_light_dspl = state
                 rotate(img_light_dspl, local_light_dspl*10)
                 rotate(img_light_dspl_night, local_light_dspl*10)
            end) 
    
    function cb_light_dspl(direction) 
        sound_play(snd_dial)
        if direction == 1 then msfs_variable_write(controlside, "Number", var_cap(local_light_dspl+2,0,26) )
        else msfs_variable_write(controlside, "Number", var_cap(local_light_dspl-2,0,26) )
        end 
    end
    dial_light_dspl = dial_add(nil, 20, 70, 57, 57, cb_light_dspl)

end  
