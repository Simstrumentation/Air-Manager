--[[
******************************************************************************************
***************Bombardier CRJ Ground Proximity Warning Panel***********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 02-19-2022
    - Original Panel Created
- **v1.1** 12-31-2022
    - Panel split apart
    - Graphics Redone
    - Ambient Light Added
    - Backlighting Added

## Left To Do:
  - N/A
	
## Notes:
  - N/A
   
******************************************************************************************
--]]


img_add_fullscreen("background.png")
img_bg_night= img_add_fullscreen("background_night.png")
snd_click=sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")


--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)                          
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)  
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-----------------------------------------------------------------

--Day Graphics
img_terrain= img_add("off.png", 75, 74, 59, 49)
img_flap= img_add("ovrd.png", 186, 74, 59, 49)
img_call= img_add("call.png", 373, 74, 59, 49)
img_terrain_Cover_Dn = img_add("cover_down.png", 52, -10,102,147) 
img_terrain_Cover_Up = img_add("cover_up.png", 52, -10,102,147) visible(img_terrain_Cover_Up, false)
img_flap_Cover_Dn = img_add("cover_down.png", 164, -10,102,147) 
img_flap_Cover_Up = img_add("cover_up.png", 164, -10,102,147) visible(img_flap_Cover_Up, false)


--Night Graphics
img_terrain_Cover_Dn_night = img_add("cover_down_night.png", 52, -10,102,147) 
img_terrain_Cover_Up_night = img_add("cover_up_night.png", 52, -10,102,147) visible(img_terrain_Cover_Up_night, false)
img_flap_Cover_Dn_night = img_add("cover_down_night.png", 164, -10,102,147) 
img_flap_Cover_Up_night = img_add("cover_up_night.png", 164, -10,102,147) visible(img_flap_Cover_Up_night, false)



-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_terrain_Cover_Dn_night, value, "LOG", 0.04)    
    opacity(img_terrain_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_terrain_Cover_Up_night, value, "LOG", 0.04)  
    opacity(img_terrain_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_flap_Cover_Dn_night, value, "LOG", 0.04)    
    opacity(img_flap_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_flap_Cover_Up_night, value, "LOG", 0.04)  
    opacity(img_flap_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode       

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------

--TERRAIN SWITCH
fs2020_variable_subscribe("L:ASCRJ_GPWS_TERR_OFF", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", 
    function (on,pwr) if (pwr==true) then visible(img_terrain, on ==1)else visible(img_terrain, false)end end) 

fs2020_variable_subscribe("L:ASCRJ_GPWS_TERR", "Number",
    function (state)  switch_set_position(sw_terrain, state) end) 

sw_terrain = switch_add(nil, nil, 75, 75, 55, 55, 
        function (position)
              sound_play(snd_click)
              if position == 0 then fs2020_variable_write("L:ASCRJ_GPWS_TERR", "Number", 1)
              else  fs2020_variable_write("L:ASCRJ_GPWS_TERR", "Number", 0) 
              end
end)
visible(sw_terrain, false)

function  cb_terrain_Cover()
    timer_start(3000, timer_terrain_Cover)    --call timer to close cover
    visible(sw_terrain, true)                        --enable button
    visible(img_terrain_Cover_Up, true) visible(img_terrain_Cover_Up_night, true)        --show up cover
    visible(img_terrain_Cover_Dn, false) visible(img_terrain_Cover_Dn_night, false)      --hide down cover
    sound_play(snd_cover_open)
    visible(sw_terrain_Cover, false)                --disable cover switch
end
sw_terrain_Cover = switch_add(nil, nil, 68, 60, 72, 74, cb_terrain_Cover)

function timer_terrain_Cover()
    visible(img_terrain_Cover_Dn, true) visible(img_terrain_Cover_Dn_night, true)        --show dn cover
    visible(img_terrain_Cover_Up, false) visible(img_terrain_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)
    visible(sw_terrain, false)                        --disable button
    visible(sw_terrain_Cover, true)                 --enable cover switch
end


--FLAP SWITCH
fs2020_variable_subscribe("L:ASCRJ_GPWS_FLAP_OVRD", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", 
    function (on,pwr) if (pwr==true) then visible(img_flap, on ==1)else visible(img_flap, false)end end) 

fs2020_variable_subscribe("L:ASCRJ_GPWS_FLAP", "Number",
    function (state)  switch_set_position(sw_flap, state) end) 

sw_flap = switch_add(nil, nil, 188, 75, 55, 55, 
        function (position)
              sound_play(snd_click)
              if position == 0 then fs2020_variable_write("L:ASCRJ_GPWS_FLAP", "Number", 1) 
              else  fs2020_variable_write("L:ASCRJ_GPWS_FLAP", "Number", 0)
              end
        end)
visible(sw_flap, false)

function  cb_flap_Cover()
    timer_start(3000, timer_flap_Cover)    --call timer to close cover
    visible(sw_flap, true)                        --enable button
    visible(img_flap_Cover_Up, true) visible(img_flap_Cover_Up_night, true)        --show up cover
    visible(img_flap_Cover_Dn, false) visible(img_flap_Cover_Dn_night, false)      --hide down cover
    sound_play(snd_cover_open)
    visible(sw_flap_Cover, false)                --disable cover switch
end
sw_flap_Cover = switch_add(nil, nil, 180, 60, 72, 74, cb_flap_Cover)

function timer_flap_Cover()
    visible(img_flap_Cover_Dn, true) visible(img_flap_Cover_Dn_night, true)        --show dn cover
    visible(img_flap_Cover_Up, false) visible(img_flap_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)
    visible(sw_flap, false)                        --disable button
    visible(sw_flap_Cover, true)                 --enable cover switch
end





--MECH CALL SWITCH
fs2020_variable_subscribe("L:ASCRJ_GPWS_MECH_CALL", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", 
    function (on,pwr)
            switch_set_position(sw_Mech_Call, on)
            if (pwr==true) then visible(img_call, on ==1)else visible(img_call, false)end
end)

sw_Mech_Call = switch_add(nil,nil, 378, 74, 49, 50, 
        function (position)
              if position == 1 then fs2020_variable_write("L:ASCRJ_GPWS_MECH", "Number", 1)  timer_start(100, function() fs2020_variable_write("L:ASCRJ_GPWS_MECH","Number",0)end) 
              else  fs2020_variable_write("L:ASCRJ_GPWS_MECH", "Number", 1)   timer_start(100, function() fs2020_variable_write("L:ASCRJ_GPWS_MECH","Number",0)end) 
              end
        end)