--[[
Modification of the Sim Innovations G1000 bezel by Russ Barlow.

Better overall behaviour with MSFS 2020 and the Working Title G1000 NXi

X-Plane compatiblity unaltered and original Sim Innovations / Russ Barlow code

- Improved graphics
- VNAV with Working Title G1000 NXi functions
- Added detection of VS and FLC states for improved behaviour of Nose Up / Down keys
- Changed behaviours to better function post MSFS Sim Update 5



***************CHANGE LOG

02-09-2021 - Added fix for FLC not working with Working TItle G1000 NXi 0.5.0 (Joe Gilker)

]]--

-- Select whether this unit is in position 1 or two.  If you need two G530s clone this instrument, rename it, and change the variable 
if instrument_prop("PLATFORM") == "RASPBERRY_PI" or instrument_prop("PLATFORM") == "ANDROID" or instrument_prop("PLATFORM") == "IPAD" then
    canvas_add(189, 47, 1034, 775, function()
        _rect(0,0,1034,775)
        _fill("black")
    end)
    canv_message = canvas_add(189, 47, 1034, 775, function()
        _rect(0,0,1034,775)
        _fill("blue")
        _txt("THIS X-PLANE 11 AND FS2020 GPS OVERLAY", "font:roboto_bold.ttf; size:70; color: white; halign:center;", 517, 298)
        _txt("WORKS ON THE DESKTOP ONLY", "font:roboto_bold.ttf; size:70; color: white; halign:center;", 517, 348)
        _txt("BUTTONS AND DIALS STILL WORK", "font:roboto_bold.ttf; size:70; color: white; halign:center;", 517, 398)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:70; color: white; halign:center;", 517, 448)
    end)
    butn_hide = button_add(nil, nil, 189, 47, 1034, 775, function()
        visible(canv_message, false)
        visible(butn_hide, false)
    end)
end

display_pos = user_prop_add_enum("Display unit function","Pilot PFD,Copilot PFD,MFD","Pilot PFD","Select unit functional position")

local g_unitpos = nil
local fs_mode = nil
local gbl_fs_ap_alt = 0
local gbl_heading = 0

bezel_prop = user_prop_add_boolean("Autopilot", true, "Show autopilot controls") -- Show or hide the autopilot controls

if user_prop_get(display_pos) == "Pilot PFD" then
    g_unitpos = "1"
    fs_mode = "PFD"
elseif user_prop_get(display_pos) == "Copilot PFD" then
    g_unitpos = "2"
    fs_mode = "PFD"
else
    g_unitpos = "3"
    fs_mode = "MFD"
end



if user_prop_get(bezel_prop) then
    img_add_fullscreen("background.png")
else
    img_add_fullscreen("background_noap.png")
end
-- Garmin Top Bezel Logo
    image_id = img_add("garmin-logo-white.png",655,11,100,23)
-- End Bezel Logo

sound_prop = user_prop_add_boolean("Sound", true, "Play button sound")

        
if user_prop_get(sound_prop) then
    click_snd = sound_add("knobclick.wav")
else
    click_snd = sound_add("knobclick_silent.wav")
end

function nav_ff()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav_ff")
    fs2020_event("H:AS1000_PFD_NAV_Switch")
    sound_play(click_snd)
end

button_add(nil,"ff_button.png", 102,107,50,32, nav_ff)

function com_ff()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_com_ff")
    fs2020_event("H:AS1000_PFD_COM_Switch")
    sound_play(click_snd)
end

button_add(nil,"ff_button.png", 1259,107,50,32, com_ff)

function ap_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_ap")
    fs2020_event("AP_MASTER")
    sound_play(click_snd)
end

button_ap = button_add(nil,"ap_button.png", 28,470,50,32, ap_click)
visible(button_ap, user_prop_get(bezel_prop))

function hdg_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_hdg")
    fs2020_event("AP_PANEL_HEADING_HOLD")
    sound_play(click_snd)
end

button_hdg = button_add(nil,"hdg_button.png", 28,520,50,32, hdg_click)
visible(button_hdg, user_prop_get(bezel_prop))

function nav_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav")
    fs2020_event("AP_NAV1_HOLD")
    sound_play(click_snd)
end

button_nav = button_add(nil,"nav_button.png", 28,570,50,32, nav_click)
visible(button_nav, user_prop_get(bezel_prop))

function apr_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_apr")
    fs2020_event("AP_APR_HOLD")
    sound_play(click_snd)
end

button_apr = button_add(nil,"apr_button.png", 28,621,50,32, apr_click)
visible(button_apr, user_prop_get(bezel_prop))

function vs_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_vs")
    fs2020_event("AP_PANEL_VS_HOLD")
    sound_play(click_snd)
end

button_vs = button_add(nil,"vs_button.png", 28,671,50,32, vs_click)
visible(button_vs, user_prop_get(bezel_prop))


--Determine state of autopilot - FLC or VS 
-- Used to determine function of Nose up / down buttons

function flc_callback(flcstate)
    FLCState = flcstate 
    return FLCState    
end
        
function vs_callback(vsenabled)
    VSenabled = vsenabled  
    return VSenabled    
end

fs2020_variable_subscribe("AUTOPILOT FLIGHT LEVEL CHANGE", "bool", flc_callback)  
 fs2020_variable_subscribe("AUTOPILOT VERTICAL HOLD", "bool", vs_callback)

    function flc_click()
    
        sound_play(click_snd)sound_play(click_snd)
       -- fs2020_event("FLIGHT_LEVEL_CHANGE")
    
        if FLCState then  --check if FLC is currently on
            fs2020_event("FLIGHT_LEVEL_CHANGE_OFF")    --For stock G1000
            fs2020_event("FLIGHT_LEVEL_CHANGE")            --for WT G1000 NXi
        else    -- if FLC currently off
            AirspeedDecimal = math.floor(AirspeedIndicated)        -- read current airspeed and convert variable
            fs2020_event("FLIGHT_LEVEL_CHANGE_ON")                --For stock G1000
            fs2020_event("FLIGHT_LEVEL_CHANGE")                        --for WT G1000 NXi
            fs2020_event("AP_SPD_VAR_SET", AirspeedDecimal)    -- set FLC speed to current airspeed
        end
    end

	function aspd_callback(asindicated)
		AirspeedIndicated = asindicated  
		return AirspeedIndicated    
	end

fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", aspd_callback)
-- End required code for proper FLC speed capture and set


button_flc = button_add(nil,"flc_button.png", 26,721,54,32, flc_click)
visible(button_flc, user_prop_get(bezel_prop))

function fd_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_fd")
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")
    sound_play(click_snd)
end

button_fd = button_add(nil,"fd_button.png", 100,470,50,32, fd_click)
visible(button_fd, user_prop_get(bezel_prop))

function alt_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_alt")
    fs2020_event("AP_PANEL_ALTITUDE_HOLD")
    sound_play(click_snd)
end

button_alt = button_add(nil,"alt_button.png", 100,520,50,32, alt_click)
visible(button_alt, user_prop_get(bezel_prop))

--VNAV SWITCH FOR WORKING TITLE G1000 NXi

function vnv_state_callback(vnvval)
    VNAVState = vnvval
    return VNAVState
end
  print(VNAVState)
fs2020_variable_subscribe("L:XMLVAR_VNAVButtonValue", "number", vnv_state_callback)


function vnv_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_vnv")
 
    if VNAVState == 1 then
      fs2020_variable_write("L:XMLVAR_VNAVButtonValue", "Number", 0)
    else
      fs2020_variable_write("L:XMLVAR_VNAVButtonValue", "Number", 1)
    end
    
    sound_play(click_snd)
end

button_vnv = button_add(nil,"vnv_button.png", 98,570,54,32, vnv_click)
visible(button_vnv, user_prop_get(bezel_prop))

function bc_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_bc")
    fs2020_event("AP_BC_HOLD")
    sound_play(click_snd)
end

button_bc = button_add(nil,"bc_button.png", 98,621,54,32, bc_click)
visible(button_bc, user_prop_get(bezel_prop))

function nosup_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_nose_up")
   -- fs2020_event("AP_VS_VAR_INC")
    if VSenabled then
            fs2020_event("AP_VS_VAR_INC")
        else 
            fs2020_event("AP_SPD_VAR_DEC")
        end
    sound_play(click_snd)
end

button_nosup = button_add(nil,"nsup_button.png", 100,671,50,32, nosup_click)
visible(button_nosup, user_prop_get(bezel_prop))

function nosdn_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_nose_down")
  --   fs2020_event("AP_VS_VAR_DEC")
    if VSenabled then
            fs2020_event("AP_VS_VAR_DEC")
        else 
           fs2020_event("AP_SPD_VAR_INC")
        end 
    sound_play(click_snd)
end

button_nosdn = button_add(nil,"nsdn_button.png", 100,721,50,32, nosdn_click)
visible(button_nosdn, user_prop_get(bezel_prop))

function sc_1_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey1")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_1")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 213,852,50,32, sc_1_click)

function sc_2_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey2")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_2")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 297,852,50,32, sc_2_click)

function sc_3_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey3")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_3")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 383,852,50,32, sc_3_click)

function sc_4_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey4")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_4")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 468,852,50,32, sc_4_click)

function sc_5_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey5")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_5")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 554,852,50,32, sc_5_click)

function sc_6_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey6")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_6")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 640,852,50,32, sc_6_click)

function sc_7_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey7")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_7")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 724,852,50,32, sc_7_click)

function sc_8_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey8")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_8")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 808,852,50,32, sc_8_click)

function sc_9_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey9")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_9")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 892,852,50,32, sc_9_click)

function sc_10_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey10")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_10")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 979,852,50,32, sc_10_click)

function sc_11_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey11")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_11")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 1064,852,50,32, sc_11_click)

function sc_12_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_softkey12")
    fs2020_event("H:AS1000_" .. fs_mode .. "_SOFTKEYS_12")
    sound_play(click_snd)
end

button_add(nil,"uparrow_button.png", 1149,852,50,32, sc_12_click)

function dir_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_direct")
    fs2020_event("H:AS1000_" .. fs_mode .. "_DIRECTTO")
    sound_play(click_snd)
end

button_add(nil,"dir_button.png", 1262,621,50,32, dir_click)

function menu_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_menu")
    fs2020_event("H:AS1000_" .. fs_mode .. "_MENU_Push")
    sound_play(click_snd)
end

button_add(nil,"menu_button.png", 1334,621,50,32, menu_click)

function fpl_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_fpl")
    fs2020_event("H:AS1000_" .. fs_mode .. "_FPL_Push")
    sound_play(click_snd)
end

button_add(nil,"fpl_button.png", 1262,673,50,32, fpl_click)

function proc_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_proc")
    fs2020_event("H:AS1000_" .. fs_mode .. "_PROC_Push")
    sound_play(click_snd)
end

button_add(nil,"proc_button.png", 1334,673,50,32, proc_click)

function clr_click_down()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_clr", 1)
    fs2020_event("H:AS1000_" .. fs_mode .. "_CLR_Long")
    --[[
    timer_fs2020_clear = timer_start(2000, function()
        fs2020_event("H:AS1000_" .. fs_mode .. "_CLR_Long")
    end)
        fs2020_event("G1000_" .. fs_mode .. "_CLEAR_BUTTON")
    ]]--
    sound_play(click_snd)
end

function clr_click_up()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_clr", 0)
    fs2020_event("H:AS1000_" .. fs_mode .. "_CLR")
    --[[
    
    if timer_running(timer_fs2020_clear) then
        timer_stop(timer_fs2020_clear)
        fs2020_event("H:AS1000_" .. fs_mode .. "_MFD_CLR")
    end
    ]]--
    sound_play(click_snd)
end

button_add(nil,"clr_button.png", 1262,725,50,32, clr_click_down, clr_click_up)

function ent_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_ent")
    fs2020_event("H:AS1000_" .. fs_mode .. "_ENT_Push")
    sound_play(click_snd)
end

button_add(nil,"ent_button.png", 1334,725,50,32, ent_click)

function alt_outer_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_alt_outer_down")
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", gbl_fs_ap_alt - 1000)
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_alt_outer_up")
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", gbl_fs_ap_alt + 1000)
    end
end

alt_dial_outer = dial_add("plain_knob_outer.png", 47,793,79,79, alt_outer_turn)
dial_click_rotate( alt_dial_outer, 6)

function alt_inner_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_alt_inner_down")
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", gbl_fs_ap_alt - 100)
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_alt_inner_up")
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", gbl_fs_ap_alt + 100)
    end
end

alt_dial_inner = dial_add("plain_knob_inner.png", 63,809,47,47, alt_inner_turn)
dial_click_rotate( alt_dial_inner, 6)

function nav_outer_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav_outer_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_NAV_Large_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav_outer_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_NAV_Large_INC")
    end
end

nav_dial_outer = dial_add("plain_knob_outer.png", 47,173,79,79, nav_outer_turn)
dial_click_rotate(nav_dial_outer, 6)

function nav_inner_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav_inner_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_NAV_Small_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav_inner_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_NAV_Small_INC")
    end
end

nav_dial_inner = dial_add("plain_knob_inner.png", 63,189,47,47, nav_inner_turn)
dial_click_rotate(nav_dial_outer, 6)

function nav_swap_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_nav12")
    fs2020_event("H:AS1000_" .. fs_mode .. "_NAV_Push")
    sound_play(click_snd)
end

button_add(nil,nil, 75,204,13,13, nav_swap_click)

function fms_outer_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_fms_outer_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_FMS_Lower_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_fms_outer_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_FMS_Lower_INC")
    end
end

fms_dial_outer = dial_add("plain_knob_outer.png", 1283,793,79,79, fms_outer_turn)
dial_click_rotate( fms_dial_outer, 6)

function fms_inner_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_fms_inner_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_FMS_Upper_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_fms_inner_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_FMS_Upper_INC")
    end
end

fms_dial_inner = dial_add("plain_knob_inner.png", 1299,809,47,47, fms_inner_turn)
dial_click_rotate( fms_dial_outer, 6)

function cursor_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_cursor")
    fs2020_event("H:AS1000_" .. fs_mode .. "_FMS_Upper_PUSH")
    sound_play(click_snd)
end

button_add(nil,nil, 1311,821,13,13, cursor_click)

function com_outer_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_com_outer_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_COM_Large_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_com_outer_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_COM_Large_INC")
    end
end

com_dial_outer = dial_add("plain_knob_outer.png", 1282,173,79,79, com_outer_turn)
dial_click_rotate( com_dial_outer, 6)

function com_inner_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_com_inner_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_COM_Small_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_com_inner_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_COM_Small_INC")
    end

end

com_dial_inner = dial_add("plain_knob_inner.png", 1298,189,47,47, com_inner_turn)
dial_click_rotate( com_dial_inner, 6)

function com_swap_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_com12")
    fs2020_event("H:AS1000_" .. fs_mode .. "_COM_Push")
    sound_play(click_snd)
end

button_add(nil,nil, 1313,204,13,13, com_swap_click)

-- add click to select 
function com_vol_press()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_cvol")
end

comvol_dial = button_add("vol_knob.png","vol_knob_prs.png", 1297,44,50,50, com_vol_press)

-- add click to select 
function nav_vol_press()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_nvol")
end

navvol_dial = button_add("vol_knob.png","vol_knob_prs.png", 62,44,50,50, nav_vol_press)

-- Pan pallette
local pal_x = 1229
local pal_y =  432

function up_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_up")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_UP")
end

up_press = button_add(nil, "up_arrow.png", pal_x + 69, pal_y + 0, 49,42, up_prs)

function up_rt_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_up_right")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_RIGHT")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_UP")
end

uprt_press = button_add(nil, "uprt_arrow.png", pal_x + 118, pal_y + 25, 46,48, up_rt_prs)

function up_lt_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_up_left")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_LEFT")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_UP")
end

uplt_press = button_add(nil, "uplt_arrow.png", pal_x + 22, pal_y + 25, 47,47, up_lt_prs)

function lt_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_left")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_LEFT")
end

lt_press = button_add(nil, "lt_arrow.png", pal_x + 0, pal_y + 74, 44,46, lt_prs)

function rt_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_right")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_RIGHT")
end

rt_press = button_add(nil, "rt_arrow.png", pal_x + 146, pal_y + 74, 44,46, rt_prs)

function dn_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_down")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_DOWN")
end

dn_press = button_add(nil, "down_arrow.png", pal_x + 69, pal_y + 148, 49,42, dn_prs)

function dnrt_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_down_right")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_RIGHT")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_DOWN")
end

dnrt_press = button_add(nil, "downrt_arrow.png", pal_x + 118, pal_y + 120, 46,48, dnrt_prs)

function dnlt_prs()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_down_left")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_LEFT")
    fs2020_event("H:AS1000_" .. fs_mode .. "_JOYSTICK_DOWN")
end

dnlt_press = button_add(nil, "downlt_arrow.png", pal_x + 22, pal_y + 120, 47,47, dnlt_prs)

pan_background = img_add("pan_background.png", pal_x ,pal_y,190,190)
local pan_vis = false
visible(pan_background, pan_vis)

function range_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_range_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_RANGE_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_range_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_RANGE_INC")
    end
end

rng_dial = dial_add("rng_knob.png", 1291,497,65,65, range_turn)
dial_click_rotate( rng_dial, 6)

function pansel_click()
    pan_vis = not pan_vis
    visible(pan_background, pan_vis)
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_pan_push")
    if pan_vis then
        fs2020_event("H:AS1000_" .. fs_mode .. "_ActivateMapCursor")
    else
        fs2020_event("H:AS1000_" .. fs_mode .. "_DeactivateMapCursor")
    end
    sound_play(click_snd)
end

button_add(nil,nil, 1313,519,21,21, pansel_click)

-- add pan controls
function hdg_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_hdg_down")
        fs2020_event("HEADING_BUG_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_hdg_up")
        fs2020_event("HEADING_BUG_INC")
    end
end

hdg_dial = dial_add("hdg_knob.png", 47,340,80,80,3, hdg_turn)
dial_click_rotate( hdg_dial, 6)

function hdg_click()--_hdg_down
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_hdg_sync")
    fs2020_event("HEADING_BUG_SET", gbl_heading)
    sound_play(click_snd)
end

button_add(nil,nil, 77,370,20,20,hdg_click)

function baro_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_baro_down")
        fs2020_event("KOHLSMAN_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_baro_up")
        fs2020_event("KOHLSMAN_INC")
    end
end

baro_dial  = dial_add("baro_knob.png", 1282,335,80,80, baro_turn)
dial_click_rotate( baro_dial, 6)

function crs_turn( direction)
    if direction ==  -1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_crs_down")
        fs2020_event("H:AS1000_" .. fs_mode .. "_CRS_DEC")
    elseif direction == 1 then
        xpl_command("sim/GPS/g1000n"..g_unitpos.."_crs_up")
        fs2020_event("H:AS1000_" .. fs_mode .. "_CRS_INC")
    end
end

crs_dial = dial_add("crs_knob.png", 1296,351,51,51,3, crs_turn)
dial_click_rotate( crs_dial, 6)

function crs_click()
    xpl_command("sim/GPS/g1000n"..g_unitpos.."_crs_sync")
    fs2020_event("H:AS1000_" .. fs_mode .. "_CRS_PUSH")
    sound_play(click_snd)
end

button_add(nil,nil, 1315,370,13,13, crs_click)

fs2020_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR", "Feet", 
                          "PLANE HEADING DEGREES MAGNETIC", "Degrees", function(ap_alt, heading)
    gbl_fs_ap_alt = ap_alt
    gbl_heading = math.floor(heading + 0.5)
end)