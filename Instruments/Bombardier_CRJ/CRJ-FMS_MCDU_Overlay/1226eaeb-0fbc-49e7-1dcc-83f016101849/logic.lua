--[[
******************************************************************************************
******************Bombardier CRJ-FMS MCDU******************************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  05-11-2022 
    - Panel Created
- **v1.1**  10-25-2022 
    - Update graphics to line up LSK Keys
    - BRT Knobs now adjusts brightness

##Left To Do:
    - N/A
	
##Notes:
    - THIS INSTRUMENT IS ONLY AN OVERLAY. It must be used in conjunction with pop out instrument from Microsoft Flight Simulator. 
            Right Alt + Click on the FMS screens in MSFS to pop out the windows. 
    - This instrument has a user prop to control either the Pilot or CoPilot FMS.      
--]]


-- Message for Raspberry Pi and tablet versions
if instrument_prop("PLATFORM") == "RASPBERRY_PI" or instrument_prop("PLATFORM") == "ANDROID" or instrument_prop("PLATFORM") == "IPAD" then
    canvas_add(150, 47, 1034, 775, function()
        _rect(0,0,1034,775)
        _fill("black")
    end)
    canv_message = canvas_add(130, 50, 500, 500, function()
        _rect(0,0,500,500)
        _fill("blue")
        _txt("THIS IS AN OVERLAY ONLY", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 100)
        _txt("IT REQUIRES THE COCKPIT POP OUT", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 150)
        _txt("SEE OUR WIKI FOR MORE INFORMATION", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 200)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 250)
    end)
    butn_hide = button_add(nil, nil, 130, 50, 500, 500, function()
        visible(canv_message, false)
        visible(butn_hide, false)
    end)
end

-- Message for desktop
pers_msg_read = persist_add("msg_read", false)
if (instrument_prop("PLATFORM") == "WINDOWS" or instrument_prop("PLATFORM") == "MAC" or instrument_prop("PLATFORM") == "LINUX") and not persist_get(pers_msg_read) then
    canv_message = canvas_add(130, 50, 500, 500, function()
        _rect(0,0,500,500)
        _fill("blue")
        _txt("THIS IS AN OVERLAY ONLY", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 100)
        _txt("IT REQUIRES THE COCKPIT POP OUT", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 150)
        _txt("SEE OUR WIKI FOR MORE INFORMATION", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 200)
        _txt("CLICK HERE TO HIDE THIS MESSAGE", "font:roboto_bold.ttf; size:30; color: white; halign:center;", 220, 250)
    end)
    butn_hide = button_add(nil, nil, 130, 50, 500, 500, function()
        visible(canv_message, false)
        visible(butn_hide, false)
        persist_put(pers_msg_read, true)
    end)
end
-------------------------------------------------------------
-------------------------------------------------------------
-------------------------------------------------------------
local button_delay = 50

--User Prop to set Pilot or CoPilot
prop_mcdu_side = user_prop_add_enum("MCDU", "Pilot,CoPilot", "Pilot", "You can choose to control Pilot or CoPilot MCDU")
if user_prop_get(prop_mcdu_side) == "Pilot" then
    controlside = "L:ASCRJ_MCDU1_"
    else controlside = "L:ASCRJ_MCDU2_"
end    


snd_click = sound_add("click.wav")
img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

--Graphics
img_knob_brt= img_add("knob_brt.png", 575,15,50,50)
img_knob_brt_night= img_add("knob_brt_night.png", 575,15,50,50) 
img_knob_pos= img_add("knob_pos.png", 70,15,50,50)
img_knob_pos_night= img_add("knob_pos_night.png", 70,15,50,50) 

--=======Back  Lighting============
img_labels_backlight = img_add_fullscreen("backlighting.png")
img_backlight_knob_brt= img_add("backlight_knob_brt.png", 575,15,50,50) 
img_backlight_knob_pos= img_add("backlight_knob_pos.png", 70,15,50,50) 

function ss_backlighting(value, pwr)
    value = var_round(value*10,2)
    if value == 0.0 or (pwr == false ) then 
        opacity(img_labels_backlight, 0, "LOG", 0.04) 
        opacity(img_backlight_knob_brt, 0, "LOG", 0.04) 
        opacity(img_backlight_knob_pos, 0, "LOG", 0.04)         
    else
        opacity(img_labels_backlight, (value), "LOG", 0.04) 
        opacity(img_backlight_knob_brt, (value), "LOG", 0.04)        
        opacity(img_backlight_knob_pos, (value), "LOG", 0.04)             
    end
end
fs2020_variable_subscribe("A:Light Potentiometer:4", "Number",
                                              "A:CIRCUIT GENERAL PANEL ON","Bool", ss_backlighting)
                                              
-----------------------------------------------------------------
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_knob_brt_night, value, "LOG", 0.04)    
    opacity(img_knob_pos_night, value, "LOG", 0.04)     

end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
-----------------------------------------------------------------
-----------------------------------------------------------------
--Button Sizes
    LSKWidth = 36
    LSKHeight = 20
    
    ActionWidth = 64
    ActionHeight = 40
    
    LetterWidth = 45
    LetterHeight = 45
    
    NumberWidth = 40
    NumberHeight = 40

--Button Graphics
    ButtonOverlay= nil --Change to  "button_pressed.png" to see push buttons.
    
    LSKButtonPressed = "button_pressed.png" 
    MSGButtonPressed = "button_pressed.png" 
    IDXButtonPressed = "button_pressed.png" 
    RADIOButtonPressed = "button_pressed.png"
    MFD_DATAButtonPressed ="button_pressed.png"
    
    DIRButtonPressed ="button_pressed.png" 
    FIXButtonPressed ="button_pressed.png"
    PROGButtonPressed ="button_pressed.png"
    MFD_MENUButtonPressed ="button_pressed.png"
    
    FPLNButtonPressed ="button_pressed.png"
    LEGSButtonPressed ="button_pressed.png" 
    PERFButtonPressed ="button_pressed.png" 
    MFD_ADVButtonPressed ="button_pressed.png"
    
    DEPARRButtonPressed ="button_pressed.png" 
    SECButtonPressed ="button_pressed.png" 
    HOLDButtonPressed ="button_pressed.png" 
    VNAVButtonPressed ="button_pressed.png" 
    UPButtonPressed ="button_pressed.png" 
    DNButtonPressed ="button_pressed.png" 
    PREVPAGEButtonPressed ="button_pressed.png" 
    MCDUButtonPressed ="button_pressed.png"        
    NEXTPAGEButtonPressed ="button_pressed.png" 
    EXECButtonPressed = "button_pressed.png"
    
    AButtonPressed = "button_pressed.png" 
    BButtonPressed = "button_pressed.png"
    CButtonPressed = "button_pressed.png" 
    DButtonPressed = "button_pressed.png"
    EButtonPressed = "button_pressed.png"
    FButtonPressed = "button_pressed.png" 
    GButtonPressed = "button_pressed.png" 
    HButtonPressed = "button_pressed.png"
    IButtonPressed = "button_pressed.png" 
    JButtonPressed = "button_pressed.png" 
    KButtonPressed = "button_pressed.png" 
    LButtonPressed = "button_pressed.png" 
    MButtonPressed = "button_pressed.png"
    NButtonPressed = "button_pressed.png"
    OButtonPressed = "button_pressed.png"
    PButtonPressed = "button_pressed.png"
    QButtonPressed = "button_pressed.png"
    RButtonPressed = "button_pressed.png"
    SButtonPressed = "button_pressed.png" 
    TButtonPressed = "button_pressed.png" 
    UButtonPressed = "button_pressed.png"
    VButtonPressed = "button_pressed.png"
    WButtonPressed = "button_pressed.png" 
    XButtonPressed = "button_pressed.png" 
    YButtonPressed = "button_pressed.png" 
    ZButtonPressed = "button_pressed.png"     
    SPButtonPressed = "button_pressed.png"    
    DELButtonPressed = "button_pressed.png" 
    DIVButtonPressed = "button_pressed.png" 
    CLRButtonPressed = "button_pressed.png" 
    
    ONEButtonPressed ="circle_pressed.png" 
    TWOButtonPressed ="circle_pressed.png" 
    THREEButtonPressed ="circle_pressed.png"
    FOURButtonPressed ="circle_pressed.png"
    FIVEButtonPressed ="circle_pressed.png"
    SIXButtonPressed ="circle_pressed.png"
    SEVENButtonPressed ="circle_pressed.png"
    EIGHTButtonPressed ="circle_pressed.png"
    NINEButtonPressed ="circle_pressed.png"
    DOTButtonPressed ="circle_pressed.png"
    ZEROButtonPressed ="circle_pressed.png"
    PLUSMINUSButtonPressed ="circle_pressed.png"


-----------------------------------------------------------------------------------
--BRT Knob
BRT_Number= 0

dial_BRT = dial_add(nil, 575,15,50,50, 
        function (dir) fs2020_variable_write(controlside.."BRT_CHANGE","Number", dir) 
        BRT_Number=BRT_Number+dir
        timer_start(button_delay, function() fs2020_variable_write(controlside.."BRT_CHANGE","Number",0) end)
                rotate(img_knob_brt, (BRT_Number*10),"LOG", 0.1)    
                rotate(img_knob_brt_night, (BRT_Number*10),"LOG", 0.1)         
                rotate(img_backlight_knob_brt, (BRT_Number*10),"LOG", 0.1)           
        end)
        
--POS Knob

--POS Doesn't Exist, but may in the future
--[[
POS_Number= 0
dial_POS = dial_add(nil, 275,15,50,50, 
        function (dir) fs2020_variable_write(controlside.."POS_CHANGE","Number", dir) 
        POS_Number=POS_Number+dir
        timer_start(button_delay, function() fs2020_variable_write(controlside.."POS_CHANGE","Number",0) end)
                rotate(img_knob_pos, (POS_Number*10),"LOG", 0.1)    
                rotate(img_knob_pos_night, (POS_Number*10),"LOG", 0.1)         
                rotate(img_backlight_knob_pos, (POS_Number*10),"LOG", 0.1)           
        end)
--]]          

----------LSK BUTTONS----------------------------------------------------
button_add(ButtonOverlay,LSKButtonPressed, 52,120,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK1L","number",1) sound_play(snd_click) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK1L","number",0) end)end)
               
button_add(ButtonOverlay,LSKButtonPressed, 52,178,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK2L","number",1)sound_play(snd_click) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK2L","number",0) end)end)
                
button_add(ButtonOverlay,LSKButtonPressed, 52,234,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK3L","number",1) sound_play(snd_click) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK3L","number",0) end)end)
               
button_add(ButtonOverlay,LSKButtonPressed, 52,292,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK4L","number",1) sound_play(snd_click) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK4L","number",0) end)end)
                
button_add(ButtonOverlay,LSKButtonPressed, 52,350,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK5L","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK5L","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,LSKButtonPressed, 52,406,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK6L","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK6L","number",0) end)
                sound_play(snd_click) end) 
-----RIGHT
button_add(ButtonOverlay,LSKButtonPressed, 604,120,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK1R","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK1R","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,LSKButtonPressed, 604,178,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK2R","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK2R","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,LSKButtonPressed, 604,234,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK3R","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK3R","number",0) end)
                sound_play(snd_click) end) 
button_add(ButtonOverlay,LSKButtonPressed, 604,292,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK4R","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK4R","number",0) end)
                sound_play(snd_click) end) 
button_add(ButtonOverlay,LSKButtonPressed, 604,350,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK5R","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK5R","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,LSKButtonPressed, 604,406,LSKWidth,LSKHeight, 
    function () fs2020_variable_write(controlside.."LSK6R","number",1)  	
                timer_start(button_delay, function() fs2020_variable_write(controlside.."LSK6R","number",0) end)
                sound_play(snd_click) end)
    
-----------------------------------------------------------------------------------
----------ACTION BUTTONS----------------------------------------------------
button_add(ButtonOverlay,MSGButtonPressed, 23,526,ActionWidth,ActionHeight, 
    function () fs2020_variable_write(controlside.."MSG","number",1)sound_play(snd_click)
    timer_start(button_delay, function() fs2020_variable_write(controlside.."MSG","number",0) end) end)              
button_add(ButtonOverlay,IDXButtonPressed, 23,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."INDEX","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."INDEX","number",0) end) end)   
button_add(ButtonOverlay,RADIOButtonPressed, 23,634,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."RADIO","number",1) sound_play(snd_click)  
    timer_start(button_delay, function() fs2020_variable_write(controlside.."RADIO","number",0) end)end)      
button_add(ButtonOverlay,MFD_DATAButtonPressed, 24,687,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."MFD_DATA","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."MFD_DATA","number",0) end)end)       
button_add(ButtonOverlay,DIRButtonPressed, 107,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."DIR_INTC","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."DIR_INTC","number",0) end)end)        
button_add(ButtonOverlay,FIXButtonPressed, 107,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."FIX","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."FIX","number",0) end)end)          
button_add(ButtonOverlay,PROGButtonPressed, 107,634,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."PROG","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."PROG","number",0) end)end)      
button_add(ButtonOverlay,MFD_MENUButtonPressed, 107,687,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."MFD_MENU","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."MFD_MENU","number",0) end)end)   
button_add(ButtonOverlay,FPLNButtonPressed, 190,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."FPLN","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."FPLN","number",0) end)end)        
button_add(ButtonOverlay,LEGSButtonPressed, 190,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."LEGS","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."LEGS","number",0) end)end)          
button_add(ButtonOverlay,PERFButtonPressed, 192,634,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."PERF","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."PERF","number",0) end) end)     
button_add(ButtonOverlay,MFD_ADVButtonPressed, 192,687,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."MFD_ADV","number",1) sound_play(snd_click)  
    timer_start(button_delay, function() fs2020_variable_write(controlside.."MFD_ADV","number",0) end)end)             
--Right Top Section    
button_add(ButtonOverlay,DEPARRButtonPressed, 275,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."DEP_ARR","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."DEP_ARR","number",0) end)end)        
button_add(ButtonOverlay,SECButtonPressed, 275,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."SEC_FPLN","number",1) sound_play(snd_click) 
   timer_start(button_delay, function() fs2020_variable_write(controlside.."SEC_FPLN","number",0) end)end)         
button_add(ButtonOverlay,HOLDButtonPressed, 358,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."HOLD","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."HOLD","number",0) end) end)     
button_add(ButtonOverlay,VNAVButtonPressed, 358,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."VNAV","number",1) sound_play(snd_click)      
    timer_start(button_delay, function() fs2020_variable_write(controlside.."VNAV","number",0) end)end)
button_add(ButtonOverlay,UPButtonPressed, 440,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."UP","number",1) sound_play(snd_click)
   timer_start(button_delay, function() fs2020_variable_write(controlside.."UP","number",0) end)end)      
button_add(ButtonOverlay,DNButtonPressed, 440,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."DOWN","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."DOWN","number",0) end)end)         
button_add(ButtonOverlay,PREVPAGEButtonPressed, 525,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."PREV_PAGE","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."PREV_PAGE","number",0) end)end)      
button_add(ButtonOverlay,MCDUButtonPressed, 525,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."MCDU_MENU","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."MCDU_MENU","number",0) end)end)                    
button_add(ButtonOverlay,NEXTPAGEButtonPressed, 607,526,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."NEXT_PAGE","number",1) sound_play(snd_click) 
    timer_start(button_delay, function() fs2020_variable_write(controlside.."NEXT_PAGE","number",0) end)end)    
button_add(ButtonOverlay,EXECButtonPressed, 607,579,ActionWidth,ActionHeight,
    function () fs2020_variable_write(controlside.."EXEC","number",1) sound_play(snd_click)  
    timer_start(button_delay, function() fs2020_variable_write(controlside.."EXEC","number",0) end)end)        
-----------------------------------------------------------------------------------
----------NUMBER BUTTONS----------------------------------------------------
button_add(ButtonOverlay,ONEButtonPressed, 85,757,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."1","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."1","number",0) end)
                sound_play(snd_click) end)   
button_add(ButtonOverlay,TWOButtonPressed, 153,757,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."2","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."2","number",0) end)
                sound_play(snd_click) end)   
button_add(ButtonOverlay,THREEButtonPressed, 219,757,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."3","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."3","number",0) end)
                sound_play(snd_click) end)  
button_add(ButtonOverlay,FOURButtonPressed, 85,812,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."4","number",1)   
                timer_start(button_delay, function() fs2020_variable_write(controlside.."4","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,FIVEButtonPressed, 153,812,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."5","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."5","number",0) end)
                sound_play(snd_click) end)  
button_add(ButtonOverlay,SIXButtonPressed, 220,812,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."6","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."6","number",0) end)
                sound_play(snd_click) end)   
button_add(ButtonOverlay,SEVENButtonPressed, 85,867,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."7","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."7","number",0) end)
                sound_play(snd_click) end)    
button_add(ButtonOverlay,EIGHTButtonPressed, 153,867,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."8","number",1)  
                timer_start(button_delay, function() fs2020_variable_write(controlside.."8","number",0) end)
                sound_play(snd_click) end)        
button_add(ButtonOverlay,NINEButtonPressed, 220,867,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."9","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."9","number",0) end)
                sound_play(snd_click) end)        
button_add(ButtonOverlay,DOTButtonPressed, 85,922,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."PERIOD","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."PERIOD","number",0) end)
                sound_play(snd_click) end)        
button_add(ButtonOverlay,ZEROButtonPressed, 153,922,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."0","number",1)   
                timer_start(button_delay, function() fs2020_variable_write(controlside.."0","number",0) end)
                sound_play(snd_click) end) 
button_add(ButtonOverlay,PLUSMINUSButtonPressed, 219,922,NumberWidth,NumberHeight,
    function () fs2020_variable_write(controlside.."PLUS","number",1)   
                timer_start(button_delay, function() fs2020_variable_write(controlside.."PLUS","number",0) end)
                sound_play(snd_click) end)           
-----------------------------------------------------------------------------------
---------LETTER BUTTONS----------------------------------------------------
button_add(ButtonOverlay,AButtonPressed, 305,642,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."A","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."A","number",0) end)
                sound_play(snd_click) end)         
button_add(ButtonOverlay,BButtonPressed, 375,642,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."B","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."B","number",0) end)
                sound_play(snd_click) end)             
button_add(ButtonOverlay,CButtonPressed, 440,642,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."C","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."C","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,DButtonPressed, 505,642,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."D","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."D","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,EButtonPressed, 575,642,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."E","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."E","number",0) end)
                sound_play(snd_click) end)
        button_add(ButtonOverlay,FButtonPressed, 305,697,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."F","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."F","number",0) end)
                sound_play(snd_click) end)         
button_add(ButtonOverlay,GButtonPressed, 375,697,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."G","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."G","number",0) end)
                sound_play(snd_click) end)           
button_add(ButtonOverlay,HButtonPressed, 440,697,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."H","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."H","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,IButtonPressed, 505,697,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."I","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."I","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,JButtonPressed, 575,697,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."J","number",1)     
                timer_start(button_delay, function() fs2020_variable_write(controlside.."J","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,KButtonPressed, 305,752,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."K","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."K","number",0) end)
                sound_play(snd_click) end)        
button_add(ButtonOverlay,LButtonPressed, 375,752,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."L","number",1)  
                timer_start(button_delay, function() fs2020_variable_write(controlside.."L","number",0) end)
                sound_play(snd_click) end)            
button_add(ButtonOverlay,MButtonPressed, 440,752,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."M","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."M","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,NButtonPressed, 505,752,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."N","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."N","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,OButtonPressed, 575,752,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."O","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."O","number",0) end)
                sound_play(snd_click) end)               
button_add(ButtonOverlay,PButtonPressed, 305,807,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."P","number",1)  
                timer_start(button_delay, function() fs2020_variable_write(controlside.."P","number",0) end)
                sound_play(snd_click) end)        
button_add(ButtonOverlay,QButtonPressed, 375,807,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."Q","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."Q","number",0) end)
                sound_play(snd_click) end)              
button_add(ButtonOverlay,RButtonPressed, 440,807,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."R","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."R","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,SButtonPressed, 505,807,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."S","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."S","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,TButtonPressed, 575,807,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."T","number",1)                     
                timer_start(button_delay, function() fs2020_variable_write(controlside.."T","number",0) end)
                sound_play(snd_click) end)                       
button_add(ButtonOverlay,UButtonPressed, 305,862,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."U","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."U","number",0) end)
                sound_play(snd_click) end)         
button_add(ButtonOverlay,VButtonPressed, 375,862,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."V","number",1)    
                timer_start(button_delay, function() fs2020_variable_write(controlside.."V","number",0) end)
                sound_play(snd_click) end)          
button_add(ButtonOverlay,WButtonPressed, 440,862,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."W","number",1)  
                timer_start(button_delay, function() fs2020_variable_write(controlside.."W","number",0) end)
                sound_play(snd_click) end)   
button_add(ButtonOverlay,XButtonPressed, 505,862,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."X","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."X","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,YButtonPressed, 575,862,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."Y","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."Y","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,ZButtonPressed, 305,918,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."Z","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."Z","number",0) end)
                sound_play(snd_click) end)                                                                                                                  
button_add(ButtonOverlay,SPButtonPressed, 375,918,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."SP","number",1)   
                timer_start(button_delay, function() fs2020_variable_write(controlside.."SP","number",0) end)
                sound_play(snd_click) end)                                                                                       
button_add(ButtonOverlay,DELButtonPressed, 440,918,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."DEL","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."DEL","number",0) end)
                sound_play(snd_click) end)     
button_add(ButtonOverlay,DIVButtonPressed, 507,918,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."SLASH","number",1)
                timer_start(button_delay, function() fs2020_variable_write(controlside.."SLASH","number",0) end)
                sound_play(snd_click) end)
button_add(ButtonOverlay,CLRButtonPressed, 575,918,LetterWidth,LetterHeight,
    function () fs2020_variable_write(controlside.."CLR","number",1) 
                timer_start(button_delay, function() fs2020_variable_write(controlside.."CLR","number",0) end)
                sound_play(snd_click) end)