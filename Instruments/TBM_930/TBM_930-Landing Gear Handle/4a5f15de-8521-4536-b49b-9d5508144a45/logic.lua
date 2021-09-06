--******************************************************************************************
-- *********************DAHER TBM 930 Landing Gear Handle****************************
--******************************************************************************************
-- Landing gear handle with working indicators for TBM 930 
-- Check lights and switches not functional in V1
--******************************************************************************************

function gear_switch(state, direction)  
    fs2020_event( fif(state == 0, "GEAR_DOWN", "GEAR_UP") )
end

-- Add images
img_add_fullscreen("bg.png")
img_unlock = img_add("transition_on.png",0,376,457,129, "visible:true")
img_LH = img_add("left.png",144,230,129,129, "visible:false")
img_NO = img_add("nose.png", 236,98,129,129, "visible:false")
img_RH = img_add("right.png",324,230,129,129, "visible:false")

-- Functions --
function new_gear_deploy(deployratio, handle, bus_volts)
    
    local power = bus_volts[1] >= 5
    
    -- Check if one of the wheels is in transition, 0 is all up, 3 is all down
    gear_total = deployratio[1] + deployratio[2] + deployratio[3]
    visible(img_LH, deployratio[1] == 1 and power)
    visible(img_NO, deployratio[2] == 1 and power)
    visible(img_RH, deployratio[3] == 1 and power)
    
    switch_set_position(switch_handle, handle)
    
    if gear_total > 0 and gear_total < 3 and power then
        if not timer_running(warning_flash) then
            warning_flash = timer_start(500, 800, function(count)
                visible(img_unlock, count%2 == 0)
            end)
        end
    else
        timer_stop(warning_flash)
        visible(img_unlock, false)
    end

end

function new_gear_deploy_FSX(center, left, right, handle, bus_volts)

    center = center / 100
    left = left / 100
    right = right / 100
    
    if handle then
        handle = 1
    else
        handle = 0
    end
    
    new_gear_deploy({left, center, right}, handle, {bus_volts})

end

-- Buttons, switches and dials --
switch_handle = switch_add("handle_up.png", "handle_dn.png", 480, 0, 287, 998, gear_switch)

-- Bus subscription --

fs2020_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                          "GEAR LEFT POSITION", "Percent", 
                          "GEAR RIGHT POSITION", "Percent", 
                          "GEAR HANDLE POSITION", "Bool", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_gear_deploy_FSX)		