--[[
--******************************************************************************************
-- ******************Cessna Citation CJ4 PUU Climate Control Switch*************************
--******************************************************************************************

v1.0 9-5-21 Herbert Puukka
	-Original Panel Created
v1.1 9-12-21 Rob Verdon
        -Added all 3 modes.
v1.2 9-13-21 Herbert Puukka
        -Replaced background image with better one.	
##Notes:
	Cabin Control has to be turned off during engine start
										 					  													   
--******************************************************************************************
--]]


--IMPORT ASSETS
img_add_fullscreen("climate_background.png")
climate_knob_img = img_add("climate_POS1.png", 60, 100, 120, 120)

--=============================================================================
-- CLIMATE CONTROL
--=============================================================================
--subscribe to position
function new_climate_pos(sw_on)
    if sw_on == 0 then
        switch_set_position(climate_switch, 0)
        rotate (climate_knob_img, -50)   
    elseif  sw_on == 1 then
        switch_set_position(climate_switch, 1)
	rotate (climate_knob_img, 0) 
    elseif  sw_on == 2 then
        switch_set_position(climate_switch, 2)
        rotate (climate_knob_img, 50)
    end
end 
fs2020_variable_subscribe("L:CLIMATE_CONTROL", "Int", new_climate_pos)


function climate_click_callback(position, direction)
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
climate_switch = switch_add(nil,nil,nil, 40, 90, 140, 140, climate_click_callback)
-- END CLIMATE CONTROL



