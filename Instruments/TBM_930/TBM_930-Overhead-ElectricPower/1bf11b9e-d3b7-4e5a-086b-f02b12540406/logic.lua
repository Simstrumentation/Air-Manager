--[[
******************************************************************************************
******************TBM 930 - Overhead-Electric Power******************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  01-21-2022 SIMSTRUMENTATION
    - Original Panel Created
- **v1.1**  01-24-2022 
    - Commented out all subscribes that are not working as it's causing a CTD when MIXMUGZ MOD is installed.

## Left To Do:
    - GPU Is INOP due to variables not read/writable.
    - STBY Generator Is INOP due to variables not read/writable.
    - Main/Stby Gen RESET is INOP due to variables not read/writable.
    	
## Notes:
    - YOU MUST CLICK EITHER END OF THE CRASHBAR TO RAISE OR LOWER IT.
--]]

img_add_fullscreen("background.png")

local crashbar_position = 0

src_off = img_add("slvr_switch_dn.png", 350, 109, 79, 163)
src_batt = img_add("slvr_switch_md.png", 350, 110, 79, 163)
visible(src_batt, false)
src_gpu = img_add("slvr_switch_up.png", 350, 110, 79, 163)
visible(src_gpu, false)

--crash bar

function toggle_cb_callback()
    if crashbar_position == 1 then    
        --fs2020_variable_write("L:XMLVAR_CrashLeverPos", "Number", 1)
        crashbar_position = 0
       opacity(img_crashdn, 0, "LOG", 0.1)        --SET UNTIL VARIABLES ARE AVAILABLE
       opacity(img_crashup, 1, "LOG", 0.1)        --SET UNTIL VARIABLES ARE AVAILABLE
    else
        --fs2020_variable_write("L:XMLVAR_CrashLeverPos", "Number", 0)
        fs2020_event("MASTER_BATTERY_OFF")
       -- fs2020_variable_write("L:XMLVAR_Battery_GPU_On", "Number", 0)            --causing crash 
        fs2020_event("ALTERNATOR_OFF")
        crashbar_position = 1
       opacity(img_crashdn, 1, "LOG", 0.1)        --SET UNTIL VARIABLES ARE AVAILABLE
       opacity(img_crashup, 0, "LOG", 0.1)       --SET UNTIL VARIABLES ARE AVAILABLE    
    end
end

switch_add(nil, nil, 220, 80, 75, 150, toggle_cb_callback)
switch_add(nil, nil, 650, 80, 75, 150, toggle_cb_callback)

crashbar_position = 1 --SET UNTIL VARIABLES ARE AVAILABLE

--[[                                                                     --MIXMUGZ CAUSING CRASH
function new_cb_position(cb)
    if cb == 0 then
      crashbar_position = 0
      opacity(img_crashdn, 0, "LOG", 0.1)
      opacity(img_crashup, 1, "LOG", 0.1)
    else
      crashbar_position =1 
      opacity(img_crashdn, 1, "LOG", 0.1)
      opacity(img_crashup, 0, "LOG", 0.1)
    end
end
fs2020_variable_subscribe("L:XMLVAR_CrashLeverPos", "Number", new_cb_position)
]]

--source switch
--[[
SWICH POSITION
    0 = GPU    
    1 = BATTERY
    2 = OFF
]]--

--function new_src_pos(gpu, battery)        --MIXMUGZ CAUSING CRASH
function new_src_pos(battery)
--    if (gpu == 1) or (battery) then            --MIXMUGZ CAUSING CRASH
    if  (battery) then
        visible(src_off, false)
        crashbar_position = 0
      opacity(img_crashdn, 0, "LOG", 0.1)   --SET UNTIL VARIABLES ARE AVAILABLEL 
      opacity(img_crashup, 1, "LOG", 0.1)    --SET UNTIL VARIABLES ARE AVAILABLE
--[[        if gpu==1 then
            visible(src_gpu, true)
            visible(src_batt, false)
       elseif battery then
            visible(src_gpu, false)
            visible(src_batt, true)
         end
 --]] 
            visible(src_gpu, false)        --ADDED UNTIL MIXMUGZ DON"T CRASH
            visible(src_batt, true)        --ADDED UNTIL MIXMUGZ DON"T CRASH
     else
          visible(src_off, true)
          visible(src_gpu, false)
          visible(src_batt, false)
    end
    
end

--[[   *****CAUSING CRASH WITH MIXMUGZ MOD
fs2020_variable_subscribe("L:XMLVAR_Battery_GPU_On", "Number",
                                                "Electrical Master Battery:1", "Bool",
                                                 new_src_pos)
--]]
fs2020_variable_subscribe("Electrical Master Battery:1", "Bool",
                                                 new_src_pos)



-- source switch touch zones
--battery
function cb_set_battery()
    if (crashbar_position == 0) then
        fs2020_event("MASTER_BATTERY_ON")
        --fs2020_variable_write("L:XMLVAR_Battery_GPU_On", "Number", 0)
    end        
end
button_add(nil, nil, 325,145, 90, 90, cb_set_battery)
--off
function cb_set_off()
    fs2020_event("MASTER_BATTERY_OFF")
    --fs2020_variable_write("L:XMLVAR_Battery_GPU_On", "Number", 0)
end
button_add(nil, nil, 325,235, 90, 90, cb_set_off)


function cb_set_gpu() --NOT OPERATIONAL AS OF SU7
    if (crashbar_position == 0) then
        fs2020_event("MASTER_BATTERY_OFF")
      --  fs2020_variable_write("L:XMLVAR_Battery_GPU_On", "Number", 1)
    end        
end
button_add(nil, nil, 325,85, 90, 90, cb_set_gpu)

--------------------------------------------------------------------------------------
--Generator
gen_off = img_add("slvr_switch_dn.png", 540, 109, 79, 163)
gen_main = img_add("slvr_switch_md.png", 540, 110, 79, 163)
visible(gen_main, false)
gen_stby = img_add("slvr_switch_up.png", 540, 110, 79, 163)
visible(gen_stby, false)

function ss_Generator(alt)
    if alt == false then
        visible(gen_off,  true)
        visible(gen_main, false)
        visible(gen_stby, false)
    elseif  alt == true then
        crashbar_position = 0
        opacity(img_crashdn, 0, "LOG", 0.1)   --SET UNTIL VARIABLES ARE AVAILABLEL 
        opacity(img_crashup, 1, "LOG", 0.1)    --SET UNTIL VARIABLES ARE AVAILABLE
        visible(gen_off, false)
        visible(gen_main, true)
        visible(gen_stby, false)
    end
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1", "bool", ss_Generator)


function cb_set_generator()
    if (crashbar_position == 0) then
        fs2020_event("TOGGLE_MASTER_ALTERNATOR")
    end        
end
button_add(nil, nil, 550, 145, 100, 120, cb_set_generator)


--------------------------------------------------------------------------------------
--Crashbar image at end to be on top of everything.
img_crashdn= img_add("crash_dn.png", 242, 80, 466, 119)
img_crashup = img_add("crash_up.png", 242, 80, 466, 119)
opacity(img_crashdn, 0)
opacity(img_crashup, 1)