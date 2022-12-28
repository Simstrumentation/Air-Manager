--[[
******************************************************************************************
******************Bombardier CRJ-Parking Brake **************************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0** 06-21-2022
    - Original Panel Created
- **v1.1** 12-27-2022
    - Updated instrument size
    - Change instrument to turn instead of new graphic
    - Added ambient light features
	
## Left To Do:
  - N/A	

## NOTES
  - N/A
    
******************************************************************************************
--]]

prop_background = user_prop_add_boolean("Show background", true, "Show the background")
if user_prop_get(prop_background) == true then
    img_bg = img_add("bg.png",0,60,360,120)
    img_bg_night =  img_add("bg_night.png",0,60,360,120)
end
    
-- Ambient Light Control
function ss_ambient_darkness(value)
    if user_prop_get(prop_background) == true then
        opacity(img_bg_night, value, "LOG", 0.04)     
        opacity(img_pbrake_night, value, "LOG", 0.04)            
     end
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)    
    
local button_delay = 50
--PARKING BRAKE

img_pbrake = img_add("park_brake_off.png", 67,75,226,89)
img_pbrake_night = img_add("park_brake_off_night.png", 67,75,226,89)

fs2020_variable_subscribe("L:ASCRJ_PARK_BRAKE", "Number", 
        function (state)
            switch_set_position(sw_pb, state)
            if state == 0 then
                    rotate(img_pbrake , 0, 'LINEAR', 0.06)
                    move (img_pbrake, nil, nil, 226,89, 'LINEAR', 0.06)
                    rotate(img_pbrake_night , 0, 'LINEAR', 0.06)
                    move (img_pbrake_night, nil, nil, 226,89, 'LINEAR', 0.06)                    
             else
                     rotate(img_pbrake , 90, 'LINEAR', 0.06)
                     move (img_pbrake, nil, nil, 248, 97, 'LINEAR', 0.06)
                     rotate(img_pbrake_night , 90, 'LINEAR', 0.06)
                     move (img_pbrake_night, nil, nil, 248, 97, 'LINEAR', 0.06)                     
             end                
        end)
        
function cb_sw_pb(position)
    if (position == 0 ) then
        fs2020_variable_write("L:ASCRJ_PARK_BRAKE","Number",1) 
    elseif (position == 1 ) then
        fs2020_variable_write("L:ASCRJ_PARK_BRAKE","Number",0)
    end 
end

sw_pb= switch_add(nil,nil, 17,60,332,100, cb_sw_pb)


