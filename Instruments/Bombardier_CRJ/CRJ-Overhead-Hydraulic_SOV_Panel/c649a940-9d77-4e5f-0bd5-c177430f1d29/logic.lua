--[[
******************************************************************************************
***************Bombardier CRJ-Overhead-Hydraulic SOV Panel*************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-27-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
******************************************************************************************
--]]

--add backgrond image

snd_click=sound_add("click.wav")
snd_cover_close=sound_add("cover_close.wav")
snd_cover_open=sound_add("cover_open.wav")

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
---------------------------------------------
--Day graphics
img_HYD_SOV1_ON = img_add("closed.png", 76,124,114,114) 
img_HYD_SOV2_ON = img_add("closed.png", 436,124,114,114) 
img_HYD_SOV1_Cover_Dn = img_add("cover_down.png", 57,20,150,230) 
img_HYD_SOV1_Cover_Up = img_add("cover_up.png", 57,20,150,230) visible(img_HYD_SOV1_Cover_Up, false)
img_HYD_SOV2_Cover_Dn = img_add("cover_down.png", 417,20,150,230) 
img_HYD_SOV2_Cover_Up = img_add("cover_up.png", 417,20,150,230) visible(img_HYD_SOV2_Cover_Up, false) 


--Night Graphics
img_HYD_SOV1_Cover_Dn_night = img_add("cover_down_night.png", 57,20,150,230) 
img_HYD_SOV1_Cover_Up_night = img_add("cover_up_night.png", 57,20,150,230) visible(img_HYD_SOV1_Cover_Up_night, false)
img_HYD_SOV2_Cover_Dn_night = img_add("cover_down_night.png", 417,20,150,230) 
img_HYD_SOV2_Cover_Up_night = img_add("cover_up_night.png", 417,20,150,230) visible(img_HYD_SOV2_Cover_Up_night, false) 

---------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)      
    opacity(img_HYD_SOV1_Cover_Dn_night, value, "LOG", 0.04)      
    opacity(img_HYD_SOV1_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_HYD_SOV1_Cover_Up_night, value, "LOG", 0.04)      
    opacity(img_HYD_SOV1_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_HYD_SOV2_Cover_Dn_night, value, "LOG", 0.04)      
    opacity(img_HYD_SOV2_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_HYD_SOV2_Cover_Up_night, value, "LOG", 0.04)                  
    opacity(img_HYD_SOV2_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-------------------------------------------------------------
-------------------------------------------------------------

local tgl_HYDR_SOV1 = 0
local tgl_HYDR_SOV2 = 0

function cb_HYDR_SOV1()
        tgl_HYDR_SOV1 = (tgl_HYDR_SOV1 + 1) % 2
        msfs_variable_write("L:ASCRJ_HYDR_SOV1","Number",tgl_HYDR_SOV1)
        sound_play(snd_click)
end
btn_HYDR_SOV1 = button_add(nil,"btn_push.png", 86,134,95,95, cb_HYDR_SOV1) visible(btn_HYDR_SOV1, false)

function  cb_HYD_SOV1_Cover()
    timer_start(3000, timer_HYD_SOV1_Cover)    --call timer to close cover
    visible(btn_HYDR_SOV1, true)                        --enable button
    visible(img_HYD_SOV1_Cover_Up, true) visible(img_HYD_SOV1_Cover_Up_night, true)        --show up cover
    visible(img_HYD_SOV1_Cover_Dn, false) visible(img_HYD_SOV1_Cover_Dn_night, false)      --hide down cover
    sound_play(snd_cover_open)
    visible(sw_HYD_SOV1_Cover, false)                --disable cover switch
    
end
sw_HYD_SOV1_Cover = switch_add(nil,nil, 70,90,150,150, cb_HYD_SOV1_Cover)

function timer_HYD_SOV1_Cover()
    visible(img_HYD_SOV1_Cover_Dn, true) visible(img_HYD_SOV1_Cover_Dn_night, true)        --show dn cover
    visible(img_HYD_SOV1_Cover_Up, false) visible(img_HYD_SOV1_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)
    visible(btn_HYDR_SOV1, false)                        --disable button
    visible(sw_HYD_SOV1_Cover, true)                 --enable cover switch
end

 
--SOV2 BUTTON 
function cb_HYDR_SOV2()
    tgl_HYDR_SOV2 = (tgl_HYDR_SOV2 + 1) % 2
    msfs_variable_write("L:ASCRJ_HYDR_SOV2","Number",tgl_HYDR_SOV2)
    sound_play(snd_click)
end
btn_HYDR_SOV2 = button_add(nil,"btn_push.png", 446,134,95,95, cb_HYDR_SOV2) visible(btn_HYDR_SOV2, false)

function  cb_HYD_SOV2_Cover()
    timer_start(3000, timer_HYD_SOV2_Cover)    --call timer to close cover
    visible(btn_HYDR_SOV2, true)                        --enable button
    visible(img_HYD_SOV2_Cover_Up, true)  visible(img_HYD_SOV2_Cover_Up_night, true)       --show up cover
    visible(img_HYD_SOV2_Cover_Dn, false)  visible(img_HYD_SOV2_Cover_Dn_night, false)        --hide down cover
    sound_play(snd_cover_open)        
    visible(sw_HYD_SOV2_Cover, false)                --disable cover switch
    
end
sw_HYD_SOV2_Cover = switch_add(nil,nil, 417,90,150,150, cb_HYD_SOV2_Cover)

function timer_HYD_SOV2_Cover()
    visible(img_HYD_SOV2_Cover_Dn, true)  visible(img_HYD_SOV2_Cover_Dn_night, true)       --show dn cover
    visible(img_HYD_SOV2_Cover_Up, false) visible(img_HYD_SOV2_Cover_Up_night, false)         --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_HYDR_SOV2, false)                        --disable button
    visible(sw_HYD_SOV2_Cover, true)                 --enable cover switch
end


--Subscribes   
msfs_variable_subscribe("L:ASCRJ_HYDR_SOV1_CLOSED", "Number",
                                            "A:CIRCUIT GENERAL PANEL ON","Bool",
    function (on,pwr)
        visible(img_HYD_SOV1_ON, (on ==1 and pwr ==true))
    end)      

msfs_variable_subscribe("L:ASCRJ_HYDR_SOV2_CLOSED", "Number", 
                                                "A:CIRCUIT GENERAL PANEL ON","Bool",
    function (on,pwr)
        visible(img_HYD_SOV2_ON, (on ==1 and pwr ==true))
    end)   