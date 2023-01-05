--[[
******************************************************************************************
******************TBM 930 - Overhead-Electric Power******************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: http://simstrumentation.com
   
- **v1.0**  01-21-2022 SIMSTRUMENTATION
    - Original Panel Created
- **v1.1**  01-24-2022 
    - Commented out all subscribes that are not working as it's causing a CTD when MIXMUGZ MOD is installed.
- **v1.2**  01-04-2023 
    - Update for Aircraft and Avionics Update I. Works with the new TBM.

## Notes:
    - YOU MUST CLICK EITHER END OF THE CRASHBAR TO RAISE OR LOWER IT.

KNOWN ISSUES    
    - Under certain conditions, crashbar will not lower. Other switches are all operative despite this. 
--]]

img_add_fullscreen("background.png")

local crashbar_position = 0
local genState = 0
local sourceState = 0

--SOURCE SWITCH
src_off = img_add("slvr_switch_dn.png", 350, 109, 79, 163)
src_batt = img_add("slvr_switch_md.png", 350, 110, 79, 163)
visible(src_batt, false)
src_gpu = img_add("slvr_switch_up.png", 350, 110, 79, 163)
visible(src_gpu, false)

function new_src_pos(battery) 
    if  (battery) == 1 then
        visible(src_off, false)
        visible(src_gpu, false)        --ADDED UNTIL MIXMUGZ DON"T CRASH
        visible(src_batt, true)        --ADDED UNTIL MIXMUGZ DON"T CRASH
    elseif battery == 2 then
        visible(src_off, false)
        visible(src_gpu, true)
        visible(src_batt, false)
    else
        visible(src_off, true)
        visible(src_gpu, false)
        visible(src_batt, false)
    end    
end
fs2020_variable_subscribe("L:XMLVAR_Elec_Source_Switch_State", "Enum",
                                                 new_src_pos)

-- source switch touch zones
    --off
function cb_set_off()
    fs2020_variable_write("L:XMLVAR_Elec_Source_Switch_State", "ENUM", 0)  
end
button_add(nil, nil, 345,235, 90, 90, cb_set_off)

--battery
function cb_set_battery()
    fs2020_variable_write("L:XMLVAR_Elec_CrashBar_State", "Number", 1)
    fs2020_variable_write("L:XMLVAR_Elec_Source_Switch_State", "ENUM", 1)
end
button_add(nil, nil, 345,145, 90, 90, cb_set_battery)

function cb_set_GPU()
    fs2020_variable_write("L:XMLVAR_Elec_CrashBar_State", "Number", 1)
    fs2020_variable_write("L:XMLVAR_Elec_Source_Switch_State", "ENUM", 2) 
end

button_add(nil, nil, 345,55, 90, 90, cb_set_GPU)


--GENERATOR SWITCH
gen_off = img_add("slvr_switch_dn.png", 540, 109, 79, 163)
gen_main = img_add("slvr_switch_md.png", 540, 110, 79, 163)
visible(gen_main, false)
gen_stby = img_add("slvr_switch_up.png", 540, 110, 79, 163)
visible(gen_stby, false)

function ss_Generator(alt)
    genState = alt
    if genState == 0  then
        visible(gen_off,  true)
        visible(gen_main, false)
        visible(gen_stby, false)
    elseif  genState == 1 then
        visible(gen_off, false)
        visible(gen_main, true)
        visible(gen_stby, false)
    elseif  genState == 2 then
        visible(gen_off, false)
        visible(gen_main, false)
        visible(gen_stby, true)
    end 
end
fs2020_variable_subscribe("L:XMLVAR_Elec_Generator_Switch_state", "Enum", ss_Generator)

--    generator switch touch zones
function genOff()
    fs2020_variable_write("L:XMLVAR_Elec_Generator_Switch_state", "Enum", 0)
end
 function genOn()
     fs2020_variable_write("L:XMLVAR_Elec_Generator_Switch_state", "Enum", 1)
 end
 
 function genStdby()
     fs2020_variable_write("L:XMLVAR_Elec_Generator_Switch_state", "Enum", 2)
 end
button_add(nil, nil, 535, 235, 90, 90, genOff)

button_add(nil, nil, 535, 145, 90, 90, genOn)

button_add(nil, nil, 535, 55, 90, 90, genStdby)


--CRASHBAR

img_crashdn= img_add("crash_dn.png", 242, 80, 466, 119)
img_crashup = img_add("crash_up.png", 242, 80, 466, 119)

function setCB(state)
    crashbar_position = state
    if state == 1 then
        visible(img_crashdn, false)    
        visible(img_crashup, true)    
    else
        visible(img_crashdn, true)    
        visible(img_crashup, false)   
    end
end
fs2020_variable_subscribe("L:XMLVAR_Elec_CrashBar_State", "Number", setCB)

--crash bar toggle
function toggle_cb_callback()
    if crashbar_position== 0 then
        fs2020_variable_write("L:XMLVAR_Elec_CrashBar_State", "Number", 1)
    else
        fs2020_variable_write("L:XMLVAR_Elec_Source_Switch_State", "ENUM", 0)  
        fs2020_variable_write("L:XMLVAR_Elec_Generator_Switch_state", "Enum", 0)
        fs2020_variable_write("L:XMLVAR_Elec_CrashBar_State", "Number", 0)

    end
end
switch_add(nil, nil, 220, 80, 75, 150, toggle_cb_callback)
switch_add(nil, nil, 650, 80, 75, 150, toggle_cb_callback)

