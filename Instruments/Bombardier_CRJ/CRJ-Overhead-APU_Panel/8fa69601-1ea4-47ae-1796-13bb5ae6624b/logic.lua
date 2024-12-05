--[[
******************************************************************************************
******************Bombardier CRJ-Overhead-APU Panel********************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  03-22-2022
    - Coded by Mike Murphy/"Helibrewer"
    - Split into two different instruments
    - Graphics replaced

##Left To Do:
    - N/A
	
##Notes:
    - 
        
--]]

click_snd = sound_add("click.wav")
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

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
msfs_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)


--images
img_APU_pump = img_add("light_pump_fail.png", 284, 66, 100, 45)
img_APU_sov = img_add("light_sov_fail.png", 284, 99, 100, 45)
img_APU_start = img_add("light_start.png", 393, 66, 100, 45)
img_APU_avail = img_add("light_avail.png", 393, 99, 100, 45)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- variable to toggle on/off button function
tglAPU = 0

function APU_PWR()
    msfs_variable_write("L:ASCRJ_APU_PWRFUEL","Number",1) timer_start(100, function() msfs_variable_write("L:ASCRJ_APU_PWRFUEL","Number",0)end)
    sound_play(click_snd)
end
APU_PWR = button_add(nil,"btn_push.png", 291,64,82,82, APU_PWR)
    
function APU_start()
    tglAPU = (tglAPU +1) % 2  --- Toggles between 1 and zero for START and STOP -------    
    msfs_variable_write("L:ASCRJ_APU_STARTSTOP","Number",tglAPU)
    sound_play(click_snd)
end
APU_START = button_add(nil,"btn_push.png", 401,64,82,82, APU_start)
    
---------------------------------------------------------------------------------
------- Listeners for button status lights --------------------------------------
---------------------------------------------------------------------------------
function APU_pump_msg(avail,pwr)
            if (pwr==true) then
	            visible(img_APU_pump, avail == 1)
	    else visible(img_APU_pump, false)
	    end
end        
msfs_variable_subscribe("L:ASCRJ_APU_PWRFUEL_PUMP", "Number", 
				              "A:CIRCUIT GENERAL PANEL ON","Bool", APU_pump_msg)

function APU_sov_msg(avail,pwr)
            if (pwr==true) then
	        visible(img_APU_sov, avail == 1)
	    else visible(img_APU_sov, false)
	    end
end        
msfs_variable_subscribe("L:ASCRJ_APU_PWRFUEL_SOV", "Number", 
				              "A:CIRCUIT GENERAL PANEL ON","Bool", APU_sov_msg)

function APU_start_msg(start,pwr)
            if (pwr==true) then
	        visible(img_APU_start, start == 1)
	    else visible(img_APU_start, false)
	    end	        
end        
msfs_variable_subscribe("L:ASCRJ_APU_STARTSTOP_START", "Number", 
				              "A:CIRCUIT GENERAL PANEL ON","Bool", APU_start_msg)
      
function APU_avail_msg(avail,pwr)
            if (pwr==true) then
	        visible(img_APU_avail, avail == 1)
	    else visible(img_APU_avail, false)
	    end		        
end        
msfs_variable_subscribe("L:ASCRJ_APU_STARTSTOP_AVAIL", "Number", 
				              "A:CIRCUIT GENERAL PANEL ON","Bool", APU_avail_msg)
    