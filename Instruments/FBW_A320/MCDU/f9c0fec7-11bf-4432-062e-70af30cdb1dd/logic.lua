--[[
******************************************************************************************
******************Fenix A320 MCDU ********************************************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 05-31-2022
    - Original Panel Created


##Left To Do:
  

	
##Notes:
    - 
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
   msfs_event("H:A320_Neo_CDU_1_BTN_L1")
   sound_play(snd_click)
end

button_add(nil,nil, 25,175,46,38, FMC_1_BTN_LSK1L_PRESS)
--LSK2L Button
--Press
function FMC_1_BTN_LSK2L_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_L2")
   sound_play(snd_click)
end

button_add(nil,nil, 25,245,46,38, FMC_1_BTN_LSK2L_PRESS)
--LSK3L Button
--Press
function FMC_1_BTN_LSK3L_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_L3")
   sound_play(snd_click)
end

button_add(nil,nil, 25,317,46,38, FMC_1_BTN_LSK3L_PRESS)
--LSK4L Button
--Press
function FMC_1_BTN_LSK4L_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_L4")
   sound_play(snd_click)
end

button_add(nil,nil, 25,391,46,38, FMC_1_BTN_LSK4L_PRESS)
--L5 Button
--Press
function FMC_1_BTN_LSK5L_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_L5")
   sound_play(snd_click)
end

button_add(nil,nil, 25,463,46,38, FMC_1_BTN_LSK5L_PRESS)
--LSK6L Button
--Press
function FMC_1_BTN_LSK6L_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_L6")
   sound_play(snd_click)
end

button_add(nil,nil, 25,533,46,38, FMC_1_BTN_LSK6L_PRESS)
--LSK1R Button
--Press
function FMC_1_BTN_LSK1R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R1")
   sound_play(snd_click)
end

button_add(nil,nil, 753,175,46,38, FMC_1_BTN_LSK1R_PRESS)
--LSK2R Button
--Press
function FMC_1_BTN_LSK2R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R2")
   sound_play(snd_click)
end

button_add(nil,nil, 753,245,46,38, FMC_1_BTN_LSK2R_PRESS)
--LSK3R Button
--Press
function FMC_1_BTN_LSK3R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R3")
   sound_play(snd_click)
end

button_add(nil,nil, 753,317,46,38, FMC_1_BTN_LSK3R_PRESS)
--LSK4R Button
--Press
function FMC_1_BTN_LSK4R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R4")
   sound_play(snd_click)
end

button_add(nil,nil, 753,391,46,38, FMC_1_BTN_LSK4R_PRESS)
--LSK5R Button
--Press
function FMC_1_BTN_LSK5R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R5")
   sound_play(snd_click)
end

button_add(nil,nil, 753,463,46,38, FMC_1_BTN_LSK5R_PRESS)
--LSK6R Button
--Press
function FMC_1_BTN_LSK6R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R6")
   sound_play(snd_click)
end

button_add(nil,nil, 753,533,46,38, FMC_1_BTN_LSK6R_PRESS)


--DIR Button
--Press
function FMC_1_BTN_DIR_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_DIR")
   sound_play(snd_click)
end

button_add(nil,nil, 96,666,75,50, FMC_1_BTN_DIR_PRESS)
--PROG Button
--Press
function FMC_1_BTN_PROG_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_PROG")
   sound_play(snd_click)
end

button_add(nil,nil, 199,666,75,50, FMC_1_BTN_PROG_PRESS)
--PERF Button
--Press
function FMC_1_BTN_PERF_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_PERF")
   sound_play(snd_click)
end

button_add(nil,nil, 298,666,75,50, FMC_1_BTN_PERF_PRESS)
--INIT Button
--Press
function FMC_1_BTN_INIT_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_INIT")
   sound_play(snd_click)
end

button_add(nil,nil, 397,666,75,50, FMC_1_BTN_INIT_PRESS)
--DATA Button
--Press
function FMC_1_BTN_DATA_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_DATA")
   sound_play(snd_click)
end

button_add(nil,nil, 499,666,75,50, FMC_1_BTN_DATA_PRESS)
--FPLN Button
--Press
function FMC_1_BTN_FPLN_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_FPLN")
   sound_play(snd_click)
end

button_add(nil,nil, 96,734,75,50, FMC_1_BTN_FPLN_PRESS)
--RAD_NAV Button
--Press
function FMC_1_BTN_RAD_NAV_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_RAD")
   sound_play(snd_click)
end

button_add(nil,nil, 198,734,75,50, FMC_1_BTN_RAD_NAV_PRESS)
--FUEL_PRED Button
--Press
function FMC_1_BTN_FUEL_PRED_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_FUEL")
   sound_play(snd_click)
end

button_add(nil,nil, 297,734,75,50, FMC_1_BTN_FUEL_PRED_PRESS)
--SEC_F-PLN Button
function FMC_1_BTN_SEC_FPLN_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_SEC")
   sound_play(snd_click)
end

button_add(nil,nil, 397,734,75,50, FMC_1_BTN_SEC_FPLN_PRESS)
--ATC_COMM Button
--Press
function FMC_1_BTN_ATC_COM_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_ATC")
   sound_play(snd_click)
end

button_add(nil,nil, 498,734,75,50, FMC_1_BTN_ATC_COM_PRESS)
--MCDU_MENU Button
--Press
function FMC_1_BTN_MCDU_MENU_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_MENU")
   sound_play(snd_click)
end

button_add(nil,nil, 598,734,75,50, FMC_1_BTN_MCDU_MENU_PRESS)
--AIRPORT Button
--Press
function FMC_1_BTN_AIRPORT_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_AIPORT")
   sound_play(snd_click)
end

button_add(nil,nil, 96,801,75,50, FMC_1_BTN_AIRPORT_PRESS)

--ARROW LEFT Button
--Press
function FMC_1_BTN_ARROW_LEFT_PRESS()
  msfs_event("H:A320_Neo_CDU_1_BTN_PREVPAGE")
   sound_play(snd_click)
end
button_add(nil,nil, 96,868,75,50, FMC_1_BTN_ARROW_LEFT_PRESS)

--ARRROW RIGHT Button
--Press
function FMC_1_BTN_ARROW_RIGHT_PRESS()
  msfs_event("H:A320_Neo_CDU_1_BTN_NEXTPAGE")
   sound_play(snd_click)
end
button_add(nil,nil, 96,938,75,50, FMC_1_BTN_ARROW_RIGHT_PRESS)

--ARROW UP Button
--Press
function FMC_1_BTN_UP_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_UP")
   sound_play(snd_click)
end
button_add(nil,nil, 198,870,75,50, FMC_1_BTN_UP_PRESS)
--ARRROW DOWN Button
--Press
function FMC_1_BTN_DOWN_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_DOWN")
   sound_play(snd_click)
end
button_add(nil,nil, 198,940,75,50, FMC_1_BTN_DOWN_PRESS)

--CLR Button
function FMC_1_BTN_CLR_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_CLR")
   sound_play(snd_click)
end
-- ** I didn't fine any equivalent for a Long Press function for the Fenix **
--function CLR_LONG() 
--  msfs_event("H:CJ4_FMC_1_BTN_CLR_LONG")
--end
button_add(nil,nil, 675,1197,53,52, FMC_1_BTN_CLR_PRESS)

--BRT Button
--Press
function FMC_1_BTN_BRT_PRESS()
    msfs_variable_write("L:"..unitpos.."_BRIGHTNESS_UP", "Num", 1)
    sound_play(snd_click)
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
   msfs_event("H:A320_Neo_CDU_1_BTN_A")
   sound_play(snd_click)
end

button_add(nil,nil, 337,820,53,51, FMC_1_BTN_A_PRESS)
--B Button
--Press
function FMC_1_BTN_B_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_B")
   sound_play(snd_click)
end

button_add(nil,nil, 421,820,53,51, FMC_1_BTN_B_PRESS)
--C Button
--Press
function FMC_1_BTN_C_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_C")
   sound_play(snd_click)
end

button_add(nil,nil, 505,820,53,51, FMC_1_BTN_C_PRESS)
--D Button
--Press
function FMC_1_BTN_D_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_D")
   sound_play(snd_click)
end

button_add(nil,nil, 590,820,53,51, FMC_1_BTN_D_PRESS)
--E Button
--Press
function FMC_1_BTN_E_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_E")
   sound_play(snd_click)
end

button_add(nil,nil, 675,820,53,51, FMC_1_BTN_E_PRESS)
--F Button
--Press
function FMC_1_BTN_F_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_F")
   sound_play(snd_click)
end
button_add(nil,nil, 338,897,53,51, FMC_1_BTN_F_PRESS)
--G Button
--Press
function FMC_1_BTN_G_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_G")
   sound_play(snd_click)
end
button_add(nil,nil, 422,897,53,51, FMC_1_BTN_G_PRESS)
--H Button
function FMC_1_BTN_H_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_H")
   sound_play(snd_click)
end
button_add(nil,nil, 505,897,53,51, FMC_1_BTN_H_PRESS)
--I Button
--Press
function FMC_1_BTN_I_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_I")
   sound_play(snd_click)
end
button_add(nil,nil, 592,897,53,51, FMC_1_BTN_I_PRESS)
--J Button
--Press
function FMC_1_BTN_J_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_J")
   sound_play(snd_click)
end
button_add(nil,nil, 676,897,53,51, FMC_1_BTN_J_PRESS)
--K Button
--Press
function FMC_1_BTN_K_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_k")
   sound_play(snd_click)
end
button_add(nil,nil, 338,974,53,51, FMC_1_BTN_K_PRESS)
--L Button
--Press
function FMC_1_BTN_L_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_L")
   sound_play(snd_click)
end
button_add(nil,nil, 421,974,53,51, FMC_1_BTN_L_PRESS)
--M Button
--Press
function FMC_1_BTN_M_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_M")
   sound_play(snd_click)
end
button_add(nil,nil, 505,974,53,51, FMC_1_BTN_M_PRESS)
--N Button
--Press
function FMC_1_BTN_N_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_N")
   sound_play(snd_click)
end
button_add(nil,nil, 591,974,53,51, FMC_1_BTN_N_PRESS)
--O Button
--Press
function FMC_1_BTN_O_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_O")
   sound_play(snd_click)
end
button_add(nil,nil, 674,974,53,51, FMC_1_BTN_O_PRESS)
--P Button
--Press
function FMC_1_BTN_P_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_P")
   sound_play(snd_click)
end
button_add(nil,nil, 337,1050,53,51, FMC_1_BTN_P_PRESS)
--Q Button
--Press
function FMC_1_BTN_Q_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_Q")
   sound_play(snd_click)
end
button_add(nil,nil, 421,1050,53,51, FMC_1_BTN_Q_PRESS)
--R Button
function FMC_1_BTN_R_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_R")
   sound_play(snd_click)
end
button_add(nil,nil, 505,1050,53,51, FMC_1_BTN_R_PRESS)
--S Button
--Press
function FMC_1_BTN_S_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_S")
   sound_play(snd_click)
end
button_add(nil,nil, 590,1050,53,51, FMC_1_BTN_S_PRESS)
--T Button
--Press
function FMC_1_BTN_T_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_T")
   sound_play(snd_click)
end
button_add(nil,nil, 674,1050,53,51, FMC_1_BTN_T_PRESS)
--U Button
--Press
function FMC_1_BTN_U_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_U")
   sound_play(snd_click)
end
button_add(nil,nil, 338,1125,53,51, FMC_1_BTN_U_PRESS)
--V Button
--Press
function FMC_1_BTN_V_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_V")
   sound_play(snd_click)
end
button_add(nil,nil, 422,1125,53,51, FMC_1_BTN_V_PRESS)
--W Button
--Press
function FMC_1_BTN_W_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_W")
   sound_play(snd_click)
end
button_add(nil,nil, 506,1125,53,51, FMC_1_BTN_W_PRESS)
--X Button
--Press
function FMC_1_BTN_X_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_X")
   sound_play(snd_click)
end
button_add(nil,nil, 592,1125,53,51, FMC_1_BTN_X_PRESS)
--Y Button
--Press
function FMC_1_BTN_Y_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_Y")
   sound_play(snd_click)
end
button_add(nil,nil, 675,1125,53,51, FMC_1_BTN_Y_PRESS)
--Z Button
--Press
function FMC_1_BTN_Z_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_Z")
   sound_play(snd_click)
end
button_add(nil,nil, 338,1201,53,51, FMC_1_BTN_Z_PRESS)

--SP Button
--Press
function FMC_1_BTN_SP_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_SP")
   sound_play(snd_click)
end
button_add(nil,nil, 505,1201,53,51, FMC_1_BTN_SP_PRESS)
--SLASH Button
--Press
function FMC_1_BTN_DIV_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_DIV")
   sound_play(snd_click)
end
button_add(nil,nil, 422,1201,53,51, FMC_1_BTN_DIV_PRESS)
--OVFY Button
--Press
function FMC_1_BTN_OVFY_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_OVFY")
   sound_play(snd_click)
end
button_add(nil,nil, 591,1201,53,51, FMC_1_BTN_OVFY_PRESS)

--ONE Button
--Press
function FMC_1_BTN_ONE_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_1")
   sound_play(snd_click)
end
button_add(nil,nil, 86,1009,49,49, FMC_1_BTN_ONE_PRESS)
--TWO Button
--Press
function FMC_1_BTN_TWO_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_2")
   sound_play(snd_click)
end
button_add(nil,nil, 166,1009,49,49, FMC_1_BTN_TWO_PRESS)
--THREE Button
--Press
function FMC_1_BTN_THREE_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_3")
   sound_play(snd_click)
end
button_add(nil,nil, 245,1009,49,49, FMC_1_BTN_THREE_PRESS)
--FOUR Button
--Press
function FMC_1_BTN_FOUR_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_4")
   sound_play(snd_click)
end
button_add(nil,nil, 87,1072,49,49, FMC_1_BTN_FOUR_PRESS)
--FIVE Button
--Press
function FMC_1_BTN_FIVE_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_5")
   sound_play(snd_click)
end
button_add(nil,nil, 166,1072,49,49, FMC_1_BTN_FIVE_PRESS)
--SIX Button
--Press
function FMC_1_BTN_SIX_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_6")
   sound_play(snd_click)
end
button_add(nil,nil, 245,1072,49,49, FMC_1_BTN_SIX_PRESS)
--SEVEN Button
--Press
function FMC_1_BTN_SEVEN_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_7")
   sound_play(snd_click)
end
button_add(nil,nil, 86,1140,49,49, FMC_1_BTN_SEVEN_PRESS)
--EIGHT Button
--Press
function FMC_1_BTN_EIGHT_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_8")
   sound_play(snd_click)
end
button_add(nil,nil, 167,1140,49,49, FMC_1_BTN_EIGHT_PRESS)
--NINE Button
--Press
function FMC_1_BTN_NINE_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_9")
   sound_play(snd_click)
end
button_add(nil,nil, 246,1139,49,49, FMC_1_BTN_NINE_PRESS)
--DOT Button
--Press
function FMC_1_BTN_DOT_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_DOT")
   sound_play(snd_click)
end
button_add(nil,nil, 86,1204,49,49, FMC_1_BTN_DOT_PRESS)
--ZERO Button
--Press
function FMC_1_BTN_ZERO_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_0")
   sound_play(snd_click)
end
button_add(nil,nil, 167,1204,49,49, FMC_1_BTN_ZERO_PRESS)
--PLUSMINUS Button
--Press
function FMC_1_BTN_PLUSMINUS_PRESS()
   msfs_event("H:A320_Neo_CDU_1_BTN_PLUSMINUS")
   sound_play(snd_click)
end
button_add(nil,nil, 246,1204,49,49, FMC_1_BTN_PLUSMINUS_PRESS)
