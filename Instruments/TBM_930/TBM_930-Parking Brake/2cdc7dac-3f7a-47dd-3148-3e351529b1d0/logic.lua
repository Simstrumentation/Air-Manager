--****************************************************************
--TBM 930 Parking Brake
-- by Joe "Crunchmeister" Gilker
--****************************************************************

-- add graphics
img_blank = img_add("Panel.png",0,0,512,512)
brake_knob  = img_add("knob.png",0,104,382, 382)

--callback function
function brake_button_cb()
    fs2020_event("PARKING_BRAKES")
    fsx_event("PARKING_BRAKES")
end

--declare button hotspot
brake_button  =  button_add(nil, nil, 0,0,512,512, brake_button_cb)

-- operate brake 
function new_switch_pos(sw_on)
    if sw_on then
        rotate(brake_knob, 90, 192,178, nil, "LINEAR",0.5, CW) 
    else
        rotate(brake_knob, 0, 164,130, nil, "LINEAR",0.5, CCW) 
    end
end

-- variable subscribe
fs2020_variable_subscribe("BRAKE PARKING INDICATOR", "Bool", new_switch_pos)
