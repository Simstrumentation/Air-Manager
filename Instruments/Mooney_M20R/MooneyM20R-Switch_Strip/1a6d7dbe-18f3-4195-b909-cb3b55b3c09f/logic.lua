--[[
--******************************************************************************************
-- **************** MOONEY M20R OVATION (CARENADO) SWITCH STRIP **************
--******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

    Secondary switches for the Mooney M20R. Contains the following controls:

      - High boost pump switch with working cover
      - Standby vacuum
      - Pitot heat
      - Fuel pump
      - Elevator trim (INOP in plane model)

  NOTES:
    
    - The preview in Air Manager makes the switch look large and ugly, but should be placed last in the z-order
      so that when the cover opens, it will be over other instruments below it in the z-order
    
    - To open the cover on the high boost pump, click on or touch the hinge  

    - Closing the switch cover while high boost pump is active will shut off the boost pump switch.
    
    - Elevator trim switch is INOP in cockpit. Will only play an error tone when activated 

    
    V1.0 - Released 2022-01-03
           
    KNOWN ISSUES:
        - None

   --******************************************************************************************
--]]



--USER PROPERTIES
screws_on = user_prop_add_enum("Show Screws","Yes, No","Yes","Select whether you want to see the srews around the switches or not")      -- default is to show screws

-- LOCAL VARS
local boost_state            -- whether high boost pump is on or off
local vac_state                -- whether standby vacuum is on or off
local cover_state = 0      -- whetther switch cover is closed (0) or open (1)

--ADD SOUNDS
snd_cover_open = sound_add("cover_open.wav")
snd_cover_close = sound_add("cover_close.wav")
snd_fail = sound_add("beepfail.wav")

--ADD STATIC GRAPHICS
--bottom screws - only show if user property selected. 
if user_prop_get(screws_on) == "Yes" then

  img_add("screw.png", 68, 628, 40, 40)
  img_add("screw.png", 248, 628, 40, 40)
  img_add("screw.png", 418, 628, 40, 40)
  img_add("screw.png", 594, 628, 40, 40)
  img_add("screw.png", 772, 628, 40, 40)

  --top screws
  img_add("screw.png", 248, 310, 40, 40)
  img_add("screw.png", 418, 310, 40, 40)
  img_add("screw.png", 594, 310, 40, 40)
  img_add("screw.png", 772, 310, 40, 40)
end

--SWITCHES
--High Boost
function hi_boost_cb()

  if cover_state == 1 then
    if boost_state == 1 then
      msfs_variable_write("L:M20R_switch_hight_boost", "Number", 0)
    else
      msfs_variable_write("L:M20R_switch_hight_boost", "Number", 1)
    end
  else
    -- play error sound
    sound_play(snd_fail)
  end

end
hi_boost_id = switch_add("hi_boost_off.png", "hi_boost_on.png", 16, 360, 160, 262, hi_boost_cb)

function new_hi_boost_pos(hi_boost)
    boost_state = hi_boost
    switch_set_position(hi_boost_id, hi_boost)    
end

msfs_variable_subscribe("L:M20R_switch_hight_boost", "Number", new_hi_boost_pos)


--Vacuum Boost
function vac_cb()
  if vac_state == 1 then
    msfs_variable_write("L:M20R_SWITCH_STANDBY_VACUUM", "Number", 0)
  else
    msfs_variable_write("L:M20R_SWITCH_STANDBY_VACUUM", "Number", 1)
  end
end 
vac_id = switch_add("vac_off.png", "vac_on.png", 190, 360, 160, 262, vac_cb)

function new_vac_pos(vac)
print (vac)
  vac_state = vac
  switch_set_position(vac_id, vac)
end

msfs_variable_subscribe("L:M20R_SWITCH_STANDBY_VACUUM", "Number", new_vac_pos)



--Pitot
function pitot_cb()
  msfs_event("PITOT_HEAT_TOGGLE", new_position)
end
pitot_id = switch_add("pitot_off.png", "pitot_on.png", 360, 360, 160, 262, pitot_cb)

function new_pitot_pos(pitot)
  switch_set_position(pitot_id, pitot)
end

msfs_variable_subscribe("PITOT HEAT", "Bool", new_pitot_pos)

--Fuel Pump
function pump_cb()
  msfs_event("TOGGLE_ELECT_FUEL_PUMP1")
end
pump_id = switch_add("pump_off.png", "pump_on.png", 532, 360, 160, 262, pump_cb)

function new_pump_pos(pump)
  switch_set_position(pump_id, pump)
end

msfs_variable_subscribe("GENERAL ENG FUEL PUMP SWITCH:1", "Bool", new_pump_pos)

--Elevator Trim
function el_trim_cb()
  -- switch currently INOP in cockpit
  -- play error sound
  sound_play(snd_fail)
end
el_trim_id = switch_add("el_trim_off.png", "el_trim_on.png", 706, 360, 160, 262, el_trim_cb)



-- high boost switch cover

function cover_cb()
  if cover_state == 0 then
    cover_state = 1
    sound_play(snd_cover_open)
    visible(cover_up_id, true)
    visible(cover_dn_id, false)
  else
    cover_state = 0
    msfs_variable_write("L:M20R_switch_hight_boost", "Number", 0)
    visible(cover_up_id, false)
    visible(cover_dn_id, true)
    sound_play(snd_cover_close)    
  end
  print (cover_state)
end


cover_id = switch_add(nil, nil, 0, 300, 166, 64, cover_cb)    -- set touch zone on switch


cover_up_id = img_add("cover_up.png", 0, 0, 180, 627)
visible(cover_up_id, false)
cover_dn_id = img_add("cover_down.png", 0, 0, 180, 627)
print (cover_state)

