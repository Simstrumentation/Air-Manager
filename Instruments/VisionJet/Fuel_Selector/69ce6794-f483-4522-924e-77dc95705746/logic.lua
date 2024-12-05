--[[
******************************************************************************************
****************** CIRRUS SF50 VISION JET FUEL SELECTOR **************************
******************************************************************************************
    Made by SIMSTRUMENTATION and Russ Barlow
    GitHub: https://simstrumentation.com

Fuel selector lever for the Vision Jet by FlightFX

Version info:
- **v1.1** - 2022-12-
    - Graphics update
    - Added backlighting
- **v1.0** - 2022-12-11
    - Original release

NOTES: 
- Made for the FlightFX Vision Jet. Will not work with other MSFS aircraft. 

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code and graphics from Russ Barlow. Used with permission. 

Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

img_add_fullscreen( "bg.png")
local tank = 0

function move_selector(position, direction)
	if tank== 0 then 
		if direction == 1 then
		    msfs_variable_write("L:SF50_FUEL_SELECTOR_AUTO", "Int",1)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_LEFT", "Int",0)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_RIGHT", "Int",0)
		end
		
	elseif tank == 1 then
		if direction == 1 then
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_AUTO", "Int",0)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_LEFT", "Int",0)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_RIGHT", "Int",1)
		else
		    msfs_variable_write("L:SF50_FUEL_SELECTOR_AUTO", "Int",0)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_LEFT", "Int",1)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_RIGHT", "Int",0)
		end
	else
		if direction == -1 then
		    msfs_variable_write("L:SF50_FUEL_SELECTOR_AUTO", "Int",1)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_LEFT", "Int",0)
                    msfs_variable_write("L:SF50_FUEL_SELECTOR_RIGHT", "Int",0)
		end
	end

end

--    backlight graphics to maintain z-order
backlight_labels = img_add_fullscreen("labels_backlight.png")
opacity(backlight_labels, 0)
fuel_sel_sw = switch_add( nil, nil, nil, 50,112,192,197, move_selector)
shadow = img_add("shadow.png" ,60,127,192,197)
fuel_lever = img_add("fuel_select.png" ,50,112,192,197)

function setFuelPosition(left, right, auto)
	if left == 1 then 
		rotate(fuel_lever, -30, 95, 130, 0, "LINEAR", 0.1, "DIRECT")
		rotate(shadow, -30, 95, 130, 0, "LINEAR", 0.1, "DIRECT")		
		tank = 0
	elseif right == 1 then 
		rotate(fuel_lever, 30, 95, 130, 0,"LINEAR", 0.1, "DIRECT")	
		rotate(shadow, 30, 95, 130, 0,"LINEAR", 0.1, "DIRECT")	
		tank = 2
	elseif auto == 1 then 
		rotate(fuel_lever, 0, 95, 130, 0,"LINEAR", 0.1, "DIRECT")
		rotate(shadow, 0, 95, 130, 0,"LINEAR", 0.1, "DIRECT")
		tank = 1
	end
	switch_set_position( fuel_sel_sw, tank)
end
msfs_variable_subscribe("L:SF50_fuel_selector_left", "Number",
                                              "L:SF50_fuel_selector_right", "Number",
                                              "L:SF50_fuel_selector_auto", "Number", 
                                              setFuelPosition)

-- backlight
function lightPot(val, panel, pot, power)
    lightKnob = val
    panelLight = panel
    if power  then
        opacity(backlight_labels, (pot/100), "LOG", 0.1)  
    end
end

msfs_variable_subscribe("L:LIGHTING_PANEL_1", "Number",
                                                "A:LIGHT PANEL:1", "Bool", 
                                                "A:LIGHT POTENTIOMETER:3", "Percent", 
                                                "A:ELECTRICAL MASTER BATTERY", "Bool",
                                                 lightPot)