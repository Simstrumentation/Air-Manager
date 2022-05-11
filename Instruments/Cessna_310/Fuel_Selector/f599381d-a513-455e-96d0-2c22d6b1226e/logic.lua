--[[
******************************************************************************************
********************* Cessna 310R (Milviz) Fuel Selector Valves************************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
    Fuel selector valves for the Milviz C310R
    
    INSTRUCTIONS        
        Tap / click on the labels for the fuel selector positions to select
        that position
    
    V1.0 - Released 2022-05-010

    NOTE:
        Will only work with Milviz C130
        
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
    fs2020_variable_write("L:C310_SW_FUEL_SEL_LEFT", "Enum", 2)
end
left_left_btn = button_add(nil, nil, 50, 165, 100, 100, left_left_main)

-- Aux Tank
function left_aux_main()
    fs2020_variable_write("L:C310_SW_FUEL_SEL_LEFT", "Enum", 1)
end
left_aux_btn = button_add(nil, nil, 165, 65, 100, 100, left_aux_main)

-- Opposite
function left_right_main()
    fs2020_variable_write("L:C310_SW_FUEL_SEL_LEFT", "Enum", 0)
end
left_right_btn = button_add(nil, nil, 287, 165, 100, 100, left_right_main)

--Off
function left_off_main()
    fs2020_variable_write("L:C310_SW_FUEL_SEL_LEFT", "Enum", 3)
end
left_off_btn = button_add(nil, nil, 115, 290, 100, 100, left_off_main)


--RIGHT LEVER
--Main Tank
function right_left_main()
    rotate(lever_r, 90, 57, 149, 0, "LINEAR", 0.05, "DIRECT")
    fs2020_variable_write("L:C310_SW_FUEL_SEL_RIGHT", "Enum", 2)
end
right_left_btn = button_add(nil, nil, 660, 165, 100, 100, right_left_main)

-- Aux Tank
function right_aux_main()
    rotate(lever_r,  0, 57, 149, 0, "LINEAR", 0.05, "DIRECT")
    fs2020_variable_write("L:C310_SW_FUEL_SEL_RIGHT", "Enum", 1)
end
right_aux_btn = button_add(nil, nil, 528, 65, 100, 100, right_aux_main)

-- Left Tank
function right_left_main()
    rotate(lever_r, -90, 57, 149, 0, "LINEAR", 0.05, "DIRECT")
    fs2020_variable_write("L:C310_SW_FUEL_SEL_RIGHT", "Enum", 0)
end
right_right_btn = button_add(nil, nil, 420, 165, 100, 100, right_left_main)

--Off
function right_off_main()
    rotate(lever_r,  180, 57, 149, 0, "LINEAR", 0.05, "DIRECT")
    fs2020_variable_write("L:C310_SW_FUEL_SEL_RIGHT", "Enum", 3)
end
right_off_btn = button_add(nil, nil, 573, 290, 100, 100, right_off_main)

function fuel_left(pos)
    if pos == 0 then                --opposite
        rotate(lever_l,  90, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 1 then        --main
        rotate(lever_l, 0, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 2 then        --main
        rotate(lever_l,  -90, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 3 then        --off
        rotate(lever_l, -180, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    end
end

fs2020_variable_subscribe("L:C310_SW_FUEL_SEL_LEFT", "Enum", fuel_left)

function fuel_right(pos)
    if pos == 0 then                --opposite
        rotate(lever_r,  -90, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 1 then        --main
        rotate(lever_r, 0, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 2 then        --main
        rotate(lever_r,  90, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    elseif pos == 3 then        --off
        rotate(lever_r, 180, 57, 149, 0, "LINEAR", 0.028, "DIRECT")
    end
end

fs2020_variable_subscribe("L:C310_SW_FUEL_SEL_RIGHT", "Enum", fuel_right)


