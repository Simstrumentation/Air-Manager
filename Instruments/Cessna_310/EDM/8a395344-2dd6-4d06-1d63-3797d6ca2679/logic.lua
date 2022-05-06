--[[
--******************************************************************************************
-- ********** Cessna 310R (Milviz) Engine Data Management Overlay********************
--******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
    Engine Data Management for Cessna 130R
    
    NOTE:
        - Must be used in conjunction with popout EDM instrument from within the sim
        - Select user properties to select LEFT or RIGHT engine
        - Will only work with Milviz C130R
    
    V1.0 - Released 2022-05-06

    KNOWN ISSUES:
    - None
   --******************************************************************************************
--]]

--***********************************************USER PROPERTY CONFIG***********************************************
-- define user selectable properties
mode = user_prop_add_enum("Engine","Left, Right","Left","Select the engine for this overlay") 


--  unit mode
if user_prop_get(mode) == "Left" then
    unit_mode = "L"
else
    unit_mode = "R"
end 

img_add_fullscreen("bg.png")

--Left button
function btn_l_press_cb()
    fs2020_variable_write("L:C310_SW_EDM" .. unit_mode .. "_L", "Number", 1)
end

function btn_l_release_cb()
   fs2020_variable_write("L:C310_SW_EDM" .. unit_mode .. "_L", "Number", 0)
end
btn_l = button_add(nil, nil, 68, 450, 64, 64, btn_l_press_cb, btn_l_release_cb)

--right button
function btn_r_press_cb()
    fs2020_variable_write("L:C310_SW_EDM" .. unit_mode .. "_R", "Number", 1)
end
   
function btn_l_release_cb()
     fs2020_variable_write("L:C310_SW_EDM" .. unit_mode .. "_R", "Number", 0)
end
btn_r = button_add(nil, nil, 386, 450, 64, 64, btn_r_press_cb, btn_l_release_cb)