--[[
******************************************************************************************
***************CESSNA 414 CHANCELLOR ANNUNCIATOR PANEL ********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Annunciator panel for the Cessna 414 Chancellow by FlySimware


Version info:
- **v1.03** (15 Oct, 2022)
    - Removed extra SPARE annunciator lights to save space
    - Fixed a bug where the air conditioning light wasn't working. 
    - Added user option to place test button on top, left or bottom
    
- **v1.02** (21 Sept, 2022)
    - Fixed a bug for courtesy light due to the variable used being changed at some point
      
- **v1.01** (30 April, 2022)
    - Fixed a bug affecting the L and R Alt annunciator lights under certain conditions
    - Added a global inter-instrument variable to that other Cessna 414 instrument 
      indicator lights will also illuminate when test button is pressed. 


- **v1.0** (24 April, 2022)
    - Original release
    
NOTES: 
- Will only work with the Flysimware Cessna 414 Chancellor
- TEST button placement user-selectable via instrument properties.

KNOWN ISSUES:
- None

ATTRIBUTION:
All code, artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--

--***********************************************USER PROPERTY CONFIG***********************************************
font_color = user_prop_add_enum("Text Color","White, Black","White","Select color of labels")    -- user selects font color based on their background
test_button_pos = user_prop_add_enum("Test Button Position","Left, Top, Bottom","Left","Select location of PRESS TO TEST Button")    -- user selects button position
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")  
--********************************************* END USER PROPERTY CONFIG*********************************************

	--Set user prop
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    sound_volume(press_snd, 0.5)
    release_snd = sound_add("release.wav")
    sound_volume(release_snd, 0.5)
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
end

if user_prop_get(font_color ) == "White" then
   COLOR = "WHITE"
else
    COLOR = "BLACK"
end

local btnX = 20 -- default side button position
local btnY = 648 -- default side button position

if user_prop_get(test_button_pos) == " Top" then
    txt_press_to = txt_add("PRESS TO", "font:MS33558.ttf; size:24; color: "..tostring(COLOR)..";  halign:center;", 190, 25, 150, 100)
    txt_test = txt_add("TEST", "font:MS33558.ttf; size:24; color: "..tostring(COLOR)..";  halign:center;",190, 52, 150, 100)
    btnX = 350
    btnY = 15
elseif user_prop_get(test_button_pos) == " Bottom" then
    txt_press_to = txt_add("PRESS TO", "font:MS33558.ttf; size:24; color: "..tostring(COLOR)..";  halign:center;", 190, 845, 150, 100)
    txt_test = txt_add("TEST", "font:MS33558.ttf; size:24; color: "..tostring(COLOR)..";  halign:center;",190, 872, 150, 100)
    btnX = 350
    btnY = 835
else 
    txt_press_to = txt_add("PRESS TO", "font:MS33558.ttf; size:16; color: "..tostring(COLOR)..";  halign:center;", 2, 595, 100, 100)
    txt_test = txt_add("TEST", "font:MS33558.ttf; size:16; color: "..tostring(COLOR)..";  halign:center;",2, 615, 100, 100)
end
--create global inter-instrument var for the test button

systems_test = si_variable_create("systest","BOOL", false)


--background graphics
img_add("bg.png", 0,100,540,733)

-- Annunciator test button
function cb_test_pressed()
    fs2020_variable_write("L:ANUNNCIATOR_TEST_SWITCH", "Number", 1)
    si_variable_write(systems_test, true)
    sound_play(press_snd)
 end

function cb_test_released()
     fs2020_variable_write("L:ANUNNCIATOR_TEST_SWITCH", "Number", 0)
     si_variable_write(systems_test, false)
     sound_play(release_snd)
end
testbtn = button_add("button_up.png", "button_dn.png", btnX, btnY , 80, 80, cb_test_pressed, cb_test_released)

-- ADD TEXT FIELDS FOR ANNUNCIATOR INDICATORS
-- Low Voltage
txt_low_volt_off = txt_add("LOW VOLT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 135, 200, 200)
txt_low_volt_on = txt_add("LOW VOLT", "font:roboto_bold.ttf; size:34; color: red; halign:center;",115, 135, 200, 200)
visible(txt_low_volt_on, false)

-- Alternators
txt_l_alt_off = txt_add("L. ALT OUT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 220, 200, 200)
txt_l_alt_on = txt_add("L. ALT OUT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",115, 220, 200, 200)
visible(txt_l_alt_on, false)

txt_r_alt_off = txt_add("R. ALT OUT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 220, 200, 200)
txt_r_alt_on = txt_add("R. ALT OUT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",330, 220, 200, 200)
visible(txt_r_alt_on, false)


--Cabin Altitude
txt_cabin_alt_off = txt_add("CABIN ALT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 315, 200, 200)
txt_cabin_alt_on = txt_add("CABIN ALT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",115, 315, 200, 200)
visible(txt_cabin_alt_on, false)

--Hydraulic Flow
txt_l_hyd_off = txt_add("L. HYD FLOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 400, 200, 200)
txt_l_hyd_on = txt_add("L. HYD FLOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",115, 400, 200, 200)
visible(txt_l_hyd_on, false)

txt_r_hyd_off = txt_add("R. HYD FLOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 400, 200, 200)
txt_r_hyd_on = txt_add("R. HYD FLOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",330, 400, 200, 200)
visible(txt_r_hyd_on, false)


-- Fuel Flow
txt_l_fuel_off = txt_add("L. FUEL LOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 488, 200, 200)
txt_l_fuel_on = txt_add("L. FUEL LOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",115, 488, 200, 200)
visible(txt_l_fuel_on, false)

txt_r_fuel_off = txt_add("R. FUEL LOW", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 488, 200, 200)
txt_r_fuel_on = txt_add("R. FUEL LOW", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",330, 488, 200, 200)
visible(txt_r_fuel_on, false)

-- Spares


txt_spare7_off = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 750, 200, 200)
txt_spare7_on = txt_add("SPARE", "font:roboto_bold.ttf; size:34; color: white; halign:center;",330, 750, 200, 200)
visible(txt_spare7_on, false)

-- Door Warning
txt_door_off = txt_add("DOOR WARN", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 135, 200, 200)
txt_door_on = txt_add("DOOR WARN", "font:roboto_bold.ttf; size:34; color: red; halign:center;",330, 135, 200, 200)
visible(txt_door_on, false)

-- Hydraulic Pressure
txt_hyd_press_off = txt_add("HYD PRESS", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 315, 200, 200)
txt_hyd_press_on = txt_add("HYD PRESS", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",330, 315, 200, 200)
visible(txt_hyd_press_on, false)

-- Air Conditioning Pressure
txt_ac_off = txt_add("A COND HYD", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 575, 200, 200)
txt_ac_on = txt_add("A COND HYD", "font:roboto_bold.ttf; size:34; color: #37df27; halign:center;",115, 575, 200, 200)
visible(txt_ac_on, false)

-- Heater Overheat
txt_htr_off = txt_add("HEATER OVHT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 575, 200, 200)
txt_htr_on = txt_add("HEATER OVHT", "font:roboto_bold.ttf; size:34; color: yellow; halign:center;",330, 575, 200, 200)
visible(txt_htr_on, false)

-- Courtesy Light
txt_court_off = txt_add("COURTESY LT", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 750, 200, 200)
txt_court_on = txt_add("COURTESY LT", "font:roboto_bold.ttf; size:34; color: white; halign:center;",115, 750, 200, 200)
visible(txt_court_on, false)

-- Windshield
txt_ws_off = txt_add("WINDSHIELD", "font:roboto_bold.ttf; size:34; color: black; halign:center;",115, 665, 200, 200)
txt_ws_on = txt_add("WINDSHIELD", "font:roboto_bold.ttf; size:34; color: #37df27; halign:center;",115, 665, 200, 200)
visible(txt_ws_on, false)

-- Surface Deice
txt_surf_off = txt_add("SURF DEICE", "font:roboto_bold.ttf; size:34; color: black; halign:center;",330, 665, 200, 200)
txt_surf_on = txt_add("SURF DEICE", "font:roboto_bold.ttf; size:34; color: #37df27; halign:center;",330, 665, 200, 200)
visible(txt_surf_on, false)


function toggle_indicators(test, volts, door, alt_l, alt_l_state, alt_r, alt_r_state, cabin, hyd_press, l_hyd, r_hyd, l_fuel, r_fuel, ac_on, ws, surf, court, pedestal, gearpos, prop_l, prop_r)
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
    if volts > 1 and ( (alt_l_state == false or alt_l < 18) or  test == 1) then
        visible(txt_l_alt_on, true)
    else
        visible(txt_l_alt_on, false)
        
    end

    --alternator right
    if volts > 1 and ( (alt_r_state == false or alt_r< 18) or  test == 1) then
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
    if volts > 8 and ((court == 1 )   or  test == 1) then
        visible(txt_court_on, true)
    else
        visible(txt_court_on, false)
    end
    
    -- Spares
    if volts > 1 and (test == 1) then
--         visible(txt_spare1_on, true)
--         visible(txt_spare2_on, true)
--         visible(txt_spare3_on, true)
--         visible(txt_spare4_on, true)
--         visible(txt_spare5_on, true)
--         visible(txt_spare6_on, true)
        visible(txt_spare7_on, true)
    else
--         visible(txt_spare1_on, false)
--         visible(txt_spare2_on, false)
--         visible(txt_spare3_on, false)
--         visible(txt_spare4_on, false)
--         visible(txt_spare5_on, false)
--         visible(txt_spare6_on, false)
        visible(txt_spare7_on, false)    
    end
end

fs2020_variable_subscribe("L:ANUNNCIATOR_TEST_SWITCH", "NUMBER", 
                                               "A:ELECTRICAL MAIN BUS VOLTAGE", "VOLTS",
                                               "L:DOOR_HANDLE_UPPER_INSIDE_ENABLED", "NUMBER",
                                               "A:ELECTRICAL GENALT BUS VOLTAGE:1", "VOLTS", 
                                               "A:GENERAL ENG MASTER ALTERNATOR:1", "BOOL",
                                               "A:ELECTRICAL GENALT BUS VOLTAGE:2", "VOLTS", 
                                               "A:GENERAL ENG MASTER ALTERNATOR:2", "BOOL",
                                               "A:PRESSURIZATION CABIN ALTITUDE", "NUMBER", 
                                               "A:GEAR HYDRAULIC PRESSURE:1", "NUMBER", 
                                               "A:Hydraulic Pressure:1", "Number", 
                                               "A:Hydraulic Pressure:2", "Number", 
                                               "A:FUEL LEFT QUANTITY", "NUMBER",
                                               "A:FUEL RIGHT QUANTITY", "NUMBER",
                                               "L:GENERIC_Momentary_AIRCON_COOL_SWITCH_1", "Number",  
                                               "A:WINDSHIELD DEICE SWITCH", "NUMBER",
                                               "L:STRUCTURAL_DEICE_CYCLE", "NUMBER",
                                               "A:LIGHT PEDESTRAL:10", "NUMBER",
                                               "A:LIGHT PEDESTAL:13", "NUMBER",  
                                               "A: GEAR CENTER POSITION:1", "PERCENT", 
                                               "A:PROP RPM:1", "RPM",
                                               "A:PROP RPM:2", "RPM",
                                               toggle_indicators)

