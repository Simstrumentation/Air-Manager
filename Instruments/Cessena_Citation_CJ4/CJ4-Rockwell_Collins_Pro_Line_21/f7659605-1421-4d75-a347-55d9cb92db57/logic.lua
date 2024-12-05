--[[
******************************************************************************************
******************Cessna Citation CJ4 FMS MCDU Overlay*****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com
   
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
- **v2.0** 10-5-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 12-30-2021    
    - Prepare for SI Submission to store
    - Added note to Github link in Info
    - Replaced sounds with custom built sounds
    - Renamed graphics to remove capitals
- **v2.2** 12-06-2022        
   - Updated code to reflect AAU1 being released in 2023Q1
   - Added screen power feature

## Left To Do:
  - Brightness BRT/DIM Buttons not active due to vars not accessible.
	
## Notes:
  - N/A  

******************************************************************************************        
--]]

--SET USER PROPERTIES
unit_pos = user_prop_add_enum("Position", "Pilot,Copilot", "Pilot", "Choose instrument position")

--  unit position
if user_prop_get(unit_pos) == "Pilot" then
    instr_pos = "1"
else
    instr_pos = "2"
end


--Backgroud Image 
screenoff = img_add("display_off.png", 70, 50, 600, 600)
img_add_fullscreen("background.png")

img_bg_night = img_add_fullscreen("background_night.png")

function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

-- Ambient Light Control
img_backlight = img_add_fullscreen("backlight.png")
function ss_backlighting(value, panellight, power, extpower, busvolts)
    value = var_round(value,2)      
    if  panellight == false  or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                           "LIGHT PANEL","Bool",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)

function ss_screenpower(Cir47)
        if Cir47== true then
            visible(screenoff, false)
        else
            visible(screenoff, true)
        end        
end
msfs_variable_subscribe(
                          "CIRCUIT ON:47","bool", ss_screenpower)


--Sounds   
snd_click = sound_add("click.wav")

--Button Graphics
    SelectorButtonPressed = "selector_btn_pressed.png"
    CLRButtonPressed = "clr_btn_pressed.png"
    MSGButtonPressed = "msg_btn_pressed.png"
    DIRButtonPressed = "dir_btn_pressed.png"
    IDXButtonPressed = "idx_btn_pressed.png"
    TUNButtonPressed = "tun_btn_pressed.png"
    FPLNButtonPressed = "fpln_btn_pressed.png"
    LEGSButtonPressed = "legs_btn_pressed.png"
    DEPAPRButtonPressed = "deparr_btn_pressed.png"
    PERFButtonPressed = "perf_btn_pressed.png"
    DSPL_MENUButtonPressed = "dspl_menu_btn_pressed.png"
    MFD_ADVButtonPressed = "mfd_adv_btn_pressed.png"
    MFD_DATAButtonPressed = "mfd_data_btn_pressed.png"
    PREVPAGEButtonPressed = "prevpage_btn_pressed.png"
    NEXTPAGEButtonPressed = "nextpage_btn_pressed.png"
    EXECButtonPressed = "exec_btn_pressed.png"
    DIVButtonPressed = "div_btn_pressed.png"
    
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
    ONEButtonPressed = "one_btn_pressed.png"
    TWOButtonPressed = "two_btn_pressed.png"
    THREEButtonPressed = "three_btn_pressed.png"
    FOURButtonPressed = "four_btn_pressed.png"
    FIVEButtonPressed = "five_btn_pressed.png"
    SIXButtonPressed = "six_btn_pressed.png"
    SEVENButtonPressed = "seven_btn_pressed.png"
    EIGHTButtonPressed = "eight_btn_pressed.png"
    NINEButtonPressed = "nine_btn_pressed.png"
    DOTButtonPressed = "dot_btn_pressed.png"
    ZEROButtonPressed = "zero_btn_pressed.png"
    PLUSMINUSButtonPressed = "plusminus_btn_pressed.png"
    SPButtonPressed = "sp_btn_pressed.png"

--START OF BUTTONS************

--L1 Button
function FMC_1_BTN_L1()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L1")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,183,60,33, FMC_1_BTN_L1)
--L2 Button
function FMC_1_BTN_L2()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L2")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,246,60,33, FMC_1_BTN_L2)
--L3 Button
function FMC_1_BTN_L3()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L3")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,309,60,33, FMC_1_BTN_L3)
--L4 Button
function FMC_1_BTN_L4()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L4")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,372,60,33, FMC_1_BTN_L4)
--L5 Button
function FMC_1_BTN_L5()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L5")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,435,60,33, FMC_1_BTN_L5)
--L6 Button
function FMC_1_BTN_L6()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L6")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 21,499,60,33, FMC_1_BTN_L6)
--R1 Button
function FMC_1_BTN_R1()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R1")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,183,60,33, FMC_1_BTN_R1)
--R2 Button
function FMC_1_BTN_R2()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R2")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,247,60,33, FMC_1_BTN_R2)
--R3 Button
function FMC_1_BTN_R3()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R3")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,310,60,33, FMC_1_BTN_R3)
--R4 Button
function FMC_1_BTN_R4()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R4")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,372,60,33, FMC_1_BTN_R4)
--R5 Button
function FMC_1_BTN_R5()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R5")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,435,60,33, FMC_1_BTN_R5)
--R6 Button
function FMC_1_BTN_R6()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R6")
   sound_play(snd_click)
end
button_add(nil,SelectorButtonPressed, 654,499,60,33, FMC_1_BTN_R6)


--MSG Button
function FMC_1_BTN_MSG()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_MSG")
   sound_play(snd_click)
end
button_add(nil,MSGButtonPressed, 14,572,51,47, FMC_1_BTN_MSG)
--DIR Button
function FMC_1_BTN_DIR()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_DIR")
   sound_play(snd_click)
end
button_add(nil,DIRButtonPressed, 14,634,51,47, FMC_1_BTN_DIR)
--IDX Button
function FMC_1_BTN_IDX()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_IDX")
   sound_play(snd_click)
end
button_add(nil,IDXButtonPressed, 14,697,51,47, FMC_1_BTN_IDX)
--TUN Button
function FMC_1_BTN_TUN()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_TUN")
   sound_play(snd_click)
end
button_add(nil,TUNButtonPressed, 14,772,51,47, FMC_1_BTN_TUN)
--FPLN Button
function FMC_1_BTN_FPLN()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_FPLN")
   sound_play(snd_click)
end
button_add(nil,FPLNButtonPressed, 87,634,51,47, FMC_1_BTN_FPLN)
--LEGS Button
function FMC_1_BTN_LEGS()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_LEGS")
   sound_play(snd_click)
end
button_add(nil,LEGSButtonPressed, 162,634,51,47, FMC_1_BTN_LEGS)
--DEPARR Button
function FMC_1_BTN_DEPARR()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_DEPARR")
   sound_play(snd_click)
end
button_add(nil,DEPARRButtonPressed, 235,634,51,47, FMC_1_BTN_DEPARR)
--PERF Button
function FMC_1_BTN_PERF()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_PERF")
   sound_play(snd_click)
end
button_add(nil,PERFButtonPressed, 308,634,51,47, FMC_1_BTN_PERF)
--DSPL_MENU Button
function FMC_1_BTN_DSPL_MENU()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_DSPL_MENU")
   sound_play(snd_click)
end
button_add(nil,DSPL_MENUButtonPressed, 383,634,51,47, FMC_1_BTN_DSPL_MENU)
--MFD_ADV Button
function FMC_1_BTN_MFD_ADV()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_MFD_ADV")
   sound_play(snd_click)
end
button_add(nil,MFD_ADVButtonPressed, 456,634,51,47, FMC_1_BTN_MFD_ADV)
--MFD_DATA Button
function FMC_1_BTN_MFD_DATA()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_MFD_DATA")
   sound_play(snd_click)
end
button_add(nil,MFD_DATAButtonPressed, 531,634,51,47, FMC_1_BTN_MFD_DATA)
--PREVPAGE Button
function FMC_1_BTN_PREVPAGE()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_PREVPAGE")
   sound_play(snd_click)
end
button_add(nil,PREVPAGEButtonPressed, 602,634,51,47, FMC_1_BTN_PREVPAGE)
--NEXTPAGE Button
function FMC_1_BTN_NEXTPAGE()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_NEXTPAGE")
   sound_play(snd_click)
end
button_add(nil,NEXTPAGEButtonPressed, 683,634,51,47, FMC_1_BTN_NEXTPAGE)
--EXEC Button
function FMC_1_BTN_EXEC()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_EXEC")
   sound_play(snd_click)
end
button_add(nil,EXECButtonPressed, 683,572,51,47, FMC_1_BTN_EXEC)


--CLR Button
function FMC_1_BTN_CLR_Start()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_CLR")
   sound_play(snd_click)
   timer_id1 = timer_start(1000,CLR_LONG)
end
function FMC_1_BTN_CLR_End()
       timer_stop(timer_id1)
end

function CLR_LONG()
msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_CLR_LONG")
end

button_add(nil,CLRButtonPressed, 683,696,51,47, FMC_1_BTN_CLR_Start, FMC_1_BTN_CLR_End)

--BRT Button **DOESN'T WORK
function FMC_1_BTN_BRT()
    --Ready when variables accessible.
end
button_add(nil,nil, 733,755,42,42, FMC_1_BTN_BRT)

--DIM Button **DOESN'T WORK
function FMC_1_BTN_DIM()
    --Ready when variables accessible.
end
button_add(nil,nil, 733,804,42,42, FMC_1_BTN_DIM)

--A Button
function FMC_1_BTN_A()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_A")
   sound_play(snd_click)
end
button_add(nil,AButtonPressed, 77,697,51,47, FMC_1_BTN_A)
--B Button
function FMC_1_BTN_B()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_B")
   sound_play(snd_click)
end
button_add(nil,BButtonPressed, 136,697,51,47, FMC_1_BTN_B)
--C Button
function FMC_1_BTN_C()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_C")
   sound_play(snd_click)
end
button_add(nil,CButtonPressed, 193,697,51,47, FMC_1_BTN_C)
--D Button
function FMC_1_BTN_D()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_D")
   sound_play(snd_click)
end
button_add(nil,DButtonPressed, 252,697,51,47, FMC_1_BTN_D)
--E Button
function FMC_1_BTN_E()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_E")
   sound_play(snd_click)
end
button_add(nil,EButtonPressed, 311,697,51,47, FMC_1_BTN_E)
--F Button
function FMC_1_BTN_F()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_F")
   sound_play(snd_click)
end
button_add(nil,FButtonPressed, 370,697,51,47, FMC_1_BTN_F)
--G Button
function FMC_1_BTN_G()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_G")
   sound_play(snd_click)
end
button_add(nil,GButtonPressed, 429,697,51,47, FMC_1_BTN_G)
--H Button
function FMC_1_BTN_H()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_H")
   sound_play(snd_click)
end
button_add(nil,HButtonPressed, 76,772,51,47, FMC_1_BTN_H)
--I Button
function FMC_1_BTN_I()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_I")
   sound_play(snd_click)
end
button_add(nil,IButtonPressed, 134,772,51,47, FMC_1_BTN_I)
--J Button
function FMC_1_BTN_J()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_J")
   sound_play(snd_click)
end
button_add(nil,JButtonPressed, 193,772,51,47, FMC_1_BTN_J)
--K Button
function FMC_1_BTN_K()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_K")
   sound_play(snd_click)
end
button_add(nil,KButtonPressed, 253,772,51,47, FMC_1_BTN_K)
--L Button
function FMC_1_BTN_L()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_L")
   sound_play(snd_click)
end
button_add(nil,LButtonPressed, 311,772,51,47, FMC_1_BTN_L)
--M Button
function FMC_1_BTN_M()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_M")
   sound_play(snd_click)
end
button_add(nil,MButtonPressed, 370,772,51,47, FMC_1_BTN_M)
--N Button
function FMC_1_BTN_N()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_N")
   sound_play(snd_click)
end
button_add(nil,NButtonPressed, 429,772,51,47, FMC_1_BTN_N)
--O Button
function FMC_1_BTN_O()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_O")
   sound_play(snd_click)
end
button_add(nil,OButtonPressed, 77,846,51,47, FMC_1_BTN_O)
--P Button
function FMC_1_BTN_P()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_P")
   sound_play(snd_click)
end
button_add(nil,PButtonPressed, 136,846,51,47, FMC_1_BTN_P)
--Q Button
function FMC_1_BTN_Q()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_Q")
   sound_play(snd_click)
end
button_add(nil,QButtonPressed, 193,846,51,47, FMC_1_BTN_Q)
--R Button
function FMC_1_BTN_R()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_R")
   sound_play(snd_click)
end
button_add(nil,RButtonPressed, 252,846,51,47, FMC_1_BTN_R)
--S Button
function FMC_1_BTN_S()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_S")
   sound_play(snd_click)
end
button_add(nil,SButtonPressed, 311,846,51,47, FMC_1_BTN_S)
--T Button
function FMC_1_BTN_T()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_T")
   sound_play(snd_click)
end
button_add(nil,TButtonPressed, 370,846,51,47, FMC_1_BTN_T)
--U Button
function FMC_1_BTN_U()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_U")
   sound_play(snd_click)
end
button_add(nil,UButtonPressed, 429,846,51,47, FMC_1_BTN_U)
--V Button
function FMC_1_BTN_V()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_V")
   sound_play(snd_click)
end
button_add(nil,VButtonPressed, 75,921,51,47, FMC_1_BTN_V)
--W Button
function FMC_1_BTN_W()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_W")
   sound_play(snd_click)
end
button_add(nil,WButtonPressed, 135,921,51,47, FMC_1_BTN_W)
--X Button
function FMC_1_BTN_X()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_X")
   sound_play(snd_click)
end
button_add(nil,XButtonPressed, 193,921,51,47, FMC_1_BTN_X)
--Y Button
function FMC_1_BTN_Y()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_Y")
   sound_play(snd_click)
end
button_add(nil,YButtonPressed, 253,921,51,47, FMC_1_BTN_Y)
--Z Button
function FMC_1_BTN_Z()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_Z")
   sound_play(snd_click)
end
button_add(nil,ZButtonPressed, 311,921,51,47, FMC_1_BTN_Z)


--SP Button
function FMC_1_BTN_SP()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_SP")
   sound_play(snd_click)
end
button_add(nil,SPButtonPressed, 370,919,51,47, FMC_1_BTN_SP)
--DIV Button
function FMC_1_BTN_DIV()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_DIV")
   sound_play(snd_click)
end
button_add(nil,DIVButtonPressed, 429,919,51,47, FMC_1_BTN_DIV)


--ONE Button
function FMC_1_BTN_ONE()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_1")
   sound_play(snd_click)
end
button_add(nil,ONEButtonPressed, 487,695,50,50, FMC_1_BTN_ONE)
--TWO Button
function FMC_1_BTN_TWO()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_2")
   sound_play(snd_click)
end
button_add(nil,TWOButtonPressed, 553,695,50,50, FMC_1_BTN_TWO)
--THREE Button
function FMC_1_BTN_THREE()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_3")
   sound_play(snd_click)
end
button_add(nil,THREEButtonPressed, 618,695,50,50, FMC_1_BTN_THREE)
--FOUR Button
function FMC_1_BTN_FOUR()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_4")
   sound_play(snd_click)
end
button_add(nil,FOURButtonPressed, 488,768,50,50, FMC_1_BTN_FOUR)
--FIVE Button
function FMC_1_BTN_FIVE()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_5")
   sound_play(snd_click)
end
button_add(nil,FIVEButtonPressed, 553,768,50,50, FMC_1_BTN_FIVE)
--SIX Button
function FMC_1_BTN_SIX()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_6")
   sound_play(snd_click)
end
button_add(nil,SIXButtonPressed, 618,768,50,50, FMC_1_BTN_SIX)
--SEVEN Button
function FMC_1_BTN_SEVEN()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_7")
   sound_play(snd_click)
end
button_add(nil,SEVENButtonPressed, 488,844,50,50, FMC_1_BTN_SEVEN)
--EIGHT Button
function FMC_1_BTN_EIGHT()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_8")
   sound_play(snd_click)
end
button_add(nil,EIGHTButtonPressed, 555,844,50,50, FMC_1_BTN_EIGHT)
--NINE Button
function FMC_1_BTN_NINE()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_9")
   sound_play(snd_click)
end
button_add(nil,NINEButtonPressed, 618,844,50,50, FMC_1_BTN_NINE)
--DOT Button
function FMC_1_BTN_DOT()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_DOT")
   sound_play(snd_click)
end
button_add(nil,DOTButtonPressed, 487,918,50,50, FMC_1_BTN_DOT)
--ZERO Button
function FMC_1_BTN_ZERO()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_0")
   sound_play(snd_click)
end
button_add(nil,ZEROButtonPressed, 554,918,50,50, FMC_1_BTN_ZERO)
--PLUSMINUS Button
function FMC_1_BTN_PLUSMINUS()
   msfs_event("H:CJ4_FMC_" .. instr_pos .. "_BTN_PLUSMINUS")
   sound_play(snd_click)
end
button_add(nil,PLUSMINUSButtonPressed, 618,918,50,50, FMC_1_BTN_PLUSMINUS)