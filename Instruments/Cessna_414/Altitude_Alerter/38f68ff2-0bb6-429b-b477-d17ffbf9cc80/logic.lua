--[[
**************************************************************************************
***************CESSNA 414 CHANCELLOR ALTITUDE ALERTER  ********************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

Altitude alterter / preselector panel for the Cessna 414 Chancellow by FlySimware

Version info:

- **v1.0** (24 April, 2022)
    - Original release
    
NOTES: 
- Will only work with the Flysimware Cessna 414 Chancellor

KNOWN ISSUES:
- None

ATTRIBUTION:
All code, artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--
    
--declare variables
 local tenthousanths
 local thousanths
 local hundreths
local alerter_armed

--Add graphics
img_add_fullscreen("bg.png")

--add indicator light graphics and set initial visibility to off
armedlight = img_add("light_amber.png", 484, 72, 33, 33, "visible:false")
altalertlight = img_add("light_green.png", 17, 120, 33, 33, "visible:false")
tenthouzero = img_add("ten_thou_0.png", 150, 106, 29, 45 )
hilight = img_add("light_amber.png", 17, 72, 33, 33, "visible:false")
lolight = img_add("light_amber.png", 17, 166, 33, 33, "visible:false")
cpldlight = img_add("light_green.png", 484, 166, 33, 33, "visible:false")


--Add text areas for alerter values
txt_ten_thou = txt_add("", "font:MS33558.ttf; size:42; color: #dcdcdc; halign:left;", 153, 108, 200, 200)
txt_thou = txt_add("0", "font:MS33558.ttf; size:42; color: #dcdcdc; halign:left;", 241, 108, 200, 200)
txt_hun = txt_add("0", "font:MS33558.ttf; size:42; color: #dcdcdc; halign:left;", 323, 108, 200, 200)


--Altitude selection levers

--ten thousandths
function cb_ten_thou(position, direction)
    position = tenthousanths
    if direction == 1 then
        if position <= 8 then
            position = position + 1
        end
    elseif direction == -1 then
        if position >= 1 then
            position = position - 1
        end  
    end 

    fs2020_variable_write("L:Alerter_GENERIC_ALERTER_TEN_THOUSANDTHS", "Number", position)
    fs2020_variable_write("L:GENERIC_ALERTER_TEN_THOUSANDTHS", "Number", position*11)   
end 
sw_tenthou=switch_add("sel_0.png", "sel_1.png", "sel_2.png", "sel_3.png", "sel_4.png", "sel_5.png", "sel_6.png", "sel_7.png", "sel_8.png", "sel_9.png",181, 80, 30, 150, "CIRCULAR", cb_ten_thou)

--thousandths
function cb_thou(position, direction)
    position = thousanths
    if direction == 1 then
        if position <= 8 then
            position = position + 1
        end
    elseif direction == -1 then
        if position >= 1 then
            position = position - 1
        end  
    end 
    fs2020_variable_write("L:Alerter_GENERIC_ALERTER_THOUSANDTHS", "Number", position)
    fs2020_variable_write("L:GENERIC_ALERTER_THOUSANDTHS", "Number", position*11)
end 
sw_thou=switch_add("sel_0.png", "sel_1.png", "sel_2.png", "sel_3.png", "sel_4.png", "sel_5.png", "sel_6.png", "sel_7.png", "sel_8.png", "sel_9.png",271, 80, 30, 150, "CIRCULAR", cb_thou )

--hundredths
function cb_hun(position, direction)
        position = hundreths
    if direction == 1 then
        if position <= 8 then
            position = position + 1
        end
    elseif direction == -1 then
        if position >= 1 then
            position = position - 1
        end  
    end  
    
    fs2020_variable_write("L:Alerter_GENERIC_ALERTER_HUNDREDTHS", "Number", position)
    fs2020_variable_write("L:GENERIC_ALERTER_HUNDREDTHS", "Number", position*11)
end 
sw_hun=switch_add("sel_0.png", "sel_1.png", "sel_2.png", "sel_3.png", "sel_4.png", "sel_5.png", "sel_6.png", "sel_7.png", "sel_8.png", "sel_9.png",351, 80, 30, 150, "CIRCULAR", cb_hun  )

function alerter_arm()
        if alerter_armed == 1 then
            fs2020_variable_write("L:Alt_Arm_Switch", "Number", 0)
        else
            fs2020_variable_write("L:Alt_Arm_Switch", "Number", 1)
        end
end
btn_arm=button_add(nil, nil, 482,112, 40, 40, alerter_arm)


-- get subscribed variables, set locals, and set indicator states
function get_vars(tenthou, thou, hun, armed, alt_lock, alt_indicated, mainbusvoltage)
    --handle ten thousandths field
    tenthousanths = tenthou
    if tenthousanths == 0 then
        visible(tenthouzero, true)
        txt_set(txt_ten_thou, "")
    else
        visible(tenthouzero, false)
        txt_set(txt_ten_thou, string.sub(tenthousanths, 1, 1))
    end
     switch_set_position(sw_tenthou, tenthousanths)
     
    --handle thousandths field
    thousanths = thou
    txt_set(txt_thou, string.sub(thousanths, 1, 1))
     switch_set_position(sw_thou, thousanths)   

    --handle hundredths field
    hundreths = hun
    txt_set(txt_hun, string.sub(hundreths, 1, 1))
    switch_set_position(sw_hun, hundreths)
    
    --INDICATOR LIGHTS
    --armed light
    alerter_armed = armed    -- must revisit to get correct behaviour
    if mainbusvoltage > 1 and alerter_armed == 1 then
        visible(armedlight, true)
    else
        visible(armedlight, false)
    end
   
    -- get absolute difference between selected and indicated altitudes
   alt_diff = math.abs(alt_lock - alt_indicated)

      -- coupled light 
   if mainbusvoltage > 1 and alt_diff <= 20 then
       visible(cpldlight, true)
   else
       visible(cpldlight, false)
   end
   
     --alert light
     if mainbusvoltage > 1 and alt_diff <  300 then
       visible(altalertlight, true)
   else
       visible(altalertlight, false)
   end
   
    --High light
     if mainbusvoltage > 1 and alt_diff <=  300 and alt_diff >= 1000then
       visible(hilight, true)
   else
       visible(hilight, false)
   end
   
     --low light
     if mainbusvoltage > 1 and alt_diff >=  300 and alt_diff <= 1000then
       visible(lolight, true)
   else
       visible(lolight, false)
   end
end

fs2020_variable_subscribe("L:Alerter_GENERIC_ALERTER_TEN_THOUSANDTHS", "Number", 
                                                "L:Alerter_GENERIC_ALERTER_THOUSANDTHS", "Number", 
                                                "L:Alerter_GENERIC_ALERTER_HUNDREDTHS", "Number", 
                                                "L:Alt_Arm_Switch", "Number",
                                                "A:AUTOPILOT ALTITUDE LOCK VAR", "FEET",
                                                "A:INDICATED ALTITUDE", "FEET", 
                                                "A:ELECTRICAL MAIN BUS VOLTAGE", "Volts",                                               
                                                get_vars)