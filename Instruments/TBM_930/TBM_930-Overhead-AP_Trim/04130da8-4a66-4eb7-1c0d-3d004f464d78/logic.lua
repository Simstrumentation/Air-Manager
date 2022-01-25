--[[
******************************************************************************************
*********************TBM 930 - Overhead-AP Trim *************************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  01-23-2022  SIMSTRUMENTATION
    - Original Panel Created


## Left To Do:
    - 
    	
## Notes:
    - 

--]]

img_add_fullscreen("background.png")

fs2020_variable_subscribe("A:AUTOPILOT DISENGAGED", "bool",
                                              "A:RUDDER TRIM DISABLED", "bool",
                                              --"A:AILERON TRIM DISABLED", "bool",
    function (ap,rudder)      
             if ap == true and rudder == true then   
                visible(img_aptrim_on, false)
                visible(img_aptrim_apoff, false)
                visible(img_aptrim_off, true)
             elseif ap == false then
                visible(img_aptrim_on, true)
                visible(img_aptrim_apoff, false)
                visible(img_aptrim_off, false)
             elseif ap == true and rudder == false then           
                visible(img_aptrim_on, false)
                visible(img_aptrim_apoff, true)
                visible(img_aptrim_off, false)
             end
end)

--Ignition Touch Buttons
function cb_aptrim_on()
       fs2020_event("K:RUDDER_TRIM_DISABLED_SET",0)
        fs2020_event("K:AILERON_TRIM_DISABLED_SET",0)
        fs2020_event("AUTOPILOT_DISENGAGE_SET",0)        
end
button_add(nil,nil, 40, 60, 200, 70, cb_aptrim_on)

function cb_aptrim_apoff()
        fs2020_event("K:RUDDER_TRIM_DISABLED_SET",0)
        fs2020_event("K:AILERON_TRIM_DISABLED_SET",0)
        fs2020_event("AUTOPILOT_DISENGAGE_SET",1)        
end
button_add(nil,nil, 40, 130, 200, 70, cb_aptrim_apoff)

function cb_aptrim_off()
        fs2020_event("K:RUDDER_TRIM_DISABLED_SET",1)
        fs2020_event("K:AILERON_TRIM_DISABLED_SET",1)  
        fs2020_event("AUTOPILOT_DISENGAGE_SET",1)
end
button_add(nil,nil, 40, 200, 200, 70, cb_aptrim_off)


--Ignition Graphics
img_aptrim_on = img_add("red_switch_up.png", 130, 50, 126, 244)
img_aptrim_apoff  = img_add("red_switch_md.png", 130, 50, 126, 244)
img_aptrim_off = img_add("red_switch_dn.png", 130, 50, 126, 244)
visible(img_aptrim_on, false)
visible(img_aptrim_apoff, false)
