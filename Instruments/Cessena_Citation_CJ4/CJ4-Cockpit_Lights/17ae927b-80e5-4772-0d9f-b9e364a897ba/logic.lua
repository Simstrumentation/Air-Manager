--[[
******************************************************************************************
******************Cessna Citation CJ4 Cockpit Lights Panel*******************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 10-16-21 Rob "FlightLevelRob" Verdon 
    - Original Panel Created
- **v1.1** 01-02-22 Simstrumentation 
    - Made knobs size smaller to allow easier dragging of panel
    - Knob sound wasn't working
    - Added cabin lights toggle on center push with click sound
    																						
##Left To Do:
    - 
	
##Notes:
    - This has no background associated with it directly. You may use the AirManager settings to create one.						   
******************************************************************************************
--]]

--===========IMPORT ASSETS==============================
snd_dial = sound_add("dial.wav")
snd_click = sound_add("click.wav")

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_light_flood_knob_night, value, "LOG", 0.04)
    opacity(img_light_pilot_knob_night, value, "LOG", 0.04)
    opacity(img_light_copilot_knob_night, value, "LOG", 0.04)	
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--Knobs--
img_light_pilot_knob = img_add("panel_dimmer.png", 10, 5, 134, 134)
img_light_pilot_knob_night = img_add("panel_dimmer_night.png", 10, 5, 134, 134)
img_light_pilot_dimmer_indicator = img_add("panel_dimmer_inidicator.png", 10, 3, 134, 134)

img_light_flood_knob = img_add("panel_dimmer.png", 150, 5, 134, 134)
img_light_flood_knob_night = img_add("panel_dimmer_night.png", 150, 5, 134, 134)
img_light_flood_dimmer_indicator = img_add("panel_dimmer_inidicator.png", 150, 3, 134, 134)

img_light_copilot_knob = img_add("panel_dimmer.png", 290, 5, 134, 134)
img_light_copilot_knob_night = img_add("panel_dimmer_night.png", 290, 5, 134, 134)
img_light_copilot_dimmer_indicator = img_add("panel_dimmer_inidicator.png", 290, 3, 134, 134)

-------Panel Backlighting
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_light_flood_dimmer_indicator, 0.0, "LOG", 0.04)
        opacity(img_light_pilot_dimmer_indicator, 0.0, "LOG", 0.04)
        opacity(img_light_copilot_dimmer_indicator, 0.0, "LOG", 0.04)                
    else
        opacity(img_light_flood_dimmer_indicator, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_light_pilot_dimmer_indicator, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_light_copilot_dimmer_indicator, ((value/2)+0.5), "LOG", 0.04)                
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)

--******************************************************************************************
--Flood Light Knob
function ss_Lights_Flood(value)
    rotate (img_light_flood_knob, (value*80),"LOG", 0.1)
    rotate (img_light_flood_knob_night, (value*80),"LOG", 0.1)
    rotate (img_light_flood_dimmer_indicator, (value*80),"LOG", 0.1)
    switch_set_position(sw_light_flood, (value * 10)) 
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:4", "Number", ss_Lights_Flood)

function callback_light_flood(position, direction)
    sound_play(snd_dial)
    fs2020_variable_write("A:LIGHT CABIN:3", "BOOL", true)
    fs2020_event("LIGHT_POTENTIOMETER_4_SET",var_cap((var_round((position + direction), 0) * 10),0,100))
    --fs2020_variable_write("L:LIGHTING_Knob_Master", "Int", var_cap((var_round((position + direction), 0) * 10),0,100))
end
sw_light_flood = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 158, 13, 120, 120, callback_light_flood)
function callback_light_flood_click()
    position = switch_get_position(sw_light_flood)
    if position <= 0 then
        fs2020_variable_write("A:LIGHT CABIN:3", "BOOL", true)
        fs2020_event("LIGHT_POTENTIOMETER_4_SET",100)
        sound_play(snd_click)
    else 
        fs2020_variable_write("A:LIGHT CABIN:3", "BOOL", true)
        fs2020_event("LIGHT_POTENTIOMETER_4_SET",0)
        sound_play(snd_click)
     end
end
button_add(nil,nil, 190,50,50,50,callback_light_flood_click)

--Pilot Light Knob
function ss_Lights_Pilot(value)
    rotate (img_light_pilot_knob, (value*80),"LOG", 0.1)
    rotate (img_light_pilot_knob_night, (value*80),"LOG", 0.1)
    rotate (img_light_pilot_dimmer_indicator, (value*80),"LOG", 0.1)
    switch_set_position(sw_light_pilot, (value * 10)) 
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:5", "Number", ss_Lights_Pilot)

function callback_light_pilot(position, direction)
    sound_play(snd_dial)
    fs2020_variable_write("A:LIGHT CABIN:1", "BOOL", true)
    fs2020_event("LIGHT_POTENTIOMETER_5_SET",var_cap((var_round((position + direction), 0) * 10),0,100))
end
sw_light_pilot = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 18, 13, 120, 120, callback_light_pilot)
function callback_light_pilot_click()
    position = switch_get_position(sw_light_pilot)
    if position <= 0 then
        fs2020_variable_write("A:LIGHT CABIN:1", "BOOL", true)
        fs2020_event("LIGHT_POTENTIOMETER_5_SET",100)
        sound_play(snd_click)
    else 
        fs2020_variable_write("A:LIGHT CABIN:1", "BOOL", true)
        fs2020_event("LIGHT_POTENTIOMETER_5_SET",0)
        sound_play(snd_click)
     end
end
button_add(nil,nil, 50,50,50,50,callback_light_pilot_click)
--CoPilot Light Knob
function ss_Lights_CoPilot(value)
    rotate (img_light_copilot_knob, (value*80),"LOG", 0.1)
    rotate (img_light_copilot_knob_night, (value*80),"LOG", 0.1)
    rotate (img_light_copilot_dimmer_indicator, (value*80),"LOG", 0.1)
    switch_set_position(sw_light_copilot, (value * 10)) 
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:6", "Number", ss_Lights_CoPilot)

function callback_light_copilot(position, direction)
    sound_play(snd_dial)
    fs2020_variable_write("A:LIGHT CABIN:2", "BOOL", true)
    fs2020_event("LIGHT_POTENTIOMETER_6_SET",var_cap((var_round((position + direction), 0) * 10),0,100))
end
sw_light_copilot = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 298, 13, 120, 120, callback_light_copilot)
function callback_light_copilot_click()
    position = switch_get_position(sw_light_copilot)
    if position <= 0 then
        fs2020_variable_write("A:LIGHT CABIN:2", "BOOL", true)
        fs2020_event("LIGHT_POTENTIOMETER_6_SET",100)
        sound_play(snd_click)
    else 
        fs2020_variable_write("A:LIGHT CABIN:2", "BOOL", true)
        fs2020_event("LIGHT_POTENTIOMETER_6_SET",0)
        sound_play(snd_click)
     end
end
button_add(nil,nil, 330,50,50,50,callback_light_copilot_click)