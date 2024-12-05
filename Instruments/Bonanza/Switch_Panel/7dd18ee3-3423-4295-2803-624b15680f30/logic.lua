--[[
--******************************************************************************************
-- ******************* BEECHCRAFT BONANZA SWITCH PANEL **************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Main switch panel for the Beechcraft Bonanza G36
    
    RELEASES: 
    
        V1.0 - Released 2022-12-26
        
    NOTES:
        - NONE          
  
    
    KNOWN ISSUES:
        - Propeller Deice switch works, but doesn't activate the switch in the virtual cockpit. Suspect this is a B: variable issue
        - Alt Static Air lever is INOP in virtual cockpit, but is active and functional in the plane's model. Lever in this panel
          funtions properly, only no virtual cockpit animation to match. 

   --******************************************************************************************
--]]

img_add_fullscreen("bg.png")
fail_snd = sound_add("beepfail.wav")
---------------------Switches
--Battery 1
function battery1_cb()
    msfs_event("K:TOGGLE_MASTER_BATTERY", 1)
end
batt1_id = switch_add("sw_blue_dn.png", "sw_blue_up.png", 22, 112, 34, 78,  battery1_cb)


function new_batt1_pos(batt1)
    if batt1 then
        switch_set_position(batt1_id , 1)
    else
        switch_set_position(batt1_id , 0)
    
    end
end
msfs_variable_subscribe("ELECTRICAL MASTER BATTERY:1", "Bool", new_batt1_pos)

-- Battery 2
function battery2_cb()
    msfs_event("K:TOGGLE_MASTER_BATTERY", 2)
end
batt2_id = switch_add("sw_blue_dn.png", "sw_blue_up.png", 105,112, 34, 78,  battery2_cb)


function new_batt2_pos(batt2)
    if batt2 then
        switch_set_position(batt2_id , 1)
    else
        switch_set_position(batt2_id , 0)
    end
end
msfs_variable_subscribe("ELECTRICAL MASTER BATTERY:2", "Bool", new_batt2_pos)

-- Alt 1
function alt1_cb()
    --msfs_event("TOGGLE_MASTER_ALTERNATOR")
    msfs_event("K:TOGGLE_ALTERNATOR1")
end
alt1_id = switch_add("sw_blue_dn.png", "sw_blue_up.png", 188,112, 34, 78,  alt1_cb)

function new_alt1_pos(alt1)
    if alt1 then
        switch_set_position(alt1_id , 1)
    else
        switch_set_position(alt1_id , 0)
    
    end
end
msfs_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1", "Bool", new_alt1_pos)

-- Alt 2
function alt2_cb()
    --msfs_event("TOGGLE_MASTER_ALTERNATOR")
    msfs_event("K:TOGGLE_ALTERNATOR2")
end
alt2_id = switch_add("sw_blue_dn.png", "sw_blue_up.png", 273,112, 34, 78,  alt2_cb)

function new_alt2_pos(alt2)
    if alt2 then
        switch_set_position(alt2_id , 1)
    else
        switch_set_position(alt2_id , 0)
    
    end
end
msfs_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:2", "Bool", new_alt2_pos)

-- Avionics
function avionics_cb()
    msfs_event("K:TOGGLE_AVIONICS_MASTER")
end
avionics_id = switch_add("sw_blue_dn.png", "sw_blue_up.png", 372,112, 34, 78,  avionics_cb)

function new_avionics_pos(avionics)
    if avionics then
        switch_set_position(avionics_id , 1)
    else
        switch_set_position(avionics_id , 0) 
    end
end
msfs_variable_subscribe("AVIONICS MASTER SWITCH", "Bool", new_avionics_pos)

-- AC Master
function ac_master_cb()
    sound_play(fail_snd)
end
ac_master_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 471,112, 34, 78,  ac_master_cb)

-- AC Blower
function ac_blower_cb()
    sound_play(fail_snd)
end
ac_blower_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 561,112, 34, 78,  ac_blower_cb)

-- Vent Blower
function vent_cb()
    sound_play(fail_snd)
end
vent_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 666,112, 34, 78,  vent_cb)

-- Fuel Pump
function pump_cb()
    msfs_event("TOGGLE_ELECT_FUEL_PUMP")
end
pump_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 747,112, 34, 78,  pump_cb)

function new_pump_pos(pump)
    if pump then
        switch_set_position(pump_id , 1)
    else
        switch_set_position(pump_id , 0)
    end
end

msfs_variable_subscribe("GENERAL ENG FUEL PUMP SWITCH:1", "Bool", new_pump_pos)
 -- Annun Test
 function annun_cb()
     sound_play(fail_snd)
 end
annun_id = switch_add("anun_up.png", "anun_dn.png", 12,270, 37, 37, annun_cb)
 -- Magneto / Kkey

ign_off = img_add("key_off.png", 110, 240,120, 120)
ign_left = img_add("key_left.png", 110, 240,120, 120)
ign_right = img_add("key_right.png", 110, 240,120, 120)
ign_both = img_add("key_both.png", 110, 240,120, 120)
ign_start = img_add("key_start.png", 110, 240,120, 120)

--Set initial key to Off
visible(ign_off,false)
visible(ign_left,false)
visible(ign_right,false)
visible(ign_both,false)
visible(ign_start,false)

local ign_state = 0

function ignition_cb(ig_dir)
    if ig_dir == 1 then
        ign_state = ign_state + 1
        if ign_state == 5 then
            ign_state = 4
        end
    elseif ig_dir == -1 then
        ign_state = ign_state - 1
        if ign_state == -1 then
            ign_state= 0
        end
    end

    if ign_state == 0 then
        msfs_event("MAGNETO1_OFF")
    elseif ign_state == 1 then 
        msfs_event("MAGNETO_RIGHT")
    elseif ign_state == 2 then 
        msfs_event("MAGNETO_LEFT")
    elseif ign_state == 3 then 
        msfs_event("MAGNETO1_BOTH")
    elseif ign_state == 4 then 
        msfs_event("TOGGLE_STARTER1")
    end
end

ignition_sw = dial_add(nil,75,163,80,80,ignition_cb)

function new_ignition (ign_pos)
    visible(ign_off,false)
    visible(ign_left,false)
    visible(ign_right,false)
    visible(ign_both,false)
    visible(ign_start,false)
    
    if ign_pos[1] == 0 then
        visible(ign_off,true)
        ign_state= 0
    elseif ign_pos[1] == 2 then
        visible(ign_right,true)
        ign_state= 1
    elseif ign_pos[1] == 1 then
        visible(ign_left,true)
        ign_state= 2
    elseif ign_pos[1] == 3 then
        visible(ign_both,true)
        ign_state= 3
    elseif ign_pos[1] == 4 then
        visible(ign_start,true)
        ign_state= 4
    end
end

function updateIgnitionSwitch()
    ign_pos ={}
    if EngineStarter == true then
            ign_pos[1] = 4
        elseif EngineCombustion == false and LeftMagneto == false and RightMagneto == false then
            ign_pos[1] = 0 
        elseif LeftMagneto == true and RightMagneto == false then
            ign_pos[1] = 1
        elseif LeftMagneto == false and RightMagneto == true then
            ign_pos[1] = 2
        else ign_pos[1] = 3
    end
    new_ignition (ign_pos)
end

function new_engStarter(engStart)
    EngineStarter = engStart
        updateIgnitionSwitch()
end

function new_LeftMagneto(magneto)
    LeftMagneto = magneto
    updateIgnitionSwitch()
end

function new_RightMagneto(magneto)
    RightMagneto = magneto
    updateIgnitionSwitch()
end

function new_EngineCombustion(combustion)
    EngineCombustion = combustion
    updateIgnitionSwitch()
end

msfs_variable_subscribe("GENERAL ENG STARTER:1", "Bool",  new_engStarter)
msfs_variable_subscribe("RECIP ENG LEFT MAGNETO:1", "Bool",  new_LeftMagneto)
msfs_variable_subscribe("RECIP ENG RIGHT MAGNETO:1", "Bool",  new_RightMagneto)
msfs_variable_subscribe("GENERAL ENG COMBUSTION:1", "Bool",  new_EngineCombustion)

-- Pitot Heat
function pitot_cb()
    msfs_event("PITOT_HEAT_TOGGLE", 1)
end
 pitot_id = switch_add("sw_yellow_dn.png", "sw_yellow_up.png", 368, 255, 34, 78,  pitot_cb)
 
 function new_pitot_pos(pitot)
    if pitot == 1 then
        switch_set_position(pitot_id, 1)
    else
        switch_set_position(pitot_id, 0)
    end
end

msfs_variable_subscribe("L:DEICE_Pitot_1", "Int", new_pitot_pos)
 
 
-- Prop Deice
local deice_pos
function prop_cb()
    msfs_event("TOGGLE_PROPELLER_DEICE")
end
prop_id = switch_add("sw_yellow_dn.png", "sw_yellow_up.png", 450, 255, 34, 78,  prop_cb)

function new_prop_pos(prop)
    if prop  == 1 then
        switch_set_position(prop_id, 1)
        deice_pos = 1
    else
        switch_set_position(prop_id, 0)
        deice_pos = 0
    end
    print (prop)
end
msfs_variable_subscribe("L:DEICE_Propeller_1", "Enum", new_prop_pos)       
   
-- Strobe
function strobe_cb()
    msfs_event("STROBES_TOGGLE")
end
strobe_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 532, 255, 34, 78,  strobe_cb)
 
 function new_strobe_pos(strobe)
    if strobe then
       switch_set_position(strobe_id, 1)
    else
       switch_set_position(strobe_id, 0)
    end
end
msfs_variable_subscribe("LIGHT STROBE", "Bool", new_strobe_pos)
           
-- Beacon
function beacon_cb()
    msfs_event("TOGGLE_BEACON_LIGHTS")
end
beacon_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 615, 255, 34, 78,  beacon_cb)

function new_beacon_pos(beacon)
    if beacon then
       switch_set_position(beacon_id, 1)
    else
       switch_set_position(beacon_id, 0)
    end
end
msfs_variable_subscribe("LIGHT BEACON", "Bool",new_beacon_pos)

            
-- Nav
function nav_cb()
    msfs_event("TOGGLE_NAV_LIGHTS")
end
nav_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 699, 255, 34, 78,  nav_cb)
function new_nav_pos(nav)
    if nav then
       switch_set_position(nav_id, 1)
    else
       switch_set_position(nav_id, 0)
    end
end
msfs_variable_subscribe("LIGHT NAV", "Bool", new_nav_pos)

                    
-- Flood 
function flood_cb(pos)
    newVal = math.abs(pos -1)
    switch_set_position(flood_id, newVal)
    msfs_event("GLARESHIELD_LIGHTS_SET", newVal)
end
flood_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 72, 390, 34, 78,  flood_cb)

function new_flood_pos(flood)
    switch_set_position(flood_id, flood)
end
msfs_variable_subscribe("LIGHT GLARESHIELD", "Bool", new_flood_pos)

-- Panel
function panel_cb(pos)
    newVal = math.abs(pos -1)
    switch_set_position(panel_id, newVal)
    msfs_event("PANEL_LIGHTS_SET", newVal)
end
panel_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 150, 390, 34, 78,  panel_cb)

function new_panel_pos(panel)
    switch_set_position(panel_id, panel)
end
msfs_variable_subscribe("LIGHT PANEL", "Bool", new_panel_pos)

-- Taxi
function taxi_cb()
    msfs_event("TOGGLE_TAXI_LIGHTS")
end
taxi_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 230, 390, 34, 78,  taxi_cb)

function new_taxi_pos(taxi)
    if taxi then
       switch_set_position(taxi_id, 1)
    else
       switch_set_position(taxi_id, 0)
    end
end
msfs_variable_subscribe("LIGHT TAXI", "Bool", new_taxi_pos)

-- Landing
function ldg_cb()
    msfs_event("LANDING_LIGHTS_TOGGLE")
end
ldg_id = switch_add("sw_silver_dn.png", "sw_silver_up.png", 310, 390, 34, 78,  ldg_cb)

function new_ldg_pos(ldg)
    if ldg then
       switch_set_position(ldg_id, 1)
    else
       switch_set_position(ldg_id, 0)
    end
end
msfs_variable_subscribe("LIGHT LANDING", "Bool", new_ldg_pos)

-- Alt Air
function air_cb()
    msfs_event("TOGGLE_ALTERNATE_STATIC")
end        
air_id = switch_add("air_off.png", "air_on.png",408,440, 213, 78, air_cb)

function new_alt_air_pos(alt_on)
    if alt_on then
        switch_set_position(air_id, 1)
    else 
        switch_set_position(air_id, 0)
    end
end    
msfs_variable_subscribe("ALTERNATE STATIC SOURCE OPEN", "Bool", new_alt_air_pos)
                
-- Brake
function brake_cb()
    msfs_event("PARKING_BRAKES")
end        
brake_id = switch_add("brake_off.png", "brake_on.png", 651,440, 213, 78, brake_cb)

function new_brake_pos(brake)
    if brake then
        switch_set_position(brake_id, 1)
    else
        switch_set_position(brake_id, 0)
    end
end
msfs_variable_subscribe("BRAKE PARKING INDICATOR", "Bool", new_brake_pos)