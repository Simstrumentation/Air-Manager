--[[
******************************************************************************************
******************TBM 930 - Overhead-Overhead-IntLights ****************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  01-21-2022  SIMSTRUMENTATION
    - Original Panel Created


## Left To Do:
    - Dimmer/Cabin/Access Switches don't work after SU5. Variables not read/writeable.
    	
## Notes:
    - The knobster is not aware of state and can allow you to turn past a position. Thus it's possible to turn the panel lights off if you quickly turn the knob clockwise. Unknown how to avoid this.
    - If using mixMugz the Panel Dimmer Knob may have to be turned first in the cockpit before it's recognized by AirManager.
--]]

img_add_fullscreen("background.png")
img_panel_dimmer = img_add("panel_knob.png", 100, 150, 110, 110)

--Pannel Dimmer Knob
sw_panel_dimmer = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,  95,145,120,120, "CIRCULAIR",
        function (pos,dir)
            if (pos == 0 and dir == 1)  then  --At OFF going to ON
                fs2020_event("K:PANEL_LIGHTS_SET", 1)
                fs2020_event("K:PEDESTRAL_LIGHTS_SET", 1)               
            elseif (pos == 1 and dir == -1)  then  --At ON going to OFF
                fs2020_event("K:PANEL_LIGHTS_SET", 0)
                fs2020_event("K:PEDESTRAL_LIGHTS_SET", 0)
            elseif (pos >= 1 and pos <= 24 and dir == 1)  then      --Decrease Pot
                fs2020_event("LIGHT_POTENTIOMETER_DEC", 4)                                        
            elseif (pos >= 1 and  dir == -1)  then      --Increase Pot
                fs2020_event("LIGHT_POTENTIOMETER_INC", 4)  
           end
    end)
                            
fs2020_variable_subscribe("A:LIGHT PANEL", "BOOL",
                                              "A:LIGHT POTENTIOMETER:4", "PERCENT",
        function (lights_on,lights_pot)
            if (lights_on == false and lights_pot ==100) then       --if off              
                switch_set_position(sw_panel_dimmer, 0)
                rotate(img_panel_dimmer, -110,"LOG", 0.1)
            elseif (lights_on == true and lights_pot == 100)   then     --if on bright
                switch_set_position(sw_panel_dimmer, 1)
                rotate(img_panel_dimmer, -95,"LOG", 0.1)
            elseif (lights_on == true and lights_pot < 100)   then      
                switch_set_position(sw_panel_dimmer, (26-var_round(lights_pot/4,0)))                     
                rotate(img_panel_dimmer, 5- lights_pot,"LOG", 0.1)                     
            end
        end)
                            
--Dimmer Switch                                                                                  
sw_dimmer_lights = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 310, 128, 80, 145,
                            function (pos)
                         --       if pos == 0 then fs2020_variable_write("O:LIGHTING_Dimmer_Light_Position","number",1)
                        --        elseif pos == 1 then fs2020_variable_write("O:LIGHTING_Dimmer_Light_Position","number",0)
                         --       end
                            end)
                            
fs2020_variable_subscribe("O:LIGHTING_Dimmer_Light_Position", "number",
                            function (pos)
                                 switch_set_position(sw_dimmer_lights, pos)
                            end)
                            
--Cabin Switch                           
sw_cabin_lights = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 410, 128, 80, 145,
                            function (pos)
                            --    if pos == 0 then fs2020_variable_write("O:LIGHTING_Cabin_Light_Position","number",1)
                             --   elseif pos == 1 then fs2020_variable_write(":LIGHTING_Cabin_Light_Position","number",0)
                            --    end
                            end)
                            
fs2020_variable_subscribe("A:LIGHT CABIN ON", "Bool",
                            function (pos)
                                 switch_set_position(sw_cabin_lights, pos)
                            end)
                            
--Access Switch          
sw_access_lights = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 510, 128, 80, 145,
                            function (pos)
                            print(pos)
                            --    if pos == 0 then fs2020_event("PEDESTRAL_LIGHTS_SET",1)
                          --      elseif pos == 1 then fs2020_event("PEDESTRAL_LIGHTS_SET",0)
                          --      end
                            end)
                            
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:8", "number",
                            function (pos)
                                 switch_set_position(sw_access_lights, pos)
                            end)
                            

