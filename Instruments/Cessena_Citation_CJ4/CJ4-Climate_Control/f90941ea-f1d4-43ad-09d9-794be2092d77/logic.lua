--[[
******************************************************************************************
******************Cessna Citation CJ4 Climate Control Switch***************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0**  09-05-2021 Herbert Puukka
    - Original Panel Created
- **v1.1**  09-12-2021 Rob "FlightLevelRob" Verdon
    - Added all 3 positions.
- **v1.2**   09-19-2021 Joe "Crunchmeister" Gilke
    - Added new graphics     
- **v2.0**   09-19-2021 Joe "Crunchmeister" Gilke
    - Added new graphics       
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
	
##Left To Do:
    - 	
	
##Notes:
    - Cabin Control has to be turned off during engine start
										 					  													   
******************************************************************************************
--]]

prop_BG = user_prop_add_boolean("Display Background",true,"Show grey background")


if user_prop_get(prop_BG) == true then
    img_add_fullscreen("background.png")
    img_bg_night = img_add_fullscreen("background_night.png")
end    

img_labels = img_add_fullscreen("labels.png")
img_labels_backlight = img_add_fullscreen("labels_backlight.png")
img_climate_knob = img_add("knob.png", 62, 75, 125, 125)
img_climate_knob_night = img_add("knob_night.png", 62, 75, 125, 125)

img_climate_knob_indicator_backlight = img_add("knob_inidicator_backlight.png", 62, 75, 125, 125)


--******************************************************************************************
-- Ambient Light Control
function ss_ambient_darkness(value)
        if user_prop_get(prop_BG) == true then
            opacity(img_bg_night, value, "LOG", 0.04)    --set this panels night background 
        end
    opacity(img_climate_knob_night, value, "LOG", 0.04)
    opacity(img_labels, (1-value), "LOG", 0.04) 
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)
--Backlighting
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_climate_knob_indicator_backlight, 0.0, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_climate_knob_indicator_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
--=============================================================================
-- CLIMATE CONTROL

--subscribe to position
function ss_climate_control(sw_on)
    if sw_on == 0 then
        switch_set_position(sw_climate_control, 0)
        rotate (img_climate_knob, -55)   
        rotate (img_climate_knob_night, -55)    
        rotate (img_climate_knob_indicator_backlight, -55)         
    elseif  sw_on == 1 then
        switch_set_position(sw_climate_control, 1)
	rotate (img_climate_knob, 0) 
        rotate (img_climate_knob_night, 0)    
        rotate (img_climate_knob_indicator_backlight, 0) 
    elseif  sw_on == 2 then
        switch_set_position(sw_climate_control, 2)
        rotate (img_climate_knob, 55)
        rotate (img_climate_knob_night, 55)    
        rotate (img_climate_knob_indicator_backlight, 55) 
    end
end 
fs2020_variable_subscribe("L:CLIMATE_CONTROL", "Int", ss_climate_control)


function callback_climate_control(position, direction)
    if direction == 1 then           -- turned dial to the right  
        if position == 1 then    -- turn from pos 1 to pos 2		
		fs2020_variable_write("L:CLIMATE_CONTROL", "Int",2) 
 
	elseif position == 0 then    -- turn from pos 0 to pos 1
		fs2020_variable_write("L:CLIMATE_CONTROL", "Int",1)  
	end
    else    -- turned dial to the right  		   
        if position == 2 then
		fs2020_variable_write("L:CLIMATE_CONTROL", "Int",1)

        elseif position == 1 then
		fs2020_variable_write("L:CLIMATE_CONTROL", "Int",0)
	end
   end
end
sw_climate_control = switch_add(nil,nil,nil, 62, 75, 125, 125, callback_climate_control)
-- END CLIMATE CONTROL



