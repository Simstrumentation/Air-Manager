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

##Left To Do:
    - 
    
##Notes:
    - Pannel Dimmer Disconnet is disabled for now.
    
--******************************************************************************************
--]]

snd_click = sound_add("click.wav")
snd_dial = sound_add("dial.wav")

prop_BG = user_prop_add_boolean("Display Background",true,"Show grey background")
prop_hide = user_prop_add_boolean("Hide Ambient Light Insturment and Auto Dim",false,"Hide Ambient Light Insturment and Auto Dim")

if user_prop_get(prop_BG) == true then
    img_add_fullscreen("background.png")
    bg_night = img_add_fullscreen("background_night.png")
end    

local update_timer = 500 -- default 500ms timer for intrument updates


-- Initialize states
ready_for_output = 0.0 -- initialize darkness value at startup
auto_set = 0 -- 1 = Auto, 0 = Man, initialize mode to manual
local man_night = 0 -- set night to off
local man_day = 1 -- set day to on

--Create si variable
var_ambient_darkness = si_variable_create("sivar_ambient_darkness", "FLOAT", 0.0)

--Add buttons
img_buttons = img_add_fullscreen("buttons.png")
img_buttons_night = img_add_fullscreen("buttons_night.png")

--******************************************************************************************
--Backlighting
img_labels = img_add_fullscreen("labels.png")
img_ambient_knob = img_add("knob.png", 60, 40, 120, 120)
img_ambient_knob_night = img_add("knob_night.png", 60, 40, 120, 120)
    
img_ambient_knob_indicator_backlight = img_add("knob_inidicator_backlight.png", 60, 40, 120, 120)
img_labels_backlight = img_add_fullscreen("labels_backlight.png")

img_day_indicator = img_add("button_indicator.png", 6, 164, 74, 45)
img_night_indicator = img_add("button_indicator.png", 157, 164, 74, 45)
img_auto_indicator= img_add("button_indicator.png", 82, 216, 74, 45)

function ss_backlighting(value, power, extpower, busvolts)
    value = var_round(value,2)      
    if value == 1.0 or (power == false and extpower == false and busvolts < 5) then 
        opacity(img_labels_backlight, 0.1, "LOG", 0.04)
        opacity(img_ambient_knob_indicator_backlight , 0.0, "LOG", 0.04)
    else
        opacity(img_labels_backlight, ((value/2)+0.5), "LOG", 0.04)
        opacity(img_ambient_knob_indicator_backlight, ((value/2)+0.5), "LOG", 0.04)
    end
end
fs2020_variable_subscribe("A:LIGHT POTENTIOMETER:3", "Number",
                          "ELECTRICAL MASTER BATTERY","Bool",
                          "EXTERNAL POWER ON:1", "Bool",
                          "ELECTRICAL MAIN BUS VOLTAGE", "Volts", ss_backlighting)

--====================================================
--Set 

function callback_timer()
    if (auto_set) == 1 then
        calculate()
    end
    si_variable_write(var_ambient_darkness, ready_for_output)
end
calculate_timer2 = timer_start(0, update_timer, callback_timer)

function pos_ambient_darkness(value)
--    if user_prop_get(prop_hide) == false and auto_set == 1 then
        value = var_round(value,2)
        rotate (img_ambient_knob, (value*290),"LOG", 0.04) 
        rotate (img_ambient_knob_night, (value*290),"LOG", 0.04)    
        rotate (img_ambient_knob_indicator_backlight, (value*290),"LOG", 0.04) 
        switch_set_position(sw_ambient_darkness, (value * 10))
        if user_prop_get(prop_BG) == true then
            opacity(bg_night, value, "LOG", 0.04)    --set this panels night background 
        end
        opacity(img_buttons_night, value, "LOG", 0.04)
        opacity(img_ambient_knob_night, value, "LOG", 0.04)    --set this panels night background   
        opacity(img_labels, (1-value), "LOG", 0.04)    --set this panels night background     
--    end
end 
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", pos_ambient_darkness)

function callback_ambient_darkness_knob(position, direction)
    if (auto_set) == 0 then
        sound_play(snd_dial)
        ready_for_output = (var_round( var_cap(position + direction, 0, 10), 0) / 10)
    end
end
sw_ambient_darkness = switch_add(nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil, 60, 40, 120, 120, callback_ambient_darkness_knob)
--=======Buttons===========================================
function callback_ambient_mode(val1)
    auto_set = fif(auto_set == 1, 0, 1)
    sound_play(snd_click)
    switch_set_position(sw_ambient_mode, fif(val1 == 0, 1, 0))
    visible(img_auto_indicator, fif(auto_set == 1, true, false))
    if auto_set == 1 then
         visible(img_night_indicator, false)
         visible(img_day_indicator, false)
         switch_set_position(sw_day, 0)    
         switch_set_position(sw_night, 0) 
         man_day = 0
         man_night = 0
    end
print("mode "..auto_set)
end

function calllback_day_btn(val2)
print("valday "..val2)
    if auto_set == 0 then
        man_day = fif(man_day == 1, 0, 1)
        if man_day == 1 then
            ready_for_output = 0.0
            switch_set_position(sw_day, 0)    
            visible(img_day_indicator, true)
            visible(img_night_indicator, false)
            visible(img_auto_indicator, false)
            switch_set_position(sw_night, 0)
            man_night = 0 
        else
            visible(img_day_indicator, false)
            visible(img_auto_indicator, false)
        end
        sound_play(snd_click)
    end
print("day "..man_day)
end

function calllback_night_btn(val3)
print("valnight "..val3)
    if auto_set == 0 then
        man_night = fif(man_night == 1, 0, 1)
        if man_night == 1 then
            ready_for_output = 1.0
            switch_set_position(sw_night, 0) 
            visible(img_night_indicator, true)
            visible(img_day_indicator, false)
            visible(img_auto_indicator, false)
            switch_set_position(sw_day, 0)    
            man_day = 0 
        else
            visible(img_night_indicator, false)
            visible(img_auto_indicator, false)
        end
        sound_play(snd_click)
    end
print("night "..man_night)
end

sw_ambient_mode = switch_add(nil,nil, 95, 205, 50, 50 , callback_ambient_mode)
sw_day = switch_add(nil, nil, 20, 160, 50, 50, calllback_day_btn)
sw_night = switch_add(nil, nil, 170, 160, 50, 50, calllback_night_btn)


switch_set_position(sw_ambient_darkness,ready_for_output)
switch_set_position(sw_ambient_mode, auto_set)    --sets instrument startup
switch_set_position(sw_day, man_day)    --sets instrument startup
switch_set_position(sw_night, man_night)    --sets instrument startup
visible(img_day_indicator, fif(man_day==1,true,false))
visible(img_night_indicator, fif(man_night==1,true,false))
visible(img_auto_indicator, fif(auto_set==1,true,false))
pos_ambient_darkness(ready_for_output)
si_variable_write(var_ambient_darkness, ready_for_output) -- initialize to no darkness


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
--        visible(bg_day, false)
--        visible(bg_night, false)
        switch_set_position(sw_ambient_mode, 1)
        auto_set = 1
end



