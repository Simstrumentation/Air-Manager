--[[
******************************************************************************************
*****************Bombardier CRJ Pedestal-Lighting Control Panel***********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 06-20-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

snd_dial = sound_add("dial.wav")
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2)
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)
        opacity(img_dial_dspl_backlighting, 0, "LOG", 0.04)        
        opacity(img_dial_integ_backlighting, 0, "LOG", 0.04)        
        opacity(img_dial_flood_backlighting, 0, "LOG", 0.04)        
        opacity(img_dial_cb_pnl_backlighting, 0, "LOG", 0.04)                                
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_dial_dspl_backlighting, (value), "LOG", 0.04)        
        opacity(img_dial_integ_backlighting, (value), "LOG", 0.04)         
        opacity(img_dial_flood_backlighting, (value), "LOG", 0.04)         
        opacity(img_dial_cb_pnl_backlighting, (value), "LOG", 0.04)                                  
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
-----------------------------------------------------------------

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_dial_dspl_night, value, "LOG", 0.04)    
    opacity(img_dial_integ_night, value, "LOG", 0.04)
    opacity(img_dial_flood_night, value, "LOG", 0.04)
    opacity(img_dial_cb_pnl_night, value, "LOG", 0.04)        
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-----------------------------------------
--Day Graphics
img_dial_dspl = img_add("knob_classic.png", 14, 35, 60, 60)
img_dial_integ = img_add("knob_classic.png", 104, 35, 60, 60)
img_dial_flood = img_add("knob_classic.png", 193, 35, 60, 60)
img_dial_cb_pnl = img_add("knob_classic.png", 283, 35, 60, 60)

--Night Graphics
img_dial_dspl_night = img_add("knob_classic_night.png", 14, 35, 60, 60)
img_dial_integ_night = img_add("knob_classic_night.png", 104, 35, 60, 60)
img_dial_flood_night = img_add("knob_classic_night.png", 193, 35, 60, 60)
img_dial_cb_pnl_night = img_add("knob_classic_night.png", 283, 35, 60, 60)

--Backlighting
img_dial_dspl_backlighting = img_add("knob_classic_backlighting.png", 14, 35, 60, 60)
img_dial_integ_backlighting = img_add("knob_classic_backlighting.png", 104, 35, 60, 60)
img_dial_flood_backlighting = img_add("knob_classic_backlighting.png", 193, 35, 60, 60)
img_dial_cb_pnl_backlighting = img_add("knob_classic_backlighting.png", 283, 35, 60, 60)

--DSPL
local local_dspl = 0
msfs_variable_subscribe("L:ASCRJ_INTL_DSPL_BRT", "Number",  
        function (state)
            local_dspl = state
            rotate(img_dial_dspl, (local_dspl *10)-130, "LOG", 0.04) rotate(img_dial_dspl_night, (local_dspl *10)-130, "LOG", 0.04) rotate(img_dial_dspl_backlighting, (local_dspl *10)-130, "LOG", 0.04) 
            sound_play(snd_dial) 
        end) 

function cb_dspl(direction) 
    if direction == 1 then msfs_variable_write("L:ASCRJ_INTL_DSPL_BRT", "Number", var_cap(local_dspl +1,0,26) ) 
    else msfs_variable_write("L:ASCRJ_INTL_DSPL_BRT", "Number", var_cap(local_dspl -1,0,26) )
    end
end
dial_dspl= dial_add(nil, 14, 35, 60, 60, cb_dspl)

--INTEG
local local_integ = 0
msfs_variable_subscribe("L:ASCRJ_INTL_INTEG_BRT", "Number",  
        function (state)
            local_integ = state
            rotate(img_dial_integ, (local_integ *10)-130, "LOG", 0.04) rotate(img_dial_integ_night, (local_integ *10)-130, "LOG", 0.04) rotate(img_dial_integ_backlighting, (local_integ *10)-130, "LOG", 0.04) 
            sound_play(snd_dial) 
            end) 

function cb_integ(direction) 
    if direction == 1 then msfs_variable_write("L:ASCRJ_INTL_INTEG_BRT", "Number", var_cap(local_integ +1,0,26) ) 
    else msfs_variable_write("L:ASCRJ_INTL_INTEG_BRT", "Number", var_cap(local_integ -1,0,26) )
    end 
end
dial_integ= dial_add(nil, 104, 35, 60, 60, cb_integ)

--FLOOD
local local_flood = 0
msfs_variable_subscribe("L:ASCRJ_INTL_FLOOD_BRT", "Number",  
        function (state)
            local_flood = state
            rotate(img_dial_flood, (local_flood *10)-130, "LOG", 0.04) rotate(img_dial_flood_night, (local_flood *10)-130, "LOG", 0.04) rotate(img_dial_flood_backlighting, (local_flood *10)-130, "LOG", 0.04) 
            sound_play(snd_dial) 
           end) 

function cb_flood(direction) 
    if direction == 1 then msfs_variable_write("L:ASCRJ_INTL_FLOOD_BRT", "Number", var_cap(local_flood +1,0,26) ) 
    else msfs_variable_write("L:ASCRJ_INTL_FLOOD_BRT", "Number", var_cap(local_flood -1,0,26) )
    end 
end
dial_flood= dial_add(nil, 193, 35, 60, 60, cb_flood)

--CB_PNL
local local_cb_pnl = 0
msfs_variable_subscribe("L:ASCRJ_INTL_CB_PNL_BRT", "Number",  
        function (state)
            local_cb_pnl = state
            rotate(img_dial_cb_pnl, (local_cb_pnl *10)-130, "LOG", 0.04) rotate(img_dial_cb_pnl_night, (local_cb_pnl *10)-130, "LOG", 0.04) rotate(img_dial_cb_pnl_backlighting, (local_cb_pnl *10)-130, "LOG", 0.04) 
            sound_play(snd_dial) 
           end) 

function cb_cb_pnl(direction) 
    if direction == 1 then msfs_variable_write("L:ASCRJ_INTL_CB_PNL_BRT", "Number", var_cap(local_cb_pnl +1,0,26) ) 
    else msfs_variable_write("L:ASCRJ_INTL_CB_PNL_BRT", "Number", var_cap(local_cb_pnl -1,0,26) )
    end 
end
dial_cb_pnl= dial_add(nil, 283, 35, 60, 60, cb_cb_pnl)