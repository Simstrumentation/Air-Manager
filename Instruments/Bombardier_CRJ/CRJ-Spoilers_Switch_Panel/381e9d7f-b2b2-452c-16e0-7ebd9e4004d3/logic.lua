--[[
******************************************************************************************
******************Bombardier CRJ Spoiler Switches Panel******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-17-2022
    - Original Panel Created
- **v1.1** 03-26-2023
    -Updated Graphics

## Left To Do:
  - Graphics

## Notes:
  - N/A
  
******************************************************************************************
--]]


img_add_fullscreen("background.png")
img_bg_night= img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) 
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)                             
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-----------------------------------------------------------------

--Day Graphics

img_sw_SPLR_MODE_up = img_add("lrg_toggle_up.png",  100, 0, 108, 300)
img_sw_SPLR_MODE_mid = img_add("lrg_toggle_mid.png",  100, 0, 108, 300)visible(img_sw_SPLR_MODE_mid, false)
img_sw_SPLR_MODE_dn = img_add("lrg_toggle_down.png",  100, 0, 108, 300) visible(img_sw_SPLR_MODE_dn, false)

img_sw_LHArmed_up = img_add("lrg_toggle_up.png",  18, 195, 108, 300)
img_sw_LHArmed_dn = img_add("lrg_toggle_down.png",  18, 195, 108, 300) visible(img_sw_LHArmed_dn, false)

img_sw_RHArmed_up = img_add("lrg_toggle_up.png",  305, 195, 108, 300)
img_sw_RHArmed_dn = img_add("lrg_toggle_down.png",  305, 195, 108, 300) visible(img_sw_RHArmed_dn, false)

--Night Graphics
img_sw_SPLR_MODE_up_night = img_add("lrg_toggle_up_night.png",  101, 0, 108, 300)
img_sw_SPLR_MODE_mid_night = img_add("lrg_toggle_mid_night.png",  101, 0, 108, 300)visible(img_sw_SPLR_MODE_mid_night, false)
img_sw_SPLR_MODE_dn_night = img_add("lrg_toggle_down_night.png",  101, 0, 108, 300) visible(img_sw_SPLR_MODE_dn_night, false)

img_sw_LHArmed_up_night = img_add("lrg_toggle_up_night.png",  18, 195, 108, 300)
img_sw_LHArmed_dn_night = img_add("lrg_toggle_down_night.png",  18, 195, 108, 300) visible(img_sw_LHArmed_dn_night, false)

img_sw_RHArmed_up_night = img_add("lrg_toggle_up_night.png", 305, 195, 108, 300)
img_sw_RHArmed_dn_night = img_add("lrg_toggle_down_night.png",  305, 195, 108, 300) visible(img_sw_RHArmed_dn_night, false)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_sw_SPLR_MODE_up_night, value, "LOG", 0.04)        
    opacity(img_sw_SPLR_MODE_mid_night, value, "LOG", 0.04)                      
    opacity(img_sw_SPLR_MODE_dn_night, value, "LOG", 0.04)        
    opacity(img_sw_LHArmed_up_night, value, "LOG", 0.04)                            
    opacity(img_sw_LHArmed_dn_night, value, "LOG", 0.04)        
    opacity(img_sw_RHArmed_up_night, value, "LOG", 0.04)                    
    opacity(img_sw_RHArmed_dn_night, value, "LOG", 0.04)         
      
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------

--GND LIFT DUMPING
msfs_variable_subscribe("L:ASCRJ_TQ_SPLR_MODE", "Number", 
        function (state)
           switch_set_position(sw_gnd_lft, state)
            visible(img_sw_SPLR_MODE_up, state ==2)
            visible(img_sw_SPLR_MODE_up_night, state ==2)
            visible(img_sw_SPLR_MODE_mid, state ==1)
            visible(img_sw_SPLR_MODE_mid_night, state ==1)  
            visible(img_sw_SPLR_MODE_dn, state ==0)
            visible(img_sw_SPLR_MODE_dn_night, state ==0)     
        end)            

function cb_gnd_lft(position,direction)
  msfs_variable_write("L:ASCRJ_TQ_SPLR_MODE","Number",5)  --this is used to trick AM into getting position.
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_TQ_SPLR_MODE","Number",1) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_TQ_SPLR_MODE","Number",0) 
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_TQ_SPLR_MODE","Number",2)        
    elseif (position == 2 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_TQ_SPLR_MODE","Number",1)        
    end 
end
sw_gnd_lft = switch_add(nil,nil,nil, 115,55,80,180, 'VERTICAL',  cb_gnd_lft)   

--Thrust Reverser Left Hand img_sw_LHArmed_up
function cb_tr_lh(position)
   if position == 1 then
        msfs_variable_write("L:ASCRJ_TQ_REV1_MODE","number",1) 
    else
        msfs_variable_write("L:ASCRJ_TQ_REV1_MODE","number",0) 
    end
end
sw_tr_lh = switch_add(nil,nil, 35, 250, 80, 180, cb_tr_lh)   


msfs_variable_subscribe("L:ASCRJ_TQ_REV1_MODE","Number",  
         function (state)
            visible(img_sw_LHArmed_up, state ==1)
            visible(img_sw_LHArmed_up_night, state ==1)
            visible(img_sw_LHArmed_dn, state ==0)
            visible(img_sw_LHArmed_dn_night, state ==0)     
            if state ==0  then switch_set_position(sw_tr_lh, 1)
            else switch_set_position(sw_tr_lh, 0)
            end
        end) 
  
--Thrust Reverser Right Hand
function cb_tr_rh(position)
   if position == 1 then
        msfs_variable_write("L:ASCRJ_TQ_REV2_MODE","number",1) 
    else
        msfs_variable_write("L:ASCRJ_TQ_REV2_MODE","number",0) 
    end
end
sw_tr_rh = switch_add(nil,nil, 325, 250, 80, 180, cb_tr_rh)   


msfs_variable_subscribe("L:ASCRJ_TQ_REV2_MODE","Number",  
         function (state)
            visible(img_sw_RHArmed_up, state ==1)
            visible(img_sw_RHArmed_up_night, state ==1)
            visible(img_sw_RHArmed_dn, state ==0)
            visible(img_sw_RHArmed_dn_night, state ==0)              
            if state ==0  then switch_set_position(sw_tr_rh, 1)
            else switch_set_position(sw_tr_rh, 0)
            end
        end) 
  