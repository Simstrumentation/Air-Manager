--[[
******************************************************************************************
***************CESSNA 414 CHANCELLOW ANNUNCIATOR PANEL ********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

Annunciator panel for the Cessna 414 Chancellow by FlySimware


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

--background graphics
img_add_fullscreen("bg.png")

-- Annunciator test button
function cb_test_pressed()
    fs2020_variable_write("L:ANUNNCIATOR_TEST_SWITCH", "Number", 1)
 end

function cb_test_released()
     fs2020_variable_write("L:ANUNNCIATOR_TEST_SWITCH", "Number", 0)
     visible(txt_spare1_on, false)
end
testbtn = button_add("button_up.png", "button_dn.png", 20, 848, 100, 100, cb_test_pressed, cb_test_released)

-- ADD TEXT FIELDS FOR ANNUNCIATOR INDICATORS
-- Low Voltage
txt_low_volt_off = txt_add("LOW VOLT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 35, 200, 200)
txt_low_volt_on = txt_add("LOW VOLT", "font:roboto_bold.ttf; size:34; color: red; halign:center;",175, 35, 200, 200)
visible(txt_low_volt_on, false)

-- Alternators
txt_l_alt_off = txt_add("L. ALT OUT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 120, 200, 200)
txt_l_alt_on = txt_add("L. ALT OUT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",175, 120, 200, 200)
visible(txt_l_alt_on, false)

txt_r_alt_off = txt_add("R. ALT OUT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 120, 200, 200)
txt_r_alt_on = txt_add("R. ALT OUT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",390, 120, 200, 200)
visible(txt_r_alt_on, false)


--Cabin Altitude
txt_cabin_alt_off = txt_add("CABIN ALT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 215, 200, 200)
txt_cabin_alt_on = txt_add("CABIN ALT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",175, 215, 200, 200)
visible(txt_cabin_alt_on, false)

--Hydraulic Flow
txt_l_hyd_off = txt_add("L. HYD FLOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 300, 200, 200)
txt_l_hyd_on = txt_add("L. HYD FLOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",175, 300, 200, 200)
visible(txt_l_hyd_on, false)

txt_r_hyd_off = txt_add("R. HYD FLOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 300, 200, 200)
txt_r_hyd_on = txt_add("R. HYD FLOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",390, 300, 200, 200)
visible(txt_r_hyd_on, false)


-- Fuel Flow
txt_l_fuel_off = txt_add("L. FUEL LOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 385, 200, 200)
txt_l_fuel_on = txt_add("L. FUEL LOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",175, 385, 200, 200)
visible(txt_l_fuel_on, false)

txt_r_fuel_off = txt_add("R. FUEL LOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 385, 200, 200)
txt_r_fuel_on = txt_add("R. FUEL LOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",390, 385, 200, 200)
visible(txt_r_fuel_on, false)

-- Spares
txt_spare1_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 475, 200, 200)
txt_spare1_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",175, 475, 200, 200)
visible(txt_spare1_on, false)

txt_spare2_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 565, 200, 200)
txt_spare2_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",175, 565, 200, 200)
visible(txt_spare2_on, false)

txt_spare3_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 830, 200, 200)
txt_spare3_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",175, 830, 200, 200)
visible(txt_spare3_on, false)

txt_spare4_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 475, 200, 200)
txt_spare4_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",390, 475, 200, 200)
visible(txt_spare4_on, false)

txt_spare5_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 565, 200, 200)
txt_spare5_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",390, 565, 200, 200)
visible(txt_spare5_on, false)

txt_spare6_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 830, 200, 200)
txt_spare6_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",390, 830, 200, 200)
visible(txt_spare6_on, false)

txt_spare7_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 915, 200, 200)
txt_spare7_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",390, 915, 200, 200)
visible(txt_spare7_on, false)

-- Door Warning
txt_door_off = txt_add("DOOR WARN", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 35, 200, 200)
txt_door_on = txt_add("DOOR WARN", "font:roboto_bold.ttf; size:34; color: red; halign:center;",390, 35, 200, 200)
visible(txt_door_on, false)

-- Hydraulic Pressure
txt_hyd_press_off = txt_add("HYD PRESS", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 215, 200, 200)
txt_hyd_press_on = txt_add("HYD PRESS", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",390, 215, 200, 200)
visible(txt_hyd_press_on, false)

-- Air Conditioning Pressure
txt_ac_off = txt_add("A COND HYD", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 655, 200, 200)
txt_ac_on = txt_add("A COND HYD", "font:roboto_bold.ttf; size:34; color: #37df27; halign:center;",175, 655, 200, 200)
visible(txt_ac_on, false)

-- Heater Overheat
txt_htr_off = txt_add("HEATER OVHT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 655, 200, 200)
txt_htr_on = txt_add("HEATER OVHT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",390, 655, 200, 200)
visible(txt_htr_on, false)

-- Courtesy Light
txt_court_off = txt_add("COURTESY LT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 915, 200, 200)
txt_court_on = txt_add("COURTESY LT", "font:roboto_bold.ttf; size:34; color: white; halign:center;",175, 915, 200, 200)
visible(txt_court_on, false)

-- Windshield
txt_ws_off = txt_add("WINDSHIELD", "font:roboto_bold.ttf; size:34; color: black; halign:center;",175, 740, 200, 200)
txt_ws_on = txt_add("WINDSHIELD", "font:roboto_bold.ttf; size:34; color: #37df27; halign:center;",175, 740, 200, 200)
visible(txt_ws_on, false)

-- Surface Deice
txt_surf_off = txt_add("SURF DEICE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",390, 740, 200, 200)
txt_surf_on = txt_add("SURF DEICE", "font:roboto_bold.ttf; size:34; color: #37df27; halign:center;",390, 740, 200, 200)
visible(txt_surf_on, false)


function toggle_indicators(test, volts, door, alt_l, alt_r, cabin, hyd_press, l_hyd, r_hyd, l_fuel, r_fuel, ac_on, ws, surf, court, pedestal, gearpos, prop_l, prop_r)
    -- low voltage
    if volts > 1 and (volts < 25 or  test == 1) then
        visible(txt_low_volt_on, true)
    else
        visible(txt_low_volt_on, false)
    end
    
    --door open
    if volts > 1 and (door == 1 or  test == 1) then
        visible(txt_door_on, true)
    else
        visible(txt_door_on, false)
    end
    
    --alternator left
    if volts > 1 and ( alt_l == 0 or  test == 1) then
        visible(txt_l_alt_on, true)
    else
        visible(txt_l_alt_on, false)
    end
    
    --alternator right
    if volts > 1 and (alt_r == 0 or  test == 1) then
        visible(txt_r_alt_on, true)
    else
        visible(txt_r_alt_on, false)
    end
    --cabin pressure
    if volts > 1 and (cabin > 10000 or  test == 1) then
        visible(txt_cabin_alt_on, true)
    else
        visible(txt_cabin_alt_on, false)
    end
    
    --hydraulic pressure
     if volts > 1 and ((hyd_press < 1000 and (gearpos < 1 and gearpos > 99))  or  test == 1) then
        visible(txt_hyd_press_on, true)
    else
        visible(txt_hyd_press_on, false)
    end
    
    --hydraulic flow l
    if volts > 1 and ((l_hyd < 1000 and prop_l > 100) or  test == 1) then
        visible(txt_l_hyd_on, true)
    else
        visible(txt_l_hyd_on, false)
    end
    
    --hydraulic flow r
    if volts > 1 and ((r_hyd < 1000 and prop_r > 100) or  test == 1) then
        visible(txt_r_hyd_on, true)
    else
        visible(txt_r_hyd_on, false)
    end
    
    --fuel low l
    if volts > 1 and (l_fuel < 0.03786 or  test == 1) then
        visible(txt_l_fuel_on, true)
    else
        visible(txt_l_fuel_on, false)
    end
    
    --fuel low r
    if volts > 1 and (r_fuel < 0.03786 or  test == 1) then
        visible(txt_r_fuel_on, true)
    else
        visible(txt_r_fuel_on, false)
    end
     --AC On
     if volts > 1 and (ac_on ==2  or  test == 1) then
        visible(txt_ac_on, true)
    else
        visible(txt_ac_on, false)
    end
    
    --Heater overheat    (INOP atm. Only test mode works)
    if volts > 1 and (test == 1) then
        visible(txt_htr_on, true)
    else
        visible(txt_htr_on, false)
    end
    
    --Windshield Deice
    if volts > 1 and (ws ==1  or  test == 1) then
        visible(txt_ws_on, true)
    else
        visible(txt_ws_on, false)
    end
    
    --Surface Deice
    if volts > 1 and (surf > 0  or  test == 1) then
        visible(txt_surf_on, true)
    else
        visible(txt_surf_on, false)
    end
    
    --Courtesy light
    if volts > 1 and ((court == 1 or pedestal == 13)   or  test == 1) then
        visible(txt_court_on, true)
    else
        visible(txt_court_on, false)
    end
    
    -- Spares
    if volts > 1 and (test == 1) then
        visible(txt_spare1_on, true)
        visible(txt_spare2_on, true)
        visible(txt_spare3_on, true)
        visible(txt_spare4_on, true)
        visible(txt_spare5_on, true)
        visible(txt_spare6_on, true)
        visible(txt_spare7_on, true)
    else
        visible(txt_spare1_on, false)
        visible(txt_spare2_on, false)
        visible(txt_spare3_on, false)
        visible(txt_spare4_on, false)
        visible(txt_spare5_on, false)
        visible(txt_spare6_on, false)
        visible(txt_spare7_on, false)    
    end
end

fs2020_variable_subscribe("L:ANUNNCIATOR_TEST_SWITCH", "NUMBER", 
                                               "A:ELECTRICAL MAIN BUS VOLTAGE", "Volts",
                                               "L:DOOR_HANDLE_UPPER_INSIDE_ENABLED", "NUMBER",
                                               "A:GENERAL ENG MASTER ALTERNATOR:1", "NUMBER", 
                                               "A:GENERAL ENG MASTER ALTERNATOR:2", "NUMBER", 
                                               "A:PRESSURIZATION CABIN ALTITUDE", "NUMBER", 
                                               "A:GEAR HYDRAULIC PRESSURE:1", "NUMBER", 
                                               "A:Hydraulic Pressure:1", "Number", 
                                               "A:Hydraulic Pressure:2", "Number", 
                                               "A:FUEL LEFT QUANTITY", "NUMBER",
                                               "A:FUEL RIGHT QUANTITY", "NUMBER",
                                               "L:GENERIC_Monentary_AIRCON_COOL_SWITCH_1", "Number",  
                                               "A:WINDSHIELD DEICE SWITCH", "NUMBER",
                                               "L:STRUCTURAL_DEICE_CYCLE", "NUMBER",
                                               "A:LIGHT CABIN POWER SETTING", "NUMBER",
                                               "A:LIGHT PEDESTAL:13", "NUMBER",  
                                               "A: GEAR CENTER POSITION:1", "PERCENT", 
                                               "A:PROP RPM:1", "RPM",
                                               "A:PROP RPM:2", "RPM",
                                               toggle_indicators)

