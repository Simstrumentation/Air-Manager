--[[
--******************************************************************************************
-- **********************DAHER KODIAK (SWS) RUDDER TRM  ***************************
--******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
    Main electrical switch panel for the Daher Kodiak by SimWorks Studios. 
    
    NOTE:
    
    V1.0 - Released 2022-01-03
    
    KNOWN ISSUES:
        - NONE
   --******************************************************************************************
--]]

--LOAD IMAGES IN CORRECT Z-ORDER
img_add_fullscreen("bg.png")                                                    --background

-- add switch graphics
rudder_bg_id = img_add("switch_c.png",40, 66, 289, 133)            --unpressed switch
rudder_l_id = img_add("switch_l.png",40, 66, 289, 133)                --pressed left
visible (rudder_l_id, false)                                                              -- hide pressed state when not in use
rudder_r_id = img_add("switch_r.png",40, 66, 289, 133)                --pressed right
visible(rudder_r_id, false)                                                               -- hide pressed state when not in use

-- left rudder adustment
function rudder_l_cb(direction)
      visible (rudder_l_id, true)    --show pressed state on press
      fs2020_event("RUDDER_TRIM_LEFT")  
end

function rudder_l_release_cb()
     visible (rudder_l_id, false)    --show unpressed state on release
end 
rudder_l_btn_id = button_add(nil, nil, 40, 66, 120, 133, rudder_l_cb, rudder_l_release_cb)

-- right rudder adustment
function rudder_r_cb(direction)
    visible (rudder_r_id, true)    --show pressed state on press
      fs2020_event("RUDDER_TRIM_RIGHT")  
end

function rudder_r_release_cb()
     visible (rudder_r_id, false)    --show unpressed state on release
end 
rudder_r_btn_id = button_add(nil, nil, 200, 66, 120, 133, rudder_r_cb, rudder_r_release_cb)