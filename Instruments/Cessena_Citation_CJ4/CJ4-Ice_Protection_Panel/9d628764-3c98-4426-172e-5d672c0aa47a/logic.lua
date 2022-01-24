--[[
******************************************************************************************
******************Cessna Citation CJ4 Ice Protection Panel******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    
- **v1.0**  06-14-2021 Joe "Crunchmeister" Gilke
    - Original Panel Created
- **v2.0**  09-22-2021 Todd "Toddimus831" Lorey and Joe "Crunchmeister" Gilker
    - Removed Mobiflight events and replaced logic
    - New graphics
    - Added night mode
    - Added backlight dimming
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.1** 01-16-22 SIMSTRUMENTATION 
    - Click sounds replaced with custom.
    - Resource folder file capitials renamed for SI Store submittion  

##Left To Do:
    - 	
	
##Notes:
    - 

******************************************************************************************
]]--

--IMPORT ASSETS
img_add_fullscreen("background.png")
click_snd=sound_add("click.wav")

--=======Night Lighting=============================================
img_bg_night = img_add_fullscreen("background_night.png")
-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--=======Back Lighting=============================================
img_labels_backlight = img_add_fullscreen("backlight.png")
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)
						  
local deice_airframe_1 = nil
local deice_airframe_2 = nil
local struct_deice_switch = nil
local pitot1_state = nil
local pitot2_state = nil

--  WING/ENG ANTI-ICE 

function callback_l_wing(pos)
    fs2020_variable_write("L:DEICE_Airframe_1","Int", fif(deice_airframe_1, 0, 1))
    fs2020_event("TOGGLE_STRUCTURAL_DEICE")
    sound_play(click_snd)
end

function callback_r_wing(pos)
    fs2020_variable_write("L:DEICE_Airframe_2","Int", fif(deice_airframe_2, 0, 1))
    fs2020_event("TOGGLE_STRUCTURAL_DEICE")
    sound_play(click_snd)
end

function ss_update_airframe_deice_callback(af1, af2, switch)
	deice_airframe_1 = fif(af1==1, true, false)
	deice_airframe_2 = fif(af2==1, true, false)
	struct_deice_switch = switch
  	if (deice_airframe_1 or deice_airframe_2) ~= struct_deice_switch then
  	    fs2020_event("TOGGLE_STRUCTURAL_DEICE")
	end
	switch_set_position(sw_l_wing, fif(af1==1, 1, 0))
        switch_set_position(sw_r_wing, fif(af2==1, 1, 0))
end
fs2020_variable_subscribe("L:DEICE_Airframe_1", "Int", 
			  "L:DEICE_Airframe_2", "Int", 
			  "STRUCTURAL DEICE SWITCH", "BOOL", ss_update_airframe_deice_callback)
			  
sw_l_wing = switch_add(nil, "button_on.png", 96, 58, 74, 58, callback_l_wing)
sw_r_wing = switch_add(nil, "button_on.png", 207, 57, 74, 58, callback_r_wing)



--  L ENGINE DEICE
function callback_l_engine(position)
    if position == 0 then
        switch_set_position(sw_l_eng, 1)
        fs2020_event("ANTI_ICE_TOGGLE_ENG1")
    elseif position == 1 then
        switch_set_position(sw_l_eng, 0)
        fs2020_event("ANTI_ICE_TOGGLE_ENG1")
    end
    sound_play(click_snd)
end
sw_l_eng = switch_add(nil, "button_on.png", 97, 162, 74, 58, callback_l_engine)

function ss_l_eng(l_eng_on)
    if l_eng_on then
        switch_set_position(sw_l_eng, 1)
    else 
        switch_set_position(sw_l_eng, 0)
    end
end    
fs2020_variable_subscribe("GENERAL ENG ANTI ICE POSITION:1", "Bool", ss_l_eng)
-- END L ENGINE DEICE

--  R ENGINE DEICE
function callback_r_engine(position)
    if position == 0 then
        switch_set_position(sw_r_eng, 1)
        fs2020_event("ANTI_ICE_TOGGLE_ENG2")
    elseif position == 1 then
        switch_set_position(sw_r_eng, 0)
        fs2020_event("ANTI_ICE_TOGGLE_ENG2")
    end
    sound_play(click_snd)
end
sw_r_eng = switch_add(nil, "button_on.png", 208, 162, 74, 58, callback_r_engine)

function ss_r_eng(r_eng_on)
    if r_eng_on then
        switch_set_position(sw_r_eng, 1)
    else 
        switch_set_position(sw_r_eng, 0)
    end
end    
fs2020_variable_subscribe("GENERAL ENG ANTI ICE POSITION:2", "Bool", ss_r_eng)
-- END  R ENGINE DEICE

--  PITOT
function callback_pitot1(position)
    fs2020_event("PITOT_HEAT_TOGGLE", 1)
    sound_play(click_snd)
end
sw_l_pitot = switch_add(nil, "button_on.png", 320, 162, 74, 58, callback_pitot1)

function callback_pitot2(position)
    fs2020_event("PITOT_HEAT_TOGGLE", 2)
    sound_play(click_snd)
end
sw_r_pitot = switch_add(nil, "button_on.png", 432, 162, 74, 58, callback_pitot2)

function ss_pitotpos(pitot1_st, pitot2_st)
    pitot1_state = pitot1_st
    pitot1_state = pitot1_st
    if pitot1_st==1 then
        switch_set_position(sw_l_pitot , 1)
    else 
        switch_set_position(sw_l_pitot , 0)
    end
    if pitot2_st==1 then
        switch_set_position(sw_r_pitot, 1)
    else 
        switch_set_position(sw_r_pitot, 0)
    end
end    
fs2020_variable_subscribe("L:DEICE_Pitot_1", "Int",
                          "L:DEICE_Pitot_2", "Int", ss_pitotpos)
-- END PITOT

--  WING LIGHT
function callback_wing_light(position)
    fs2020_event("TOGGLE_WING_LIGHTS")
    sound_play(click_snd)
end
sw_wing_light = switch_add(nil, "button_on.png", 547, 58, 74, 58, callback_wing_light)

function ss_wing_light(light_on)
    if light_on then
        switch_set_position(sw_wing_light , 1)
    else 
        switch_set_position(sw_wing_light , 0)
    end
end    
fs2020_variable_subscribe("LIGHT WING", "Bool", ss_wing_light)
-- END WING LIGHT