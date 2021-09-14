--[[
   CJ4 FMS-3200 FMC
   Author Rob Verdon
   rob.verdon@gmail.com
   
- **v1.0** 3-7-21 Rob Verdon
    - Original Panel Created
- **v1.1** 8-23-21 Rob Verdon
    - Add Space Button on keypad.
- **v1.2** 9-5-21 
    - Replaced mobi flight variables with LVARs.
- **v1.3** 9-12-21 Herbert Puukka
    - Replaced background image with better one.
    - The new default size is 800x1010. You may need to resize your instruments.
- **v1.4** 9-13-21 Rob Verdon
    - Cleaned up code, removed user option to show buttons. 
--]]





--Backgroud Image before anything else
img_add_fullscreen("background.png")


--Sounds   
click_snd = sound_add("knobclick.wav")
fail_snd = sound_add("beepfail.wav")

--Button Graphics
    SelectorButtonPressed = "Selector_btn_pressed.png"
    CLRButtonPressed = "CLR_btn_pressed.png"
    MSGButtonPressed = "MSG_btn_pressed.png"
    DIRButtonPressed = "DIR_btn_pressed.png"
    IDXButtonPressed = "IDX_btn_pressed.png"
    TUNButtonPressed = "TUN_btn_pressed.png"
    FPLNButtonPressed = "FPLN_btn_pressed.png"
    LEGSButtonPressed = "LEGS_btn_pressed.png"
    DEPARRButtonPressed = "DEPARR_btn_pressed.png"
    PERFButtonPressed = "PERF_btn_pressed.png"
    DSPL_MENUButtonPressed = "DSPL_MENU_btn_pressed.png"
    MFD_ADVButtonPressed = "MFD_ADV_btn_pressed.png"
    MFD_DATAButtonPressed = "MFD_DATA_btn_pressed.png"
    PREVPAGEButtonPressed = "PREVPAGE_btn_pressed.png"
    NEXTPAGEButtonPressed = "NEXTPAGE_btn_pressed.png"
    EXECButtonPressed = "EXEC_btn_pressed.png"
    DIVButtonPressed = "DIV_btn_pressed.png"
    
    AButtonPressed = "A_btn_pressed.png"
    BButtonPressed = "B_btn_pressed.png"
    CButtonPressed = "C_btn_pressed.png"
    DButtonPressed = "D_btn_pressed.png"
    EButtonPressed = "E_btn_pressed.png"
    FButtonPressed = "F_btn_pressed.png"
    GButtonPressed = "G_btn_pressed.png"
    HButtonPressed = "H_btn_pressed.png"
    IButtonPressed = "I_btn_pressed.png"
    JButtonPressed = "J_btn_pressed.png"
    KButtonPressed = "K_btn_pressed.png"
    LButtonPressed = "L_btn_pressed.png"
    MButtonPressed = "M_btn_pressed.png"
    NButtonPressed = "N_btn_pressed.png"
    OButtonPressed = "O_btn_pressed.png"
    PButtonPressed = "P_btn_pressed.png"
    QButtonPressed = "Q_btn_pressed.png"
    RButtonPressed = "R_btn_pressed.png"
    SButtonPressed = "S_btn_pressed.png"
    TButtonPressed = "T_btn_pressed.png"
    UButtonPressed = "U_btn_pressed.png"
    VButtonPressed = "V_btn_pressed.png"
    WButtonPressed = "W_btn_pressed.png"
    XButtonPressed = "X_btn_pressed.png"
    YButtonPressed = "Y_btn_pressed.png"
    ZButtonPressed = "Z_btn_pressed.png"
    ONEButtonPressed = "ONE_btn_pressed.png"
    TWOButtonPressed = "TWO_btn_pressed.png"
    THREEButtonPressed = "THREE_btn_pressed.png"
    FOURButtonPressed = "FOUR_btn_pressed.png"
    FIVEButtonPressed = "FIVE_btn_pressed.png"
    SIXButtonPressed = "SIX_btn_pressed.png"
    SEVENButtonPressed = "SEVEN_btn_pressed.png"
    EIGHTButtonPressed = "EIGHT_btn_pressed.png"
    NINEButtonPressed = "NINE_btn_pressed.png"
    DOTButtonPressed = "DOT_btn_pressed.png"
    ZEROButtonPressed = "ZERO_btn_pressed.png"
    PLUSMINUSButtonPressed = "PLUSMINUS_btn_pressed.png"
    SPButtonPressed = "SP_btn_pressed.png"

--START OF BUTTONS************

--L1 Button
function FMC_1_BTN_L1()
   fs2020_event("H:CJ4_FMC_1_BTN_L1")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 18,174,45,25, FMC_1_BTN_L1)
--L2 Button
function FMC_1_BTN_L2()
   fs2020_event("H:CJ4_FMC_1_BTN_L2")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 18,233,45,25, FMC_1_BTN_L2)
--L3 Button
function FMC_1_BTN_L3()
   fs2020_event("H:CJ4_FMC_1_BTN_L3")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 18,292,45,25, FMC_1_BTN_L3)
--L4 Button
function FMC_1_BTN_L4()
   fs2020_event("H:CJ4_FMC_1_BTN_L4")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 17,351,45,25, FMC_1_BTN_L4)
--L5 Button
function FMC_1_BTN_L5()
   fs2020_event("H:CJ4_FMC_1_BTN_L5")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 17,411,45,25, FMC_1_BTN_L5)
--L6 Button
function FMC_1_BTN_L6()
   fs2020_event("H:CJ4_FMC_1_BTN_L6")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 17,471,45,25, FMC_1_BTN_L6)
--R1 Button
function FMC_1_BTN_R1()
   fs2020_event("H:CJ4_FMC_1_BTN_R1")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 728,173,45,25, FMC_1_BTN_R1)
--R2 Button
function FMC_1_BTN_R2()
   fs2020_event("H:CJ4_FMC_1_BTN_R2")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 728,232,45,25, FMC_1_BTN_R2)
--R3 Button
function FMC_1_BTN_R3()
   fs2020_event("H:CJ4_FMC_1_BTN_R3")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 728,291,45,25, FMC_1_BTN_R3)
--R4 Button
function FMC_1_BTN_R4()
   fs2020_event("H:CJ4_FMC_1_BTN_R4")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 729,350,45,25, FMC_1_BTN_R4)
--R5 Button
function FMC_1_BTN_R5()
   fs2020_event("H:CJ4_FMC_1_BTN_R5")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 729,409,45,25, FMC_1_BTN_R5)
--R6 Button
function FMC_1_BTN_R6()
   fs2020_event("H:CJ4_FMC_1_BTN_R6")
   sound_play(click_snd)
end
button_add(nil,SelectorButtonPressed, 730,469,45,25, FMC_1_BTN_R6)


--MSG Button
function FMC_1_BTN_MSG()
   fs2020_event("H:CJ4_FMC_1_BTN_MSG")
   sound_play(click_snd)
end
button_add(nil,MSGButtonPressed, 16,545,52,52, FMC_1_BTN_MSG)
--DIR Button
function FMC_1_BTN_DIR()
   fs2020_event("H:CJ4_FMC_1_BTN_DIR")
   sound_play(click_snd)
end
button_add(nil,DIRButtonPressed, 16,615,52,52, FMC_1_BTN_DIR)
--IDX Button
function FMC_1_BTN_IDX()
   fs2020_event("H:CJ4_FMC_1_BTN_IDX")
   sound_play(click_snd)
end
button_add(nil,IDXButtonPressed, 16,686,52,52, FMC_1_BTN_IDX)
--TUN Button
function FMC_1_BTN_TUN()
   fs2020_event("H:CJ4_FMC_1_BTN_TUN")
   sound_play(click_snd)
end
button_add(nil,TUNButtonPressed, 16,769,52,52, FMC_1_BTN_TUN)
--FPLN Button
function FMC_1_BTN_FPLN()
   fs2020_event("H:CJ4_FMC_1_BTN_FPLN")
   sound_play(click_snd)
end
button_add(nil,FPLNButtonPressed, 94,615,52,52, FMC_1_BTN_FPLN)
--LEGS Button
function FMC_1_BTN_LEGS()
   fs2020_event("H:CJ4_FMC_1_BTN_LEGS")
   sound_play(click_snd)
end
button_add(nil,LEGSButtonPressed, 173,615,52,52, FMC_1_BTN_LEGS)
--DEPARR Button
function FMC_1_BTN_DEPARR()
   fs2020_event("H:CJ4_FMC_1_BTN_DEPARR")
   sound_play(click_snd)
end
button_add(nil,DEPARRButtonPressed, 252,615,52,52, FMC_1_BTN_DEPARR)
--PERF Button
function FMC_1_BTN_PERF()
   fs2020_event("H:CJ4_FMC_1_BTN_PERF")
   sound_play(click_snd)
end
button_add(nil,PERFButtonPressed, 331,615,52,52, FMC_1_BTN_PERF)
--DSPL_MENU Button
function FMC_1_BTN_DSPL_MENU()
   fs2020_event("H:CJ4_FMC_1_BTN_DSPL_MENU")
   sound_play(click_snd)
end
button_add(DSPL_MENUButton,DSPL_MENUButtonPressed, 410,615,52,52, FMC_1_BTN_DSPL_MENU)
--MFD_ADV Button
function FMC_1_BTN_MFD_ADV()
   fs2020_event("H:CJ4_FMC_1_BTN_MFD_ADV")
   sound_play(click_snd)
end
button_add(nil,MFD_ADVButtonPressed, 489,615,52,52, FMC_1_BTN_MFD_ADV)
--MFD_DATA Button
function FMC_1_BTN_MFD_DATA()
   fs2020_event("H:CJ4_FMC_1_BTN_MFD_DATA")
   sound_play(click_snd)
end
button_add(nil,MFD_DATAButtonPressed, 568,615,52,52, FMC_1_BTN_MFD_DATA)
--PREVPAGE Button
function FMC_1_BTN_PREVPAGE()
   fs2020_event("H:CJ4_FMC_1_BTN_PREVPAGE")
   sound_play(click_snd)
end
button_add(nil,PREVPAGEButtonPressed, 645,615,52,52, FMC_1_BTN_PREVPAGE)
--NEXTPAGE Button
function FMC_1_BTN_NEXTPAGE()
   fs2020_event("H:CJ4_FMC_1_BTN_NEXTPAGE")
   sound_play(click_snd)
end
button_add(nil,NEXTPAGEButtonPressed, 728,615,52,52, FMC_1_BTN_NEXTPAGE)
--EXEC Button
function FMC_1_BTN_EXEC()
   fs2020_event("H:CJ4_FMC_1_BTN_EXEC")
   sound_play(click_snd)
end
button_add(nil,EXECButtonPressed, 728,545,52,52, FMC_1_BTN_EXEC)


--CLR Button
function FMC_1_BTN_CLR_Start()
   fs2020_event("H:CJ4_FMC_1_BTN_CLR")
   sound_play(click_snd)
   timer_id1 = timer_start(1000,CLR_LONG)
end
function FMC_1_BTN_CLR_End()
       timer_stop(timer_id1)
end

function CLR_LONG()
fs2020_event("H:CJ4_FMC_1_BTN_CLR_LONG")
end

button_add(nil,CLRButtonPressed, 728,685,52,52, FMC_1_BTN_CLR_Start, FMC_1_BTN_CLR_End)

--BRT Button **DOESN'T WORK
function FMC_1_BTN_BRT()
  --TESTING:
   --fs2020_variable_write("I:XMLVAR_MCDU_1_Brightness", "Int", 1)
   -- fs2020_event("I:XMLVAR_MCDU_1_Brightness",1)
   --fs2020_event("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM",1)
   --fs2020_variable_write("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM", "Int", 1)
   --sound_play(fail_snd)
end
button_add(nil,nil, 733,755,42,42, FMC_1_BTN_BRT)
--DIM Button **DOESN'T WORK
function FMC_1_BTN_DIM()
  -- fs2020_event("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM",0)
   --sound_play(fail_snd)
end
button_add(nil,nil, 733,804,42,42, FMC_1_BTN_DIM)








--A Button
function FMC_1_BTN_A()
   fs2020_event("H:CJ4_FMC_1_BTN_A")
   sound_play(click_snd)
end
button_add(nil,AButtonPressed, 83,685,52,52, FMC_1_BTN_A)
--B Button
function FMC_1_BTN_B()
   fs2020_event("H:CJ4_FMC_1_BTN_B")
   sound_play(click_snd)
end
button_add(nil,BButtonPressed, 145,685,52,52, FMC_1_BTN_B)
--C Button
function FMC_1_BTN_C()
   fs2020_event("H:CJ4_FMC_1_BTN_C")
   sound_play(click_snd)
end
button_add(nil,CButtonPressed, 207,685,52,52, FMC_1_BTN_C)
--D Button
function FMC_1_BTN_D()
   fs2020_event("H:CJ4_FMC_1_BTN_D")
   sound_play(click_snd)
end
button_add(nil,DButtonPressed, 269,685,52,52, FMC_1_BTN_D)
--E Button
function FMC_1_BTN_E()
   fs2020_event("H:CJ4_FMC_1_BTN_E")
   sound_play(click_snd)
end
button_add(nil,EButtonPressed, 332,685,52,52, FMC_1_BTN_E)
--F Button
function FMC_1_BTN_F()
   fs2020_event("H:CJ4_FMC_1_BTN_F")
   sound_play(click_snd)
end
button_add(nil,FButtonPressed, 393,685,52,52, FMC_1_BTN_F)
--G Button
function FMC_1_BTN_G()
   fs2020_event("H:CJ4_FMC_1_BTN_G")
   sound_play(click_snd)
end
button_add(nil,GButtonPressed, 455,685,52,52, FMC_1_BTN_G)
--H Button
function FMC_1_BTN_H()
   fs2020_event("H:CJ4_FMC_1_BTN_H")
   sound_play(click_snd)
end
button_add(nil,HButtonPressed, 83,769,52,52, FMC_1_BTN_H)
--I Button
function FMC_1_BTN_I()
   fs2020_event("H:CJ4_FMC_1_BTN_I")
   sound_play(click_snd)
end
button_add(nil,IButtonPressed, 145,769,52,52, FMC_1_BTN_I)
--J Button
function FMC_1_BTN_J()
   fs2020_event("H:CJ4_FMC_1_BTN_J")
   sound_play(click_snd)
end
button_add(nil,JButtonPressed, 207,769,52,52, FMC_1_BTN_J)
--K Button
function FMC_1_BTN_K()
   fs2020_event("H:CJ4_FMC_1_BTN_K")
   sound_play(click_snd)
end
button_add(nil,KButtonPressed, 269,769,52,52, FMC_1_BTN_K)
--L Button
function FMC_1_BTN_L()
   fs2020_event("H:CJ4_FMC_1_BTN_L")
   sound_play(click_snd)
end
button_add(nil,LButtonPressed, 331,769,52,52, FMC_1_BTN_L)
--M Button
function FMC_1_BTN_M()
   fs2020_event("H:CJ4_FMC_1_BTN_M")
   sound_play(click_snd)
end
button_add(nil,MButtonPressed, 395,769,52,52, FMC_1_BTN_M)
--N Button
function FMC_1_BTN_N()
   fs2020_event("H:CJ4_FMC_1_BTN_N")
   sound_play(click_snd)
end
button_add(nil,NButtonPressed, 458,769,52,52, FMC_1_BTN_N)
--O Button
function FMC_1_BTN_O()
   fs2020_event("H:CJ4_FMC_1_BTN_O")
   sound_play(click_snd)
end
button_add(nil,OButtonPressed, 83,852,52,52, FMC_1_BTN_O)
--P Button
function FMC_1_BTN_P()
   fs2020_event("H:CJ4_FMC_1_BTN_P")
   sound_play(click_snd)
end
button_add(nil,PButtonPressed, 145,852,52,52, FMC_1_BTN_P)
--Q Button
function FMC_1_BTN_Q()
   fs2020_event("H:CJ4_FMC_1_BTN_Q")
   sound_play(click_snd)
end
button_add(nil,QButtonPressed, 207,852,52,52, FMC_1_BTN_Q)
--R Button
function FMC_1_BTN_R()
   fs2020_event("H:CJ4_FMC_1_BTN_R")
   sound_play(click_snd)
end
button_add(nil,RButtonPressed, 269,852,52,52, FMC_1_BTN_R)
--S Button
function FMC_1_BTN_S()
   fs2020_event("H:CJ4_FMC_1_BTN_S")
   sound_play(click_snd)
end
button_add(nil,SButtonPressed, 332,852,52,52, FMC_1_BTN_S)
--T Button
function FMC_1_BTN_T()
   fs2020_event("H:CJ4_FMC_1_BTN_T")
   sound_play(click_snd)
end
button_add(nil,TButtonPressed, 395,852,52,52, FMC_1_BTN_T)
--U Button
function FMC_1_BTN_U()
   fs2020_event("H:CJ4_FMC_1_BTN_U")
   sound_play(click_snd)
end
button_add(nil,UButtonPressed, 458,852,52,52, FMC_1_BTN_U)
--V Button
function FMC_1_BTN_V()
   fs2020_event("H:CJ4_FMC_1_BTN_V")
   sound_play(click_snd)
end
button_add(nil,VButtonPressed, 83,936,52,52, FMC_1_BTN_V)
--W Button
function FMC_1_BTN_W()
   fs2020_event("H:CJ4_FMC_1_BTN_W")
   sound_play(click_snd)
end
button_add(nil,WButtonPressed, 145,936,52,52, FMC_1_BTN_W)
--X Button
function FMC_1_BTN_X()
   fs2020_event("H:CJ4_FMC_1_BTN_X")
   sound_play(click_snd)
end
button_add(nil,XButtonPressed, 207,936,52,52, FMC_1_BTN_X)
--Y Button
function FMC_1_BTN_Y()
   fs2020_event("H:CJ4_FMC_1_BTN_Y")
   sound_play(click_snd)
end
button_add(nil,YButtonPressed, 269,936,52,52, FMC_1_BTN_Y)
--Z Button
function FMC_1_BTN_Z()
   fs2020_event("H:CJ4_FMC_1_BTN_Z")
   sound_play(click_snd)
end
button_add(nil,ZButtonPressed, 331,936,52,52, FMC_1_BTN_Z)


--SP Button
function FMC_1_BTN_SP()
   fs2020_event("H:CJ4_FMC_1_BTN_SP")
   sound_play(click_snd)
end
button_add(nil,SPButtonPressed, 395,936,52,52, FMC_1_BTN_SP)
--DIV Button
function FMC_1_BTN_DIV()
   fs2020_event("H:CJ4_FMC_1_BTN_DIV")
   sound_play(click_snd)
end
button_add(nil,DIVButtonPressed, 458,936,52,52, FMC_1_BTN_DIV)


--ONE Button
function FMC_1_BTN_ONE()
   fs2020_event("H:CJ4_FMC_1_BTN_1")
   sound_play(click_snd)
end
button_add(nil,ONEButtonPressed, 520,683,55,55, FMC_1_BTN_ONE)
--TWO Button
function FMC_1_BTN_TWO()
   fs2020_event("H:CJ4_FMC_1_BTN_2")
   sound_play(click_snd)
end
button_add(nil,TWOButtonPressed, 590,683,55,55, FMC_1_BTN_TWO)
--THREE Button
function FMC_1_BTN_THREE()
   fs2020_event("H:CJ4_FMC_1_BTN_3")
   sound_play(click_snd)
end
button_add(nil,THREEButtonPressed, 659,683,55,55, FMC_1_BTN_THREE)
--FOUR Button
function FMC_1_BTN_FOUR()
   fs2020_event("H:CJ4_FMC_1_BTN_4")
   sound_play(click_snd)
end
button_add(nil,FOURButtonPressed, 520,766,55,55, FMC_1_BTN_FOUR)
--FIVE Button
function FMC_1_BTN_FIVE()
   fs2020_event("H:CJ4_FMC_1_BTN_5")
   sound_play(click_snd)
end
button_add(nil,FIVEButtonPressed, 589,766,55,55, FMC_1_BTN_FIVE)
--SIX Button
function FMC_1_BTN_SIX()
   fs2020_event("H:CJ4_FMC_1_BTN_6")
   sound_play(click_snd)
end
button_add(nil,SIXButtonPressed, 659,766,55,55, FMC_1_BTN_SIX)
--SEVEN Button
function FMC_1_BTN_SEVEN()
   fs2020_event("H:CJ4_FMC_1_BTN_7")
   sound_play(click_snd)
end
button_add(nil,SEVENButtonPressed, 520,850,55,55, FMC_1_BTN_SEVEN)
--EIGHT Button
function FMC_1_BTN_EIGHT()
   fs2020_event("H:CJ4_FMC_1_BTN_8")
   sound_play(click_snd)
end
button_add(nil,EIGHTButtonPressed, 590,850,55,55, FMC_1_BTN_EIGHT)
--NINE Button
function FMC_1_BTN_NINE()
   fs2020_event("H:CJ4_FMC_1_BTN_9")
   sound_play(click_snd)
end
button_add(nil,NINEButtonPressed, 658,850,55,55, FMC_1_BTN_NINE)
--DOT Button
function FMC_1_BTN_DOT()
   fs2020_event("H:CJ4_FMC_1_BTN_DOT")
   sound_play(click_snd)
end
button_add(nil,DOTButtonPressed, 520,934,55,55, FMC_1_BTN_DOT)
--ZERO Button
function FMC_1_BTN_ZERO()
   fs2020_event("H:CJ4_FMC_1_BTN_0")
   sound_play(click_snd)
end
button_add(nil,ZEROButtonPressed, 590,934,55,55, FMC_1_BTN_ZERO)
--PLUSMINUS Button
function FMC_1_BTN_PLUSMINUS()
   fs2020_event("H:CJ4_FMC_1_BTN_PLUSMINUS")
   sound_play(click_snd)
end
button_add(nil,PLUSMINUSButtonPressed, 659,934,55,55, FMC_1_BTN_PLUSMINUS)