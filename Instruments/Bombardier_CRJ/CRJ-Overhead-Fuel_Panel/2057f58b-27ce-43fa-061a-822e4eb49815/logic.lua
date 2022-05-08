--[[
******************************************************************************************
******************Bombardier CRJ-Overhead-Fuel Panel********************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  04-22-2022
    - Coded by Mike Murphy/"Helibrewer"
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

------------- Initialize button toggle state -----
tgl_LBP = 0
rbp_Toggle = 0
grav_xflo = 0
xflo_left = 0
xflo_right = 0
tglXFL_AO = 0
------------ Declare global variables-------
----------- events ------------------
btnFuelP_L = "L:ASCRJ_FUEL_PUMP_L"
btnGrav_Xflo = "L:ASCRJ_FUEL_GRAVITY_FLOW"
btnFuelP_R = "L:ASCRJ_FUEL_PUMP_R"
btnXflo_L = "L:ASCRJ_FUEL_XFLOW_L"
btnXflo_AO = "L:ASCRJ_FUEL_XFLOW_OVRD"
btnXflo_R = "L:ASCRJ_FUEL_XFLOW_R"

----------- status listeners --------
msgLBP_INOP = "L:ASCRJ_FUEL_PUMP_L_INOP"
msgLBP_ON = "L:ASCRJ_FUEL_PUMP_L_ON"
msgGF_O = "L:ASCRJ_FUEL_GRAVITY_FLOW_OPEN"
msgGF_F = "L:ASCRJ_FUEL_GRAVITY_FLOW_FAIL"
msgRBP_INOP = "L:ASCRJ_FUEL_PUMP_R_INOP"
msgRBP_ON = "L:ASCRJ_FUEL_PUMP_R_ON"
msgLXF_ON = "L:ASCRJ_FUEL_XFLOW_L_ON"
msgRXF_ON = "L:ASCRJ_FUEL_XFLOW_R_ON"
msgLXF_FAIL = "L:ASCRJ_FUEL_XFLOW_L_FAIL"
msgRXF_FAIL = "L:ASCRJ_FUEL_XFLOW_R_FAIL"
msgXAO_MAN = "L:ASCRJ_FUEL_XFLOW_OVRD_MAN"
---------------------------------------------

imgLBP_ON = img_add("light_on.png", 75, 73, 100, 45)    
imgLBP_INOP = img_add("light_inop.png", 75, 105, 100, 45)        
imgGF_FAIL = img_add("light_fail.png", 267, 73, 100, 45) 
imgGF_OPEN = img_add("light_open.png", 267, 105, 100, 45)
imgRBP_ON = img_add("light_on.png", 462, 73, 100, 45)    
imgRBP_INOP = img_add("light_inop.png", 462, 105, 100, 45)
imgLXF_ON = img_add("light_on.png", 75, 211, 100, 45)         
imgLXF_FAIL = img_add("light_fail.png", 76, 245, 100, 45)
imgXAO_MAN = img_add("light_man.png", 275, 208, 86, 86)
imgRXF_ON = img_add("light_on.png", 463, 211, 100, 45)            
imgRXF_FAIL = img_add("light_fail.png", 464, 245, 100, 45) 

function Pump_LBP()
    tgl_LBP = (tgl_LBP +1) % 2
    fs2020_variable_write(btnFuelP_L, "Number",tgl_LBP)
    sound_play(click_snd)
end
    btnPump_LB = button_add(nil,"btn_push.png", 85,70,85,85, Pump_LBP) 
    
function Grav_xflo()
    grav_xflo = (grav_xflo +1) % 2
    fs2020_variable_write(btnGrav_Xflo, "Number", grav_xflo)          
    sound_play(click_snd)
end
    btnXflo = button_add(nil, "btn_push.png", 275, 70, 85, 85, Grav_xflo)
    
function Pump_RBP()
    rbp_Toggle = (rbp_Toggle +1) % 2
    fs2020_variable_write(btnFuelP_R, "Number",rbp_Toggle)
    sound_play(click_snd)
end
    btnPump_RB = button_add(nil,"btn_push.png", 468,70,85,85, Pump_RBP)
    
function XFL_L()
    xflo_left = (xflo_left +1) % 2
    fs2020_variable_write(btnXflo_L, "Number",xflo_left)
    sound_play(click_snd)
end
    btnXFL_L = button_add(nil,"btn_push.png", 85,210,85,85, XFL_L)
    
function XFL_AO()
    tglXFL_AO = (tglXFL_AO +1) % 2
    fs2020_variable_write(btnXflo_AO, "Number",tglXFL_AO)
    sound_play(click_snd)
end
    btnXFL_L = button_add(nil,"btn_push.png", 275,210,83,83, XFL_AO)

function XFL_R()
    xflo_right = (xflo_right +1) % 2
    fs2020_variable_write(btnXflo_R, "Number",xflo_right)
    sound_play(click_snd)
end
    btnXFL_R = button_add(nil,"btn_push.png", 468,210,83,83, XFL_R) 
    
                                                                                                                                                                                                                                                                                               
-----------------------------------------
---- Button label listeners -------------
-----------------------------------------

function LB_INOP_msg(inop,pwr)
	visible(imgLBP_INOP, (inop ==1 and pwr ==true))
end        
fs2020_variable_subscribe(msgLBP_INOP, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  LB_INOP_msg)
    
function LB_ON_msg(on,pwr)
        visible(imgLBP_ON, (on ==1 and pwr ==true))
end
fs2020_variable_subscribe(msgLBP_ON, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  LB_ON_msg)
-----------------------------------------

function GF_OPEN_msg(open,pwr)
	visible(imgGF_OPEN, (open ==1 and pwr ==true))
end        
fs2020_variable_subscribe(msgGF_O, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  GF_OPEN_msg)
    
function GF_FAIL_msg(fail,pwr)
        visible(imgGF_FAIL, (fail ==1 and pwr ==true))
end
fs2020_variable_subscribe(msgGF_F, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  GF_FAIL_msg)
----------------------------------------------
function RB_INOP_msg(inop,pwr)
	visible(imgRBP_INOP, (inop ==1 and pwr ==true))
end        
fs2020_variable_subscribe(msgRBP_INOP, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  RB_INOP_msg)
    
function RB_ON_msg(on,pwr)
        visible(imgRBP_ON, (on ==1 and pwr ==true))
end
fs2020_variable_subscribe(msgRBP_ON, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  RB_ON_msg)
--------------------------------------------------

function LXF_FAIL_msg(fail,pwr)
	visible(imgLXF_FAIL, (fail ==1 and pwr ==true))
end        
fs2020_variable_subscribe(msgLXF_FAIL, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  LXF_FAIL_msg)
    
function LXF_ON_msg(on,pwr)
        visible(imgLXF_ON, (on ==1 and pwr ==true))
end
fs2020_variable_subscribe(msgLXF_ON, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  LXF_ON_msg)
--------------------------------------------------
function XAO_MAN_msg(man,pwr)
	visible(imgXAO_MAN, (man ==1 and pwr ==true))
end        
fs2020_variable_subscribe(msgXAO_MAN, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  XAO_MAN_msg)
-----------------------------------------------------    
    
function RXF_FAIL_msg(fail,pwr)
	visible(imgRXF_FAIL, (fail ==1 and pwr ==true))
end        
fs2020_variable_subscribe(msgRXF_FAIL, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  RXF_FAIL_msg)
    
function RXF_ON_msg(on,pwr)
        visible(imgRXF_ON, (on ==1 and pwr ==true))
end
fs2020_variable_subscribe(msgRXF_ON, "Number","A:CIRCUIT GENERAL PANEL ON","Bool",  RXF_ON_msg)     
