--[[
******************************************************************************************
************************ CIRRUS SF50 VISION JET SWITCH PANEL *****************************
******************************************************************************************
    Made by SIMSTRUMENTATION in collaboration with Russ Barlow for FlightFX VisionJet, updated for MS 2024 VisionJet by Vandalay1125
    GitHub: https://simstrumentation.com

Master switch panel for the Vision Jet by Microsoft/Asobo

Version info:
- **v1.0** - 2024-12-31
    - Original release


NOTES: 
- Panel knob will adjust backlighting of this panel and all other Vision Jet - specific
   instruments in this collection
- Since the GTC580 and G3000 bezels are NOT specific to this plane, but rather GENERIC
    instruments, the panel dimmer will not affect their backlighting brightness.

- Playing or muting of sounds can be adjusted via instrument user properties

- Will only work with the MS Vision Jet

KNOWN ISSUES:
- Checklist and max deice inop in 2024

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
local lightKnob = 100
local panelLight

--battery 2
function set_bat2(position)
  --  print(position)
    if position ==1 then
        msfs_event("B:SF50_ELECTRICAL_BATTERY_2_SWITCH", 0)
    else
        msfs_event("B:SF50_ELECTRICAL_BATTERY_2_SWITCH", 1)    
    end
end
bat2_sw = switch_add( "tog_off.png" , "tog_on.png", 74,64,68,125, set_bat2)

function  new_bat2_pos(batt2)    
    switch_set_position(bat2_sw , batt2)
    if batt2 then
        visible(batt2_annun, true)
    else
        visible(batt2_annun, false)
    end
end
msfs_variable_subscribe("B:SF50_ELECTRICAL_BATTERY_2_SWITCH", "BOOL", new_bat2_pos)

batt2_annun = img_add("switch_annunciator.png", 94, 156, 30, 19, "visible:false")

--battery 1
function set_bat1(position)
    if position ==1 then
        msfs_event("B:SF50_ELECTRICAL_BATTERY_1_SWITCH", 0)
    else
        msfs_event("B:SF50_ELECTRICAL_BATTERY_1_SWITCH", 1)    
    end
end

bat1_sw = switch_add( "tog_off.png" , "tog_on.png", 142,64,68,125, set_bat1)
batt1_annun = img_add("switch_annunciator.png", 162, 156, 30, 19, "visible:false")



function  new_bat1_pos(batt1)
    switch_set_position(bat1_sw , batt1)
    if batt1 then
        visible(batt1_annun, true)
    else
        visible(batt1_annun, false)
    end
end
msfs_variable_subscribe("B:SF50_ELECTRICAL_BATTERY_1_SWITCH", "BOOL", new_bat1_pos)


--generator 1
function set_gen1(position)
    if position ==1 then
        msfs_event("B:SF50_ELECTRICAL_GEN_1_SWITCH", 0)
    else
        msfs_event("B:SF50_ELECTRICAL_GEN_1_SWITCH", 1)    
    end
end
gen1_sw = switch_add( "tog_off.png" , "tog_on.png", 215,64,68,125, set_gen1)
gen1_annun = img_add("switch_annunciator.png", 235, 156, 30, 19, "visible:false")

function new_gen1_pos(gen1)
    switch_set_position(gen1_sw , gen1)
    if gen1 then
        visible(gen1_annun, true)
    else
        visible(gen1_annun, false)
    end
end
msfs_variable_subscribe("B:SF50_ELECTRICAL_GEN_1_SWITCH", "BOOL", new_gen1_pos)

--generator 2
function set_gen2(position)
    if position ==1 then
        msfs_event("B:SF50_ELECTRICAL_GEN_2_SWITCH", 0)
    else
        msfs_event("B:SF50_ELECTRICAL_GEN_2_SWITCH", 1)    
    end
end
gen2_sw = switch_add( "tog_off.png" , "tog_on.png", 282,64,68,125, set_gen2)
gen2_annun = img_add("switch_annunciator.png", 301, 156, 30, 19, "visible:false")
function new_gen2_pos(gen2)
    switch_set_position(gen2_sw , gen2)
     if gen2 then
        visible(gen2_annun, true)
    else
        visible(gen2_annun, false)
    end   
end
msfs_variable_subscribe("B:SF50_ELECTRICAL_GEN_2_SWITCH", "BOOL", new_gen2_pos)

--strobe lights
function set_strb(position)
    msfs_event("STROBES_TOGGLE")
end
strb_sw = switch_add( "tog_off.png" , "tog_on.png", 363,64,68,125, set_strb)
strobe_annun = img_add("switch_annunciator.png", 382, 156, 30, 19, "visible:false")

function new_strobe_pos(strobe)
    switch_set_position(strb_sw, strobe)
    if strobe then
        visible(strobe_annun, true)
    else
        visible(strobe_annun, false)
    end  
end
msfs_variable_subscribe("LIGHT STROBE", "BOOL", new_strobe_pos)

--landing lights
function set_land(position)
    if position ==1 then
        msfs_event("B:SF50_LIGHTING_LANDING_LIGHTS", 0)
    else
        msfs_event("B:SF50_LIGHTING_LANDING_LIGHTS", 1)    
    end
end
land_sw = switch_add( "tog_off.png" , "tog_on.png", 432,64,68,125, set_land)
land_annun = img_add("switch_annunciator.png", 452, 156, 30, 19, "visible:false")

function new_land_pos(land)
    switch_set_position(land_sw, land)
    if land then
        visible(land_annun, true)
    else
        visible(land_annun, false)
    end  
end
msfs_variable_subscribe("B:SF50_LIGHTING_LANDING_LIGHTS", "BOOL", new_land_pos)

--ice lights
function set_nav(position)
    msfs_event("TOGGLE_WING_LIGHTS")
end
ice_sw = switch_add( "tog_off.png" , "tog_on.png", 500,64,68,125, set_nav)
ice_annun = img_add("switch_annunciator.png", 520, 156, 30, 19, "visible:false")

function cb_set_ice_light(light)
    switch_set_position(ice_sw, light)
    if light then
        visible(ice_annun, true)
    else
        visible(ice_annun, false)
    end 
end 
msfs_variable_subscribe("LIGHT WING", "Bool", cb_set_ice_light)

--oxygen switch
function set_moxy(position)
    position = oxygen
    if oxygen == 0 then
        msfs_event("B:SF50_PRESSURIZATION_OXYGEN_MASTER", 1)
    else
        msfs_event("B:SF50_PRESSURIZATION_OXYGEN_MASTER", 0)
    end
end

moxy_sw = switch_add( "tog_off.png" , "tog_on.png", 597,64,68,125, set_moxy)
moxy_annun = img_add("switch_annunciator.png", 616, 156, 30, 19, "visible:false")

function setOxy(pos)
 --   print(pos)
    switch_set_position(moxy_sw, pos)
    oxygen = pos
    if pos ==1 then
        visible(moxy_annun, true)
    else
        visible(moxy_annun, false)
    end
end

msfs_variable_subscribe("B:SF50_PRESSURIZATION_OXYGEN_MASTER", "Number", setOxy)

--fresh air
function set_bair()
    if fresh_air == 0 then
        msfs_event("B:SF50_PRESSURIZATION_SWITCH_AIR_BLEED", 1)
    else
        msfs_event("B:SF50_PRESSURIZATION_SWITCH_AIR_BLEED", 0)
    end    
end

bair_sw = switch_add( "tog_off.png" , "tog_on.png", 665,64,68,125, set_bair)
bair_annun = img_add("switch_annunciator.png", 684, 156, 30, 19, "visible:false")

function setAir(pos)
    switch_set_position(bair_sw, pos)
        if pos ==1 then
        visible(bair_annun, true)
    else
        visible(bair_annun, false)
    end
    fresh_air = pos
end

msfs_variable_subscribe("B:SF50_PRESSURIZATION_SWITCH_AIR_BLEED", "Number", setAir)

--probe
function set_prob(position)
    msfs_event("PITOT_HEAT_TOGGLE", 1)
end
prob_sw = switch_add( "tog_off.png" , "tog_on.png", 733,64,68,125, set_prob)
probe_annun = img_add("switch_annunciator.png", 753, 156, 30, 19, "visible:false")

function new_pitot_pos(pitot)
    switch_set_position(prob_sw, pitot)
    if pitot then
        visible(probe_annun, true)
    else
        visible(probe_annun, false)
    end 
end
msfs_variable_subscribe("PITOT HEAT", "Bool", new_pitot_pos)

--engine anti-ice
function set_engai(position)
    msfs_event("K:ANTI_ICE_TOGGLE_ENG1")
end

engai_sw = switch_add( "tog_off.png" , "tog_on.png", 842,64,68,125, set_engai)
ai_annun = img_add("switch_annunciator.png", 862, 156, 30, 19, "visible:false")

function engai_change(ai)
    switch_set_position(engai_sw, ai)
    if ai then
        visible(ai_annun, true)
    else
        visible(ai_annun, false)
    end 
end

msfs_variable_subscribe("A:ENG ANTI ICE:1", "Bool", engai_change)

--wing anti-ice
function set_wingai(position)
   msfs_event("K:TOGGLE_STRUCTURAL_DEICE")
end
wingai_sw = switch_add( "tog_off.png" , "tog_on.png", 910,64,68,125, set_wingai)
wing_annun = img_add("switch_annunciator.png", 928, 156, 30, 19, "visible:false")

function wingai_change(wi)
    wing_ice = wi
    switch_set_position(wingai_sw, wi)
    if wi then
        visible(wing_annun, true)
    else
        visible(wing_annun, false)
    end 
end
msfs_variable_subscribe("A:STRUCTURAL DEICE SWITCH", "Bool", wingai_change)

--windshield deice
function set_windon(position)
    if position == 1 then
        msfs_event("B:DEICE_WINDSHIELD_1", 0)
    else
        msfs_event("B:DEICE_WINDSHIELD_1", 1)
    end
end
windon_sw = switch_add( "tog_off.png" , "tog_on.png", 993,64,68,125, set_windon)
ws_annun = img_add("switch_annunciator.png", 1013, 156, 30, 19, "visible:false")

function windon_change(wo)
    switch_set_position(windon_sw, wo)
    if wo == 1 then
        visible(ws_annun, true)
    else
        visible(ws_annun, false)
    end 
end
msfs_variable_subscribe("B:DEICE_WINDSHIELD_1", "Number", windon_change)

--windshield high
function set_windhi(position)
    if windhi == 1 then
        msfs_event("B:DEICE_WINDSHIELD_HIGH", 0)
    else
        msfs_event("B:DEICE_WINDSHIELD_HIGH", 1)
    end
end
windhi_sw = switch_add( "tog_off.png" , "tog_on.png", 1059,64,68,125, set_windhi)
windhi_annun = img_add("switch_annunciator.png", 1078, 156, 30, 19, "visible:false")

function windhi_set(pos)
 --   print(pos)
    switch_set_position(windhi_sw, pos)
    windhi = pos
    if windhi == 1 then
        visible(windhi_annun, true)
    else
        visible(windhi_annun, false)
    end 
end
msfs_variable_subscribe("B:DEICE_WINDSHIELD_HIGH", "Number", windhi_set)

--windshield_max
-- inop in 2024
function release()
    sound_volume(release_snd, .5)
    sound_play(release_snd)
end

function set_windmax(position)
    if windmax == 1 then
        msfs_variable_write("L:SF50_deice_max", "Number", 0)
    else
        msfs_variable_write("L:SF50_deice_max", "Number", 1)
    end
    sound_play(click_snd)
end
windmax_sw = button_add( "max_button_norm.png", "max_button_press.png" , 1136,64,63,124, set_windmax, release)

function windmax_set(pos)
    windmax = pos
end
msfs_variable_subscribe("L:SF50_deice_max", "Number", windmax_set)


--Light Potentiometer


function lightKnob_set(val)
    knobval = round(val)
end

msfs_variable_subscribe("B:SF50_LIGHTING_INSTRUMENT_LIGHTS", "Number", lightKnob_set)

function set_panel_lights(direction)
    
        if direction == 1 then
            if knobval < 100 then
                newVal = knobval + 5       
                msfs_event("B:SF50_LIGHTING_INSTRUMENT_LIGHTS", newVal)
            end
           
        elseif direction == -1 then
            if knobval > 0 then
                newVal = knobval - 5
                msfs_event("B:SF50_LIGHTING_INSTRUMENT_LIGHTS", newVal)
            end
        end
        if knobval >0 and knobval <100 then
           sound_play(dial_snd)
           dial_click_rotate(light_pot, 10)
        else
           dial_click_rotate(light_pot, 0)
        end            
end
light_pot = dial_add( "light_knob.png", 1234,87,82,82, set_panel_lights)

--checklist
-- inop 2024

img_backlight = img_add_fullscreen("labels.png")
backlight_group = group_add(img_backlight, batt2_annun, batt1_annun, gen1_annun, gen2_annun, strobe_annun, land_annun, ice_annun, moxy_annun, bair_annun, probe_annun, ai_annun, wing_annun, ws_annun, windhi_annun)

opacity(backlight_group, 0)

-- backlight
function lightPot(val, power)
    if power  then
        opacity(backlight_group, (val/100), "LINEAR", 0.5)
    else
        opacity(backlight_group, 0, "LINEAR", 0.5)    
    end
end

msfs_variable_subscribe("B:SF50_LIGHTING_INSTRUMENT_LIGHTS", "Number",
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)


function round(num)
    return math.floor(num + 0.5)
end