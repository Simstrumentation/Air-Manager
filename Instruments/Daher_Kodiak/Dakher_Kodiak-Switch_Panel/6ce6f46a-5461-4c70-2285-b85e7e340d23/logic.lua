--[[
--******************************************************************************************
-- **********************DAHER KODIAK (SWS) SWITCH PANEL**************************
--******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    Main electrical switch panel for the Daher Kodiak by SimWorks Studios. 
    
    NOTE:
    3-position switches (fuel pump and starter) are activated by touching on the labels
    above and below the switches and not on the switch itself. 

    V1.01 - Released 2022-02-06
        - fixed minor sizing bug in touch areas fuel pump and starter switches (Thanks to 
           Tony / Sling380 for finding and fixing the issue)
       
    V1.0 - Released 2021-12-22
    
    KNOWN ISSUES:
        - ignition switch does not toggle the switch in the virtual cockpit, but is functional
        - aux fuel pump switch is not cosmetically accurate. Will be fixed in a future version
   --******************************************************************************************
--]]

--add backgrond image
img_add_fullscreen("bg.png")

--LOCAL VARIABLES
local current_pos_pump
local current_pos_starter

--MASTER SWITCH

function master_click_callback(position)
    if position == 0 then
        switch_set_position(master_switch_id, 1)
        msfs_event("TOGGLE_MASTER_BATTERY")
    else
        switch_set_position(master_switch_id, 0)
        msfs_event("TOGGLE_MASTER_BATTERY")
    end
end

master_switch_id = switch_add("master_off.png", "master_on.png", 184, 160, 136, 205, master_click_callback)

function new_master_pos(master)
    if master then
        switch_set_position(master_switch_id, 1)
    else 
        switch_set_position(master_switch_id, 0)
    end
end    
msfs_variable_subscribe("ELECTRICAL MASTER BATTERY", "Bool", new_master_pos)

--AVIONICS SWITCH

function avionics_click_callback(position)
    if position == 0 then
        switch_set_position(avionics_switch_id, 1)
        msfs_event("TOGGLE_AVIONICS_MASTER")
    else
        switch_set_position(avionics_switch_id, 0)
        msfs_event("TOGGLE_AVIONICS_MASTER")
    end
end

avionics_switch_id = switch_add("rocker_off.png", "rocker_on.png",367, 172, 106, 183, avionics_click_callback)

function new_avionics_pos(avionics)
    if avionics then
        switch_set_position(avionics_switch_id, 1)
    else 
        switch_set_position(avionics_switch_id, 0)
    end
end    
msfs_variable_subscribe("AVIONICS MASTER SWITCH", "Bool", new_avionics_pos)

--AUX SWITCH

function avionics_click_callback(position)
    if position == 0 then
        switch_set_position(aux_switch_id, 1)
        msfs_variable_write("L:XMLVAR_AUX_Bus_ON", "number", 1)
    else
        switch_set_position(aux_switch_id, 0)
        msfs_variable_write("L:XMLVAR_AUX_Bus_ON", "number", 0)
    end
end

aux_switch_id = switch_add("rocker_off.png", "rocker_on.png",506, 172, 106, 183, avionics_click_callback)

function new_aux_pos(aux)
    if aux==1 then
        switch_set_position(aux_switch_id, 1)
    else 
        switch_set_position(aux_switch_id, 0)
    end
end    
msfs_variable_subscribe("L:XMLVAR_AUX_Bus_ON", "Number", new_aux_pos)

--FUEL PUMP SWITCH

--[[
SWITCH POSITIONS:
    0 - OFF
    1 - STDBY
    2 - ON
]]--

pump_stdby_id = img_add("paddle_mid.png", 688, 75, 83, 167)
pump_off_id = img_add("paddle_down.png", 688, 75, 83, 167)
visible(pump_off_id, false)
pump_on_id = img_add("paddle_up.png", 688, 75, 83, 167)
visible(pump_on_id, false)

function cb_pump_pos_inc()
    if current_pos_pump == 0  then
        msfs_variable_write("L:SWS_FUEL_Switch_Pump_1", "Enum", 1)
    end
    if current_pos_pump == 1  then
        msfs_variable_write("L:SWS_FUEL_Switch_Pump_1", "Enum", 2)
    end   
end

function cb_pump_pos_dec()
        if current_pos_pump == 2  then
        msfs_variable_write("L:SWS_FUEL_Switch_Pump_1", "Enum", 1)
    end
    if current_pos_pump == 1  then
        msfs_variable_write("L:SWS_FUEL_Switch_Pump_1", "Enum",0)
    end   
end
btn_pump_up = button_add(nil, nil, 688, 50, 100, 100, cb_pump_pos_inc)
btn_pump_dn = button_add(nil, nil, 688, 166, 100, 100, cb_pump_pos_dec)

function new_pump_pos(pos)
    if pos==0 then
        --  switch_set_position(start_switch_id, 0)
        visible(pump_off_id , true)
        visible(pump_on_id , false)
    elseif pos == 1 then 
        -- switch_set_position(start_switch_id, 1)
        visible(pump_off_id , false)
        visible(pump_on_id , false)
        elseif pos == 2 then 
        --  switch_set_position(start_switch_id, 2)
        visible(pump_off_id , false)
        visible(pump_on_id , true)
    end
current_pos_pump = pos
end

msfs_variable_subscribe("L:SWS_FUEL_Switch_Pump_1", "Enum", new_pump_pos)

--IGNITION SWITCH

function ignition_click_callback(position)
    if position == 0 then
        switch_set_position(ignition_switch_id, 1)
        msfs_variable_write("L:XMLVAR_Ignition", "Number", 1)
    else
        switch_set_position(ignition_switch_id, 0)
        msfs_variable_write("L:XMLVAR_Ignition", "Number", 0)
    end
end

ignition_switch_id = switch_add("toggle_down.png", "toggle_up.png",843, 75, 83, 167, ignition_click_callback)

function new_ignition_pos(ignition)
    if ignition==1 then
        switch_set_position(ignition_switch_id, 1)
    else 
        switch_set_position(ignition_switch_id, 0)
    end
    print(ignition)
end    
msfs_variable_subscribe("L:XMLVAR_Ignition", "Number", new_ignition_pos)

--STARTER SWITCH

--[[
SWITCH POSITIONS:
    0 - LO/MOTOR
    1 - OFF
    2 - HI
]]--

starter_off_id = img_add("toggle_mid.png", 999, 75, 83, 167)
starter_lo_id = img_add("toggle_down.png", 999, 75, 83, 167)
visible(starter_lo_id, false)
starter_hi_id = img_add("toggle_up.png", 999, 75, 83, 167)
visible(starter_hi_id, false)

function cb_starter_pos_inc()
    if current_pos_starter == 0  then
        msfs_variable_write("L:SWS_ENGINE_Switch_Starter_ThreeState_1", "Enum", 1)
    end
    if current_pos_starter == 1  then
        msfs_variable_write("L:SWS_ENGINE_Switch_Starter_ThreeState_1", "Enum", 2)
    end
end

function cb_starter_pos_dec()
     if current_pos_starter == 2  then
        msfs_variable_write("L:SWS_ENGINE_Switch_Starter_ThreeState_1", "Enum", 1)
    end
    if current_pos_starter == 1  then
        msfs_variable_write("L:SWS_ENGINE_Switch_Starter_ThreeState_1", "Enum",0)
    end
end

btn_starter_up = button_add(nil, nil, 999, 50, 100, 100, cb_starter_pos_inc)
btn_starter_dn = button_add(nil, nil, 999, 166, 100, 100, cb_starter_pos_dec)

function new_start_pos(pos)
    if pos==0 then
      --  switch_set_position(start_switch_id, 0)
      visible(starter_lo_id , true)
      visible(starter_hi_id , false)
    elseif pos == 1 then 
       -- switch_set_position(start_switch_id, 1)
      visible(starter_lo_id , false)
      visible(starter_hi_id , false)
     elseif pos == 2 then 
      --  switch_set_position(start_switch_id, 2)
      visible(starter_lo_id , false)
      visible(starter_hi_id , true)
    end
    --print(pos)
    current_pos_starter = pos
end

msfs_variable_subscribe("L:SWS_ENGINE_Switch_Starter_ThreeState_1", "Enum", new_start_pos)

--GENERATOR SWITCH

function gen_click_callback(position)
    if position == 0 then
        switch_set_position(gen_switch_id, 1)
        msfs_event("TOGGLE_ALTERNATOR1")
    else
        switch_set_position(gen_switch_id, 0)
       msfs_event("TOGGLE_ALTERNATOR1")
    end
end

gen_switch_id = switch_add("toggle_down.png", "toggle_up.png",843, 356, 83, 167, gen_click_callback)

function new_gen_pos(gen)
    if gen == 1  then
        switch_set_position(gen_switch_id, 1)
    else 
        switch_set_position(gen_switch_id, 0)
    end
end    
msfs_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:1", "Number", new_gen_pos)

--ALTERNATOR SWITCH

function gen_click_callback(position)
    if position == 0 then
        switch_set_position(alt_switch_id, 1)
        msfs_event("TOGGLE_ALTERNATOR2")
    else
        switch_set_position(alt_switch_id, 0)
       msfs_event("TOGGLE_ALTERNATOR2")
    end
end

alt_switch_id = switch_add("toggle_down.png", "toggle_up.png",999, 356, 83, 167, gen_click_callback)

function new_alt_pos(alt)
    if alt == 1  then
        switch_set_position(alt_switch_id, 1)
    else 
        switch_set_position(alt_switch_id, 0)
    end
end    
msfs_variable_subscribe("GENERAL ENG MASTER ALTERNATOR:2", "Number", new_alt_pos)