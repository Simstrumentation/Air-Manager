--[[
******************************************************************************************
*****************Bombardier CRJ-Overhead-Electrical Power Panel*********************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 02-09-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - If you disconnect IDG you need to use the tablet to reconnect, go to "Maintenance" tab.
******************************************************************************************
--]]

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
                                              
--Lights
img_gpu_avail = img_add("light_ac_avail.png", 480, 83, 100, 47) visible(img_gpu_avail,false)
img_gpu_inuse = img_add("light_ac_inuse.png", 480, 115, 100, 47) visible(img_gpu_inuse,false)
img_idg1_disc = img_add("light_disc.png", 60, 383, 100, 45) visible(img_idg1_disc,false)
img_idg1_fault = img_add("light_fault.png", 60, 350, 100, 45) visible(img_idg1_fault,false)
img_idg2_disc = img_add("light_disc.png", 483, 383, 100, 45) visible(img_idg2_disc,false)
img_idg2_fault = img_add("light_fault.png", 483, 350, 100, 45) visible(img_idg2_fault,false)
img_essxfer= img_add("light_altn.png", 275, 347, 86, 86 ) visible(img_essxfer,false)
img_autoxfer1_off = img_add("light_off.png", 154, 693, 100 , 45) visible(img_autoxfer1_off,false)
img_autoxfer1_fail = img_add("light_fail.png", 154, 661, 100, 45) visible(img_autoxfer1_fail,false)  
img_autoxfer2_off = img_add("light_off.png", 396, 693, 100, 45) visible(img_autoxfer2_off,false)
img_autoxfer2_fail = img_add("light_fail.png", 396, 660, 100, 45) visible(img_autoxfer2_fail,false)  

--Day Graphics
img_sw_dcservice_mid = img_add("toggle_mid.png", 13,63,181,179) 
img_sw_dcservice_dn = img_add("toggle_down.png", 13,63,181,179) visible(img_sw_dcservice_dn, false)
img_sw_batt_mid = img_add("lrg_toggle_mid.png", 186,-3,108,300) 
img_sw_batt_dn = img_add("lrg_toggle_down.png", 186,-3,108,300) visible(img_sw_batt_dn, false)
img_sw_gen1_mid = img_add("lrg_toggle_mid.png", 26,468,108,300) 
img_sw_gen1_dn = img_add("lrg_toggle_down.png", 26,468,108,300) visible(img_sw_gen1_dn, false)
img_sw_gen2_mid = img_add("lrg_toggle_mid.png", 492,468,108,300) 
img_sw_gen2_dn = img_add("lrg_toggle_down.png", 492,468,108,300) visible(img_sw_gen2_dn, false)
img_sw_apugen_mid = img_add("lrg_toggle_mid.png", 262,468,108,300) 
img_sw_apugen_dn = img_add("lrg_toggle_down.png", 262,468,108,300) visible(img_sw_apugen_dn, false)
img_idg1_Cover_Dn = img_add("cover_down.png", 48, 234,123,209) 
img_idg1_Cover_Up = img_add("cover_up.png", 48, 234,123,209) visible(img_idg1_Cover_Up, false)
img_idg2_Cover_Dn = img_add("cover_down.png", 471, 234,123,209) 
img_idg2_Cover_Up = img_add("cover_up.png", 471, 234,123,209) visible(img_idg2_Cover_Up, false)

--Night Graphics
img_sw_dcservice_mid_night = img_add("toggle_mid_night.png", 13,63,181,179) visible(img_sw_dcservice_mid_night, false)
img_sw_dcservice_dn_night = img_add("toggle_down_night.png", 13,63,181,179) visible(img_sw_dcservice_dn_night, false)
img_sw_batt_mid_night = img_add("lrg_toggle_mid_night.png", 186,-3,108,300) visible(img_sw_batt_mid_night , false)
img_sw_batt_dn_night = img_add("lrg_toggle_down_night.png", 186,-3,108,300) visible(img_sw_batt_dn_night , false)
img_sw_gen1_mid_night = img_add("lrg_toggle_mid_night.png", 26,468,108,300) visible(img_sw_gen1_mid_night , false)
img_sw_gen1_dn_night  = img_add("lrg_toggle_down_night.png", 26,468,108,300) visible(img_sw_gen1_dn_night , false)
img_sw_gen2_mid_night  = img_add("lrg_toggle_mid_night.png", 492,468,108,300) visible(img_sw_gen2_mid_night , false)
img_sw_gen2_dn_night  = img_add("lrg_toggle_down_night.png", 492,468,108,300) visible(img_sw_gen2_dn_night , false)
img_sw_apugen_mid_night  = img_add("lrg_toggle_mid_night.png", 262,468,108,300) visible(img_sw_apugen_mid_night , false)
img_sw_apugen_dn_night  = img_add("lrg_toggle_down_night.png", 262,468,108,300) visible(img_sw_apugen_dn_night , false)
img_idg1_Cover_Dn_night = img_add("cover_down_night.png", 48, 234,123,209) 
img_idg1_Cover_Up_night = img_add("cover_up_night.png", 48, 234,123,209) visible(img_idg1_Cover_Up_night, false)
img_idg2_Cover_Dn_night = img_add("cover_down_night.png", 471, 234,123,209) 
img_idg2_Cover_Up_night = img_add("cover_up_night.png", 471, 234,123,209) visible(img_idg2_Cover_Up_night, false)




-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_sw_dcservice_mid_night, value, "LOG", 0.04)
    opacity(img_sw_dcservice_dn_night, value, "LOG", 0.04)
    opacity(img_sw_batt_mid_night, value, "LOG", 0.04)
    opacity(img_sw_batt_dn_night, value, "LOG", 0.04)
    opacity(img_sw_gen1_mid_night, value, "LOG", 0.04)
    opacity(img_sw_gen1_dn_night, value, "LOG", 0.04)       
    opacity(img_sw_gen2_mid_night, value, "LOG", 0.04)
    opacity(img_sw_gen2_dn_night, value, "LOG", 0.04)     
    opacity(img_sw_apugen_mid_night, value, "LOG", 0.04)
    opacity(img_sw_apugen_dn_night, value, "LOG", 0.04)       
    opacity(img_idg1_Cover_Dn_night, value, "LOG", 0.04) 
    opacity(img_idg1_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode 
    opacity(img_idg1_Cover_Up_night, value, "LOG", 0.04)     
    opacity(img_idg1_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_idg2_Cover_Dn_night, value, "LOG", 0.04)
    opacity(img_idg2_Cover_Dn, (1-value), "LOG", 0.04) --reverses day mode     
    opacity(img_idg2_Cover_Up_night, value, "LOG", 0.04)
    opacity(img_idg2_Cover_Up, (1-value), "LOG", 0.04) --reverses day mode     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--VARIABLES
local tgl_gpu = 0
local tgl_idg1 = 0
local tgl_idg2 = 0
local tgl_essxfer = 0
local tgl_autoxfer1 = 0
local tgl_autoxfer2 = 0

-----------------------------------------------
--DC Service SWITCH
msfs_variable_subscribe("L:ASCRJ_ELEC_DCSERVICE", "Number", 
        function (state)
            if state == 1.0 then state = 1 end
            if state == 0.0 then state = 0 end
            switch_set_position(sw_dc, state)
            visible(img_sw_dcservice_mid, state ==0)
            visible(img_sw_dcservice_mid_night, state ==0)
            visible(img_sw_dcservice_dn, state ==1)
            visible(img_sw_dcservice_dn_night, state ==1)     
        end)

function cb_sw_dc(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_ELEC_DCSERVICE","Number",1) 
    elseif (position == 1 ) then
        msfs_variable_write("L:ASCRJ_ELEC_DCSERVICE","Number",0) 
    end 
end
sw_dc= switch_add(nil,nil, 13,63,181,179, cb_sw_dc)

--BATTERY SWITCH
function cb_sw_battmaster(position)
    if (position == 0 ) then
        msfs_variable_write("L:ASCRJ_ELEC_BATTMASTER","Number",1) 
    elseif (position == 1 ) then

        msfs_variable_write("L:ASCRJ_ELEC_BATTMASTER","Number",0) 
    end 
end
sw_battmaster= switch_add(nil,nil, 188,37,108,216, cb_sw_battmaster)
msfs_variable_subscribe("L:ASCRJ_ELEC_BATTMASTER", "Number", 
        function (state)
            switch_set_position(sw_battmaster, state)
            visible(img_sw_batt_mid, state ==0)
            visible(img_sw_batt_mid_night, state ==0)
            visible(img_sw_batt_dn, state ==1)
            visible(img_sw_batt_dn_night, state ==1)    
        end)

--AC BUTTON
function cb_gpu()
        tgl_gpu = (tgl_gpu + 1) % 2
        msfs_variable_write("L:ASCRJ_ELEC_GPU","Number",tgl_gpu)
        sound_play(snd_click)
end
btn_gpu = button_add(nil,"btn_push.png", 495, 89,68,68, cb_gpu)

msfs_variable_subscribe("A:CIRCUIT GENERAL PANEL ON","Bool",
                                             "L:ASCRJ_ELEC_GPU_AVAIL","Number",
                                             "L:ASCRJ_ELEC_GPU_INUSE","Number",
        function (pwr,GPU_Avail,GPU_Inuse)
            if (pwr ==true) then
                     if (GPU_Inuse ==1) then visible(img_gpu_inuse,true)
                     elseif (GPU_Inuse ==0) then visible(img_gpu_inuse,false)
                     end
                     if (GPU_Avail==1) then visible(img_gpu_avail,true) 
                     elseif (GPU_Avail==0) then visible(img_gpu_avail,false) 
                     end
            else
                visible(img_gpu_avail,false) 
                visible(img_gpu_inuse,false)
            end
        end)
        
-----------------------------------------
--IDG1 BUTTON
function cb_idg1_disc()
        tgl_idg1 = (tgl_idg1 + 1) % 2
        msfs_variable_write("L:ASCRJ_ELEC_IDG1","Number",tgl_idg1)
        sound_play(snd_click)
end
btn_idg1_disc = button_add(nil,"btn_push.png", 77,355,69,68, cb_idg1_disc)

function  cb_idg1_Cover()
    timer_start(3000, timer_idg1_Cover)    --call timer to close cover
    visible(btn_idg1_disc, true)                        --enable button
    visible(img_idg1_Cover_Up, true) visible(img_idg1_Cover_Up_night, true)        --show up cover
    visible(img_idg1_Cover_Dn, false) visible(img_idg1_Cover_Dn_night, false)       --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_idg1_Cover, false)                --disable cover switch
end
sw_idg1_Cover = switch_add(nil,nil, 77,355,69,68, cb_idg1_Cover)

function timer_idg1_Cover()
    visible(img_idg1_Cover_Dn, true)  visible(img_idg1_Cover_Dn_night, true)      --show dn cover
    visible(img_idg1_Cover_Up, false) visible(img_idg1_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_idg1_disc, false)                        --disable button
    visible(sw_idg1_Cover, true)                 --enable cover switch
end
--IDG1 DISC
msfs_variable_subscribe("L:ASCRJ_ELEC_IDG1_DISC", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (disc,pwr)
            if (pwr==true and disc==0 ) then visible(img_idg1_disc,false)    
            elseif (pwr==true and disc==1 ) then visible(img_idg1_disc, true)    
            else  visible(img_idg1_disc,false)  
            end
        end)
--IDG1 Fault
msfs_variable_subscribe("L:ASCRJ_ELEC_IDG1_FAULT", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (fault,pwr)
            if (pwr==true and fault==1 ) then  visible(img_idg1_fault, true)    
            else visible(img_idg1_fault,false)  
            end
        end)

--IDG2 BUTTON
function cb_idg2_disc()
        tgl_idg2 = (tgl_idg2 + 1) % 2
        msfs_variable_write("L:ASCRJ_ELEC_IDG2","Number",tgl_idg2)
        sound_play(snd_click)
end
btn_idg2_disc = button_add(nil,"btn_push.png", 501, 355, 68, 68, cb_idg2_disc)

function  cb_idg2_Cover()
    timer_start(3000, timer_idg2_Cover)    --call timer to close cover
    visible(btn_idg2_disc, true)                        --enable button
    visible(img_idg2_Cover_Up, true) visible(img_idg2_Cover_Up_night, true)        --show up cover
    visible(img_idg2_Cover_Dn, false) visible(img_idg2_Cover_Dn_night, false)       --hide down cover
    sound_play(snd_cover_open)    
    visible(sw_idg2_Cover, false)                --disable cover switch
    
end
sw_idg2_Cover = switch_add(nil,nil, 501, 355,69,68, cb_idg2_Cover)

function timer_idg2_Cover()
    visible(img_idg2_Cover_Dn, true)  visible(img_idg2_Cover_Dn_night, true)      --show dn cover
    visible(img_idg2_Cover_Up, false) visible(img_idg2_Cover_Up_night, false)        --hide up cover
    sound_play(snd_cover_close)    
    visible(btn_idg2_disc, false)                        --disable button
    visible(sw_idg2_Cover, true)                 --enable cover switch
end
--IDG2 DISC
msfs_variable_subscribe("L:ASCRJ_ELEC_IDG2_DISC", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (disc,pwr)
            if (pwr==true and disc==0 ) then visible(img_idg2_disc,false)    
            elseif (pwr==true and disc==1 ) then visible(img_idg2_disc, true)    
            else  visible(img_idg2_disc,false)  
            end
        end)
--IDG2 Fault
msfs_variable_subscribe("L:ASCRJ_ELEC_IDG2_FAULT", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (fault,pwr)
            if (pwr ==true and fault==1 ) then  visible(img_idg2_fault, true)    
            else visible(img_idg2_fault,false)  
            end
        end)        

                
--ESSXFER BUTTON
function cb_essxfer()
        tgl_essxfer = (tgl_essxfer + 1) % 2
        msfs_variable_write("L:ASCRJ_ELEC_ACESSXFER","Number",tgl_essxfer)
        sound_play(snd_click)
end
btn_essxfer = button_add(nil,"btn_push.png", 284, 355, 68, 68, cb_essxfer)


msfs_variable_subscribe("L:ASCRJ_ELEC_ACESSXFER_ALTN", "Number", 
					     "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (essxfer,pwr)
            if  (pwr==true and essxfer==0)  then visible(img_essxfer,false)    
            elseif  (pwr==true and essxfer==1)  then visible(img_essxfer, true)    
            else  visible(img_essxfer,false)  
            end
        end)
        
--Gen1 BUTTON
msfs_variable_subscribe("L:ASCRJ_ELEC_GEN1", "Number", 
        function (state)      
            switch_set_position(sw_gen1, state)
            visible(img_sw_gen1_mid, state ==0)
            visible(img_sw_gen1_mid_night, state ==0)
            visible(img_sw_gen1_dn, state ==1)
            visible(img_sw_gen1_dn_night, state ==1)                
        end)

function cb_sw_gen1(position)
    if (position == 0 ) then msfs_variable_write("L:ASCRJ_ELEC_GEN1","Number",1) 
    elseif (position == 1 ) then msfs_variable_write("L:ASCRJ_ELEC_GEN1","Number",0) 
    end 
end
sw_gen1= switch_add(nil,nil, 26, 508, 108,216, cb_sw_gen1)    

--APU BUTTON
msfs_variable_subscribe("L:ASCRJ_ELEC_APUGEN", "Number", 
        function (state)      
            switch_set_position(sw_apugen, state)
            visible(img_sw_apugen_mid, state ==0)
            visible(img_sw_apugen_mid_night, state ==0)
            visible(img_sw_apugen_dn, state ==1)
            visible(img_sw_apugen_dn_night, state ==1)                
        end)

function cb_sw_apugen(position)
print(position)
    if (position == 0 ) then msfs_variable_write("L:ASCRJ_ELEC_APUGEN","Number",1) 
    elseif (position == 1 ) then print("here") msfs_variable_write("L:ASCRJ_ELEC_APUGEN","Number",0.0) 
    end 
end
sw_apugen = switch_add(nil,nil, 262,508,108,216, cb_sw_apugen) 
                    
--Gen2 BUTTON
msfs_variable_subscribe("L:ASCRJ_ELEC_GEN2", "Number", 
        function (state)      
            switch_set_position(sw_gen2, state)
            visible(img_sw_gen2_mid, state ==0)
            visible(img_sw_gen2_mid_night, state ==0)
            visible(img_sw_gen2_dn, state ==1)
            visible(img_sw_gen2_dn_night, state ==1)                
        end)

function cb_sw_gen2(position)
    if (position == 0 ) then msfs_variable_write("L:ASCRJ_ELEC_GEN2","Number",1) 
    elseif (position == 1 ) then msfs_variable_write("L:ASCRJ_ELEC_GEN2","Number",0) 
    end 
end
sw_gen2 = switch_add(nil,nil, 492, 508, 108,216, cb_sw_gen2)                            

                                                                
--AUTOXFER1 BUTTON
msfs_variable_subscribe("L:ASCRJ_ELEC_AUTOXFER1_OFF", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (state,pwr)
            if (pwr==true and state==0 ) then visible(img_autoxfer1_off ,false)    
            elseif (pwr==true and state==1 ) then visible(img_autoxfer1_off , true)    
            else  visible(img_autoxfer1_off ,false)  
            end
        end)
function cb_AUTOXFER1()
        tgl_autoxfer1 = (tgl_autoxfer1 + 1) % 2
        msfs_variable_write("L:ASCRJ_ELEC_AUTOXFER1","Number",tgl_autoxfer1)
        sound_play(snd_click)
end
btn_AUTOXFER1 = button_add(nil,"btn_push.png", 169, 665, 68, 68, cb_AUTOXFER1)

--AUTOXFER1 Fail
msfs_variable_subscribe("L:ASCRJ_ELEC_AUTOXFER1_FAIL", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (fault,pwr)
            if (pwr==true and fault==1 ) then  visible(img_autoxfer1_fail, true)    
            else visible(img_autoxfer1_fail,false)  
            end
        end)   
        
--AUTOXFER2 BUTTON
msfs_variable_subscribe("L:ASCRJ_ELEC_AUTOXFER2_OFF", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (state,pwr)
            if (pwr==true and state==0 ) then visible(img_autoxfer2_off ,false)    
            elseif (pwr==true and state==1 ) then visible(img_autoxfer2_off , true)    
            else  visible(img_autoxfer2_off ,false)  
            end
        end)

function cb_AUTOXFER2()
        tgl_autoxfer2 = (tgl_autoxfer2 + 1) % 2
        msfs_variable_write("L:ASCRJ_ELEC_AUTOXFER2","Number",tgl_autoxfer2)
        sound_play(snd_click)
end
btn_AUTOXFER2 = button_add(nil,"btn_push.png", 411, 666, 68, 68, cb_AUTOXFER2)  

--AUTOXFER2 Fail
msfs_variable_subscribe("L:ASCRJ_ELEC_AUTOXFER2_FAIL", "Number", 
                                              "A:CIRCUIT GENERAL PANEL ON","Bool",
        function (fault,pwr)
            if (pwr==true and fault==1 ) then  visible(img_autoxfer2_fail, true)    
            else visible(img_autoxfer2_fail,false)  
            end
        end)                                                                                                                             