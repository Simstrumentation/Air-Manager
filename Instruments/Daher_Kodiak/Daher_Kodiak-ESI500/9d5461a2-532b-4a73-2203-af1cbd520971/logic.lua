--[[
--******************************************************************************************
-- ********************** DAHER KODIAK (SWS) ESI500 DISPLAY*************************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    ESI500 Backup Flight Display Overlay
    
    V1.0 - Released 2022-31-03
           
    KNOWN ISSUES:
        - None

   --******************************************************************************************
--]]

--local variables
local tgl_menu 

--Background graphic
img_add_fullscreen("bg.png")
= 0
-- menu button
function menu_cb(pos)
    if tgl_menu == 1 then
        fs2020_variable_write("L:SWS_ESI500_Menu_Level", "Number", 0 )
     else
         fs2020_variable_write("L:SWS_ESI500_Menu_Level", "Number", 1 )
     end     
end
menu_id = button_add("btn_menu_rest.png", "btn_menu_pressed.png", 89, 390, 79, 48, menu_cb)

function new_menu_pos(pos)
    tgl_menu = pos
end
fs2020_variable_subscribe("L:SWS_ESI500_Menu_Level", "Number", new_menu_pos)

--Knob

function rotate_knob(dir)
    fs2020_variable_write("L:SWS_ESI500_Menu_Option_Change", "Number", dir)
    function timer_callback(count)
         fs2020_variable_write("L:SWS_ESI500_Menu_Option_Change", "Number", 0)
    end
    timer_start(50, timer_callback)  
end

function knob_turn_cb(direction)
    if direction == 1 then
            rotate_knob(1)        
    elseif direction == -1 then
        rotate_knob(-1)
    end
end
knob_id = dial_add("knob.png", 338, 365, 102, 102, knob_turn_cb)
img_add("knob_highlight.png", 338, 365, 102, 102)


function knob_click_cb()
     fs2020_variable_write("L:SWS_ESI500_Menu_Select", "Number", 1)
     function timer_click_callback(count)
             fs2020_variable_write("L:SWS_ESI500_Menu_Select", "Number", 0)
     end
      timer_start(50, timer_click_callback) 
end
button_add(nil, nil, 358, 382, 74, 74, knob_click_cb)