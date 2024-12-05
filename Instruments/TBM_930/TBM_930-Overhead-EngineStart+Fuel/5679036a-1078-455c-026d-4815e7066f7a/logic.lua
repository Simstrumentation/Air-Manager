--[[
******************************************************************************************
******************TBM 930 - Overhead-EngineStart+Fuel ******************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  01-21-2022 SIMSTRUMENTATION
    - Original Panel Created


## Left To Do:
    - 
    	
## Notes:
    - As of 1-20-22 Starter switch in VC (SIM Virtural Cockpit) moves to ON for 3 seconds then moves to OFF and doesn't allow you to turn starter OFF. This panel is working correctly and does allow starter to be turned off.
    - Ignition switch in VC does not move.
    - Fuel SEL is INOP due to commads not available.   
--]]

-- Load sound
snd_click = sound_add("click.wav")

img_add_fullscreen("background.png")

-----STARTER-----
msfs_variable_subscribe("A:GENERAL ENG STARTER:1", "BOOL",
    function (pos)
            if pos == true  then                                 
                visible(img_starter_on, true)
                visible(img_starter_off, false)
                visible(img_starter_abort, false)
            else        
                visible(img_starter_on, false)
                visible(img_starter_off, true)
                visible(img_starter_abort, false)
            end
end)

--Starter Touch Buttons
function cb_starter_on()
        msfs_variable_write("A:GENERAL ENG STARTER:1","bool", true)           
        msfs_event("K:SET_STARTER1_HELD",1)       
end
button_add(nil,nil, 100, 80, 130, 90, cb_starter_on)

function cb_starter_off()
        msfs_variable_write("A:GENERAL ENG STARTER:1","bool", false)      
end
button_add(nil,nil, 100, 160, 130, 90, cb_starter_off)

function cb_starter_abort()
        --INOP       
end
button_add(nil,nil, 100, 260, 130, 90, cb_starter_abort)

--Starter Graphics
img_starter_on = img_add("blk_switch_up.png", 100, 85, 120, 239)
img_starter_off  = img_add("blk_switch_md.png", 100, 85, 120, 239)
img_starter_abort = img_add("blk_switch_dn.png", 100, 85, 120, 239)
visible(img_starter_on, false)
visible(img_starter_abort, false)

-------------------------------------------------------------------------------------
-----IGNITION-----
msfs_variable_subscribe("A:TURB ENG IGNITION SWITCH EX1:1", "ENUM",
    function (pos)      
             if pos == 0 then   
                visible(img_ignition_auto, false)
                visible(img_ignition_on, false)
                visible(img_ignition_off, true)
             elseif pos == 2 then
                visible(img_ignition_auto, false)
                visible(img_ignition_on, true)
                visible(img_ignition_off, false)
             elseif pos == 1 then           
                visible(img_ignition_auto, true)
                visible(img_ignition_on, false)
                visible(img_ignition_off, false)
             end
end)

--Ignition Touch Buttons
function cb_ignition_auto()
       msfs_event("K:TURBINE_IGNITION_SWITCH_SET1", 1)      
end
button_add(nil,nil, 320, 80, 130, 90, cb_ignition_auto)

function cb_ignition_on()
       msfs_event("K:TURBINE_IGNITION_SWITCH_SET1", 2)    
end
button_add(nil,nil, 320, 160, 130, 90, cb_ignition_on)

function cb_ignition_off()
       msfs_event("K:TURBINE_IGNITION_SWITCH_SET1", 0)     
end
button_add(nil,nil, 320, 260, 130, 90, cb_ignition_off)

--Ignition Graphics
img_ignition_auto = img_add("blk_switch_up.png", 320, 85, 120, 239)
img_ignition_on  = img_add("blk_switch_md.png", 320, 85, 120, 239)
img_ignition_off = img_add("blk_switch_dn.png", 320, 85, 120, 239)
visible(img_ignition_auto, false)
visible(img_ignition_on, false)


-------------------------------------------------------------------------------------
-----AUX BP-----
msfs_variable_subscribe("A:GENERAL ENG FUEL PUMP SWITCH EX1:1", "ENUM",
    function (pos)
         if pos == 2  then  
            visible(img_auxbp_auto, true)
            visible(img_auxbp_on, false)
            visible(img_auxbp_off, false)   
        elseif pos == 1  then
            visible(img_auxbp_auto, false)
            visible(img_auxbp_on, true)
            visible(img_auxbp_off, false)                                                                                  
        elseif pos == 0 then    
            visible(img_auxbp_auto, false)
            visible(img_auxbp_on, false)
            visible(img_auxbp_off, true)         
        end
end)


--AUX BP Touch Buttons
function cb_auxbp_auto()
        msfs_event("K:ELECT_FUEL_PUMP1_SET", 2)       
end
button_add(nil,nil, 560, 10, 130, 70, cb_auxbp_auto)

function cb_auxbp_on()
        msfs_event("K:ELECT_FUEL_PUMP1_SET", 1)  
end
button_add(nil,nil, 560, 80, 130, 70, cb_auxbp_on)

function cb_auxbp_off()
        msfs_event("K:ELECT_FUEL_PUMP1_SET", 0)  
end
button_add(nil,nil, 560, 150, 130, 70, cb_auxbp_off)

--AUX BP Graphics
img_auxbp_auto = img_add("blk_switch_up.png", 560, 0, 120, 239)
img_auxbp_on  = img_add("blk_switch_md.png", 560, 0, 120, 239)
img_auxbp_off = img_add("blk_switch_dn.png", 560, 0, 120, 239)
visible(img_auxbp_auto, false)
visible(img_auxbp_on, false)


-------------------------------------------------------------------------------------
-----FUEL SHIFT PUSH-----
function cb_fuelshift(pos,dir)
     if pos == 2 then msfs_event("K:FUEL_SELECTOR_RIGHT")   
     elseif pos == 3 then msfs_event("K:FUEL_SELECTOR_LEFT")
     end 
end
sw_fuelshift = switch_add(nil,nil,nil,nil, 590, 290, 60, 60, "PRESS", cb_fuelshift)

msfs_variable_subscribe("A:FUEL TANK SELECTOR:1", "ENUM",
    function (pos)          
             switch_set_position(sw_fuelshift, pos)   
end)

-----FUEL SELECTOR-----
msfs_variable_subscribe("FUEL CROSS FEED", "enum",
    function (pos)
           --Disabled until variables are writable.
          --   switch_set_position(sw_fuelshift, pos)   
end)

function cb_fuelsel(pos)
   --Disabled until variables are writable.
    -- if pos == 0 then switch_set_position(sw_fuelsel, 1)    
    -- elseif pos == 1 then switch_set_position(sw_fuelsel, 0)  
     --end 
end
sw_fuelsel = switch_add("tbm_flip_switch_off.png", "tbm_flip_switch_on.png", 810, 140, 70, 129,"PRESS", cb_fuelsel)