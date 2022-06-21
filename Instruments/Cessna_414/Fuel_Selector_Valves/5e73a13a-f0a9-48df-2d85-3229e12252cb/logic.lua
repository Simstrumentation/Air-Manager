--[[
******************************************************************************************
******************* Cessna 414 (FlySimWare) Fuel Selector Valves**********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
    Fuel selector valves for the FlySimWare C414 Chancellor
    
    INSTRUCTIONS        
        Tap / click on the labels for the fuel selector positions to select
        that position
    
    V1.0 - Released 2022-06-21

    NOTE:
        Will only work with FlySimWare C414 Chancellor
        
    KNOWN ISSUES:
    - None
   --******************************************************************************************
--]]
img_add_fullscreen("bg.png")

lever_l = img_add("lever.png", 138, 58, 111, 288)
lever_r = img_add("lever.png", 510, 58, 111, 288)

--TOUCH ZONES

--LEFT LEVER
--Main Tank
function left_left_main()
    fs2020_variable_write("L:FUEL_Lever_Selector_1", "Enum", 1)
end
left_left_btn = button_add(nil, nil, 15, 38, 180, 180, left_left_main)

-- Right Tank
function left_right_main()
    fs2020_variable_write("L:FUEL_Lever_Selector_1", "Enum", 2)
end
left_right_btn = button_add(nil, nil, 215, 38, 180, 180, left_right_main)

--Off
function left_off_main()
    fs2020_variable_write("L:FUEL_Lever_Selector_1", "Enum", 0)
end
left_off_btn = button_add(nil, nil, 126, 282, 125, 125, left_off_main)


--RIGHT LEVER
--Main Tank
function right_left_main()
    fs2020_variable_write("L:FUEL_Lever_Selector_2", "Enum", 1)
end
right_left_btn = button_add(nil, nil, 566, 38, 180, 180, right_left_main)

-- Left Tank
function right_left_main()
    fs2020_variable_write("L:FUEL_Lever_Selector_2", "Enum",0)
end
right_right_btn = button_add(nil, nil, 387, 38, 180, 180, right_left_main)

--Off
function right_off_main()
    fs2020_variable_write("L:FUEL_Lever_Selector_2", "Enum", 2)
end
right_off_btn = button_add(nil, nil, 487, 282, 125, 125, right_off_main)

function fuel_left(pos)
    if pos == 0 then                --opposite
        rotate(lever_l,  -180, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 1 then        --aux
        rotate(lever_l, -45, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 2 then        --main
        rotate(lever_l,  45, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    end
end

fs2020_variable_subscribe("L:FUEL_Lever_Selector_1", "Enum", fuel_left)

function fuel_right(pos)
    if pos == 2 then                --opposite
        rotate(lever_r,  180, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 1 then        --Aux
        rotate(lever_r, 45, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos ==0 then        --main
        rotate(lever_r,  -45, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    end
end

fs2020_variable_subscribe("L:FUEL_Lever_Selector_2", "Enum", fuel_right)


