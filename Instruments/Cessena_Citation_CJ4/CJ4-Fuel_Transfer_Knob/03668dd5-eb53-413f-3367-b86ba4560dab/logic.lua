--[[
******************************************************************************************
******************Cessna Citation CJ4 Fuel Transfer Knob***************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  02-11-2023 Simstrumentation
    - Original Panel Created

		
## Left To Do:
- N/A

## Notes:
- N/A
										 					  													   
******************************************************************************************
--]]

prop_BG = user_prop_add_boolean("Display Background",true,"Show grey background")


if user_prop_get(prop_BG) == true then
    img_add_fullscreen("background.png")
    img_bg_night = img_add_fullscreen("background_night.png")
end    

img_labels = img_add_fullscreen("labels.png")
img_labels_backlight = img_add_fullscreen("labels_backlight.png")
img_fuel_knob = img_add("knob.png", 62, 98, 125, 125)
img_fuel_knob_night = img_add("knob_night.png", 62, 98, 125, 125)

img_fuel_knob_indicator_backlight = img_add("knob_inidicator_backlight.png", 62, 98, 125, 125)


--******************************************************************************************
-- Ambient Light Control
function ss_ambient_darkness(value)
        if user_prop_get(prop_BG) == true then
            opacity(img_bg_night, value, "LOG", 0.04)    --set this panels night background 
        end
    opacity(img_fuel_knob_night, value, "LOG", 0.04)
    opacity(img_labels, (1-value), "LOG", 0.04) 
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
--Backlighting
function ss_backlighting(value, panellight, power, extpower, busvolts)
    value = var_round(value,2)
    if  panellight == false  or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_fuel_knob_indicator_backlight, 0.0, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_fuel_knob_indicator_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "LIGHT PANEL","Bool",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
--=============================================================================

--subscribe to position
function ss_fuel_transfer(Lside,Rside)
    if (Lside == false and Rside == false) then
        switch_set_position(sw_fuel_control, 1)
        rotate (img_fuel_knob, 0, "LOG", 0.1)   
        rotate (img_fuel_knob_night, 0, "LOG", 0.1)    
        rotate (img_fuel_knob_indicator_backlight, 0, "LOG", 0.1)
    elseif (Lside == true and Rside == false)  then
        switch_set_position(sw_fuel_control, 2)
	rotate (img_fuel_knob, 90, "LOG", 0.1)
        rotate (img_fuel_knob_night, 90, "LOG", 0.1)
        rotate (img_fuel_knob_indicator_backlight, 90, "LOG", 0.1)
    elseif (Lside == false and Rside == true)  then
        switch_set_position(sw_fuel_control, 0)
        rotate (img_fuel_knob, -90, "LOG", 0.1)
        rotate (img_fuel_knob_night, -90, "LOG", 0.1)
        rotate (img_fuel_knob_indicator_backlight, -90, "LOG", 0.1)
    end
end 
fs2020_variable_subscribe("CIRCUIT SWITCH ON:45", "Bool", 
                                              "CIRCUIT SWITCH ON:46", "Bool", ss_fuel_transfer)

function callback_fuel_control(position, direction)
    if direction == 1 then           -- turned dial to the right  
        if position == 1 then    -- turn from pos 1 to pos 2		
		fs2020_event("FUEL_TRANSFER_CUSTOM_INDEX_TOGGLE",1) 
	elseif position == 0 then    -- turn from pos 0 to pos 1
		fs2020_event("FUEL_TRANSFER_CUSTOM_INDEX_TOGGLE",1)
	end
    else    -- turned dial to the left  		   
        if position == 2 then
		fs2020_event("FUEL_TRANSFER_CUSTOM_INDEX_TOGGLE",2)
        elseif position == 1 then
		fs2020_event("FUEL_TRANSFER_CUSTOM_INDEX_TOGGLE",2)
	end
   end
end
sw_fuel_control = switch_add(nil,nil,nil, 62, 98, 125, 125, callback_fuel_control)
 
 
 
 
 