--[[
******************************************************************************************
-- ****************** DAHER KODIAK (SWS) SHOULDER HARNESS *********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Shoulder harness lock lever for the SWS Daher Kodiak

- **v1.0** (12-29-2021)
    
NOTES: 
    - Use user properties to select pilot or copilot side
    
KNOWN ISSUES:
- None

]]--

-- define user selectable properties
harness_position = user_prop_add_enum("Harness Position","Pilot, Co-Pilot","Pilot","Select which harness position")                  -- Select position. Pilot is default

if user_prop_get(harness_position) == "Pilot" then
    unit_mode = 1
else
    unit_mode = 2
end

--local variables
local harness_pos
local user_pos

if user_prop_get(harness_position) == "Pilot" then
    user_pos = 1
else
    user_pos = 2
end

function lock_cb()
    if harness_pos == 1 then
        msfs_variable_write("L:Lever_Harness_" .. user_pos, "Number", 0)
    else
        msfs_variable_write("L:Lever_Harness_" .. user_pos, "Number", 1)
    end
end
harness_id = switch_add("unlock.png", "lock.png", 0,0, 308, 420, lock_cb)

function new_harness_pos(harness)
    --print (harness)
    if harness == 1 then
        switch_set_position(harness_id, 1)
    else
        switch_set_position(harness_id, 0)
    end
    harness_pos = harness
end

if user_prop_get(harness_position) == "Pilot" then
    msfs_variable_subscribe("L:Lever_Harness_1", "Number", new_harness_pos)
else
    msfs_variable_subscribe("L:Lever_Harness_2", "Number", new_harness_pos)
end


