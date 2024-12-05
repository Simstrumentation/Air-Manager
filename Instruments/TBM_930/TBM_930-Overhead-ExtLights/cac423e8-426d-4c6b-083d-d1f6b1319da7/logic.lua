--[[
******************************************************************************************
******************TBM 930 - Overhead-Overhead-ExtLights ****************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  01-21-2022 Sean Reynolds/"sreynolds14" and SIMSTRUMENTATION
    - Original Panel Created
    - Added variables in for TBM MOD from mixMugz for LANDING/TAXI switch

## Left To Do:
    - PULSE is INOP with mixMugz MOD
    	
## Notes:
    -Special Thanks too Sean Reynolds/"sreynolds14" for starting this off.
    -TBM MOD can be found here: https://github.com/mixMugz/msfs_tbm930_project

--]]

img_add_fullscreen("background.png")
 function ss_ldg_taxi(ldg)
                    if ldg ==0 then    --testing if landing (bool) is true
                                visible(img_ldg_taxi_ldg, true)
                                visible(img_ldg_taxi_taxi, false)
                                visible(img_ldg_taxi_off, false)
                    elseif ldg ==1 then     --testing if taxi (bool) is true
                                visible(img_ldg_taxi_ldg, false)
                                visible(img_ldg_taxi_taxi, true)
                                visible(img_ldg_taxi_off, false)                                
                    else
                                visible(img_ldg_taxi_ldg,false)
                                visible(img_ldg_taxi_taxi, false)
                                visible(img_ldg_taxi_off, true)
                    end
end
msfs_variable_subscribe("L:XMLVAR_LANDING_TAXI_OFF_Switch_Position", "int",ss_ldg_taxi)      --TBM MOD mixMugz            
msfs_variable_subscribe("L:LIGHTING_LANDING_1", "INT",ss_ldg_taxi)                                            --STOCK


--Landing/Tax Touch Buttons
function cb_ldg_taxi_ldg()
                                    msfs_variable_write("L:XMLVAR_LANDING_TAXI_OFF_Switch_Position","Int", 0)          --TBM MOD mixMugz                                  
                                    msfs_variable_write("L:LIGHTING_LANDING_1","Int", 0)                                                 --STOCK
                                    msfs_variable_write("A:LIGHT TAXI","bool", false)     
                                    msfs_event("LANDING_LIGHTS_TOGGLE")
                                    msfs_event("K:LIGHT_POTENTIOMETER_3_SET", 0)    
                                    msfs_event("K:LIGHT_POTENTIOMETER_2_SET", 100)          
                                    msfs_event("K:LIGHT_POTENTIOMETER_10_SET", 100)      
end
button_add(nil,nil, 80, 80, 130, 90, cb_ldg_taxi_ldg)

function cb_ldg_taxi_taxi()
                                    msfs_variable_write("L:XMLVAR_LANDING_TAXI_OFF_Switch_Position","Int", 1)        --TBM MOD mixMugz            
                                    msfs_variable_write("L:LIGHTING_LANDING_1","Int", 1)                                             --STOCK
                                    msfs_variable_write("A:LIGHT LANDING","bool", false)          
                                    msfs_variable_write("A:LIGHT TAXI","bool", true)                 
                                    msfs_event("K:LIGHT_POTENTIOMETER_3_SET", 100)        
                                    msfs_event("K:LIGHT_POTENTIOMETER_2_SET", 100)         
end
button_add(nil,nil, 80, 170, 130, 90, cb_ldg_taxi_taxi)

function cb_ldg_taxi_off()
                                    msfs_variable_write("L:XMLVAR_LANDING_TAXI_OFF_Switch_Position","Int", 2)        --TBM MOD mixMugz                                   
                                    msfs_variable_write("L:LIGHTING_LANDING_1","Int", 2)                                               --STOCK
                                    msfs_variable_write("A:LIGHT LANDING","bool", false)           
                                    msfs_variable_write("A:LIGHT TAXI","bool", false)   
                                    msfs_event("K:LIGHT_POTENTIOMETER_3_SET", 100)  
end
button_add(nil,nil, 80, 260, 130, 90, cb_ldg_taxi_off)

--Landing/Tax Graphics
img_ldg_taxi_ldg = img_add("blk_switch_up.png", 80,85,120,239)
img_ldg_taxi_taxi = img_add("blk_switch_md.png", 80,85,120,239)
img_ldg_taxi_off = img_add("blk_switch_dn.png", 80,85,120,239)
visible(img_ldg_taxi_ldg, false)
visible(img_ldg_taxi_taxi, false)




-------------------------------------------------------------------------------------                            
--Pulse Lights                                                                                  
pulse_switch = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 291, 128, 80, 145,
                            function (pos)
                                if pos == 0 then
                                         msfs_event("K:LOGO_LIGHTS_SET",1)
                                         msfs_event("K:LIGHT_POTENTIOMETER_3_SET", 100)
                                else 
                                         msfs_event("K:LOGO_LIGHTS_SET",0)  
                                         msfs_event("K:LIGHT_POTENTIOMETER_3_SET", 0)       
                                end
                            end)
                            
msfs_variable_subscribe("LIGHT LOGO","bool",
                            function (pos)
                                switch_set_position(pulse_switch, pos)
                            end)
                            
--NAV Lights                            
position_lights_switch = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 389, 128, 80, 145,
                            function (pos)
                                if pos == 0 then msfs_event("TOGGLE_NAV_LIGHTS")
                                else msfs_event("TOGGLE_NAV_LIGHTS")
                                end
                            end)
                            
msfs_variable_subscribe("LIGHT NAV","bool",
                            function (pos)
                                 switch_set_position(position_lights_switch, pos)
                            end)
                            
--Strobe Lights                           
strobe_lights_switch = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 482, 128, 80, 145,
                            function (pos)
                                if pos == false then msfs_event("STROBES_TOGGLE")
                                else msfs_event("STROBES_TOGGLE")
                                end
                            end)
                            
msfs_variable_subscribe("LIGHT STROBE","BOOL",
                            function (pos)
                                 switch_set_position(strobe_lights_switch, pos)
                            end)
                            

