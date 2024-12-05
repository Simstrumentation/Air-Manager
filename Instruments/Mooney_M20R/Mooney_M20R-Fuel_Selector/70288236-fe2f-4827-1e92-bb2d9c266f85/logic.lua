--add graphics
img_add_fullscreen("FuelSelectPanel.png")
img_knob = img_add("FuelSelectKnob.png", 38, 45, 305, 305)

-- set functions to switch tanks
function callback_left()
    msfs_event("FUEL_SELECTOR_LEFT")
end    

function callback_right()
    msfs_event("FUEL_SELECTOR_RIGHT")
end

function callback_off()
    msfs_event("FUEL_SELECTOR_OFF")
end
-- set touch zones for switch activation
button_off = button_add(nil,nil,60,280,150,150,callback_off)
button_left = button_add(nil,nil,60,30,150,150,callback_left)
button_right = button_add(nil,nil,260,30,150,150,callback_right)

function new_pos_select(tank)
    if (tank == 2) then -- left tank
        rotate(img_knob, 103)
    elseif (tank == 3) then -- right tank
        rotate(img_knob, 185)
    elseif (tank == 0) then -- fuel off
        rotate(img_knob, -5)
    end
end

msfs_variable_subscribe("RECIP ENG FUEL TANK SELECTOR:1", "enum", new_pos_select)