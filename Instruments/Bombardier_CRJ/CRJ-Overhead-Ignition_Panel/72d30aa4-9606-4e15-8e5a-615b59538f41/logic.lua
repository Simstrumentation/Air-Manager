--[[
******************************************************************************************
******************Bombardier CRJ-Overhead-Ignition Panel*****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  03-26-2022
    - Coded by Mike Murphy/"Helibrewer"
    - Split into two different instruments
    - Graphics replaced

##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

click_snd = sound_add("knobclick.wav")
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
fs2020_variable_subscribe("A:Light Potentiometer:2", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)      
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--- Initialize images ---
imgENG_L = img_add("light_start.png",72,72,86,85) 
imgENG_R = img_add("light_start.png",190,72,86,85)
imgENG_RStop = img_add("light_stop.png",190,188,86,85) 
imgENG_LStop = img_add("light_stop.png",72,188,86,85) 
imgCNT_IGN_ON = img_add("light_on.png",492,129,86,85) 


-- variable to toggle on/off button function
tglCNT_IGN = 0

function ENG_L_start()
    fs2020_variable_write("L:ASCRJ_ENGS_START_L","Number",1)timer_start(100, function() fs2020_variable_write("L:ASCRJ_ENGS_START_L","Number",0)end) 
    sound_play(click_snd)
end
    ENG_L_START = button_add(nil,"btn_push.png", 80,80,70,70, ENG_L_start)
    
function ENG_R_start()
    fs2020_variable_write("L:ASCRJ_ENGS_START_R","Number",1)timer_start(100, function() fs2020_variable_write("L:ASCRJ_ENGS_START_R","Number",0)end) 
    sound_play(click_snd)
end
    ENG_R_START = button_add(nil,"btn_push.png", 198,80,70,70, ENG_R_start)
        
function ENG_R_STOP()
    fs2020_variable_write("L:ASCRJ_ENGS_STOP_R", "Number", 1)timer_start(100, function() fs2020_variable_write("L:ASCRJ_ENGS_STOP_R","Number",0)end) 
    sound_play(click_snd)
end
    btnENG_R_STOP = button_add(nil, "btn_push.png",198,196,70,70, ENG_R_STOP)

function ENG_L_STOP()
    fs2020_variable_write("L:ASCRJ_ENGS_STOP_L", "Number", 1)timer_start(100, function() fs2020_variable_write("L:ASCRJ_ENGS_STOP_L","Number",0)end) 
    sound_play(click_snd)
end
    btnENG_L_STOP = button_add(nil, "btn_push.png", 80,196,70,70, ENG_L_STOP)
                          
function CONT_IGN()
    tglCNT_IGN = (tglCNT_IGN + 1) % 2
    fs2020_variable_write("L:ASCRJ_ENGS_CONT_IGN", "Number", tglCNT_IGN)  
    sound_play(click_snd)
end
    btnCONT_IGN = button_add(nil, "btn_push.png",500,137,70,70, CONT_IGN)
---------------------------------------------------------------------------------
------- Listeners for button status lights --------------------------------------
----------------------------------------------------------------------------------
--Start Subscribes
function ENG_L_STARTING(state,pwr)
        visible(imgENG_L, (state ==1 and pwr ==true))
end
fs2020_variable_subscribe("L:ASCRJ_ENGS_START_L_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", ENG_L_STARTING)  
    
function ENG_R_STARTING(state,pwr)
        visible(imgENG_R, (state ==1 and pwr ==true))
end
fs2020_variable_subscribe("L:ASCRJ_ENGS_START_R_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", ENG_R_STARTING)

--Stop Subscribes
function ENG_L_STOPING(state,pwr)
        visible(imgENG_LStop, (state==1 and pwr ==true))
end
fs2020_variable_subscribe("L:ASCRJ_ENGS_STOP_L_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", ENG_L_STOPING)  
    
function ENG_R_STOPING(state,pwr)
        visible(imgENG_RStop, (state ==1 and pwr ==true))
end
fs2020_variable_subscribe("L:ASCRJ_ENGS_STOP_R_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", ENG_R_STOPING)
   
--Cont Subscribes   
function CONT_IGN_ON(on,pwr)
        visible(imgCNT_IGN_ON, (on ==1 and pwr ==true))
end
fs2020_variable_subscribe("L:ASCRJ_ENGS_CONT_IGN_ON", "Number","A:CIRCUIT GENERAL PANEL ON","Bool", CONT_IGN_ON)      
              	  	            	  	                	  	            	  	  
                	  	            	  	                	  	            	  	              	  	            	  	                	  	            	  	  
                	  	            	  	                	  	            	  	              	  	            	  	                	  	            	  	              	  	            	  	                	  	            	  	              	  	            	  	                	  	            	  	  