--[[
******************************************************************************************
******************Fenix A320 FMS MCDU Overlay*****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
BETA 0.1 - 05/31/2022

	
##Notes:
    -   THIS MCDU WILL ONLY WORK WITH THE FENIX A320
    
    -    This is an early beta release so you guys have something 
          functional to use now. Further enhancements like proper 
          button press states and dimming may come at a later date. 

******************************************************************************************        
--]]

-- Set up user properties
-- Is unit on Pilot or First Officer side
display_pos = user_prop_add_enum("Panel Position", "Pilot MCDU,First Officer MCDU", "Pilot MCDU", "Select unit functional position")

if user_prop_get(display_pos) == "Pilot MCDU" then
   unitpos = "S_CDU1"
else
   unitpos = "S_CDU2"
end

--Backgroud Image 
img_add_fullscreen("background.png")

--Sounds   
snd_click = sound_add("click.wav")

--Button Graphics
    SelectorButtonPressed    = "selector_btn_pressed.png"
    DIRButtonPressed         = "dir_btn_pressed.png"
    PROGButtonPressed        = "prog_btn_pressed.png"
    PERFButtonPressed        = "perf_btn_pressed.png"
    INITButtonPressed        = "init_btn_pressed.png"
    DATAButtonPressed        = "data_btn_pressed.png"
    FPLNButtonPressed        = "fpln_btn_pressed.png"
    RAD_NAVButtonPressed     = "rad_nav_btn_pressed.png"
    FUEL_PREDButtonPressed   = "fuel_pred_btn_pressed.png"
    SEC_FPLNButtonPressed    = "sec_fpln_btn_pressed.png"
    ATC_COMButtonPressed     = "atc_com_btn_pressed.png"
    MCDU_MENUButtonPressed   = "mcdu_menu_btn_pressed.png"
    AIRPORTButtonPressed     = "airport_btn_pressed.png"
    ARROW_UPButtonPressed    = "arrow_up_btn_pressed.png"
    ARROW_DOWNButtonPressed  = "arrow_down_btn_pressed.png"
    ARROW_LEFTButtonPressed  = "arrow_left_btn_pressed.png"
    ARROW_RIGHTButtonPressed = "arrow_right_btn_pressed.png"
    CLRButtonPressed         = "clr_btn_pressed.png"
    BRTButtonPressed         = "brt_btn_pressed.png"
    DIMButtonPressed         = "dim_btn_pressed.png"
    OVFYButtonPressed        = "ovfy_btn_pressed.png"
    DIVButtonPressed         = "div_btn_pressed.png"
    
    AButtonPressed = "a_btn_pressed.png"
    BButtonPressed = "b_btn_pressed.png"
    CButtonPressed = "c_btn_pressed.png"
    DButtonPressed = "d_btn_pressed.png"
    EButtonPressed = "e_btn_pressed.png"
    FButtonPressed = "f_btn_pressed.png"
    GButtonPressed = "g_btn_pressed.png"
    HButtonPressed = "h_btn_pressed.png"
    IButtonPressed = "i_btn_pressed.png"
    JButtonPressed = "j_btn_pressed.png"
    KButtonPressed = "k_btn_pressed.png"
    LButtonPressed = "l_btn_pressed.png"
    MButtonPressed = "m_btn_pressed.png"
    NButtonPressed = "n_btn_pressed.png"
    OButtonPressed = "o_btn_pressed.png"
    PButtonPressed = "p_btn_pressed.png"
    QButtonPressed = "q_btn_pressed.png"
    RButtonPressed = "r_btn_pressed.png"
    SButtonPressed = "s_btn_pressed.png"
    TButtonPressed = "t_btn_pressed.png"
    UButtonPressed = "u_btn_pressed.png"
    VButtonPressed = "v_btn_pressed.png"
    WButtonPressed = "w_btn_pressed.png"
    XButtonPressed = "x_btn_pressed.png"
    YButtonPressed = "y_btn_pressed.png"
    ZButtonPressed = "z_btn_pressed.png"

    ONEButtonPressed       = "one_btn_pressed.png"
    TWOButtonPressed       = "two_btn_pressed.png"
    THREEButtonPressed     = "three_btn_pressed.png"
    FOURButtonPressed      = "four_btn_pressed.png"
    FIVEButtonPressed      = "five_btn_pressed.png"
    SIXButtonPressed       = "six_btn_pressed.png"
    SEVENButtonPressed     = "seven_btn_pressed.png"
    EIGHTButtonPressed     = "eight_btn_pressed.png"
    NINEButtonPressed      = "nine_btn_pressed.png"
    DOTButtonPressed       = "dot_btn_pressed.png"
    ZEROButtonPressed      = "zero_btn_pressed.png"
    PLUSMINUSButtonPressed = "plusminus_btn_pressed.png"
    SPButtonPressed        = "sp_btn_pressed.png"

--START OF BUTTONS************

--LSK1L Button
--Press
function FMC_1_BTN_LSK1L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK1L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK1L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK1L", "Num", 0)
end
button_add(nil,nil, 25,175,46,38, FMC_1_BTN_LSK1L_PRESS, FMC_1_BTN_LSK1L_RELEASE)
--LSK2L Button
--Press
function FMC_1_BTN_LSK2L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK2L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK2L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK2L", "Num", 0)
end
button_add(nil,nil, 25,245,46,38, FMC_1_BTN_LSK2L_PRESS, FMC_1_BTN_LSK2L_RELEASE)
--LSK3L Button
--Press
function FMC_1_BTN_LSK3L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK3L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK3L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK3L", "Num", 0)
end
button_add(nil,nil, 25,317,46,38, FMC_1_BTN_LSK3L_PRESS, FMC_1_BTN_LSK3L_RELEASE)
--LSK4L Button
--Press
function FMC_1_BTN_LSK4L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK4L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK4L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK4L", "Num", 0)
end
button_add(nil,nil, 25,391,46,38, FMC_1_BTN_LSK4L_PRESS, FMC_1_BTN_LSK4L_RELEASE)
--L5 Button
--Press
function FMC_1_BTN_LSK5L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK5L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK5L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK5L", "Num", 0)
end
button_add(nil,nil, 25,463,46,38, FMC_1_BTN_LSK5L_PRESS, FMC_1_BTN_LSK5L_RELEASE)
--LSK6L Button
--Press
function FMC_1_BTN_LSK6L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK6L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK6L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK6L", "Num", 0)
end
button_add(nil,nil, 25,533,46,38, FMC_1_BTN_LSK6L_PRESS, FMC_1_BTN_LSK6L_RELEASE)
--LSK1R Button
--Press
function FMC_1_BTN_LSK1R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK1R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK1R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK1R", "Num", 0)
end
button_add(nil,nil, 753,175,46,38, FMC_1_BTN_LSK1R_PRESS, FMC_1_BTN_LSK1R_RELEASE)
--LSK2R Button
--Press
function FMC_1_BTN_LSK2R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK2R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK2R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK2R", "Num", 0)
end
button_add(nil,nil, 753,245,46,38, FMC_1_BTN_LSK2R_PRESS, FMC_1_BTN_LSK2R_RELEASE)
--LSK3R Button
--Press
function FMC_1_BTN_LSK3R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK3R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK3R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK3R", "Num", 0)
end
button_add(nil,nil, 753,317,46,38, FMC_1_BTN_LSK3R_PRESS, FMC_1_BTN_LSK3R_RELEASE)
--LSK4R Button
--Press
function FMC_1_BTN_LSK4R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK4R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK4R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK4R", "Num", 0)
end
button_add(nil,nil, 753,391,46,38, FMC_1_BTN_LSK4R_PRESS, FMC_1_BTN_LSK4R_RELEASE)
--LSK5R Button
--Press
function FMC_1_BTN_LSK5R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK5R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK5R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK5R", "Num", 0)
end
button_add(nil,nil, 753,463,46,38, FMC_1_BTN_LSK5R_PRESS, FMC_1_BTN_LSK5R_RELEASE)
--LSK6R Button
--Press
function FMC_1_BTN_LSK6R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK6R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_LSK6R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_LSK6R", "Num", 0)
end
button_add(nil,nil, 753,533,46,38, FMC_1_BTN_LSK6R_PRESS, FMC_1_BTN_LSK6R_RELEASE)


--DIR Button
--Press
function FMC_1_BTN_DIR_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_DIR", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_DIR_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_DIR", "Num", 0)
end
button_add(nil,nil, 96,666,75,50, FMC_1_BTN_DIR_PRESS, FMC_1_BTN_DIR_RELEASE)
--PROG Button
--Press
function FMC_1_BTN_PROG_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_PROG", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_PROG_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_PROG", "Num", 0)
end
button_add(nil,nil, 199,666,75,50, FMC_1_BTN_PROG_PRESS, FMC_1_BTN_PROG_RELEASE)
--PERF Button
--Press
function FMC_1_BTN_PERF_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_PERF", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_PERF_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_PERF", "Num", 0)
end
button_add(nil,nil, 298,666,75,50, FMC_1_BTN_PERF_PRESS, FMC_1_BTN_PERF_RELEASE)
--INIT Button
--Press
function FMC_1_BTN_INIT_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_INIT", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_INIT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_INIT", "Num", 0)
end
button_add(nil,nil, 397,666,75,50, FMC_1_BTN_INIT_PRESS, FMC_1_BTN_INIT_RELEASE)
--DATA Button
--Press
function FMC_1_BTN_DATA_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_DATA", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_DATA_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_DATA", "Num", 0)
end
button_add(nil,nil, 499,666,75,50, FMC_1_BTN_DATA_PRESS, FMC_1_BTN_DATA_RELEASE)
--FPLN Button
--Press
function FMC_1_BTN_FPLN_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_FPLN", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_FPLN_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_FPLN", "Num", 0)
end
button_add(nil,nil, 96,734,75,50, FMC_1_BTN_FPLN_PRESS, FMC_1_BTN_FPLN_RELEASE)
--RAD_NAV Button
--Press
function FMC_1_BTN_RAD_NAV_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_RAD_NAV", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_RAD_NAV_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_RAD_NAV", "Num", 0)
end
button_add(nil,nil, 198,734,75,50, FMC_1_BTN_RAD_NAV_PRESS, FMC_1_BTN_RAD_NAV_RELEASE)
--FUEL_PRED Button
--Press
function FMC_1_BTN_FUEL_PRED_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_FUEL_PRED", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_FUEL_PRED_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_FUEL_PRED", "Num", 0)
end
button_add(nil,nil, 297,734,75,50, FMC_1_BTN_FUEL_PRED_PRESS, FMC_1_BTN_FUEL_PRED_RELEASE)
--SEC_F-PLN Button
function FMC_1_BTN_SEC_FPLN_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_SEC_FPLN", "Num", 1)
   sound_play(snd_click)
end
function FMC_1_BTN_SEC_FPLN_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_SEC_FPLN", "Num", 2)
end
button_add(nil,nil, 397,734,75,50, FMC_1_BTN_SEC_FPLN_PRESS, FMC_1_BTN_SEC_FPLN_RELEASE)
--ATC_COMM Button
--Press
function FMC_1_BTN_ATC_COM_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_ATC_COM", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ATC_COM_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_ATC_COM", "Num", 0)
end
button_add(nil,nil, 498,734,75,50, FMC_1_BTN_ATC_COM_PRESS, FMC_1_BTN_ATC_COM_RELEASE)
--MCDU_MENU Button
--Press
function FMC_1_BTN_MCDU_MENU_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_MENU", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_MCDU_MENU_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_MENU", "Num", 0)
end
button_add(nil,nil, 598,734,75,50, FMC_1_BTN_MCDU_MENU_PRESS, FMC_1_BTN_MCDU_MENU_RELEASE)
--AIRPORT Button
--Press
function FMC_1_BTN_AIRPORT_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_AIRPORT", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_AIRPORT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_AIRPORT", "Num", 0)
end
button_add(nil,nil, 96,801,75,50, FMC_1_BTN_AIRPORT_PRESS, FMC_1_BTN_AIRPORT_RELEASE)

--ARROW LEFT Button
--Press
function FMC_1_BTN_ARROW_LEFT_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_LEFT", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ARROW_LEFT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_LEFT", "Num", 0)
end
button_add(nil,nil, 96,868,75,50, FMC_1_BTN_ARROW_LEFT_PRESS, FMC_1_BTN_ARROW_LEFT_RELEASE)
--ARRROW RIGHT Button
--Press
function FMC_1_BTN_ARROW_RIGHT_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_RIGHT", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ARROW_RIGHT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_RIGHT", "Num", 0)
end
button_add(nil,nil, 96,938,75,50, FMC_1_BTN_ARROW_RIGHT_PRESS, FMC_1_BTN_ARROW_RIGHT_RELEASE)
--ARROW UP Button
--Press
function FMC_1_BTN_ARROW_UP_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_UP", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ARROW_UP_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_UP", "Num", 0)
end
button_add(nil,nil, 198,870,75,50, FMC_1_BTN_ARROW_UP_PRESS, FMC_1_BTN_ARROW_UP_RELEASE)
--ARRROW DOWN Button
--Press
function FMC_1_BTN_ARROW_DOWN_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_DOWN", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ARROW_DOWN_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_ARROW_DOWN", "Num", 0)
end
button_add(nil,nil, 198,940,75,50, FMC_1_BTN_ARROW_DOWN_PRESS, FMC_1_BTN_ARROW_DOWN_RELEASE)

--CLR Button
function FMC_1_BTN_CLR_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_CLEAR", "Num", 1)
   sound_play(snd_click)
end
function FMC_1_BTN_CLR_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_CLEAR", "Num", 0)
end
-- ** I didn't fine any equivalent for a Long Press function for the Fenix **
--function CLR_LONG() 
--  msfs_event("H:CJ4_FMC_1_BTN_CLR_LONG")
--end
button_add(nil,nil, 675,1197,53,52, FMC_1_BTN_CLR_PRESS, FMC_1_BTN_CLR_RELEASE)

--BRT Button
--Press
function FMC_1_BTN_BRT_PRESS()
    msfs_variable_write("L:"..unitpos.."_BRIGHTNESS_UP", "Num", 1)
    sound_play(snd_click)
end
--Release
function FMC_1_BTN_BRT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_BRIGHTNESS_UP", "Num", 0)
end
button_add(nil,nil, 697,664,53,52, FMC_1_BTN_BRT_PRESS, FMC_1_BTN_BRT_RELEASE)

--DIM Button
--Press
function FMC_1_BTN_DIM_PRESS()
   msfs_variable_write("L:"..unitpos.."_BRIGHTNESS_DOWN", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_DIM_RELEASE()
  msfs_variable_write("L:"..unitpos.."_BRIGHTNESS_DOWN", "Num", 0)
end
button_add(nil,nil, 697,738,53,52, FMC_1_BTN_DIM_PRESS, FMC_1_BTN_DIM_RELEASE)

--Letter Buttons
--A Button
--Press
function FMC_1_BTN_A_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_A", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_A_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_A", "Num", 0)
end
button_add(nil,nil, 337,820,53,51, FMC_1_BTN_A_PRESS, FMC_1_BTN_A_RELEASE)
--B Button
--Press
function FMC_1_BTN_B_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_B", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_B_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_B", "Num", 0)
end
button_add(nil,nil, 421,820,53,51, FMC_1_BTN_B_PRESS, FMC_1_BTN_B_RELEASE)
--C Button
--Press
function FMC_1_BTN_C_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_C", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_C_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_C", "Num", 0)
end
button_add(nil,nil, 505,820,53,51, FMC_1_BTN_C_PRESS, FMC_1_BTN_C_RELEASE)
--D Button
--Press
function FMC_1_BTN_D_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_D", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_D_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_D", "Num", 0)
end
button_add(nil,nil, 590,820,53,51, FMC_1_BTN_D_PRESS, FMC_1_BTN_D_RELEASE)
--E Button
--Press
function FMC_1_BTN_E_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_E", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_E_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_E", "Num", 0)
end
button_add(nil,nil, 675,820,53,51, FMC_1_BTN_E_PRESS, FMC_1_BTN_E_RELEASE)
--F Button
--Press
function FMC_1_BTN_F_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_F", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_F_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_F", "Num", 0)
end
button_add(nil,nil, 338,897,53,51, FMC_1_BTN_F_PRESS, FMC_1_BTN_F_RELEASE)
--G Button
--Press
function FMC_1_BTN_G_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_G", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_G_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_G", "Num", 0)
end
button_add(nil,nil, 422,897,53,51, FMC_1_BTN_G_PRESS, FMC_1_BTN_G_RELEASE)
--H Button
--Press
function FMC_1_BTN_H_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_H", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_H_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_H", "Num", 0)
end
button_add(nil,nil, 505,897,53,51, FMC_1_BTN_H_PRESS, FMC_1_BTN_H_RELEASE)
--I Button
--Press
function FMC_1_BTN_I_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_I", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_I_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_I", "Num", 0)
end
button_add(nil,nil, 592,897,53,51, FMC_1_BTN_I_PRESS, FMC_1_BTN_I_RELEASE)
--J Button
--Press
function FMC_1_BTN_J_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_J", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_J_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_J", "Num", 0)
end
button_add(nil,nil, 676,897,53,51, FMC_1_BTN_J_PRESS, FMC_1_BTN_J_RELEASE)
--K Button
--Press
function FMC_1_BTN_K_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_K", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_K_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_K", "Num", 0)
end
button_add(nil,nil, 338,974,53,51, FMC_1_BTN_K_PRESS, FMC_1_BTN_K_RELEASE)
--L Button
--Press
function FMC_1_BTN_L_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_L", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_L_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_L", "Num", 0)
end
button_add(nil,nil, 421,974,53,51, FMC_1_BTN_L_PRESS, FMC_1_BTN_L_RELEASE)
--M Button
--Press
function FMC_1_BTN_M_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_M", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_M_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_M", "Num", 0)
end
button_add(nil,nil, 505,974,53,51, FMC_1_BTN_M_PRESS, FMC_1_BTN_M_RELEASE)
--N Button
--Press
function FMC_1_BTN_N_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_N", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_N_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_N", "Num", 0)
end
button_add(nil,nil, 591,974,53,51, FMC_1_BTN_N_PRESS, FMC_1_BTN_N_RELEASE)
--O Button
--Press
function FMC_1_BTN_O_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_O", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_O_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_O", "Num", 0)
end
button_add(nil,nil, 674,974,53,51, FMC_1_BTN_O_PRESS, FMC_1_BTN_O_RELEASE)
--P Button
--Press
function FMC_1_BTN_P_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_P", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_P_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_P", "Num", 0)
end
button_add(nil,nil, 337,1050,53,51, FMC_1_BTN_P_PRESS, FMC_1_BTN_P_RELEASE)
--Q Button
--Press
function FMC_1_BTN_Q_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_Q", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_Q_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_Q", "Num", 0)
end
button_add(nil,nil, 421,1050,53,51, FMC_1_BTN_Q_PRESS, FMC_1_BTN_Q_RELEASE)
--R Button
--Press
function FMC_1_BTN_R_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_R", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_R_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_R", "Num", 0)
end
button_add(nil,nil, 505,1050,53,51, FMC_1_BTN_R_PRESS, FMC_1_BTN_R_RELEASE)
--S Button
--Press
function FMC_1_BTN_S_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_S", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_S_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_S", "Num", 0)
end
button_add(nil,nil, 590,1050,53,51, FMC_1_BTN_S_PRESS, FMC_1_BTN_S_RELEASE)
--T Button
--Press
function FMC_1_BTN_T_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_T", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_T_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_T", "Num", 0)
end
button_add(nil,nil, 674,1050,53,51, FMC_1_BTN_T_PRESS, FMC_1_BTN_T_RELEASE)
--U Button
--Press
function FMC_1_BTN_U_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_U", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_U_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_U", "Num", 0)
end
button_add(nil,nil, 338,1125,53,51, FMC_1_BTN_U_PRESS, FMC_1_BTN_U_RELEASE)
--V Button
--Press
function FMC_1_BTN_V_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_V", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_V_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_V", "Num", 0)
end
button_add(nil,nil, 422,1125,53,51, FMC_1_BTN_V_PRESS, FMC_1_BTN_V_RELEASE)
--W Button
--Press
function FMC_1_BTN_W_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_W", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_W_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_W", "Num", 0)
end
button_add(nil,nil, 506,1125,53,51, FMC_1_BTN_W_PRESS, FMC_1_BTN_W_RELEASE)
--X Button
--Press
function FMC_1_BTN_X_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_X", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_X_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_X", "Num", 0)
end
button_add(nil,nil, 592,1125,53,51, FMC_1_BTN_X_PRESS, FMC_1_BTN_X_RELEASE)
--Y Button
--Press
function FMC_1_BTN_Y_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_Y", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_Y_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_Y", "Num", 0)
end
button_add(nil,nil, 675,1125,53,51, FMC_1_BTN_Y_PRESS, FMC_1_BTN_Y_RELEASE)
--Z Button
--Press
function FMC_1_BTN_Z_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_Z", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_Z_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_Z", "Num", 0)
end
button_add(nil,nil, 338,1201,53,51, FMC_1_BTN_Z_PRESS, FMC_1_BTN_Z_RELEASE)

--SP Button
--Press
function FMC_1_BTN_SP_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_SPACE", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_SP_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_SPACE", "Num", 0)
end
button_add(nil,nil, 505,1201,53,51, FMC_1_BTN_SP_PRESS, FMC_1_BTN_SP_RELEASE)
--SLASH Button
--Press
function FMC_1_BTN_SLASH_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_SLASH", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_SLASH_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_SLASH", "Num", 0)
end
button_add(nil,nil, 422,1201,53,51, FMC_1_BTN_SLASH_PRESS, FMC_1_BTN_SLASH_RELEASE)
--OVFY Button
--Press
function FMC_1_BTN_OVFY_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_OVFLY", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_OVFY_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_OVFLY", "Num", 0)
end
button_add(nil,nil, 591,1201,53,51, FMC_1_BTN_OVFY_PRESS, FMC_1_BTN_OVFY_RELEASE)

--ONE Button
--Press
function FMC_1_BTN_ONE_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_1", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ONE_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_1", "Num", 0)
end
button_add(nil,nil, 86,1009,49,49, FMC_1_BTN_ONE_PRESS, FMC_1_BTN_ONE_RELEASE)
--TWO Button
--Press
function FMC_1_BTN_TWO_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_2", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_TWO_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_2", "Num", 0)
end
button_add(nil,nil, 166,1009,49,49, FMC_1_BTN_TWO_PRESS, FMC_1_BTN_TWO_RELEASE)
--THREE Button
--Press
function FMC_1_BTN_THREE_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_3", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_THREE_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_3", "Num", 0)
end
button_add(nil,nil, 245,1009,49,49, FMC_1_BTN_THREE_PRESS, FMC_1_BTN_THREE_RELEASE)
--FOUR Button
--Press
function FMC_1_BTN_FOUR_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_4", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_FOUR_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_4", "Num", 0)
end
button_add(nil,nil, 87,1072,49,49, FMC_1_BTN_FOUR_PRESS, FMC_1_BTN_FOUR_RELEASE)
--FIVE Button
--Press
function FMC_1_BTN_FIVE_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_5", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_FIVE_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_5", "Num", 0)
end
button_add(nil,nil, 166,1072,49,49, FMC_1_BTN_FIVE_PRESS, FMC_1_BTN_FIVE_RELEASE)
--SIX Button
--Press
function FMC_1_BTN_SIX_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_6", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_SIX_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_6", "Num", 0)
end
button_add(nil,nil, 245,1072,49,49, FMC_1_BTN_SIX_PRESS, FMC_1_BTN_SIX_RELEASE)
--SEVEN Button
--Press
function FMC_1_BTN_SEVEN_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_7", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_SEVEN_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_7", "Num", 0)
end
button_add(nil,nil, 86,1140,49,49, FMC_1_BTN_SEVEN_PRESS, FMC_1_BTN_SEVEN_RELEASE)
--EIGHT Button
--Press
function FMC_1_BTN_EIGHT_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_8", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_EIGHT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_8", "Num", 0)
end
button_add(nil,nil, 167,1140,49,49, FMC_1_BTN_EIGHT_PRESS, FMC_1_BTN_EIGHT_RELEASE)
--NINE Button
--Press
function FMC_1_BTN_NINE_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_9", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_NINE_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_9", "Num", 0)
end
button_add(nil,nil, 246,1139,49,49, FMC_1_BTN_NINE_PRESS, FMC_1_BTN_NINE_RELEASE)
--DOT Button
--Press
function FMC_1_BTN_DOT_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_DOT", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_DOT_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_DOT", "Num", 0)
end
button_add(nil,nil, 86,1204,49,49, FMC_1_BTN_DOT_PRESS, FMC_1_BTN_DOT_RELEASE)
--ZERO Button
--Press
function FMC_1_BTN_ZERO_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_0", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_ZERO_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_0", "Num", 0)
end
button_add(nil,nil, 167,1204,49,49, FMC_1_BTN_ZERO_PRESS, FMC_1_BTN_ZERO_RELEASE)
--PLUSMINUS Button
--Press
function FMC_1_BTN_PLUSMINUS_PRESS()
   msfs_variable_write("L:"..unitpos.."_KEY_MINUS", "Num", 1)
   sound_play(snd_click)
end
--Release
function FMC_1_BTN_PLUSMINUS_RELEASE()
   msfs_variable_write("L:"..unitpos.."_KEY_MINUS", "Num", 0)
end
button_add(nil,nil, 246,1204,49,49, FMC_1_BTN_PLUSMINUS_PRESS, FMC_1_BTN_PLUSMINUS_RELEASE)
