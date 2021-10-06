--[[
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
]]--
--PARKING BRAKE

bg=img_add_fullscreen("bg.png")
bg_night = img_add_fullscreen("bg_night.png")
labels_backlight = img_add_fullscreen("labels_backlight.png")
opacity(labels_backlight, 0)
--Ambient lighting
--=======Night Lighting=============================================

function pos_ambient_darkness(value)
    opacity(bg_night, value, "LOG", 0.04)

    opacity(park_brake_sw_night, value, "LOG", 0.04)
     
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", pos_ambient_darkness)

--dimming

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
		opacity(labels_backlight, 0, "LOG", 0.04)
    else
        opacity(labels_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  

function new_park_brake(position)
    fs2020_event("PARKING_BRAKES")
end

park_brake_sw = switch_add("off.png", "on.png" , 0, 0, 200, 350, new_park_brake)
park_brake_sw_night = switch_add("off_night.png", "on_night.png" , 0, 0, 200, 350, new_park_brake)

function park_brake_switch(position)
    sw_on = fif(  position > 0  , 1, 0 )
    switch_set_position(park_brake_sw, position)
     switch_set_position(park_brake_sw_night, position)
end    

fs2020_variable_subscribe("BRAKE PARKING POSITION", "Position", park_brake_switch )

--end PARKING BRAKE