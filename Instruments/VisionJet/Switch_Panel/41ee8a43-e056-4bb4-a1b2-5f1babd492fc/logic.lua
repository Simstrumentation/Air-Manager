--[[
******************************************************************************************
************************ CIRRUS SF50 VISION JET SWITCH PANEL *****************************
******************************************************************************************
    Made by SIMSTRUMENTATION in collaboration with Russ Barlow
    GitHub: https://simstrumentation.com

Master switch panel for the Vision Jet by FlightFX

Version info:
- **v1.0** - 2022-12-11

NOTES: 
- BONUS FEATURE! Touching the hex screw to the left of the panel will remove all the
  aircraft covers and put on your headphones so you don't have to do it from the 
  VAMS menu in the GTC580

- Playing or muting of sounds can be adjusted via instrument user properties

- Will only work with the FlightFX Vision Jet

KNOWN ISSUES:
- None

ATTRIBUTION:
-Based on code and graphics from Russ Barlow. Used with permission. 
-Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--


--[[
    TO DO LIST
       - add user prop for manual / knobster scroll wheel
  ]]--     

play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager    

-- play sound
if user_prop_get(play_sounds) then
    click_snd = sound_add("click.wav")
    dial_snd = sound_add("dial.wav")
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
else
    press_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
end
-- end play sound
img_add_fullscreen("cirrus_switch_background.png")

--local vars
local oxygen = 0
local fresh_air = 0
local wing_ice = 0
local windhi = 0
local windmax = 0
local lightKnob = 0
local panelLight

--battery 2
function set_bat2(position)
    fs2020_event("K:TOGGLE_MASTER_BATTERY", 2)
end
bat2_sw = switch_add( "tog_off.png" , "tog_on.png", 80,64,68,125, set_bat2)

function  new_bat2_pos(batt2)    
    switch_set_position(bat2_sw , batt2)
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:2", "Bool", new_bat2_pos)

--battery 1
function set_bat1(position)
    fs2020_event("K:TOGGLE_MASTER_BATTERY", 1)
end

bat1_sw = switch_add( "tog_off.png" , "tog_on.png", 151,64,68,125, set_bat1)

function  new_bat1_pos(batt1)
    switch_set_position(bat1_sw , batt1)
end
fs2020_variable_subscribe("ELECTRICAL MASTER BATTERY:1", "Bool", new_bat1_pos)


--generator 1
function set_gen1(position)
    fs2020_event("TOGGLE_ALTERNATOR1")
end
gen1_sw = switch_add( "tog_off.png" , "tog_on.png", 223,64,68,125, set_gen1)

function new_gen1_pos(gen1)
    switch_set_position(gen1_sw , gen1)
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1", "BOOL", new_gen1_pos)

--generator 2
function set_gen2(position)
    fs2020_event("TOGGLE_ALTERNATOR2")
end

gen2_sw = switch_add( "tog_off.png" , "tog_on.png", 294,64,68,125, set_gen2)

function new_gen2_pos(gen2)
    switch_set_position(gen2_sw , gen2)
end
fs2020_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:2", "BOOL", new_gen2_pos)

--strobe lights
function set_strb(position)
    fs2020_event("STROBES_TOGGLE")
end
strb_sw = switch_add( "tog_off.png" , "tog_on.png", 367,64,68,125, set_strb)

function new_strobe_pos(strobe)
    switch_set_position(strb_sw, strobe)
end
fs2020_variable_subscribe("LIGHT STROBE", "BOOL", new_strobe_pos)

--landing lights
function set_land(position)
    fs2020_event("LANDING_LIGHTS_TOGGLE")
end
land_sw = switch_add( "tog_off.png" , "tog_on.png", 439,64,68,125, set_land)

function new_land_pos(land)
    switch_set_position(land_sw, land)
end
fs2020_variable_subscribe("LIGHT LANDING", "BOOL", new_land_pos)

--ice lights
function set_nav(position)
    fs2020_event("TOGGLE_WING_LIGHTS")
end
ice_sw = switch_add( "tog_off.png" , "tog_on.png", 509,64,68,125, set_nav)

function cb_set_ice_light(light)
    switch_set_position(ice_sw, light)
end 
fs2020_variable_subscribe("LIGHT WING", "Bool", cb_set_ice_light)

--oxygen switch
function set_moxy(position)
    if oxygen == 0 then
        fs2020_variable_write("L:SF50_oxygen_switch", "Number", 1)
    else
        fs2020_variable_write("L:SF50_oxygen_switch", "Number", 0)
    end
end

moxy_sw = switch_add( "tog_off.png" , "tog_on.png", 584,64,68,125, set_moxy)

function setOxy(pos)
    switch_set_position(moxy_sw, pos)
    oxygen = pos
end

fs2020_variable_subscribe("L:SF50_oxygen_switch", "Number", setOxy)

--fresh air
function set_bair()
    if fresh_air == 0 then
        fs2020_variable_write("L:SF50_air_flow_switch", "Number", 1)
    else
        fs2020_variable_write("L:SF50_air_flow_switch", "Number", 0)
    end    
end

bair_sw = switch_add( "tog_off.png" , "tog_on.png", 667,64,68,125, set_bair)

function setAir(pos)
    switch_set_position(bair_sw, pos)
    fresh_air = pos
end

fs2020_variable_subscribe("L:SF50_air_flow_switch", "Number", setAir)

--probe
function set_prob(position)
    fs2020_event("PITOT_HEAT_TOGGLE", 1)
end

prob_sw = switch_add( "tog_off.png" , "tog_on.png", 748,64,68,125, set_prob)

function new_pitot_pos(pitot)
    switch_set_position(prob_sw, pitot)
end
fs2020_variable_subscribe("PITOT HEAT", "Bool", new_pitot_pos)

--engine anti-ice
function set_engai(position)
    fs2020_event("K:ANTI_ICE_TOGGLE_ENG1")
end

engai_sw = switch_add( "tog_off.png" , "tog_on.png", 842,64,68,125, set_engai)

function engai_change(ai)
    switch_set_position(engai_sw, ai)
end

fs2020_variable_subscribe("A:ENG ANTI ICE:1", "Bool", engai_change)

--wing anti-ice
function set_wingai(position)
   fs2020_event("K:TOGGLE_STRUCTURAL_DEICE")
end

wingai_sw = switch_add( "tog_off.png" , "tog_on.png", 912,64,68,125, set_wingai)

function wingai_change(wi)
    wing_ice = wi
    switch_set_position(wingai_sw, wi)
end

fs2020_variable_subscribe("A:STRUCTURAL DEICE SWITCH", "Bool", wingai_change)

--windshield deice
function set_windon(position)
    fs2020_event("K:WINDSHIELD_DEICE_TOGGLE")
end

windon_sw = switch_add( "tog_off.png" , "tog_on.png", 983,64,68,125, set_windon)

function windon_change(wo)
switch_set_position(windon_sw, wo)
end
fs2020_variable_subscribe("A:WINDSHIELD DEICE SWITCH", "Bool", windon_change)

--windshield high
function set_windhi(position)
    if windhi == 1 then
        fs2020_variable_write("L:SF50_deice_high", "Number", 0)
    else
        fs2020_variable_write("L:SF50_deice_high", "Number", 1)
    end

end
windhi_sw = switch_add( "tog_off.png" , "tog_on.png", 1067,64,68,125, set_windhi)

function windhi_set(pos)
    switch_set_position(windhi_sw, pos)
    windhi = pos
end
fs2020_variable_subscribe("L:SF50_deice_high", "Number", windhi_set)

--windshield_max
function set_windmax(position)
    if windmax == 1 then
        fs2020_variable_write("L:SF50_deice_max", "Number", 0)
    else
        fs2020_variable_write("L:SF50_deice_max", "Number", 1)
    end
    sound_play(click_snd)
end
windmax_sw = button_add( "max_button_norm.png", "max_button_press.png" , 1136,64,63,124, set_windmax)

function windmax_set(pos)
    windmax = pos
end
fs2020_variable_subscribe("L:SF50_deice_max", "Number", windmax_set)


--Light Potentiometer

function set_panel_lights(direction)

        if direction == 1 then
            newVal = lightKnob + 5
            
            if newVal <=100 then
                if lightKnob == 0 then
                    fs2020_variable_write("A:LIGHT PANEL:1", "Number", 1)
                    sound_volume(click_snd, 300)
                    sound_play(click_snd)
                    sound_volume(click_snd, 100)
                end
                fs2020_variable_write("L:LIGHTING_PANEL_1", "Number", newVal)
                fs2020_event("K:LIGHT_POTENTIOMETER_SET", 3, newVal)
                fs2020_variable_write("L:LIGHTING_PANEL_1", "Number", newVal)
            end
            
        elseif direction == -1 then
            newVal = lightKnob - 5
            if newVal >=0 then
                if lightKnob == 5 then
                    fs2020_variable_write("A:LIGHT PANEL:1", "Number", 0)
                    sound_volume(click_snd, 300)
                    sound_play(click_snd)
                    sound_volume(click_snd, 100)
                end
                fs2020_variable_write("L:LIGHTING_PANEL_1", "Number", newVal)
                fs2020_event("K:LIGHT_POTENTIOMETER_SET", 3, newVal)
                fs2020_variable_write("L:LIGHTING_PANEL_1", "Number", newVal)
            end
        end
        if lightKnob >0 and lightKnob <100 then
            sound_play(dial_snd)
            dial_click_rotate(light_pot, 10)
            else
            dial_click_rotate(light_pot, 0)
        end            
end

light_pot = dial_add( "light_knob.png", 1220,87,82,82, set_panel_lights)




--checklist
function checklist_dial(direction)
    if direction == 1 then
        fs2020_event("H:checklist_scroll_down")
    else
        fs2020_event("H:checklist_scroll_up")
    end  
    sound_play(dial_snd)
    
end
dial_add(nil, 1360, 50, 40, 170, checklist_dial)
function release()
    sound_play(release_snd)
end
function checklist_press()
    fs2020_event("H:checklist_checklist_select")
    sound_play(press_snd)
end
button_add(nil, nil, 1360, 130, 50, 50, checklist_press, release)

function lightPot(val, panel, pot)
    lightKnob = val
    panelLight = panel
end

fs2020_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                 lightPot)

-- BONUS Button - remove static elements and coverings and put on headphones
function removeCovers()
    fs2020_variable_write("L:sf50_vams_static_storage_cover", "Enum", 1)
    fs2020_variable_write("L:sf50_vams_static_chocks", "Number", 1)
    fs2020_variable_write("L:sf50_vams_static_covers", "Number", 1)
    fs2020_variable_write("L:sf50_vams_static_headphones", "Number", 0)
    fs2020_variable_write("L:sf50_vams_static_storage_cover", "Enum", 0)
    fs2020_variable_write("L:sf50_vams_static_chocks", "Number", 0)
    fs2020_variable_write("L:sf50_vams_static_covers", "Number", 0)
    fs2020_variable_write("L:sf50_vams_static_headphones", "Number", 1)
end

button_add(nil, nil, 10,  100, 40, 40, removeCovers)