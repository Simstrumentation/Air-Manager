--[[
**************************************************************************************
***************CESSNA 414 CHANCELLOR AILERON TRIM KNOB  ******************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Aileron trim knob and indicator for the Cessna 414 Chancellow by FlySimware

Version info:
   
- **v1.0** (2 Nov, 2022)
    - Original release
    
NOTES: 
- Only guaranteed to  work with the Flysimware Cessna 414 Chancellor. May work
   in other aircraft but compatibility not guaranteed.
- Modelled after the instrument in the Flysimware C414AW

KNOWN ISSUES:

ATTRIBUTION:
All code, artwork and sound effects are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--
local knobPos = 0
local ailTrim

img_add_fullscreen("bg.png")

img_add_fullscreen("face.png")
indicator_id = img_add("Indicator.png",200, 42, 55, 57)
img_knob_shadow_id = img_add("knob_shadow.png", 76, 140, 310, 310)
opacity(img_knob_shadow_id, 0.5)
img_knob_id = img_add("knob.png", 56, 120, 310, 310)

function setTrim(direction)
    if direction == 1 and ailTrim <1 then
        knobPos = knobPos + 5
        
        fs2020_variable_write("A:AILERON TRIM PCT", "NUMBER", ailTrim + .02 )
    elseif direction == -1 and  ailTrim >-1 then
        knobPos = knobPos - 5
        fs2020_variable_write("A:AILERON TRIM PCT", "NUMBER", ailTrim - .02 )
    end
    rotate(img_knob_id,knobPos, "LINEAR", 0.05)
    rotate(img_knob_shadow_id,knobPos, "LINEAR", 0.05)
end


knob_turn_id=dial_add(nil, 160, 230, 100, 100, setTrim)



function setIndicator(trim)
     print (trim)
     ailTrim = trim
      newTrimVal= var_cap(trim, -1, 1)
      newIndicatorPos = (newTrimVal * 80) +190
      move(indicator_id, newIndicatorPos, 42, nil, nil)   
end

fs2020_variable_subscribe("AILERON TRIM PCT", "Number", setIndicator)