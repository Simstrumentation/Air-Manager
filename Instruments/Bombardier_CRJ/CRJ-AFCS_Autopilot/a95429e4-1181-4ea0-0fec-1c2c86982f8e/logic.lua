--[[
******************************************************************************************
******************Bombardier CRJ-AFCS Autopilot Panel*******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  06-21-2022
    - Coded by Mike Murphy/"Helibrewer"
- **v1.1**  12-28-2022
    - Graphics replaced
    - Code reworked
    
## Left To Do:
  - N/A
	
## Notes:
  - The VS Speed knob is difficult to use without a knobster. Thus there is a user prop to make the dial two buttons (Down/Up).   
        
--]]
local button_delay = 50
snd_click = sound_add("click.wav")
snd_dial = sound_add("dial.wav")

prop_VSDialorButtons = user_prop_add_boolean("VS Dial acts as buttons instead of dial", false, "") -- Show or hide the unit type onscreen

--Day Graphics
img_add_fullscreen("background.png") 
img_ap_disc = img_add("ap_disc.png", 180, 104, 140, 40)
img_dial_crs1 = img_add("knob.png", 62, 22, 80, 80)
img_crs1_dir = img_add("knob_crs1_dir.png", 62, 22, 80, 80)
img_dial_crs2 = img_add("knob.png", 1316, 22, 80, 80)
img_crs2_dir = img_add("knob_crs1_dir.png", 1316, 22, 80, 80)

img_dial_speed = img_add("knob.png", 460, 95, 80, 80)
img_speed_sel = img_add("knob_speed_sel.png", 460, 95, 80, 80)
img_dial_hdg = img_add("knob.png", 680, 95, 80, 80)
img_hdg_sync = img_add("knob_hdg_sync.png", 680, 95, 80, 80)
img_dial_alt = img_add("knob.png", 898, 95, 80, 80)
img_alt_cancel = img_add("knob_alt_cancel.png", 898, 95, 80, 80)


--Night Graphics
img_bg_night = img_add_fullscreen("background_night.png") 
img_ap_disc_night = img_add("ap_disc_night.png", 180,104,140,40) 
img_dial_crs1_night = img_add("knob_night.png", 62, 22, 80, 80)
img_crs1_dir_night = img_add("knob_crs1_dir_night.png", 62, 22, 80, 80)
img_dial_crs2_night = img_add("knob_night.png", 1316, 22, 80, 80)
img_crs2_dir_night = img_add("knob_crs1_dir_night.png", 1316, 22, 80, 80)

img_dial_speed_night = img_add("knob_night.png", 460, 95, 80, 80)
img_speed_sel_night = img_add("knob_speed_sel_night.png", 460, 95, 80, 80)
img_dial_hdg_night = img_add("knob_night.png", 680, 95, 80, 80)
img_hdg_sync_night = img_add("knob_hdg_sync_night.png", 680, 95, 80, 80)
img_dial_alt_night = img_add("knob_night.png", 898, 95, 80, 80)
img_alt_cancel_night = img_add("knob_alt_cancel_night.png", 898, 95, 80, 80)
-----------------------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_ap_disc_night, value, "LOG", 0.04)    
    opacity(img_dial_crs1_night, value, "LOG", 0.04)
    opacity(img_crs1_dir_night , value, "LOG", 0.04)  
    opacity(img_dial_crs2_night, value, "LOG", 0.04)
    opacity(img_crs2_dir_night, value, "LOG", 0.04)   
    
    opacity(img_dial_speed_night, value, "LOG", 0.04)
    opacity(img_speed_sel_night , value, "LOG", 0.04)    
    opacity(img_dial_hdg_night, value, "LOG", 0.04)
    opacity(img_hdg_sync_night , value, "LOG", 0.04)  
    opacity(img_dial_alt_night , value, "LOG", 0.04)
    opacity(img_alt_cancel_night , value, "LOG", 0.04)             

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------
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
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
-----------------------------------------------------------------

-------------------
--- FDC Buttons ---
-------------------
function FD1_Engage()
    fs2020_variable_write("L:ASCRJ_FCP_FD1","Number",1)sound_play(snd_click)
    timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_FD1","Number",0) end)
end
       FD1 = button_add(nil, "button_pressed.png", 79,117,50,34, FD1_Engage)

function AP_Engage()
        fs2020_variable_write("L:ASCRJ_FCP_AP_ENG","Number",1) sound_play(snd_click)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_AP_ENG","Number",0) end) 
end
	AP_ENG = button_add(nil, "button_pressed.png", 212,33,50,34, AP_Engage)

function XFR_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_XFR","Number",1) sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_XFR","Number",0) end)
end
	xfr_btn = button_add(nil, "button_pressed.png", 355,33,50,34, XFR_Btn)
	
function TURB_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_TURB", "Number", 1.0 )sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_TURB","Number",0) end)
end
	turb_btn = button_add(nil, "button_pressed.png", 355,117,50,34, TURB_Btn)
	
function SPD_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_SPEED", "Number", 1) sound_play(snd_click)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_SPEED","Number",0) end)
end
	spd_btn = button_add(nil, "button_pressed.png", 473,33,50,34, SPD_Btn)
	
function APPR_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_APPR", "Number", 1)sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_APPR","Number",0) end)
end
	appr_btn = button_add(nil, "button_pressed.png", 583,33,50,34, APPR_Btn)

function BC_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_BC", "Number", 1)sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_BC","Number",0) end)
end
	bc_btn = button_add(nil, "button_pressed.png", 583,117,50,34, BC_Btn)

function HDG_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_HDG", "Number", 1)sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_HDG","Number",0) end)
	HDG_Led()
end
	hdg_btn = button_add(nil, "button_pressed.png", 694,33,50,34, HDG_Btn)
        
function NAV_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_NAV", "Number",1)sound_play(snd_click)
	 timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_NAV","Number",0) end)
end
	nav_btn = button_add(nil, "button_pressed.png", 803,33,50,34, NAV_Btn)
	
function BANK_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_12BANK", "Number", 1) sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_12BANK","Number",0) end)
end
	bank_btn = button_add(nil, "button_pressed.png", 803,117,50,34, BANK_Btn)

function ALT_Btn()
	ALT_Led()
	fs2020_variable_write("L:ASCRJ_FCP_ALT", "Number",1) sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_ALT","Number",0) end)	
end
	alt_btn = button_add(nil, "button_pressed.png", 913,33,50,34, ALT_Btn)
	

function VS_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_VS", "Number",1) sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_VS","Number",0) end)
end
	vs_btn = button_add(nil, "button_pressed.png", 1021,33,50,34, VS_Btn)
	
function VNAV_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_VNAV", "Number", 1) sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_VNAV","Number",0) end)
end
	vnav_btn = button_add(nil, "button_pressed.png", 1021,117,50,34, VNAV_Btn)	
	
function FD2_Btn()
	fs2020_variable_write("L:ASCRJ_FCP_FD2", "Number", 1) sound_play(snd_click)
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_FD2","Number",0) end)
end
	fd2_btn = button_add(nil, "button_pressed.png", 1332,117,50,34, FD2_Btn)

-- Toggle the AP disconnect switch and disable the AP ENG button
function AP_Disc(position)
    fs2020_variable_write("L:ASCRJ_FCP_AP_DISC", "Number", 5)
    if position == 0 then
        fs2020_variable_write("L:ASCRJ_FCP_AP_DISC", "Number", 1)
    else
        fs2020_variable_write("L:ASCRJ_FCP_AP_DISC", "Number", 0)
    end
    sound_play(snd_click)  
end
ap_disc = switch_add(nil,nil, 173,104,150,78, AP_Disc)

function ss_ap_disc(status)
    if status == 0 then
        move(img_ap_disc, 180,104,nil,nil,'LINEAR', 0.05)
        move(img_ap_disc_night, 180,104,nil,nil,'LINEAR', 0.05)   
        switch_set_position(ap_disc, 0)     
    else
        move(img_ap_disc, 180,134,nil,nil,'LINEAR', 0.05)    
        move(img_ap_disc_night, 180,134,nil,nil,'LINEAR', 0.05)      
        switch_set_position(ap_disc, 1)            
    end
end
fs2020_variable_subscribe("ASCRJ_FCP_AP_DISC", "Feet", ss_ap_disc)

------- Knobs -------
local local_knob_crs1 = 0
function CRS1(dir)
    if dir == -1 then
        local_knob_crs1 = local_knob_crs1-1
        rotate(img_dial_crs1, (local_knob_crs1)*5)
        rotate(img_dial_crs1_night, (local_knob_crs1)*5)        
        fs2020_variable_write("L:ASCRJ_FCP_CRS1_CHANGE","Number",-1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_CRS1_CHANGE","Number",0)end)
        sound_play(snd_click)
    elseif dir == 1 then
        local_knob_crs1 = local_knob_crs1+1
        rotate(img_dial_crs1, (local_knob_crs1)*5)    
        rotate(img_dial_crs1_night, (local_knob_crs1)*5)        
        fs2020_variable_write("L:ASCRJ_FCP_CRS1_CHANGE","Number",1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_CRS1_CHANGE","Number",0)end)
        sound_play(snd_click)
    end
end    
crs1_dial = dial_add(nil, 62,22, 80, 80, CRS1)

local local_knob_speed = 0
function SPEED(dir)
    if dir == -1 then
        local_knob_speed = local_knob_speed-1
        rotate(img_dial_speed, (local_knob_speed)*5)
        rotate(img_dial_speed_night, (local_knob_speed)*5)      
        fs2020_variable_write("L:ASCRJ_FCP_SPEED_CHANGE","Number",-1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_SPEED_CHANGE","Number",0)end)
        sound_play(snd_click)
    elseif dir == 1 then
        local_knob_speed = local_knob_speed+1
        rotate(img_dial_speed, (local_knob_speed)*5)    
        rotate(img_dial_speed_night, (local_knob_speed)*5)      
        fs2020_variable_write("L:ASCRJ_FCP_SPEED_CHANGE","Number",1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_SPEED_CHANGE","Number",0)end)
        sound_play(snd_click)
    end
end    
spd_dial = dial_add(nil, 460, 95, 80, 80, SPEED)

local local_knob_hdg = 0
function HDG(dir)
    if dir == -1 then
        local_knob_hdg = local_knob_hdg-1
        rotate(img_dial_hdg, (local_knob_hdg)*5)
        rotate(img_dial_hdg_night, (local_knob_hdg)*5)          
        fs2020_variable_write("L:ASCRJ_FCP_HDG_CHANGE","Number",-1)sound_play(snd_click)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_HDG_CHANGE","Number",0)end)
    elseif dir == 1 then
        local_knob_hdg = local_knob_hdg+1
        rotate(img_dial_hdg, (local_knob_hdg)*5)    
        rotate(img_dial_hdg_night, (local_knob_hdg)*5)          
        fs2020_variable_write("L:ASCRJ_FCP_HDG_CHANGE","Number",1)sound_play(snd_click)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_HDG_CHANGE","Number",0)end)
    end
end    
hdg_dial = dial_add(nil, 682,100, 75, 75, 0.1, HDG)	

local local_knob_alt = 0
function ALT(dir)
    if dir == -1 then
        local_knob_alt = local_knob_alt-1
        rotate(img_dial_alt, (local_knob_alt)*5)
        rotate(img_dial_alt_night, (local_knob_alt)*5)      
        fs2020_variable_write("L:ASCRJ_FCP_ALT_CHANGE", "Number",-1.0)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_ALT_CHANGE","Number",0)end)
        sound_play(snd_click)
    elseif dir == 1 then
        local_knob_alt = local_knob_alt+1
        rotate(img_dial_alt, (local_knob_alt)*5)    
        rotate(img_dial_alt_night, (local_knob_alt)*5)              
        fs2020_variable_write("L:ASCRJ_FCP_ALT_CHANGE", "Number",1.0)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_ALT_CHANGE","Number",0)end)
        sound_play(snd_click)
    end
end    
alt_dial = dial_add(nil, 905,100, 75, 75, ALT)	

local local_knob_crs2  = 0
function CRS2(dir)
    if dir == -1 then
        local_knob_crs2 = local_knob_crs2-1
        rotate(img_dial_crs2, (local_knob_crs2)*5)
        rotate(img_dial_crs2_night, (local_knob_crs2)*5)            
        fs2020_variable_write("L:ASCRJ_FCP_CRS2_CHANGE","Number",-1.0) 
	timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_CRS2_CHANGE","Number",0)end)	
	sound_play(snd_click)
    elseif dir == 1 then
        local_knob_crs2 = local_knob_crs2+1
        rotate(img_dial_crs2, (local_knob_crs2)*5)    
        rotate(img_dial_crs2_night, (local_knob_crs2)*5)       
        fs2020_variable_write("L:ASCRJ_FCP_CRS2_CHANGE","Number",1.0) 
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_CRS2_CHANGE","Number",0)end)
        sound_play(snd_click)
    end
end    
crs2_dial = dial_add(nil, 1320, 25, 75, 75, CRS2)

-------- Vertical Speed Wheel --------
if user_prop_get(prop_VSDialorButtons) then
        function cb_VS_DEC() --VS DEC    
           fs2020_event("AP_VS_VAR_DEC")
           sound_play(snd_dial)
        end
        button_add(nil,"button_pressed.png", 1140, 26, 35, 65, cb_VS_DEC) 
        function cb_VS_INC()     --VS INC  
           fs2020_event("AP_VS_VAR_INC")
           sound_play(snd_dial)
        end
        button_add(nil,"button_pressed.png", 1140, 91, 35, 65, cb_VS_INC)     
    else  
        function cb_V_Speed(dir)
            if dir == 1 then
    	        fs2020_variable_write("L:ASCRJ_FCP_WHEEL_CHANGE","Number",1)
                timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_WHEEL_CHANGE","Number",0)end)	    
            elseif dir == -1 then
                fs2020_variable_write("L:ASCRJ_FCP_WHEEL_CHANGE","Number",-1)
                timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_WHEEL_CHANGE","Number",0)end)	     
            end
            sound_play(snd_dial)            
    end
    dial_VS =dial_add(nil, 1143, 25, 45, 130, cb_V_Speed)
end

---------------------------	
-- LED lights for button --
---------------------------    
function AP_Led(status)
    if status == 0 then
        visible(AP_led1, false)
        visible(AP_led2, false)
    else
        visible(AP_led1, true)
        visible(AP_led2, true)
    end
end        
    
    AP_led1 = img_add("led1.png", 189, 42, 18, 18)
    AP_led2 = img_add("led2.png", 267, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_AP_ENG_LED", "Number", AP_Led)
    
function SPD_Led(status)
	if status == 0 then
        visible(SPD_led1, false)
        visible(SPD_led2, false)
    else
        visible(SPD_led1, true)
        visible(SPD_led2, true)
    end
end

    SPD_led1 = img_add("led1.png", 453, 42, 18, 18)
    SPD_led2 = img_add("led2.png", 525, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_SPEED_LED", "Number", SPD_Led)
	
function BC_Led(status)
	if status == 0 then
        visible(BC_led1, false)
        visible(BC_led2, false)
    else
        visible(BC_led1, true)
        visible(BC_led2, true)
    end
end

    BC_led1 = img_add("led1.png", 564, 124, 18, 18)
    BC_led2 = img_add("led2.png", 634, 124, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_BC_LED", "Number", BC_Led)
    
function XFR_Led(status)
    if status == 0 then
        visible(XFR_led1, false)
        visible(XFR_led2, false)
    else
        visible(XFR_led1, true)
        visible(XFR_led2, true)
    end
end        
    
    XFR_led1 = img_add("led1.png", 334, 42, 18, 18)
    XFR_led2 = img_add("led2.png", 407, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_XFR_LED", "Number", XFR_Led)
    
function TURB_Led(status)
    if status == 0 then
        visible(TURB_led1, false)
        visible(TURB_led2, false)
    else
        visible(TURB_led1, true)
        visible(TURB_led2, true)
    end
end        
    
    TURB_led1 = img_add("led1.png", 334, 124, 18, 18)
    TURB_led2 = img_add("led2.png", 407, 124, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_TURB_LED", "Number", TURB_Led)
    
function APPR_Led(status)
    if status == 0 then
        visible(APPR_led1, false)
        visible(APPR_led2, false)
    else
        visible(APPR_led1, true)
        visible(APPR_led2, true)
    end
end        
    
    APPR_led1 = img_add("led1.png", 564, 42, 18, 18)
    APPR_led2 = img_add("led2.png", 634, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_APPR_LED", "Number", APPR_Led)

function HDG_Led(led)
    
    if led == 0 then
        visible(HDG_led1, false)
        visible(HDG_led2, false)
    else
        visible(HDG_led1, true)
        visible(HDG_led2, true)
    end
end        
    
    HDG_led1 = img_add("led1.png", 674, 42, 18, 18)
    HDG_led2 = img_add("led2.png", 745, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_HDG_LED", "Number",HDG_Led)
    
function NAV_Led(status)
    if status == 0 then
        visible(NAV_led1, false)
        visible(NAV_led2, false)
    else
        visible(NAV_led1, true)
        visible(NAV_led2, true)
    end
end        
    
    NAV_led1 = img_add("led1.png", 782, 42, 18, 18)
    NAV_led2 = img_add("led2.png", 854, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_NAV_LED", "Number", NAV_Led) 
    
function BANK_Led(status)
    if status == 0 then
        visible(BANK_led1, false)
        visible(BANK_led2, false)
    else
        visible(BANK_led1, true)
        visible(BANK_led2, true)
    end
end        
    
    BANK_led1 = img_add("led1.png", 782, 124, 18, 18)
    BANK_led2 = img_add("led2.png", 854, 124, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_12BANK_LED", "Number", BANK_Led) 
    
function ALT_Led(status)
    if status == 0 then
        visible(ALT_led1, false)
        visible(ALT_led2, false)
    else
        visible(ALT_led1, true)
        visible(ALT_led2, true)
    end
end        
    
    ALT_led1 = img_add("led1.png", 891, 42, 18, 18)
    ALT_led2 = img_add("led2.png", 962, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_ALT_LED", "Number", ALT_Led)
    
function VS_Led(status)
    if status == 0 then
        visible(VS_led1, false)
        visible(VS_led2, false)
    else
        visible(VS_led1, true)
        visible(VS_led2, true)
    end
end        
    
    VS_led1 = img_add("led1.png", 1001, 42, 18, 18)
    VS_led2 = img_add("led2.png", 1071, 42, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_VS_LED", "Number", VS_Led)
    
function VNAV_Led(status)
    if status == 0 then
        visible(VNAV_led1, false)
        visible(VNAV_led2, false)
    else
        visible(VNAV_led1, true)
        visible(VNAV_led2, true)
    end
end        
    
    VNAV_led1 = img_add("led1.png", 1001, 124, 18, 18)
    VNAV_led2 = img_add("led2.png", 1071, 124, 18, 18)
    fs2020_variable_subscribe("L:ASCRJ_FCP_VNAV_LED", "Number", VNAV_Led)	        		    		                		    		        		    		
-----------------------------------------------
-------- PUSH FUNCTIONS -----------------------
-----------------------------------------------

function CRS1_Direct()
	fs2020_variable_write("L:ASCRJ_FCP_CRS1_DIRECT", "Number", 1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_CRS1_DIRECT","Number",0)end)	
	sound_play(snd_click)
end
	crs1_push = button_add(nil, "circle_pressed.png",  78, 36, 49, 49, CRS1_Direct)
	
function CRS2_Direct()
	fs2020_variable_write("L:ASCRJ_FCP_CRS2_DIRECT", "Number", 1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_CRS2_DIRECT","Number",0)end)	
	sound_play(snd_click)
end
	crs2_push = button_add(nil,"circle_pressed.png", 1333, 36, 49, 49, CRS2_Direct)

function Cancel()
	fs2020_variable_write("L:ASCRJ_FCP_ALT_CANCEL", "Number", 1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_ALT_CANCEL","Number",0)end)		
	sound_play(snd_click)
end
	cncl_push = button_add(nil, "circle_pressed.png", 915, 109, 49, 49, Cancel)	

function SYNC()
	fs2020_variable_write("L:ASCRJ_FCP_HDG_SYNC", "Number", 1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_HDG_SYNC","Number",0)end)		
	sound_play(snd_click)
end
	sync_push = button_add(nil, "circle_pressed.png", 696, 109, 49, 49, SYNC)

function IAS_MACH()
	fs2020_variable_write("L:ASCRJ_FCP_IAS_MACH", "Number", 1)
        timer_start(button_delay, function() fs2020_variable_write("L:ASCRJ_FCP_IAS_MACH","Number",0)end)		
	sound_play(snd_click)
end
	ias_mach_push = button_add(nil, "circle_pressed.png", 476, 109, 49, 49, IAS_MACH)	