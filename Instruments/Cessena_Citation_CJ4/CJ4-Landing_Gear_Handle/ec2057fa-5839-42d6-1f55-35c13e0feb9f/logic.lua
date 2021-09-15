--******************************************************************************************
-- ******************Cessna Citation CJ4 Landing Gear Handle****************************
-- ******************         modified by Simstrumentation        ****************************
--******************************************************************************************
-- Reskinning of an existing Air Manager generic gear handle to match the look and 
-- feel of the Cessna Citation CJ4
-- Original logic left mostly intact
-- High res graphics and reconfiguration of the code by Joe "Crunchmeister" Gilker
--******************************************************************************************
--[[
CHANGE LOG

V1.0
- original release using in-game screenshots for graphics

V1.1
- new custom hand-built graphics added


]]--

-- Buttons, switches and dials functions --
function gear_switch(state, direction)
      fs2020_event( fif(state == 0, "GEAR_DOWN", "GEAR_UP") )
end

-- Add images
img_add_fullscreen("gearback.png")
img_unlock = img_add("unlock.png",347,246,165,181, "visible:false")
img_LH = img_add("LH.png",309,390,36,36, "visible:false")
img_NO = img_add("NO.png",411,198,36,36, "visible:false")
img_RH = img_add("RH.png",514,390,36,36, "visible:false")
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
switch_handle = switch_add("handleup.png", "handledown.png", 122, 288, 123, 421, gear_switch)

-- Bus subscription --
xpl_dataref_subscribe("sim/aircraft/parts/acf_gear_deploy", "FLOAT[10]",
                      "sim/cockpit2/controls/gear_handle_down", "INT",
                      "sim/cockpit2/electrical/bus_volts", "FLOAT[6]", new_gear_deploy)
fsx_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                       "GEAR LEFT POSITION", "Percent", 
                       "GEAR RIGHT POSITION", "Percent", 
                       "GEAR HANDLE POSITION", "Bool", 
                       "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_gear_deploy_FSX)
fs2020_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                          "GEAR LEFT POSITION", "Percent", 
                          "GEAR RIGHT POSITION", "Percent", 
                          "GEAR HANDLE POSITION", "Bool", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", new_gear_deploy_FSX)					   