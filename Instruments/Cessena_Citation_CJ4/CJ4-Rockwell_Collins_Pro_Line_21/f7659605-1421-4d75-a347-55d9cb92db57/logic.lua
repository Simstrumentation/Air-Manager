--[[
******************************************************************************************
******************Cessna Citation CJ4 FMS MCDU Overlay*****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 03-07-2021 Rob Verdon
    - Original Panel Created
- **v1.1** 08-23-2021 Rob Verdon
    - Add Space Button on keypad.
- **v1.2** 09-05-2021 
    - Replaced mobi flight variables with HVARs.
- **v1.3** 09-12-2021 Herbert Puukka
    - Replaced background image with better one.
    - The new default size is 800x1010. You may need to resize your instruments.
- **v1.4** 09-13-2021 Rob Verdon
    - Cleaned up code, removed user option to show buttons. 
- **v2.0** 9-26-2021 Joe Gilker
    - New graphics
    - Added night mode 
    - Added back lighting
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status

##Left To Do:
    - 	Brightness BRT/DIM Buttons not active due to BVars not accessible.
	
##Notes:
    -   

******************************************************************************************        
--]]

--Backgroud Image 
img_add_fullscreen("background.png")

img_bg_night = img_add_fullscreen("background_night.png")

function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- Ambient Light Control
img_backlight = img_add_fullscreen("backlight.png")
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  

--Sounds   
snd_click = sound_add("knobclick.wav")
snd_fail = sound_add("beepfail.wav")

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
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,183,60,33, FMC_1_BTN_L1)
--L2 Button
function FMC_1_BTN_L2()
   fs2020_event("H:CJ4_FMC_1_BTN_L2")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,246,60,33, FMC_1_BTN_L2)
--L3 Button
function FMC_1_BTN_L3()
   fs2020_event("H:CJ4_FMC_1_BTN_L3")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,309,60,33, FMC_1_BTN_L3)
--L4 Button
function FMC_1_BTN_L4()
   fs2020_event("H:CJ4_FMC_1_BTN_L4")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,372,60,33, FMC_1_BTN_L4)
--L5 Button
function FMC_1_BTN_L5()
   fs2020_event("H:CJ4_FMC_1_BTN_L5")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,435,60,33, FMC_1_BTN_L5)
--L6 Button
function FMC_1_BTN_L6()
   fs2020_event("H:CJ4_FMC_1_BTN_L6")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,499,60,33, FMC_1_BTN_L6)
--R1 Button
function FMC_1_BTN_R1()
   fs2020_event("H:CJ4_FMC_1_BTN_R1")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,183,60,33, FMC_1_BTN_R1)
--R2 Button
function FMC_1_BTN_R2()
   fs2020_event("H:CJ4_FMC_1_BTN_R2")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,247,60,33, FMC_1_BTN_R2)
--R3 Button
function FMC_1_BTN_R3()
   fs2020_event("H:CJ4_FMC_1_BTN_R3")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,310,60,33, FMC_1_BTN_R3)
--R4 Button
function FMC_1_BTN_R4()
   fs2020_event("H:CJ4_FMC_1_BTN_R4")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,372,60,33, FMC_1_BTN_R4)
--R5 Button
function FMC_1_BTN_R5()
   fs2020_event("H:CJ4_FMC_1_BTN_R5")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,435,60,33, FMC_1_BTN_R5)
--R6 Button
function FMC_1_BTN_R6()
   fs2020_event("H:CJ4_FMC_1_BTN_R6")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,499,60,33, FMC_1_BTN_R6)


--MSG Button
function FMC_1_BTN_MSG()
   fs2020_event("H:CJ4_FMC_1_BTN_MSG")
   sound_play(snd_click)
end
button_add(nil,MSGButtonPressed, 14,572,51,47, FMC_1_BTN_MSG)
--DIR Button
function FMC_1_BTN_DIR()
   fs2020_event("H:CJ4_FMC_1_BTN_DIR")
   sound_play(snd_click)
end
button_add(nil,DIRButtonPressed, 14,634,51,47, FMC_1_BTN_DIR)
--IDX Button
function FMC_1_BTN_IDX()
   fs2020_event("H:CJ4_FMC_1_BTN_IDX")
   sound_play(snd_click)
end
button_add(nil,IDXButtonPressed, 14,697,51,47, FMC_1_BTN_IDX)
--TUN Button
function FMC_1_BTN_TUN()
   fs2020_event("H:CJ4_FMC_1_BTN_TUN")
   sound_play(snd_click)
end
button_add(nil,TUNButtonPressed, 14,772,51,47, FMC_1_BTN_TUN)
--FPLN Button
function FMC_1_BTN_FPLN()
   fs2020_event("H:CJ4_FMC_1_BTN_FPLN")
   sound_play(snd_click)
end
button_add(nil,FPLNButtonPressed, 87,634,51,47, FMC_1_BTN_FPLN)
--LEGS Button
function FMC_1_BTN_LEGS()
   fs2020_event("H:CJ4_FMC_1_BTN_LEGS")
   sound_play(snd_click)
end
button_add(nil,LEGSButtonPressed, 162,634,51,47, FMC_1_BTN_LEGS)
--DEPARR Button
function FMC_1_BTN_DEPARR()
   fs2020_event("H:CJ4_FMC_1_BTN_DEPARR")
   sound_play(snd_click)
end
button_add(nil,DEPARRButtonPressed, 235,634,51,47, FMC_1_BTN_DEPARR)
--PERF Button
function FMC_1_BTN_PERF()
   fs2020_event("H:CJ4_FMC_1_BTN_PERF")
   sound_play(snd_click)
end
button_add(nil,PERFButtonPressed, 308,634,51,47, FMC_1_BTN_PERF)
--DSPL_MENU Button
function FMC_1_BTN_DSPL_MENU()
   fs2020_event("H:CJ4_FMC_1_BTN_DSPL_MENU")
   sound_play(snd_click)
end
button_add(nil,DSPL_MENUButtonPressed, 383,634,51,47, FMC_1_BTN_DSPL_MENU)
--MFD_ADV Button
function FMC_1_BTN_MFD_ADV()
   fs2020_event("H:CJ4_FMC_1_BTN_MFD_ADV")
   sound_play(snd_click)
end
button_add(nil,MFD_ADVButtonPressed, 456,634,51,47, FMC_1_BTN_MFD_ADV)
--MFD_DATA Button
function FMC_1_BTN_MFD_DATA()
   fs2020_event("H:CJ4_FMC_1_BTN_MFD_DATA")
   sound_play(snd_click)
end
button_add(nil,MFD_DATAButtonPressed, 531,634,51,47, FMC_1_BTN_MFD_DATA)
--PREVPAGE Button
function FMC_1_BTN_PREVPAGE()
   fs2020_event("H:CJ4_FMC_1_BTN_PREVPAGE")
   sound_play(snd_click)
end
button_add(nil,PREVPAGEButtonPressed, 602,634,51,47, FMC_1_BTN_PREVPAGE)
--NEXTPAGE Button
function FMC_1_BTN_NEXTPAGE()
   fs2020_event("H:CJ4_FMC_1_BTN_NEXTPAGE")
   sound_play(snd_click)
end
button_add(nil,NEXTPAGEButtonPressed, 683,634,51,47, FMC_1_BTN_NEXTPAGE)
--EXEC Button
function FMC_1_BTN_EXEC()
   fs2020_event("H:CJ4_FMC_1_BTN_EXEC")
   sound_play(snd_click)
end
button_add(nil,EXECButtonPressed, 683,572,51,47, FMC_1_BTN_EXEC)


--CLR Button
function FMC_1_BTN_CLR_Start()
   fs2020_event("H:CJ4_FMC_1_BTN_CLR")
   sound_play(snd_click)
   timer_id1 = timer_start(1000,CLR_LONG)
end
function FMC_1_BTN_CLR_End()
       timer_stop(timer_id1)
end

function CLR_LONG()
fs2020_event("H:CJ4_FMC_1_BTN_CLR_LONG")
end

button_add(nil,CLRButtonPressed, 683,696,51,47, FMC_1_BTN_CLR_Start, FMC_1_BTN_CLR_End)

--BRT Button **DOESN'T WORK
function FMC_1_BTN_BRT()
  --TESTING:
   --fs2020_variable_write("I:XMLVAR_MCDU_1_Brightness", "Int", 1)
   -- fs2020_event("I:XMLVAR_MCDU_1_Brightness",1)
   --fs2020_event("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM",1)
   --fs2020_variable_write("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM", "Int", 1)
   --sound_play(snd_fail)
end
button_add(nil,nil, 733,755,42,42, FMC_1_BTN_BRT)
--DIM Button **DOESN'T WORK
function FMC_1_BTN_DIM()
  -- fs2020_event("O:XMLVAR_FMC_CJ4_1_Button_BRT_DIM",0)
   --sound_play(snd_fail)
end
button_add(nil,nil, 733,804,42,42, FMC_1_BTN_DIM)

--A Button
function FMC_1_BTN_A()
   fs2020_event("H:CJ4_FMC_1_BTN_A")
   sound_play(snd_click)
end
button_add(nil,AButtonPressed, 77,697,51,47, FMC_1_BTN_A)
--B Button
function FMC_1_BTN_B()
   fs2020_event("H:CJ4_FMC_1_BTN_B")
   sound_play(snd_click)
end
button_add(nil,BButtonPressed, 136,697,51,47, FMC_1_BTN_B)
--C Button
function FMC_1_BTN_C()
   fs2020_event("H:CJ4_FMC_1_BTN_C")
   sound_play(snd_click)
end
button_add(nil,CButtonPressed, 193,697,51,47, FMC_1_BTN_C)
--D Button
function FMC_1_BTN_D()
   fs2020_event("H:CJ4_FMC_1_BTN_D")
   sound_play(snd_click)
end
button_add(nil,DButtonPressed, 252,697,51,47, FMC_1_BTN_D)
--E Button
function FMC_1_BTN_E()
   fs2020_event("H:CJ4_FMC_1_BTN_E")
   sound_play(snd_click)
end
button_add(nil,EButtonPressed, 311,697,51,47, FMC_1_BTN_E)
--F Button
function FMC_1_BTN_F()
   fs2020_event("H:CJ4_FMC_1_BTN_F")
   sound_play(snd_click)
end
button_add(nil,FButtonPressed, 370,697,51,47, FMC_1_BTN_F)
--G Button
function FMC_1_BTN_G()
   fs2020_event("H:CJ4_FMC_1_BTN_G")
   sound_play(snd_click)
end
button_add(nil,GButtonPressed, 429,697,51,47, FMC_1_BTN_G)
--H Button
function FMC_1_BTN_H()
   fs2020_event("H:CJ4_FMC_1_BTN_H")
   sound_play(snd_click)
end
button_add(nil,HButtonPressed, 76,772,51,47, FMC_1_BTN_H)
--I Button
function FMC_1_BTN_I()
   fs2020_event("H:CJ4_FMC_1_BTN_I")
   sound_play(snd_click)
end
button_add(nil,IButtonPressed, 134,772,51,47, FMC_1_BTN_I)
--J Button
function FMC_1_BTN_J()
   fs2020_event("H:CJ4_FMC_1_BTN_J")
   sound_play(snd_click)
end
button_add(nil,JButtonPressed, 193,772,51,47, FMC_1_BTN_J)
--K Button
function FMC_1_BTN_K()
   fs2020_event("H:CJ4_FMC_1_BTN_K")
   sound_play(snd_click)
end
button_add(nil,KButtonPressed, 253,772,51,47, FMC_1_BTN_K)
--L Button
function FMC_1_BTN_L()
   fs2020_event("H:CJ4_FMC_1_BTN_L")
   sound_play(snd_click)
end
button_add(nil,LButtonPressed, 311,772,51,47, FMC_1_BTN_L)
--M Button
function FMC_1_BTN_M()
   fs2020_event("H:CJ4_FMC_1_BTN_M")
   sound_play(snd_click)
end
button_add(nil,MButtonPressed, 370,772,51,47, FMC_1_BTN_M)
--N Button
function FMC_1_BTN_N()
   fs2020_event("H:CJ4_FMC_1_BTN_N")
   sound_play(snd_click)
end
button_add(nil,NButtonPressed, 429,772,51,47, FMC_1_BTN_N)
--O Button
function FMC_1_BTN_O()
   fs2020_event("H:CJ4_FMC_1_BTN_O")
   sound_play(snd_click)
end
button_add(nil,OButtonPressed, 77,846,51,47, FMC_1_BTN_O)
--P Button
function FMC_1_BTN_P()
   fs2020_event("H:CJ4_FMC_1_BTN_P")
   sound_play(snd_click)
end
button_add(nil,PButtonPressed, 136,846,51,47, FMC_1_BTN_P)
--Q Button
function FMC_1_BTN_Q()
   fs2020_event("H:CJ4_FMC_1_BTN_Q")
   sound_play(snd_click)
end
button_add(nil,QButtonPressed, 193,846,51,47, FMC_1_BTN_Q)
--R Button
function FMC_1_BTN_R()
   fs2020_event("H:CJ4_FMC_1_BTN_R")
   sound_play(snd_click)
end
button_add(nil,RButtonPressed, 252,846,51,47, FMC_1_BTN_R)
--S Button
function FMC_1_BTN_S()
   fs2020_event("H:CJ4_FMC_1_BTN_S")
   sound_play(snd_click)
end
button_add(nil,SButtonPressed, 311,846,51,47, FMC_1_BTN_S)
--T Button
function FMC_1_BTN_T()
   fs2020_event("H:CJ4_FMC_1_BTN_T")
   sound_play(snd_click)
end
button_add(nil,TButtonPressed, 370,846,51,47, FMC_1_BTN_T)
--U Button
function FMC_1_BTN_U()
   fs2020_event("H:CJ4_FMC_1_BTN_U")
   sound_play(snd_click)
end
button_add(nil,UButtonPressed, 429,846,51,47, FMC_1_BTN_U)
--V Button
function FMC_1_BTN_V()
   fs2020_event("H:CJ4_FMC_1_BTN_V")
   sound_play(snd_click)
end
button_add(nil,VButtonPressed, 75,921,51,47, FMC_1_BTN_V)
--W Button
function FMC_1_BTN_W()
   fs2020_event("H:CJ4_FMC_1_BTN_W")
   sound_play(snd_click)
end
button_add(nil,WButtonPressed, 135,921,51,47, FMC_1_BTN_W)
--X Button
function FMC_1_BTN_X()
   fs2020_event("H:CJ4_FMC_1_BTN_X")
   sound_play(snd_click)
end
button_add(nil,XButtonPressed, 193,921,51,47, FMC_1_BTN_X)
--Y Button
function FMC_1_BTN_Y()
   fs2020_event("H:CJ4_FMC_1_BTN_Y")
   sound_play(snd_click)
end
button_add(nil,YButtonPressed, 253,921,51,47, FMC_1_BTN_Y)
--Z Button
function FMC_1_BTN_Z()
   fs2020_event("H:CJ4_FMC_1_BTN_Z")
   sound_play(snd_click)
end
button_add(nil,ZButtonPressed, 311,921,51,47, FMC_1_BTN_Z)


--SP Button
function FMC_1_BTN_SP()
   fs2020_event("H:CJ4_FMC_1_BTN_SP")
   sound_play(snd_click)
end
button_add(nil,SPButtonPressed, 370,919,51,47, FMC_1_BTN_SP)
--DIV Button
function FMC_1_BTN_DIV()
   fs2020_event("H:CJ4_FMC_1_BTN_DIV")
   sound_play(snd_click)
end
button_add(nil,DIVButtonPressed, 429,919,51,47, FMC_1_BTN_DIV)


--ONE Button
function FMC_1_BTN_ONE()
   fs2020_event("H:CJ4_FMC_1_BTN_1")
   sound_play(snd_click)
end
button_add(nil,ONEButtonPressed, 487,695,50,50, FMC_1_BTN_ONE)
--TWO Button
function FMC_1_BTN_TWO()
   fs2020_event("H:CJ4_FMC_1_BTN_2")
   sound_play(snd_click)
end
button_add(nil,TWOButtonPressed, 553,695,50,50, FMC_1_BTN_TWO)
--THREE Button
function FMC_1_BTN_THREE()
   fs2020_event("H:CJ4_FMC_1_BTN_3")
   sound_play(snd_click)
end
button_add(nil,THREEButtonPressed, 618,695,50,50, FMC_1_BTN_THREE)
--FOUR Button
function FMC_1_BTN_FOUR()
   fs2020_event("H:CJ4_FMC_1_BTN_4")
   sound_play(snd_click)
end
button_add(nil,FOURButtonPressed, 488,768,50,50, FMC_1_BTN_FOUR)
--FIVE Button
function FMC_1_BTN_FIVE()
   fs2020_event("H:CJ4_FMC_1_BTN_5")
   sound_play(snd_click)
end
button_add(nil,FIVEButtonPressed, 553,768,50,50, FMC_1_BTN_FIVE)
--SIX Button
function FMC_1_BTN_SIX()
   fs2020_event("H:CJ4_FMC_1_BTN_6")
   sound_play(snd_click)
end
button_add(nil,SIXButtonPressed, 618,768,50,50, FMC_1_BTN_SIX)
--SEVEN Button
function FMC_1_BTN_SEVEN()
   fs2020_event("H:CJ4_FMC_1_BTN_7")
   sound_play(snd_click)
end
button_add(nil,SEVENButtonPressed, 488,844,50,50, FMC_1_BTN_SEVEN)
--EIGHT Button
function FMC_1_BTN_EIGHT()
   fs2020_event("H:CJ4_FMC_1_BTN_8")
   sound_play(snd_click)
end
button_add(nil,EIGHTButtonPressed, 555,844,50,50, FMC_1_BTN_EIGHT)
--NINE Button
function FMC_1_BTN_NINE()
   fs2020_event("H:CJ4_FMC_1_BTN_9")
   sound_play(snd_click)
end
button_add(nil,NINEButtonPressed, 618,844,50,50, FMC_1_BTN_NINE)
--DOT Button
function FMC_1_BTN_DOT()
   fs2020_event("H:CJ4_FMC_1_BTN_DOT")
   sound_play(snd_click)
end
button_add(nil,DOTButtonPressed, 487,918,50,50, FMC_1_BTN_DOT)
--ZERO Button
function FMC_1_BTN_ZERO()
   fs2020_event("H:CJ4_FMC_1_BTN_0")
   sound_play(snd_click)
end
button_add(nil,ZEROButtonPressed, 554,918,50,50, FMC_1_BTN_ZERO)
--PLUSMINUS Button
function FMC_1_BTN_PLUSMINUS()
   fs2020_event("H:CJ4_FMC_1_BTN_PLUSMINUS")
   sound_play(snd_click)
end
button_add(nil,PLUSMINUSButtonPressed, 618,918,50,50, FMC_1_BTN_PLUSMINUS)