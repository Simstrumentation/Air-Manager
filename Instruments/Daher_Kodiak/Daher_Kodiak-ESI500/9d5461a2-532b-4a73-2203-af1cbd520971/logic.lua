--[[
--******************************************************************************************
-- ********************** DAHER KODIAK (SWS) ESI500 DISPLAY*************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    ESI500 Backup Flight Display Overlay
    
This ESI 500 bezel is specifically designed for use with the SimWorks Studios Daher Kodiak for MSFS 2020.

    
    V1.02 - Released 2022-02-04
        - New graphics for both bezel and knob
        - Sounds added 
        
    V1.01 - Released 2022-01-04
        - Fixed incorrect behaviour on knob
        - Clicking knob resets altimeter to std when menu not showing
        
    V1.0 - Released 2022-31-03
           
    KNOWN ISSUES:
        - None

   --******************************************************************************************
--]]

-- set local variables
local tgl_menu 

--***********************************************USER PROPERTY CONFIG***********************************************
-- define user selectable properties
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                           -- Use sounds in Air Manager  

-- INITIALIZE USER PROPERTIES
-- play sounds
if user_prop_get(play_sounds) then
    press_snd = sound_add("click.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end
-- end play sounds

-- END INITIALIZE USER PROPERTIES

--*********************************************END USER PROPERTY CONFIG***********************************************
--Background graphic
img_add_fullscreen("bg.png")

-- menu button
-- Menu button uses an lvar that is latched at 1 when the menu button is pressed. This will display
-- the menu in the ESI500. Lvar much be toggled back to 0 to close it

function menu_cb(pos)
    if tgl_menu == 0 or tgl_menu == 2 then
        fs2020_variable_write("L:SWS_ESI500_Menu_Level", "Number", 1 )
     elseif tgl_menu == 1 then
         fs2020_variable_write("L:SWS_ESI500_Menu_Level", "Number", 0 )
     end 
     sound_play(press_snd)    
end
menu_id = button_add("btn_menu_rest.png", "btn_menu_pressed.png", 89, 390, 79, 48, menu_cb)

function new_menu_pos(pos)
    tgl_menu = pos
end
fs2020_variable_subscribe("L:SWS_ESI500_Menu_Level", "Number", new_menu_pos)

--Knob
function rotate_knob(dir)
    if tgl_menu ==0 then
         if dir == 1 then
                fs2020_event("K:Kohlsman_Inc",3)
           elseif dir == -1 then
                fs2020_event("K:Kohlsman_Dec",3)
           end
        else
        fs2020_variable_write("L:SWS_ESI500_Menu_Option_Change", "Number", dir)
        function timer_callback(count)
            fs2020_variable_write("L:SWS_ESI500_Menu_Option_Change", "Number", 0)
        end
        timer_start(50, timer_callback)  
    end
    sound_play(dial_snd)
end

function knob_turn_cb(dir)
    if dir == 1 then
            rotate_knob(1)        
    elseif dir == -1 then
        rotate_knob(-1)
    end
end
knob_id = dial_add("knob.png", 338, 360, 102, 102, knob_turn_cb)
img_add("knob_highlight.png", 338, 360, 102, 102)


function knob_click_cb()
    if tgl_menu == 0 then
        fs2020_event("K:BAROMETRIC_STD_PRESSURE", 3)
    else 
        fs2020_variable_write("L:SWS_ESI500_Menu_Select", "Number", 1)
        function timer_click_callback(count)
                fs2020_variable_write("L:SWS_ESI500_Menu_Select", "Number", 0)
        end
        timer_start(50, timer_click_callback)       
    end
    sound_play(press_snd)
end
button_add(nil, nil, 358, 382, 74, 74, knob_click_cb)