

img_add_fullscreen("bg.png")

local wshld = 0

-- surface deice
function surface_cb(position, direction)
    new_pos = position + direction
    msfs_variable_write("L:C310_SW_DEICE_SURFACE", "Enum", new_pos)
end
surface_id = switch_add("white_up.png", "white_mid.png", "white_down.png", 54, 30, 60, 113, surface_cb)

function set_surface(pos)
    switch_set_position(surface_id, pos)
end

msfs_variable_subscribe("L:C310_SW_DEICE_SURFACE", "Enum", set_surface)

--Propeller deice
function prop_cb()
    msfs_event("TOGGLE_PROPELLER_DEICE")
end
prop_id = switch_add("white_down.png", "white_up.png", 174, 30, 60, 113, prop_cb)

function set_prop(pos)
    switch_set_position(prop_id, pos)
end
msfs_variable_subscribe("L:C310_SW_DEICE_PROP", "Number", set_prop)

--windshield deice
function wshld_cb()
    if wshld == 0 then
        msfs_variable_write("L:C310_SW_DEICE_WINDSHLD", "Number", 1)
    else
        msfs_variable_write("L:C310_SW_DEICE_WINDSHLD", "Number", 0)
    end    
end
wshld_id = switch_add("white_down.png", "white_up.png", 394, 30, 60, 113, wshld_cb)

function set_wshld(pos)
    switch_set_position(wshld_id, pos)
    wshld = pos
end
msfs_variable_subscribe("L:C310_SW_DEICE_WINDSHLD", "Number", set_wshld)

--pitot heat

function pitot_cb()
    msfs_event("PITOT_HEAT_TOGGLE")
end    
pitot_id = switch_add("white_down.png", "white_up.png", 504, 30, 60, 113, pitot_cb)

function set_pitot(pos)
    switch_set_position(pitot_id, pos)
end
msfs_variable_subscribe("PITOT HEAT", "Bool", set_pitot)


--Avionics
function avionics_cb()
    msfs_event("TOGGLE_AVIONICS_MASTER")
end
avionics_id = switch_add("white_down.png", "white_up.png", 616, 30, 60, 113, avionics_cb)

function set_avionics(pos)
    switch_set_position(avionics_id, pos)
end

msfs_variable_subscribe("AVIONICS MASTER SWITCH", "Bool", set_avionics)

--ice light

function deice_cb()
    msfs_event("TOGGLE_WING_LIGHTS")
end  
deice_id = switch_add("white_down.png", "white_up.png", 726, 30, 60, 113, deice_cb)

function set_deice(pos)
    switch_set_position(deice_id, pos)
end

msfs_variable_subscribe("L:C310_SW_LIGHTS_DEICE", "Number", set_deice)


--anti collision light
function anticoll_cb()
    msfs_event("TOGGLE_BEACON_LIGHTS")
end
anticoll_id = switch_add("white_down.png", "white_up.png", 838, 30, 60, 113, anticoll_cb)

function set_anticoll(pos)
    switch_set_position(anticoll_id, pos)
end 
msfs_variable_subscribe("LIGHT BEACON", "Bool", set_anticoll)

--Strobe light
function strobe_cb()
    msfs_event("STROBES_TOGGLE")
end
strobe_id = switch_add("white_down.png", "white_up.png", 952, 30, 60, 113, strobe_cb)

function set_strobe(pos)
    switch_set_position(strobe_id, pos)
end 
msfs_variable_subscribe("LIGHT STROBE", "Bool", set_strobe)

--nav light
function nav_cb()
    msfs_event("TOGGLE_NAV_LIGHTS")
end

nav_id = switch_add("white_down.png", "white_up.png", 1062, 30, 60, 113, nav_cb)

function set_nav(pos)
    switch_set_position(nav_id, pos)
end
msfs_variable_subscribe("LIGHT NAV", "Bool", set_nav)

--taxi light
function taxi_cb()
    msfs_event("TOGGLE_TAXI_LIGHTS")
end
taxi_id = switch_add("white_down.png", "white_up.png", 1174, 30, 60, 113, taxi_cb)

function set_taxi(pos)
    switch_set_position(taxi_id, pos)
end
msfs_variable_subscribe("LIGHT TAXI", "Bool", set_taxi)

--landing light
function landing_cb(position, direction)
    newpos= position + direction
    msfs_variable_write("L:C310_SW_LIGHTS_LANDING", "Enum", newpos)
end

landing_id = switch_add("white_up.png", "white_mid.png", "white_down.png", 1290, 30, 60, 113, landing_cb)

function set_ldg(pos)
    switch_set_position(landing_id, pos)
end

msfs_variable_subscribe("L:C310_SW_LIGHTS_LANDING", "Enum", set_ldg)