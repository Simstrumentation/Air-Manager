--[[
******************************************************************************************
*****************Bombardier CRJ Pedestal-Flight Desk Door Panel**********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 04-18-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

snd_click = sound_add("click.wav")
snd_dial = sound_add("dial.wav")


img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")

function ss_backlighting(value, pwr)
    value = var_round(value*10,2) --value*0.038 if using Lvar L:ASCRJ_INTL_OVHD
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04)              
        opacity(img_backlight_lock_knob, 0, "LOG", 0.04)               
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04)
        opacity(img_backlight_lock_knob, (value), "LOG", 0.04)          
    end
end
msfs_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)

--Day Graphics
img_dial_lock= img_add("diamond_gray_knob.png", 218,35,70,70)

--Night Graphics
img_dial_lock_night= img_add("diamond_gray_knob_night.png", 218,35,70,70)

--Backlighting
img_backlight_lock_knob = img_add("backlight_diamond_knob.png", 218,35,70,70)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_dial_lock_night, value, "LOG", 0.04)       
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)


--Door Lock
function ss_lock(state)
    switch_set_position(switch_lock, state)
    rotate(img_dial_lock, -(40-(state*40)))
    rotate(img_dial_lock_night, -(40-(state*40)))  
    rotate(img_backlight_lock_knob, -(40-(state*40)))     
end
msfs_variable_subscribe("L:ASCRJ_FDD_MODE", "Number", ss_lock)

function cb_sw_lock(position, direction)
    if (position == 0 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_FDD_MODE","number",1) 
    elseif (position == 1 and direction == 1 ) then
        msfs_variable_write("L:ASCRJ_FDD_MODE","number",2) 
    elseif (position == 1 and direction == -1 ) then
        msfs_variable_write("L:ASCRJ_FDD_MODE","number",0)         
    elseif (position == 2 and direction == -1) then
        msfs_variable_write("L:ASCRJ_FDD_MODE","number",1)               
    end 
end
switch_lock = switch_add(nil,nil,nil, 228,40,50,50, "CIRCULAIR" , cb_sw_lock) 

-------------------------------------------------------------------
   
img_lockfail= img_add("lockfail.png", 89,31,37,27)   
--Lock Fail LED
function ss_lockfail(state)
    visible(img_lockfail, state==1)
end
msfs_variable_subscribe("L:ASCRJ_FDD_LOCK_FAIL", "Number", ss_lockfail)

img_autolock= img_add("autolock.png", 90,73,37,27)   
--Lock Fail LED
function ss_autolock(state)
    visible(img_autolock, state==1)
end
msfs_variable_subscribe("L:ASCRJ_FDD_AUTO_UNLK", "Number", ss_autolock)
   