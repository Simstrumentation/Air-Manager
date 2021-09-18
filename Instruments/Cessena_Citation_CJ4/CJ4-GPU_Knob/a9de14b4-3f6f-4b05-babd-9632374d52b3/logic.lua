--[[
--******************************************************************************************
-- ******************Cessna Citation CJ4 GPU- Ground Power Unit Knob************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 9-18-21 Rob "FlightLevelRob" Verdon
    - Original Panel Created

##Left To Do:
    - Panel Dimming
    - Panel Backlighting

##Notes:
    - This knob is compatiable with all aircraft that support GPU/External Power. 
										 					  													   
--******************************************************************************************
--]]


--===========IMPORT ASSETS==============================
img_add_fullscreen("background.png")
img_GPU_knob = img_add("knob.png", 60, 100, 120, 120)

--=============================================================================
-- Ground Power Unit Knob
--=============================================================================
--subscribe to position
function pos_GPU(sw_on)
    if sw_on == 0 then
        switch_set_position(sw_GPU, 0)
        rotate (img_GPU_knob, -50)   
    elseif  sw_on == 1 then
        switch_set_position(sw_GPU, 1)
	rotate (img_GPU_knob, 50) 
    end
end 
fs2020_variable_subscribe("EXTERNAL POWER ON", "Number", pos_GPU)

--toggle gpu power on/off
function callback_GPU(position, direction)		   
          fs2020_event("K:TOGGLE_EXTERNAL_POWER") 
end
sw_GPU = switch_add(nil,nil, 50, 90, 140, 140, callback_GPU)




