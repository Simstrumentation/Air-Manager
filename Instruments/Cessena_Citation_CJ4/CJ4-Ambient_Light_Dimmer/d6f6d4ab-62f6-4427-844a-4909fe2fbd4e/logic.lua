--[[
--******************************************************************************************
-- ******************Cessna Citation CJ4 Ambient Light Dimmer**************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

   
- **v1.0** 9-18-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker
    - Original Panel Created
- **v1.2** 10-1-21 Todd "Toddimus831" Lorey
    - Adjust illumination depending upon sun position
--*********END OF INTERNAL ALPHA TESTING****************
- **v2.0** 10-5-21 Rob "FlightLevelRob" Verdon and Joe "Crunchmeister" Gilker and Todd "Toddimus831" Lorey
    !!- Initial Public Release -!!
    - Variable renaming for clarity
    - Added backlight logic to account for battery, external power and bus volts status
- **v2.01** 10-10-2021 
    - Clean up code and add more commenting for sumbission to AM store   
--******************************************************************************************
--]]

-- Add sounds
snd_click = sound_add("doubleclick.wav")
snd_dial = sound_add("dial.wav")

-- Create user props
prop_BG = user_prop_add_boolean("Display Background",true,"Show grey background")
prop_hide = user_prop_add_boolean("Hide Ambient Light Insturment and Auto Dim",false,"Hide Ambient Light Insturment and Auto Dim")
prop_arduino_hue = user_prop_add_string("Philips Hue Light Control Arduino Name String", "ARDUINO_NANO_A", "Change this if you have already have Arduinos connected for different things and need to make this a different channel. See Simstrumentation GitHub for documentation.")

if user_prop_get(prop_BG) == true then
    img_add_fullscreen("background.png")
    bg_night = img_add_fullscreen("background_night.png")
end    

local update_timer = 500 -- default 500ms timer for intrument updates

-- Initialize states
ready_for_output = 0.0 -- initialize darkness value at startup to no dimming
local auto_set = 0 -- 1 = Auto, 0 = Man, initialize mode to manual
local man_night = 0 -- set night to off
local man_day = 1 -- set day to on

--Create si variable
var_ambient_darkness = si_variable_create("sivar_ambient_darkness", "FLOAT", 0.0)

--Add buttons
img_buttons = img_add_fullscreen("buttons.png")
img_buttons_night = img_add_fullscreen("buttons_night.png")

--Message Port for Hue Dimming
currentambientdarkness = 0
function callback_message_port_hue(message_port_hue1, payload)
  print("received new message with id " .. message_port_hue1)
end
message_port_hue1 = hw_message_port_add(user_prop_get(prop_arduino_hue), callback_message_port_hue1)

--******************************************************************************************
--Backlighting images
img_labels = img_add_fullscreen("labels.png")
img_ambient_knob = img_add("knob.png", 60, 40, 120, 120)
img_ambient_knob_night = img_add("knob_night.png", 60, 40, 120, 120)
    
img_ambient_knob_indicator_backlight = img_add("knob_inidicator_backlight.png", 60, 40, 120, 120)
img_labels_backlight = img_add_fullscreen("labels_backlight.png")

img_day_indicator = img_add("button_indicator.png", 6, 164, 74, 45)
img_night_indicator = img_add("button_indicator.png", 157, 164, 74, 45)
img_auto_indicator= img_add("button_indicator.png", 82, 216, 74, 45)

-- Get backlight value and power information from sim and apply to images
function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then -- set backlighting to off levels
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_ambient_knob_indicator_backlight , 0.0, "LOG", 0.04)
    else -- adjust to intermediate level
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_ambient_knob_indicator_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)

--====================================================
--Ambient lighting/darkness adjustments

function callback_timer() 
    if (auto_set) == 1 then --  call calculation function from library at set rate if in auto mode
        calculate()
    end
    si_variable_write(var_ambient_darkness, ready_for_output) -- write present value to si var
end
calculate_timer2 = timer_start(0, update_timer, callback_timer)

function pos_ambient_darkness(value) -- apply darkness value from si var to instrument and adjust knob position to match
        value = var_round(value,2)
        rotate (img_ambient_knob, (value*290),"LOG", 0.04) 
        rotate (img_ambient_knob_night, (value*290),"LOG", 0.04)    
        rotate (img_ambient_knob_indicator_backlight, (value*290),"LOG", 0.04) 
        switch_set_position(sw_ambient_darkness, (value * 10))
        if user_prop_get(prop_BG) == true then
            opacity(bg_night, value, "LOG", 0.04)    --set this instrument's night background if enabled by user prop
        end
        opacity(img_buttons_night, value, "LOG", 0.04)
        opacity(img_ambient_knob_night, value, "LOG", 0.04)       
        opacity(img_labels, (1-value), "LOG", 0.04)       
        if  (currentambientdarkness ~= value) then       --Setting Hue Light   
            hw_message_port_send(message_port_hue1, 776, "BYTE[1]", {254-(value*254) } )
            currentambientdarkness = value     --Used for IF statement so only sending updates to Hue Light
       end 
end 
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", pos_ambient_darkness)

-- Ambient dimmer knob
function callback_ambient_darkness_knob(position, direction)
    if (auto_set) == 0 then -- if in manual mode, set output value to be used in si var update based on new knob position
        sound_play(snd_dial)
        ready_for_output = (var_round( var_cap(position + direction, 0, 10), 0) / 10)
    end
    if position ~= 0 or position ~= 100 then -- set indicators to off if knob moved from end stops
         visible(img_night_indicator, false)
         visible(img_day_indicator, false)
         switch_set_position(sw_day, 0)    
         switch_set_position(sw_night, 0) 
         man_day = 0
         man_night = 0
    end
end
sw_ambient_darkness = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 60, 40, 120, 120, callback_ambient_darkness_knob)

--=======Buttons===========================================
-- Button callbacks
function callback_ambient_mode(val1) -- configures instrument to run in manual or auto mode for determining instrument dimming level
    auto_set = fif(auto_set == 1, 0, 1) -- toggle auto_set state
    sound_play(snd_click)
    switch_set_position(sw_ambient_mode, fif(val1 == 0, 1, 0)) -- toggle switch position
    visible(img_auto_indicator, fif(auto_set == 1, true, false)) -- set indicator
    if auto_set == 1 then -- clear manual indicators and states
         visible(img_night_indicator, false)
         visible(img_day_indicator, false)
         switch_set_position(sw_day, 0)    
         switch_set_position(sw_night, 0) 
         man_day = 0
         man_night = 0
    end
end

function calllback_day_btn(val2) -- triggers instrument to run in full brightness 
    if auto_set == 0 then -- only run if in manual mode
        man_day = fif(man_day == 1, 0, 1) -- toggle state
        if man_day == 1 then -- if new state is manual day on...
            ready_for_output = 0.0 -- set output value to zero darkness level
            switch_set_position(sw_day, 0)   -- adjust switch positions and visibilities accordingly
            visible(img_day_indicator, true)
            visible(img_night_indicator, false)
            visible(img_auto_indicator, false)
            switch_set_position(sw_night, 0)
            man_night = 0 
        else -- if new state is manual day off, turn indicator off and make sure auto is still off
            visible(img_day_indicator, false)
            visible(img_auto_indicator, false)
        end
        sound_play(snd_click)
    end
end

function calllback_night_btn(val3) -- triggers instrument to run in full darkness mode
    if auto_set == 0 then --  only run if in manual mode
        man_night = fif(man_night == 1, 0, 1) -- toggle state
        if man_night == 1 then -- if new state is manual night on...
            ready_for_output = 1.0 -- set output value to full darkness level
            switch_set_position(sw_night, 0) -- adjust switch positions and visibilities accordingly
            visible(img_night_indicator, true)
            visible(img_day_indicator, false)
            visible(img_auto_indicator, false)
            switch_set_position(sw_day, 0)    
            man_day = 0 
        else -- if new state is manual night off, turn indicator off and make sure auto is still off
            visible(img_night_indicator, false)
            visible(img_auto_indicator, false)
        end
        sound_play(snd_click)
    end
end

-- Create buttons
sw_ambient_mode = switch_add(nil,nil, 95, 205, 50, 50 , callback_ambient_mode)
sw_day = switch_add(nil, nil, 20, 160, 50, 50, calllback_day_btn)
sw_night = switch_add(nil, nil, 170, 160, 50, 50, calllback_night_btn)

-- Initialize values, button positions and visibilities at startup
switch_set_position(sw_ambient_darkness,ready_for_output)  --sets instrument startup from variables set at top of script
switch_set_position(sw_ambient_mode, auto_set)    
switch_set_position(sw_day, man_day)    
switch_set_position(sw_night, man_night)    
visible(img_day_indicator, fif(man_day==1,true,false))
visible(img_night_indicator, fif(man_night==1,true,false))
visible(img_auto_indicator, fif(auto_set==1,true,false))
pos_ambient_darkness(ready_for_output)
si_variable_write(var_ambient_darkness, ready_for_output) -- initialize to no darkness

-- Handle case where user property is to hide instrument and run in auto mode (stealth setting)
if user_prop_get(prop_hide) == true then
        visible(img_labels, false)
        visible(img_ambient_knob, false)
        visible(img_ambient_knob_night, false)
        visible(img_ambient_knob_indicator_backlight, false)
        visible(img_labels_backlight, false)
        visible(sw_night, false)
        visible(sw_day, false)
        visible(sw_ambient_darkness, false)        
        visible(sw_ambient_mode, false)
        visible(img_buttons, false)
        visible(img_buttons_night, false)
        visible(img_day_indicator, false)
        visible(img_night_indicator, false)
        visible(img_auto_indicator, false)
        switch_set_position(sw_ambient_mode, 1)
        auto_set = 1
end



