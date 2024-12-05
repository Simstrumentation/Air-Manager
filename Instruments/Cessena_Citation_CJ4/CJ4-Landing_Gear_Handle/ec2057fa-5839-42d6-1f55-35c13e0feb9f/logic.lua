--[[
******************************************************************************************
******************Cessna Citation CJ4 Landing Gear Handle****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  08-2021  Joe "Crunchmeister" Gilker
    - Original panel created
- **v2.0**  09-15-2021  Joe "Crunchmeister" Gilker
    - New graphics
    - Added night mode
    - Added backlight dimming
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-05-2021 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-16-2022 SIMSTRUMENTATION
    - Added notes in INFO for contact info for SI Store Submission
- **v2.2** 12-06-2022 Joe "Crunchmeister" Gilker       
    - Updated code to reflect AAU1 being released in 2023Q1   
   
## Left To Do:
  - N/A
	
## Notes:
  - N/A

******************************************************************************************
]]--

img_add_fullscreen("gearback.png")
img_gear_handle_support = img_add("handlesupport.png", 122, 288, 123, 421)
img_bg_night = img_add_fullscreen("gearback_night.png")

img_backlight = img_add_fullscreen("backlight.png")
img_unlock = img_add("unlock.png",347,246,165,181, "visible:false")
img_LH = img_add("LH.png",309,390,36,36, "visible:false")
img_NO = img_add("NO.png",411,198,36,36, "visible:false")
img_RH = img_add("RH.png",514,390,36,36, "visible:false")

img_gear_handle = img_add("handleup.png", 115, 288, 123, 421)
img_gear_handle_night = img_add("handleup_night.png", 115, 288, 123, 421)


--Backlighting
function ss_backlighting(value, panellight, power, extpower, busvolts)
    value = var_round(value,2)      
    if  panellight == false  or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
msfs_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                           "LIGHT PANEL","Bool",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  

function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
    opacity(img_gear_handle_night, value, "LOG", 0.04) 
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

------------------------------------------------------------------
--Landing Gear

function new_gear_deploy(deployratio, handle, bus_volts)
    local power = bus_volts[1] >= 5
    gear_total = deployratio[1] + deployratio[2] + deployratio[3]
    visible(img_LH, deployratio[1] == 1 and power)
    visible(img_NO, deployratio[2] == 1 and power)
    visible(img_RH, deployratio[3] == 1 and power)
    
    switch_set_position(sw_gear_handle, handle)
    switch_set_position(sw_gear_handle_night, handle)
    
    
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

function  ss_landing_gear(center, left, right, handle, bus_volts)
    center = center / 100
    left = left / 100
    right = right / 100
    if handle then
        handle = 1
        move (img_gear_handle, 115, 530, 123, 421, "LOG", 0.1)
        move (img_gear_handle_night, 115, 530, 123, 421, "LOG", 0.1)
        opacity(img_gear_handle_support, 1, "LOG", 0.07)
    else
        handle = 0
        opacity(img_gear_handle_support, 0, "LOG", 0.9)
        move (img_gear_handle, 115, 288, 123, 421, "LOG", 0.1)
        move (img_gear_handle_night, 115, 288, 123, 421, "LOG", 0.1)        
    end
    new_gear_deploy({left, center, right}, handle, {bus_volts})
end
msfs_variable_subscribe("GEAR CENTER POSITION", "Percent", 
                          "GEAR LEFT POSITION", "Percent", 
                          "GEAR RIGHT POSITION", "Percent", 
                          "GEAR HANDLE POSITION", "Bool", 
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_landing_gear)

function callback_gear_switch(state, direction)
      msfs_event( fif(state == 0, "GEAR_DOWN", "GEAR_UP") )
end
sw_gear_handle = switch_add(nil, nil, 122, 288, 123, 421, callback_gear_switch)
sw_gear_handle_night = switch_add(nil, nil, 122, 288, 123, 421, callback_gear_switch)                          