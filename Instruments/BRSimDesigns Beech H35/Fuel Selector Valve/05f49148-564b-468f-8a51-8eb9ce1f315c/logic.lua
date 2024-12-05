--[[
--******************************************************************************************
-- *************************** Beech H35 Fuel Selector Lever *****************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

   
    Fuel selector lever for the BRSimDesigns Beec H35 V-Tail. May work with other BRSimDesigns planes
    like the Debonair, but I don't own them so can't test. Wont work with other MSFS default planes or 
    other 3rd party planes that were tested.
    
    NOTE:
    Cycle fuel lever by touching / clicking  the OFF / LEFT MAIN / RIGHT MAIN labels on the background
    
    V1.0 - Released 2022-12-28
    
    KNOWN ISSUES:
        - None

   --******************************************************************************************
--]]
--add graphics
img_add_fullscreen("FuelSelectPanel.png")
img_knob = img_add("FuelSelectKnob.png", 278, 140, 246, 393)

-- set functions to switch tanks
function callback_left()
    msfs_event("FUEL_SELECTOR_LEFT_MAIN")
end    

function callback_right()
    msfs_event("FUEL_SELECTOR_RIGHT_MAIN")
end

function callback_off()
    msfs_event("FUEL_SELECTOR_OFF")
end
-- set touch zones for switch activation
button_off = button_add(nil,nil,220,520,150,150,callback_off)
button_left = button_add(nil,nil,115,175,150,150,callback_left)
button_right = button_add(nil,nil, 385, 92, 150,150,callback_right)

function new_pos_select(tank)
    if (tank == 19) then -- left tank
        rotate(img_knob, 90, 104, 207, 0, "LINEAR", 0.05, cw)
    elseif (tank == 20) then -- right tank
        rotate(img_knob, 165, 104, 207,  0,"LINEAR", 0.05, cw)
    elseif (tank == 0) then -- fuel off
        rotate(img_knob, 10, 104, 207,  0, "LINEAR", 0.05, cw)
    end
        print (tank)
end

msfs_variable_subscribe("A:FUEL TANK SELECTOR:1", "enum", new_pos_select)
