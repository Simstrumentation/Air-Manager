--[[
******************************************************************************************
******************************Garmin G1000 Overlay Bezel**********************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

This G1000 bezel is specifically designed for use with Microsoft Flight Simulator (2020)
and to work with the Working Title G1000 NXi 0.8 or higher. It's compatible with the stock G1000, 
although some functions (such as VNAV) may be INOP due to not being available in the stock G1000.

INSTRUCTIONS:

When placing G1000NXi bezel into a new panel:
    1. right click on bezel in panel preview
    2. Select Unit Mode (PFD or MFD)
    3. Select which logo you would like displayed
    4. Select if you want the bezel to have sounds when buttons are pressed
    5. Select what autopilot controls you would like to show.


Version info:

- **v1.0** (August-2021)
    - Original modification of Sim Innovations G1000 to function with Working Title G1000 NXi
    
- **v2.0** (10-21-2021)
    - Full recoding from the ground up for MSFS only and the WT G1000 NXi
    - Complete new instrument with new id. 
    - New custom graphics
    - New custom sounds
    - All buttons function exactly as the real G1000 unit

- **v2.01** (10-21-2021)
    - Map panning working with WT G1000 NXi

- **v2.1** (1-14-2022)
    - Bezel graphic update with new textures
    - added user props for autopilot controls:
        * show all AP controls
        * hide AP buttons but show ALT knob
        * hide AP buttons and ALT knob
    - lights around knobs now in off state until G1000 unit is powered up. 
    
NOTES: 
- Compatible with Working Title G1000 NXi 0.8 and above
- Volume knob for NAV radio works on stock G1000, but that function is currently INOP in the WT G1000 NXi

KNOWN ISSUES:
- None

ATTRIBUTION:
All code, artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
]]--

-- set local variables
local unit_mode = nil
local flc_engaged = nil
local vs_engaged = nil
local current_airspeed = 0
local current_alt = 0
local current_hdg = 0
local show_ap_buttons = true
local show_alt_knob = true
-- end set local variables

--***********************************************USER PROPERTY CONFIG***********************************************
-- define user selectable properties
mode = user_prop_add_enum("Unit Mode","PFD, MFD","PFD","Select whether this is the PFD or MFD")                  -- Select unit mode. PFD is default
logo_used = user_prop_add_enum("Select Logo","Simstrumentation, Garmin","Simstrumentation","Select which logo to display at the top of the bezel")     -- Select which logo to show - Simstrumentation default
show_ap = user_prop_add_enum("Include autopilot controls", "All,Hide buttons,Hide buttons and ALT knob", "All", "Select how autopilot controls will be displayed")
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

--[[
-- Future user prop for when G1000 and instrument altimeters are separated in MSFS. 
-- Currently, both are set by the G1000, which is incorrect behaviour. 
-- This will allow users to have the baro knob set the pressure on the G1000 only, the main Kohlsman, or both

baro_select = user_prop_add_enum("Select Barometer behaviour","Kohlsman,G1000,Both","Both","Select which altimeter the G1000 baro knob sets. Default is both")
]]--


-- end define user selectable properties

-- INITIALIZE USER PROPERTIES

--  unit mode
if user_prop_get(mode) == "PFD" then
    unit_mode = "PFD"
else
    unit_mode = "MFD"
end
--  end unit mode

-- show autopilot controls
if user_prop_get(show_ap) ==  "All" then                        -- shows all autopilot controls
    img_add_fullscreen("bg_ap.png")                 
    knob_lights_id = img_add("backlight_all.png", 1, 1, 1412, 917)    --backlight with alt knob
    show_ap_buttons = true
    show_alt_knob = true
elseif user_prop_get(show_ap) == "Hide buttons" then            -- hides autopilot controls but keeps altitude selector knob
    img_add_fullscreen("bg_noap.png")
    knob_lights_id = img_add("backlight_all.png", 1, 1, 1412, 917)     --backlight with alt knob
    show_ap_buttons = false
    show_alt_knob = true
else                                                            -- hides autopilot controls and altitude selector knob
    img_add_fullscreen("bg_noap_noalt.png")                     
    knob_lights_id = img_add_fullscreen("backlight_no_alt.png") --backlight without alt knob
    show_ap_buttons = false
    show_alt_knob  = false
end
visible(knob_lights_id, true)  --set initial state of backlights off    
-- end show autopilot control

-- logo to display
if user_prop_get(logo_used) == "Simstrumentation" then
    img_add("simstrumentation_logo.png",645,11,161,12)                                                  -- Show Simstrumentation logo
else 
    img_add("garmin-logo-white.png",675,5,100,28)                                                         -- Show Garmin logo
end
-- end logo to display

-- play sounds
if user_prop_get(play_sounds) then
    press_snd = sound_add("click.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end
-- end play sounds

-- END INITIALIZE USER PROPERTIES

--*********************************************END USER PROPERTY CONFIG***********************************************

-- make knob backlights turn on when unit is powered on
function power_on(avionics, mainbus, generator)
  	--set aircraft main bus power state
    if (mainbus >= 1 or generator == true ) then
		power_state = true
	else
		power_state = false
	end
    
    --set aircraft avionics power state
    if (power_state and avionics) then
        avionics_state = true
    else
        avionics_state = false
    end

    -- set PFD power state
    if unit_mode == "PFD" then
        if power_state then
            opacity(knob_lights_id, 1, "LOG", 0.03)
        else
            opacity(knob_lights_id, 0,  "LINEAR", 1)
        end
    end
    -- set MFD power state
    if unit_mode == "MFD" then
        if avionics_state then
            opacity(knob_lights_id, 1, "LOG", 0.03)
        else
            opacity(knob_lights_id, 0,  "LINEAR", 1)
        end
    end
end



fs2020_variable_subscribe("CIRCUIT AVIONICS ON", "BOOL",
					        "ELECTRICAL MAIN BUS VOLTAGE", "Volts",
					        "GENERAL ENG GENERATOR SWITCH:1", "BOOL",
                            power_on)
-- end make knob backlights turn on when unit is powered on

-- NAV / COMM CHANNELS

-- switch nav channel button
function switch_nav_channel()
    fs2020_event("H:AS1000_" .. unit_mode .. "_NAV_Switch")
    sound_play(press_snd)
end
button_add(nil,"channel_swap_pressed.png", 102,107,50,32, switch_nav_channel)
-- end switch nav channel button

-- switch comm channel button
function switch_com_channel()
    fs2020_event("H:AS1000_" .. unit_mode .. "_COM_Switch")
    sound_play(press_snd)
end

button_add(nil,"channel_swap_pressed.png", 1259,107,50,32, switch_com_channel)
-- end switch comm channel button

-- nav volume knob
function nav_vol_adjust(direction)
    if direction ==  1 then
        --fs2020_event("H:AS1000_PFD_VOL_1_INC")
        fs2020_event("NAV1_VOLUME_INC")
        fs2020_event("NAV2_VOLUME_INC")
    elseif direction == -1 then
        --fs2020_event("H:AS1000_PFD_VOL_1_INC")
        fs2020_event("NAV1_VOLUME_DEC")
        fs2020_event("NAV2_VOLUME_DEC")
    end
    sound_play(dial_snd)
end

navvol_dial = dial_add("plain_knob_inner.png", 63,47,42,42, nav_vol_adjust)
-- end nav volume knob

-- com volume knob
function com_vol_adjust(direction)
    if direction ==  1 then
        --fs2020_event("H:AS1000_PFD_VOL_2_INC")
        fs2020_event("COM1_VOLUME_INC")
        fs2020_event("COM2_VOLUME_INC")
    elseif direction == -1 then
        --fs2020_event("H:AS1000_PFD_VOL_2_DEC")
        fs2020_event("COM1_VOLUME_DEC")
        fs2020_event("COM2_VOLUME_DEC")
        
    end
    sound_play(dial_snd)
end

comvol_dial = dial_add("plain_knob_inner.png", 1300,47,42,42, com_vol_adjust)
-- end com volume knob

-- nav radio tuning knob
function knob_nav_tune_outer( direction)        --large outer knob
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_NAV_Large_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_NAV_Large_DEC")
    end
    sound_play(dial_snd)
end

nav_dial_outer = dial_add("plain_knob_outer.png", 47,173,79,79, knob_nav_tune_outer)
dial_click_rotate(nav_dial_outer, 6)

function knob_nav_tune_inner( direction)        --small inner knob
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_NAV_Small_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_NAV_Small_DEC")
    end
    sound_play(dial_snd)
end

nav_dial_inner = dial_add("plain_knob_inner.png", 61,187,52,52, knob_nav_tune_inner)
dial_click_rotate(nav_dial_inner, 6)

-- nav radio channel swap button
function btn_nav_channel_swap()         -- press to swap channels
    fs2020_event("H:AS1000_" .. unit_mode .. "_NAV_Push")
    sound_play(press_snd)
end

button_add(nil,nil, 75,204,13,13, btn_nav_channel_swap)
-- end nav radio tuning knob

-- com radio tuning knob
function knob_com_tune_outer( direction)
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_COM_Large_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_COM_Large_DEC")
    end
    sound_play(dial_snd)
end

com_dial_outer = dial_add("plain_knob_outer.png", 1282,173,79,79, knob_com_tune_outer)
dial_click_rotate( com_dial_outer, 6)

function knob_com_tune_inner( direction)
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_COM_Small_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_COM_Small_DEC")
    end
    sound_play(dial_snd)
end

com_dial_inner = dial_add("plain_knob_inner.png", 1295,187,52,52, knob_com_tune_inner)

dial_click_rotate( com_dial_inner, 6)

function btn_com_channel_swap()         -- press to swap channels
    fs2020_event("H:AS1000_" .. unit_mode .. "_COM_Push")
    sound_play(press_snd)
end

button_add(nil,nil, 1313,204,13,13, btn_com_channel_swap)
-- end com radio tuning knob

-- END NAV / COMM CHANNELS


-- AUTOPILOT FUNCTIONS

-- heading knob
function dial_hdg( direction)
    if direction ==  1 then
        fs2020_event("HEADING_BUG_INC")
    elseif direction == -1 then
        fs2020_event("HEADING_BUG_DEC")
    end
    sound_play(dial_snd)
end

hdg_dial = dial_add("hdg_knob.png", 45,340,80,80,3, dial_hdg)
dial_click_rotate( hdg_dial, 6)

function btn_hdg()--_hdg_down
    fs2020_event("HEADING_BUG_SET", current_hdg)
    sound_play(press_snd)
end

button_add(nil,nil, 77,370,20,20,btn_hdg)
-- end heading knob

-- ap button
function btn_ap()
    fs2020_event("AP_MASTER")
    sound_play(press_snd)
end

button_ap = button_add(nil,"ap_pressed.png", 28,470,50,34, btn_ap)
visible(button_ap, show_ap_buttons)  -- only show if AP buttons shown
-- end ap button

-- heading button
function btn_hdg()
    fs2020_event("AP_PANEL_HEADING_HOLD")
    sound_play(press_snd)
end

button_hdg = button_add(nil,"hdg_pressed.png", 28,520,50,34, btn_hdg)
visible(button_hdg, show_ap_buttons)  -- only show if AP buttons shown
-- end heading button

-- nav mode button
function btn_nav()
    fs2020_event("AP_NAV1_HOLD")
    sound_play(press_snd)
end

button_nav = button_add(nil,"nav_pressed.png", 28,570,50,32, btn_nav)
visible(button_nav, show_ap_buttons) -- only show if AP buttons shown
-- end nav mode button

-- apr mode button
function btn_apr()

    fs2020_event("AP_APR_HOLD")
    sound_play(press_snd)
end

button_apr = button_add(nil,"apr_pressed.png", 28,621,52,33, btn_apr)
visible(button_apr, show_ap_buttons) -- only show if AP buttons shown
-- end apr mode button

-- vs hold button
function btn_vs()
    fs2020_event("AP_PANEL_VS_HOLD")
    sound_play(press_snd)
end

button_vs = button_add(nil,"vs_pressed.png", 28,671,50,32, btn_vs)
visible(button_vs, show_ap_buttons)  -- only show if AP buttons shown
-- end vs hold button

-- Determine state of autopilot - FLC or VS.
-- Required for correct operation of FLC, VS and nose up / down buttons

function flc_callback(flc_state)
    flc_engaged = flc_state 
end
        
function vs_callback(vs_state)
    vs_engaged = vs_state  
end

function get_cuurent_ias(asi_val)
	current_airspeed = asi_val  
end

-- flight level change mode button
function btn_flc()
    if flc_engaged then                                             --check if FLC is currently on
        fs2020_event("FLIGHT_LEVEL_CHANGE_OFF")                     --disengage FLC mode
    else    -- if FLC currently off
        current_airspeed = math.floor(current_airspeed)             -- read current airspeed and convert variable
        fs2020_event("FLIGHT_LEVEL_CHANGE_ON")                      -- engage FLC mode
        fs2020_event("AP_SPD_VAR_SET", current_airspeed)            -- set FLC speed to current airspeed
    end
    sound_play(press_snd)
end

button_flc = button_add(nil,"flc_pressed.png", 26,721,54,32, btn_flc)
visible(button_flc, show_ap_buttons) -- only show if AP buttons shown

--simvar subscriptions for FLC and VS operation
fs2020_variable_subscribe("AUTOPILOT FLIGHT LEVEL CHANGE", "bool", flc_callback)  
fs2020_variable_subscribe("AUTOPILOT VERTICAL HOLD", "bool", vs_callback)
fs2020_variable_subscribe("AIRSPEED INDICATED", "knots", get_cuurent_ias)

-- end flight level change mode button

-- flight director button
function btn_fd()
    fs2020_event("TOGGLE_FLIGHT_DIRECTOR")
    sound_play(press_snd)
end

button_fd = button_add(nil,"fd_pressed.png", 100,470,50,32, btn_fd)
visible(button_fd, show_ap_buttons)  -- only show if AP buttons shown
-- end flight director button

-- altitude mode button
function btn_alt()
    fs2020_event("AP_PANEL_ALTITUDE_HOLD")
    sound_play(press_snd)
end

button_alt = button_add(nil,"alt_pressed.png", 100,520,50,32, btn_alt)
visible(button_alt, show_ap_buttons) -- only show if AP buttons shown
-- end altitude mode button

-- vertical navigation mode button
function btn_vnav()
    fs2020_event("H:AS1000_VNAV_TOGGLE")
    sound_play(press_snd)
end

button_vnv = button_add(nil,"vnv_pressed.png", 98,570,54,32, btn_vnav)
visible(button_vnv, show_ap_buttons) -- only show if AP buttons shown
-- end vertical navigation mode button

-- back course button
function btn_bc()
    fs2020_event("AP_BC_HOLD")
    sound_play(press_snd)
end

button_bc = button_add(nil,"bc_pressed.png", 98,621,54,32, btn_bc)
visible(button_bc, show_ap_buttons)  -- only show if AP buttons shown
-- end back course button

-- nose up button
function btn_noseup()
    if vs_engaged then                      -- if VS mode
        fs2020_event("AP_VS_VAR_INC")
    elseif flc_engaged then                 -- if FLC mode
        fs2020_event("AP_SPD_VAR_DEC")
    else                                    -- PITCH mode
        fs2020_event("AP_PITCH_REF_INC_UP")
    end
    sound_play(press_snd)
end

btn_noseup_id = button_add(nil,"nsup_pressed.png", 100,671,50,32, btn_noseup)
visible(btn_noseup_id, show_ap_buttons)   -- only show if AP buttons shown
-- end nose up button

-- nose down button
function btn_nosedown()
    if vs_engaged then                          -- if VS mode
            fs2020_event("AP_VS_VAR_DEC")
    elseif flc_engaged then                     -- if FLC mode
        fs2020_event("AP_SPD_VAR_INC")
    else                                        -- PITCH mode
        fs2020_event("AP_PITCH_REF_INC_DN")
    end 
    sound_play(press_snd)
end

btn_nosedown_id = button_add(nil,"nsdn_pressed.png", 100,721,50,32, btn_nosedown)
visible(btn_nosedown_id, show_ap_buttons)   -- only show if AP buttons shown
-- end nose down button

-- alt knob
function knob_alt_outer( direction)
    if direction ==  1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt + 1000)
    elseif direction == -1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt - 1000)
    end
    sound_play(dial_snd)
end

knob_alt_outer_id = dial_add("plain_knob_outer.png", 47,793,79,79, knob_alt_outer)
dial_click_rotate( knob_alt_outer_id, 6)
visible(knob_alt_outer_id, show_alt_knob) 

function knob_alt_inner( direction)
    if direction ==  1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt + 100)
    elseif direction == -1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt - 100)
    end
    sound_play(dial_snd)
end

knob_alt_inner_id = dial_add("plain_knob_inner.png", 61,807,52,52, knob_alt_inner)
dial_click_rotate( knob_alt_inner_id, 6)
visible(knob_alt_inner_id, show_alt_knob) 
-- end alt knob

-- simvar subscriptions for ALT and HDG
fs2020_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR", "Feet", 
                          "PLANE HEADING DEGREES MAGNETIC", "Degrees", 
                          function(ap_alt, heading)
                              current_alt = ap_alt
                              current_hdg = math.floor(heading + 0.5)
                          end
                        )
-- end simvar subscriptions for ALT and HDG

-- END AUTOPILOT FUNCTIONS

-- SOFTKEYS
function btn_sc1()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_1")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 212,852,50,32, btn_sc1)

function btn_sc2()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_2")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 296,852,50,32, btn_sc2)

function btn_sc3()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_3")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 382,852,50,32, btn_sc3)

function btn_sc4()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_4")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 467,852,50,32, btn_sc4)

function btn_sc5()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_5")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 553,852,50,32, btn_sc5)

function btn_sc6()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_6")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 639,852,50,32, btn_sc6)

function btn_sc7()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_7")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 723,852,50,32, btn_sc7)

function btn_sc8()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_8")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 807,852,50,32, btn_sc8)

function btn_sc9()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_9")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 891,852,50,32, btn_sc9)

function btn_sc10()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_10")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 978,852,50,32, btn_sc10)

function btn_sc11()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_11")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 1063,852,50,32, btn_sc11)

function btn_sc12()
    fs2020_event("H:AS1000_" .. unit_mode .. "_SOFTKEYS_12")
    sound_play(press_snd)
end

button_add(nil,"softkey_pressed.png", 1148,852,50,32, btn_sc12)

-- END SOFTKEYS

-- FMS CONTROLS

-- baro / crs knob
function knob_baro( direction)
    if direction ==  1 then
        fs2020_event("KOHLSMAN_INC")
    elseif direction == -1 then
        fs2020_event("KOHLSMAN_DEC")
    end
    sound_play(dial_snd)
end

baro_dial  = dial_add("plain_knob_outer.png", 1281,333,82,82, knob_baro)
dial_click_rotate( baro_dial, 6)

function knob_crs( direction)
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_CRS_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_CRS_DEC")
    end
    sound_play(dial_snd)
end

crs_dial = dial_add("crs_knob.png", 1294,347, 54, 54, knob_crs)
dial_click_rotate( crs_dial, 6)

function btn_crs_knob()
    fs2020_event("H:AS1000_" .. unit_mode .. "_CRS_PUSH")
    sound_play(press_snd)
end

button_add(nil,nil, 1315,370,13,13, btn_crs_knob)
-- end baro / crs knob

-- MAP CONTROL KNOB AND JOYSTICK 
--map panning

local pal_y =  432
pan_background = img_add("pan_background.png", 1229 ,432,190,190)
-- up

function btn_0_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_UP")
end

up_press = button_add(nil, "0_deg.png", 1298, 432, 49,42, btn_0_deg)

-- up right
function btn_45_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_RIGHT")
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_UP")
end

uprt_press = button_add(nil, "45_deg.png", 1345, 457, 46,48, btn_45_deg)

-- right
function btn_90_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_RIGHT")
end

rt_press = button_add(nil, "90_deg.png", 1374, 504, 44,46, btn_90_deg)

--down right
function btn_135_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_RIGHT")
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_DOWN")
end
dnrt_press = button_add(nil, "135_deg.png", 1347, 552, 46,48, btn_135_deg)

-- down
function btn_180_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_DOWN")
end

dn_press = button_add(nil, "180_deg.png", 1298, 580, 49,42, btn_180_deg)

-- down left
function btn_225_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_LEFT")
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_DOWN")
end

dnlt_press = button_add(nil, "225_deg.png", 1251, 552, 47,47, btn_225_deg)


-- left
function btn_270_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_LEFT")
end
lt_press = button_add(nil, "270_deg.png", 1229, 506, 44,46, btn_270_deg)


-- up left
function btn_315_deg()
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_LEFT")
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_UP")
end

uplt_press = button_add(nil, "315_deg.png", 1252, 458, 47,47, btn_315_deg)


local show_cursor = false
visible(pan_background, show_cursor)
-- end map panning

-- map zoom knob
function range_turn( direction)
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_RANGE_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_RANGE_DEC")
    end
    sound_play(dial_snd)
end

rng_dial = dial_add("plain_knob_inner.png", 1296,501,54,54, range_turn)
dial_click_rotate( rng_dial, 6)

function btn_map_cursor_toggle()
    show_cursor = not show_cursor
    visible(pan_background, show_cursor)
    fs2020_event("H:AS1000_" .. unit_mode .. "_JOYSTICK_PUSH")
    sound_play(press_snd)
end

button_add(nil,nil, 1313,519,21,21, btn_map_cursor_toggle)
-- end map zoom knob

-- END MAP CONTROL KNOB AND JOYSTICK 

-- FMS BUTTONS

--dct button
function btn_dct()
    fs2020_event("H:AS1000_" .. unit_mode .. "_DIRECTTO")
    sound_play(press_snd)
end

button_add(nil,"dir_pressed.png", 1262,621,50,32, btn_dct)
--end dct button

--menu button
function btn_menu()
    fs2020_event("H:AS1000_" .. unit_mode .. "_MENU_Push")
    sound_play(press_snd)
end

button_add(nil,"menu_pressed.png", 1334,621,50,32, btn_menu)
--end menu button

--fpl button
function btn_fpl()
    fs2020_event("H:AS1000_" .. unit_mode .. "_FPL_Push")
    sound_play(press_snd)
end

button_add(nil,"fpl_pressed.png", 1262,673,50,32, btn_fpl)
--end fpl button

-- proc button
function btn_proc()
    fs2020_event("H:AS1000_" .. unit_mode .. "_PROC_Push")
    sound_play(press_snd)
end

button_add(nil,"proc_pressed.png", 1334,673,50,32, btn_proc)
-- proc button

--CLR button
function fmc_btn_clear_start()
    fs2020_event("H:AS1000_" .. unit_mode .. "_CLR")
    sound_play(press_snd)
    timer_id1 = timer_start(1000,CLR_LONG)
 end

 function fmc_btn_clear_end()
        timer_stop(timer_id1)
 end
 
 function CLR_LONG()
    fs2020_event("H:AS1000_" .. unit_mode .. "_CLR_Long")
 end
 
button_add(nil,"clr_pressed.png", 1262,725,50,32, fmc_btn_clear_start,  fmc_btn_clear_end)
--end CLR button

--ent button
function btn_ent()
    fs2020_event("H:AS1000_" .. unit_mode .. "_ENT_Push")
    sound_play(press_snd)
end

button_add(nil,"ent_pressed.png", 1334,725,50,32, btn_ent)
--end ent button

-- END FMS BUTTONS

-- fms knob
function fms_outer_turn( direction)
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_FMS_Lower_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_FMS_Lower_DEC")
    end
    sound_play(dial_snd)
end

fms_dial_outer = dial_add("plain_knob_outer.png", 1282,793,79,79, fms_outer_turn)
dial_click_rotate( fms_dial_outer, 6)

function fms_inner_turn( direction)
    if direction ==  1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_FMS_Upper_INC")
    elseif direction == -1 then
        fs2020_event("H:AS1000_" .. unit_mode .. "_FMS_Upper_DEC")
    end
    sound_play(dial_snd)
end

fms_dial_inner = dial_add("plain_knob_inner.png", 1296,807,52,52, fms_inner_turn)
dial_click_rotate( fms_dial_outer, 6)

function cursor_click()
    fs2020_event("H:AS1000_" .. unit_mode .. "_FMS_Upper_PUSH")
    sound_play(press_snd)
end

button_add(nil,nil, 1311,821,13,13, cursor_click)
-- end fms knob

--END FMS CONTROLS