--[[
**************************************************************************************
************CESSNA 414 CHANCELLOR DIGITAL ALTITUDE ALERTER  **************
**************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Digital altitude alterter / preselector panel for the Cessna 414 Chancellow by FlySimware

Version info:
- **v1.01** - 2022-10-22
    - Fixed compatibility with non-WTT versions of the plane
    
- **v1.0** - 2022-10-15
    - Original release
    
NOTES: 
- Designed for the C414 Chancellor. May work with other planes, but compatibility not guaranteed nor supported. 
- BONUS FEATURE: Includes a press on the alt knob to square up the heading bug

KNOWN ISSUES:
- None
    
ATTRIBUTION:
All code and artwork  are original creations by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--
--LOCAL VARIABLES
local alerter_armed = 0

--GRAPHICS

img_face = img_add_fullscreen("bg.png")
txt_select = txt_add("0000", "size:70px; color:red; halign:right", 110, 44, 300, 100)
txt_bg= txt_add("8888888", "size:70px; color:red; halign:right", 110, 44, 300, 100)
opacity(txt_bg, 0.15)
opacity(txt_select, 0)

--emissive_arm = img_add("light_amber.png", 75, 113, 30, 30)  


--FUNCTIONS
function knobTurnOuter(dir)
    if (dir) == 1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt + 1000)     --for WTT verison
        fs2020_event("AP_ALT_VAR_INC")                                                   --for non-WTT version
    elseif(dir) == -1 then
        fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt - 1000)     --for WTT verison
        fs2020_event("AP_ALT_VAR_DEC")                                                  --for non-WTT version
    end
    dial_click_rotate(knob_outer, 5)
end

function knobTurnInner(dir)
    if (dir) == 1 then
       fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt + 100)    --for WTT verison
       fs2020_event("AP_ALT_VAR_INC")                                                 --for non-WTT version
    elseif(dir) == -1 then
       fs2020_event("AP_ALT_VAR_SET_ENGLISH", current_alt - 100)        --for WTT verison
       fs2020_event("AP_ALT_VAR_DEC")                                                    --for non-WTT version
    end
    dial_click_rotate(knob_inner, 5)
end

function btn_hdg()
    fs2020_event("HEADING_BUG_SET", current_hdg)
end

--[[
-- FSW removed the ARM button from the alerter. Leaving this here in case it's brought back.
function arm_pressed()
    fs2020_event("H:APGA_ARM")
end

button_id = switch_add("arm_btn.png", "arm_btn_pressed.png", 96,142,86,48, arm_pressed)
]]--



knob_outer_shadow = img_add("knob_shadow.png", 400, 138, 155, 130)
rotate(knob_outer_shadow, 45)
opacity(knob_outer_shadow, 0.5)
knob_outer = dial_add("knob_outer.png", 390, 118, 125, 125, knobTurnOuter)
knob_inner = dial_add("knob_inner.png", 390, 118, 125, 125, knobTurnInner)
button_add(nil,nil, 390, 118, 125, 125,btn_hdg)

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
fs2020_variable_subscribe("L:Garmin_Alerter_Code", "Number",
                                              "AUTOPILOT ALTITUDE LOCK VAR", "Feet",  
                                              setvalues)

               
                            -- simvar subscriptions for ALT and HDG
fs2020_variable_subscribe("AUTOPILOT ALTITUDE LOCK VAR", "Feet", 
                          "PLANE HEADING DEGREES MAGNETIC", "Degrees", 
                          function(ap_alt, heading)
                              current_alt = ap_alt
                              current_hdg = math.floor(heading + 0.5) 
                          end
                        )             
function setpowerstate(bus_volts, avionics_on)

    if bus_volts > 14 and avionics_on == true  then
        opacity(txt_select,1.0, "LOG", 0.04)
    else
        opacity(txt_select, 0, "LOG", 0.04)
    end
end

--VARIABLE SUBCRIPTIONS
fs2020_variable_subscribe("ELECTRICAL MAIN BUS VOLTAGE", "Volts", 
                          "AVIONICS MASTER SWITCH", "Bool", 
                           setpowerstate)           
                            
                                                                                                         
