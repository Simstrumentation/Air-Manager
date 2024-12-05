--[[
--******************************************************************************************
-- ************************ DAHER KODIAK (SWS) FUEL VALVES **************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Left and right fuel valves for the Daher Kodiak
    
    NOTE:
    toggle the switches by touching / clicking on the black detent nubs 
    
    V1.0 - Released 2022-12-23
    
    KNOWN ISSUES:
        - None

   --******************************************************************************************
--]]

--add graphics
img_add_fullscreen("bg.png")
lever_left_id = img_add("lever_left.png", 264, 74, 75, 263)
lever_right_id = img_add("lever_right.png", 395, 74, 75, 263)

--global variables
local left_pos
local right_pos

--LEFT TANK TOGGLE
function left_tank_toggle()
     if left_pos == 0 then
        msfs_variable_write("L:SWS_Kodiak_TankSelector_1", "Number", 1)
    else
        msfs_variable_write("L:SWS_Kodiak_TankSelector_1", "Number", 0)
    end
end

btn_left_on_id = button_add(nil, nil, 65, 240, 80, 80, left_tank_toggle)
btn_left_off_id = button_add(nil, nil, 270, 90, 80, 80, left_tank_toggle)

--RIGHT TANK TOGGLE
function right_tank_toggle()
     if right_pos == 0 then
        msfs_variable_write("L:SWS_Kodiak_TankSelector_2", "Number", 1)
    else
        msfs_variable_write("L:SWS_Kodiak_TankSelector_2", "Number", 0)
    end
end
btn_right_on_id = button_add(nil, nil, 580, 240, 80, 80, right_tank_toggle)
btn_right_off_id = button_add(nil, nil, 400, 90, 80, 80, right_tank_toggle)


function new_left_pos(new_left_pos)
    left_pos = new_left_pos
    if left_pos == 0 then   
        rotate(lever_left_id, 0, 40, 230, 0, "LOG", 0.02, "CW")
    else
        rotate(lever_left_id, -100, 40, 230, 0, "LOG", 0.02, "CCW")
    end
end

msfs_variable_subscribe("L:SWS_Kodiak_TankSelector_1", "Number", new_left_pos)

function new_right_pos(new_right_pos)
    right_pos = new_right_pos
    if right_pos == 0 then
        rotate(lever_right_id, 0, 40, 230, 0, "LOG", 0.04, "CCW")
    else
        rotate(lever_right_id,  100, 40, 230, 0, "LOG", 0.02, "CW")
    end
end

msfs_variable_subscribe("L:SWS_Kodiak_TankSelector_2", "Number", new_right_pos)
