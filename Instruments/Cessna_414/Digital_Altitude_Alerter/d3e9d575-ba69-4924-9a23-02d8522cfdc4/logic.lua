--[[
**************************************************************************************
***************CESSNA 414 CHANCELLOR ALTITUDE ALERTER  ********************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

Digital altitude alterter / preselector panel for the Cessna 414 Chancellow by FlySimware

Version info:

- **v1.0** (2020-05-22)
    - Original release
    
NOTES: 
- Will only work with the Flysimware Cessna 414 Chancellor
- Currently in ßETA / Early access. Please report any issues on our Discord server. 

KNOWN ISSUES:
- None
    
ATTRIBUTION:
All code and artwork  are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

img_face = img_add_fullscreen("bg.png")

txt_select = txt_add("0000", "size:70px; color:red; halign:right", 110, 44, 300, 100)
txt_bg= txt_add("8888888", "size:70px; color:red; halign:right", 110, 44, 300, 100)
opacity(txt_bg, 0.15)
emissive_arm = img_add("light_amber.png", 75, 113, 30, 30)  

-- global variables
local alerter_armed = 0

--FUNCTIONS
function knobTurnOuter(dir)
    if (dir) == 1 then
        fs2020_event("H:KNOB_ALT_SEL_1000_INC")
    elseif(dir) == -1 then
        fs2020_event("H:KNOB_ALT_SEL_1000_DEC")
    end
    dial_click_rotate(knob_outer, 5)
end

function knobTurnInner(dir)
    if (dir) == 1 then
        fs2020_event("H:KNOB_ALT_SEL_100_INC")
    elseif(dir) == -1 then
        fs2020_event("H:KNOB_ALT_SEL_100_DEC") 
    end
    dial_click_rotate(knob_inner, 5)
end

function arm_pressed()
    if alerter_armed == 1 then 
            alerter_armed = 0
            fs2020_variable_write("L:Alt_Arm_Switch", "Number", 0)
        else
            alerter_armed = 1
            fs2020_variable_write("L:Alt_Arm_Switch", "Number", 1)
        end
end

button_id = switch_add("arm_btn.png", "arm_btn_pressed.png", 96,142,86,48, arm_pressed)
knob_outer = dial_add("knob_outer.png", 390, 118, 125, 125, knobTurnOuter)
knob_inner = dial_add("knob_inner.png", 390, 118, 125, 125, knobTurnInner)


function setvalues(armed, altSelected)
    if armed == 1 then
        alerter_armed = 1
        visible(emissive_arm, true)
        switch_set_position(button_id, 1)
    else
        alerter_armed = 0
        visible(emissive_arm, false)
        switch_set_position(button_id,0)
    end   
    txt_set(txt_select, string.format("%04.0f", altSelected) )    
end

-- Variable Subscription
fs2020_variable_subscribe("L:Alt_Arm_Switch", "Number",
                                              "L:Garmin_Alerter_Code", "Feet",  
                                              setvalues)
