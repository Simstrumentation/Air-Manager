--[[
   CJ4 FMS-3200 FMC
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.2
   Functonal as of 8-23-2021
   8-23-2021-Add SP Button
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509

--]]





--Backgroud Image before anything else
img_add_fullscreen("background.png")


--Sounds   
click_snd = sound_add("knobclick.wav")
fail_snd = sound_add("beepfail.wav")

--Display Buttons
displaybtns = user_prop_add_boolean("Display the Buttons when pressed", true, "") -- Show or hide the unit type onscreen
if user_prop_get(displaybtns) then
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
    else
    SelectorButtonPressed = nil
    CLRButtonPressed = nil
    MSGButtonPressed = nil
    DIRButtonPressed = nil
    IDXButtonPressed = nil
    TUNButtonPressed = nil
    FPLNButtonPressed = nil
    LEGSButtonPressed = nil
    DEPARRButtonPressed = nil
    PERFButtonPressed = nil
    DSPL_MENUButtonPressed = nil
    MFD_ADVButtonPressed = nil
    MFD_DATAButtonPressed = nil
    PREVPAGEButtonPressed = nil
    NEXTPAGEButtonPressed = nil
    EXECButtonPressed = nil
    DIVButtonPressed = nil
    
    AButtonPressed = nil
    BButtonPressed = nil
    CButtonPressed = nil
    DButtonPressed = nil
    EButtonPressed = nil
    FButtonPressed = nil
    GButtonPressed = nil
    HButtonPressed = nil
    IButtonPressed = nil
    JButtonPressed = nil
    KButtonPressed = nil
    LButtonPressed = nil
    MButtonPressed = nil
    NButtonPressed = nil
    OButtonPressed = nil
    PButtonPressed = nil
    QButtonPressed = nil
    RButtonPressed = nil
    SButtonPressed = nil
    TButtonPressed = nil
    UButtonPressed = nil
    VButtonPressed = nil
    WButtonPressed = nil
    XButtonPressed = nil
    YButtonPressed = nil
    ZButtonPressed = nil
    ONEButtonPressed = nil
    TWOButtonPressed = nil
    THREEButtonPressed = nil
    FOURButtonPressed = nil
    FIVEButtonPressed = nil
    SIXButtonPressed = nil
    SEVENButtonPressed = nil
    EIGHTButtonPressed = nil
    NINEButtonPressed = nil
    DOTButtonPressed = nil
    ZEROButtonPressed = nil
    PLUSMINUSButtonPressed = nil
    SPButton = nil
end 
displaybtnsalwys = user_prop_add_boolean("Display Buttons Always", false, "") -- Show or hide the unit type onscreen
if user_prop_get(displaybtnsalwys) then
    SelectorButton = "Selector_btn_pressed.png"
    CLRButton = "CLR_btn_pressed.png"
    MSGButton = "MSG_btn_pressed.png" 
    DIRButton = "DIR_btn_pressed.png"
    IDXButton = "IDX_btn_pressed.png"
    TUNButton = "TUN_btn_pressed.png"
    FPLNButton = "FPLN_btn_pressed.png"
    LEGSButton = "LEGS_btn_pressed.png"
    DEPARRButton = "DEPARR_btn_pressed.png"
    PERFButton = "PERF_btn_pressed.png"
    DSPL_MENUButton = "DSPL_MENU_btn_pressed.png"
    MFD_ADVButton = "MFD_ADV_btn_pressed.png"
    MFD_DATAButton = "MFD_DATA_btn_pressed.png"
    PREVPAGEButton = "PREVPAGE_btn_pressed.png"
    NEXTPAGEButton = "NEXTPAGE_btn_pressed.png"
    EXECButton = "EXEC_btn_pressed.png"
    DIVButton = "DIV_btn_pressed.png"
    
    AButton = "A_btn_pressed.png"
    BButton = "B_btn_pressed.png"
    CButton = "C_btn_pressed.png"
    DButton = "D_btn_pressed.png"
    EButton = "E_btn_pressed.png"
    FButton = "F_btn_pressed.png"
    GButton = "G_btn_pressed.png"
    HButton = "H_btn_pressed.png"
    IButton = "I_btn_pressed.png"
    JButton = "J_btn_pressed.png"
    KButton = "K_btn_pressed.png"
    LButton = "L_btn_pressed.png"
    MButton = "M_btn_pressed.png"
    NButton = "N_btn_pressed.png"
    OButton = "O_btn_pressed.png"
    PButton = "P_btn_pressed.png"
    QButton = "Q_btn_pressed.png"
    RButton = "R_btn_pressed.png"
    SButton = "S_btn_pressed.png"
    TButton = "T_btn_pressed.png"
    UButton = "U_btn_pressed.png"
    VButton = "V_btn_pressed.png"
    WButton = "W_btn_pressed.png"
    XButton = "X_btn_pressed.png"
    YButton = "Y_btn_pressed.png"
    ZButton = "Z_btn_pressed.png"
    ONEButton = "ONE_btn_pressed.png"
    TWOButton = "TWO_btn_pressed.png"
    THREEButton = "THREE_btn_pressed.png"
    FOURButton = "FOUR_btn_pressed.png"
    FIVEButton = "FIVE_btn_pressed.png"
    SIXButton = "SIX_btn_pressed.png"
    SEVENButton = "SEVEN_btn_pressed.png"
    EIGHTButton = "EIGHT_btn_pressed.png"
    NINEButton = "NINE_btn_pressed.png"
    DOTButton = "DOT_btn_pressed.png"
    ZEROButton = "ZERO_btn_pressed.png"
    PLUSMINUSButton = "PLUSMINUS_btn_pressed.png"
    SPButtonPressed = "SP_btn_pressed.png"
    else
    SelectorButton = nil
    CLRButton = nil
    MSGButton = nil
    DIRButton = nil
    IDXButton = nil
    TUNButton = nil
    FPLNButton = nil
    LEGSButton = nil
    DEPARRButton = nil
    PERFButton = nil
    DSPL_MENUButton = nil
    MFD_ADVButton = nil
    MFD_DATAButton = nil
    PREVPAGEButton = nil
    NEXTPAGEButton = nil
    EXECButton = nil
    DIVButton = nil
    
    AButton = nil
    BButton = nil
    CButton = nil
    DButton = nil
    EButton = nil
    FButton = nil
    GButton = nil
    HButton = nil
    IButton = nil
    JButton = nil
    KButton = nil
    LButton = nil
    MButton = nil
    NButton = nil
    OButton = nil
    PButton = nil
    QButton = nil
    RButton = nil
    SButton = nil
    TButton = nil
    UButton = nil
    VButton = nil
    WButton = nil
    XButton = nil
    YButton = nil
    ZButton = nil
    ONEButton = nil
    TWOButton = nil
    THREEButton = nil
    FOURButton = nil
    FIVEButton = nil
    SIXButton = nil
    SEVENButton = nil
    EIGHTButton = nil
    NINEButton = nil
    DOTButton = nil
    ZEROButton = nil
    PLUSMINUSButton = nil
    SPButton = nil
end 
--START OF BUTTONS************f

--L1 Button
function FMC_1_BTN_L1()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L1")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 18,159,45,25, FMC_1_BTN_L1)
--L2 Button
function FMC_1_BTN_L2()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L2")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 18,218,45,25, FMC_1_BTN_L2)
--L3 Button
function FMC_1_BTN_L3()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L3")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 18,277,45,25, FMC_1_BTN_L3)
--L4 Button
function FMC_1_BTN_L4()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L4")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 17,336,45,25, FMC_1_BTN_L4)
--L5 Button
function FMC_1_BTN_L5()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L5")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 17,396,45,25, FMC_1_BTN_L5)
--L6 Button
function FMC_1_BTN_L6()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L6")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 17,456,45,25, FMC_1_BTN_L6)
--R1 Button
function FMC_1_BTN_R1()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R1")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 728,158,45,25, FMC_1_BTN_R1)
--R2 Button
function FMC_1_BTN_R2()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R2")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 728,217,45,25, FMC_1_BTN_R2)
--R3 Button
function FMC_1_BTN_R3()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R3")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 728,276,45,25, FMC_1_BTN_R3)
--R4 Button
function FMC_1_BTN_R4()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R4")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 729,335,45,25, FMC_1_BTN_R4)
--R5 Button
function FMC_1_BTN_R5()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R5")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 729,394,45,25, FMC_1_BTN_R5)
--R6 Button
function FMC_1_BTN_R6()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R6")
   sound_play(click_snd)
end
button_add(SelectorButton,SelectorButtonPressed, 730,454,45,25, FMC_1_BTN_R6)


--MSG Button
function FMC_1_BTN_MSG()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_MSG")
   sound_play(click_snd)
end
button_add(MSGButton,MSGButtonPressed, 16,530,52,52, FMC_1_BTN_MSG)
--DIR Button
function FMC_1_BTN_DIR()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_DIR")
   sound_play(click_snd)
end
button_add(DIRButton,DIRButtonPressed, 16,600,52,52, FMC_1_BTN_DIR)
--IDX Button
function FMC_1_BTN_IDX()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_IDX")
   sound_play(click_snd)
end
button_add(IDXButton,IDXButtonPressed, 16,670,52,52, FMC_1_BTN_IDX)
--TUN Button
function FMC_1_BTN_TUN()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_TUN")
   sound_play(click_snd)
end
button_add(TUNButton,TUNButtonPressed, 16,754,52,52, FMC_1_BTN_TUN)
--FPLN Button
function FMC_1_BTN_FPLN()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_FPLN")
   sound_play(click_snd)
end
button_add(FPLNButton,FPLNButtonPressed, 94,600,52,52, FMC_1_BTN_FPLN)
--LEGS Button
function FMC_1_BTN_LEGS()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_LEGS")
   sound_play(click_snd)
end
button_add(LEGSButton,LEGSButtonPressed, 173,600,52,52, FMC_1_BTN_LEGS)
--DEPARR Button
function FMC_1_BTN_DEPARR()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_DEPARR")
   sound_play(click_snd)
end
button_add(DEPARRButton,DEPARRButtonPressed, 252,600,52,52, FMC_1_BTN_DEPARR)
--PERF Button
function FMC_1_BTN_PERF()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_PERF")
   sound_play(click_snd)
end
button_add(PERFButton,PERFButtonPressed, 331,600,52,52, FMC_1_BTN_PERF)
--DSPL_MENU Button
function FMC_1_BTN_DSPL_MENU()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_DSPL_MENU")
   sound_play(click_snd)
end
button_add(DSPL_MENUButton,DSPL_MENUButtonPressed, 410,600,52,52, FMC_1_BTN_DSPL_MENU)
--MFD_ADV Button
function FMC_1_BTN_MFD_ADV()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_MFD_ADV")
   sound_play(click_snd)
end
button_add(MFD_ADVButton,MFD_ADVButtonPressed, 489,600,52,52, FMC_1_BTN_MFD_ADV)
--MFD_DATA Button
function FMC_1_BTN_MFD_DATA()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_MFD_DATA")
   sound_play(click_snd)
end
button_add(MFD_DATAButton,MFD_DATAButtonPressed, 568,600,52,52, FMC_1_BTN_MFD_DATA)
--PREVPAGE Button
function FMC_1_BTN_PREVPAGE()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_PREVPAGE")
   sound_play(click_snd)
end
button_add(PREVPAGEButton,PREVPAGEButtonPressed, 645,600,52,52, FMC_1_BTN_PREVPAGE)
--NEXTPAGE Button
function FMC_1_BTN_NEXTPAGE()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_NEXTPAGE")
   sound_play(click_snd)
end
button_add(NEXTPAGEButton,NEXTPAGEButtonPressed, 728,600,52,52, FMC_1_BTN_NEXTPAGE)
--EXEC Button
function FMC_1_BTN_EXEC()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_EXEC")
   sound_play(click_snd)
end
button_add(EXECButton,EXECButtonPressed, 728,530,52,52, FMC_1_BTN_EXEC)


--CLR Button
function FMC_1_BTN_CLR_Start()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_CLR")
   sound_play(click_snd)
   timer_id1 = timer_start(1000,CLR_LONG)
end
function FMC_1_BTN_CLR_End()
       timer_stop(timer_id1)
end

function CLR_LONG()
fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_CLR_LONG")
end

button_add(CLRButton,CLRButtonPressed, 731,671,52,52, FMC_1_BTN_CLR_Start, FMC_1_BTN_CLR_End)

--BRT Button **DOESN'T WORK
function FMC_1_BTN_BRT()
   fs2020_event("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM",100)
   sound_play(fail_snd)
end
button_add(nil,nil, 733,741,42,42, FMC_1_BTN_BRT)
--DIM Button **DOESN'T WORK
function FMC_1_BTN_DIM()
   fs2020_event("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM",0)
   sound_play(fail_snd)
end
button_add(nil,nil, 733,790,42,42, FMC_1_BTN_DIM)








--A Button
function FMC_1_BTN_A()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_A")
   sound_play(click_snd)
end
button_add(AButton,AButtonPressed, 83,671,52,52, FMC_1_BTN_A)
--B Button
function FMC_1_BTN_B()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_B")
   sound_play(click_snd)
end
button_add(BButton,BButtonPressed, 145,671,52,52, FMC_1_BTN_B)
--C Button
function FMC_1_BTN_C()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_C")
   sound_play(click_snd)
end
button_add(CButton,CButtonPressed, 207,671,52,52, FMC_1_BTN_C)
--D Button
function FMC_1_BTN_D()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_D")
   sound_play(click_snd)
end
button_add(DButton,DButtonPressed, 269,671,52,52, FMC_1_BTN_D)
--E Button
function FMC_1_BTN_E()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_E")
   sound_play(click_snd)
end
button_add(EButton,EButtonPressed, 331,671,52,52, FMC_1_BTN_E)
--F Button
function FMC_1_BTN_F()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_F")
   sound_play(click_snd)
end
button_add(FButton,FButtonPressed, 393,671,52,52, FMC_1_BTN_F)
--G Button
function FMC_1_BTN_G()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_G")
   sound_play(click_snd)
end
button_add(GButton,GButtonPressed, 455,671,52,52, FMC_1_BTN_G)
--H Button
function FMC_1_BTN_H()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_H")
   sound_play(click_snd)
end
button_add(HButton,HButtonPressed, 83,754,52,52, FMC_1_BTN_H)
--I Button
function FMC_1_BTN_I()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_I")
   sound_play(click_snd)
end
button_add(IButton,IButtonPressed, 145,754,52,52, FMC_1_BTN_I)
--J Button
function FMC_1_BTN_J()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_J")
   sound_play(click_snd)
end
button_add(JButton,JButtonPressed, 207,754,52,52, FMC_1_BTN_J)
--K Button
function FMC_1_BTN_K()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_K")
   sound_play(click_snd)
end
button_add(KButton,KButtonPressed, 269,754,52,52, FMC_1_BTN_K)
--L Button
function FMC_1_BTN_L()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_L")
   sound_play(click_snd)
end
button_add(LButton,LButtonPressed, 331,754,52,52, FMC_1_BTN_L)
--M Button
function FMC_1_BTN_M()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_M")
   sound_play(click_snd)
end
button_add(MButton,MButtonPressed, 395,754,52,52, FMC_1_BTN_M)
--N Button
function FMC_1_BTN_N()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_N")
   sound_play(click_snd)
end
button_add(NButton,NButtonPressed, 458,754,52,52, FMC_1_BTN_N)
--O Button
function FMC_1_BTN_O()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_O")
   sound_play(click_snd)
end
button_add(OButton,OButtonPressed, 83,837,52,52, FMC_1_BTN_O)
--P Button
function FMC_1_BTN_P()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_P")
   sound_play(click_snd)
end
button_add(PButton,PButtonPressed, 145,837,52,52, FMC_1_BTN_P)
--Q Button
function FMC_1_BTN_Q()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_Q")
   sound_play(click_snd)
end
button_add(QButton,QButtonPressed, 207,837,52,52, FMC_1_BTN_Q)
--R Button
function FMC_1_BTN_R()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_R")
   sound_play(click_snd)
end
button_add(RButton,RButtonPressed, 269,837,52,52, FMC_1_BTN_R)
--S Button
function FMC_1_BTN_S()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_S")
   sound_play(click_snd)
end
button_add(SButton,SButtonPressed, 331,837,52,52, FMC_1_BTN_S)
--T Button
function FMC_1_BTN_T()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_T")
   sound_play(click_snd)
end
button_add(TButton,TButtonPressed, 395,837,52,52, FMC_1_BTN_T)
--U Button
function FMC_1_BTN_U()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_U")
   sound_play(click_snd)
end
button_add(UButton,UButtonPressed, 458,837,52,52, FMC_1_BTN_U)
--V Button
function FMC_1_BTN_V()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_V")
   sound_play(click_snd)
end
button_add(VButton,VButtonPressed, 83,921,52,52, FMC_1_BTN_V)
--W Button
function FMC_1_BTN_W()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_W")
   sound_play(click_snd)
end
button_add(WButton,WButtonPressed, 145,921,52,52, FMC_1_BTN_W)
--X Button
function FMC_1_BTN_X()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_X")
   sound_play(click_snd)
end
button_add(XButton,XButtonPressed, 207,921,52,52, FMC_1_BTN_X)
--Y Button
function FMC_1_BTN_Y()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_Y")
   sound_play(click_snd)
end
button_add(YButton,YButtonPressed, 269,921,52,52, FMC_1_BTN_Y)
--Z Button
function FMC_1_BTN_Z()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_Z")
   sound_play(click_snd)
end
button_add(ZButton,ZButtonPressed, 331,921,52,52, FMC_1_BTN_Z)


--SP Button
function FMC_1_BTN_SP()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_SP")
   sound_play(click_snd)
end
button_add(SPButton,SPButtonPressed, 395,921,52,52, FMC_1_BTN_SP)
--DIV Button
function FMC_1_BTN_DIV()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_DIV")
   sound_play(click_snd)
end
button_add(DIVButton,DIVButtonPressed, 458,921,52,52, FMC_1_BTN_DIV)


--ONE Button
function FMC_1_BTN_ONE()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_1")
   sound_play(click_snd)
end
button_add(ONEButton,ONEButtonPressed, 520,669,55,55, FMC_1_BTN_ONE)
--TWO Button
function FMC_1_BTN_TWO()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_2")
   sound_play(click_snd)
end
button_add(TWOButton,TWOButtonPressed, 590,669,55,55, FMC_1_BTN_TWO)
--THREE Button
function FMC_1_BTN_THREE()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_3")
   sound_play(click_snd)
end
button_add(THREEButton,THREEButtonPressed, 659,669,55,55, FMC_1_BTN_THREE)
--FOUR Button
function FMC_1_BTN_FOUR()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_4")
   sound_play(click_snd)
end
button_add(FOURButton,FOURButtonPressed, 520,753,55,55, FMC_1_BTN_FOUR)
--FIVE Button
function FMC_1_BTN_FIVE()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_5")
   sound_play(click_snd)
end
button_add(FIVEButton,FIVEButtonPressed, 589,752,55,55, FMC_1_BTN_FIVE)
--SIX Button
function FMC_1_BTN_SIX()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_6")
   sound_play(click_snd)
end
button_add(SIXButton,SIXButtonPressed, 659,752,55,55, FMC_1_BTN_SIX)
--SEVEN Button
function FMC_1_BTN_SEVEN()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_7")
   sound_play(click_snd)
end
button_add(SEVENButton,SEVENButtonPressed, 520,836,55,55, FMC_1_BTN_SEVEN)
--EIGHT Button
function FMC_1_BTN_EIGHT()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_8")
   sound_play(click_snd)
end
button_add(EIGHTButton,EIGHTButtonPressed, 590,836,55,55, FMC_1_BTN_EIGHT)
--NINE Button
function FMC_1_BTN_NINE()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_9")
   sound_play(click_snd)
end
button_add(NINEButton,NINEButtonPressed, 658,836,55,55, FMC_1_BTN_NINE)
--DOT Button
function FMC_1_BTN_DOT()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_DOT")
   sound_play(click_snd)
end
button_add(DOTButton,DOTButtonPressed, 520,920,55,55, FMC_1_BTN_DOT)
--ZERO Button
function FMC_1_BTN_ZERO()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_0")
   sound_play(click_snd)
end
button_add(ZEROButton,ZEROButtonPressed, 590,920,55,55, FMC_1_BTN_ZERO)
--PLUSMINUS Button
function FMC_1_BTN_PLUSMINUS()
   fs2020_event("MOBIFLIGHT.CJ4_FMC_1_BTN_PLUSMINUS")
   sound_play(click_snd)
end
button_add(PLUSMINUSButton,PLUSMINUSButtonPressed, 662,920,55,55, FMC_1_BTN_PLUSMINUS)