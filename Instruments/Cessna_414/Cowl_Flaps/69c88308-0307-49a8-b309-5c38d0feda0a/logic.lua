--[[
******************************************************************************************
***************CESSNA 414AW CHANCELLOR COWL FLAP CONTROLS ***********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Vertical speed indicator for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- User property can select to show or hide the background
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- On flight restart, there may be a sync loss between the plane and instrument. Activating
   the instrument in the virtual cockpit will re-sync

ATTRIBUTION:
Code and graphics by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBackplate = user_prop_add_boolean("Show backplate", true, "Choose whether to see the dark background")

if user_prop_get(showBackplate ) then
    img_add_fullscreen("backplate.png")
end

--********************************************* END USER PROPERTY CONFIG*********************************************
--LOCAL VARIABLES
local cowl_l_val
local cowl_r_val
img_add_fullscreen("bg.png")

--ADD GRAPHICS
shadow_l_id = img_add("shadow.png", 95, 195, 250, 74)
opacity(shadow_l_id, .5)
lever_l_id = img_add("lever.png", 76, 175, 250, 74)
shadow_r_id = img_add("shadow.png", 495, 195, 250, 74)
opacity(shadow_r_id, .5)
lever_r_id = img_add("lever.png", 476, 175, 250, 74)

--LEFT COWL EVENT
function toggle_cowl_l()
   if cowl_l_val ==  0 then
        fs2020_variable_write("RECIP ENG COWL FLAP POSITION:1", "Percent", 100)
    elseif cowl_l_val == 100 then
        fs2020_variable_write("RECIP ENG COWL FLAP POSITION:1", "Percent", 0)
   end
end
lever_btn = button_add(nil, nil, 76, 120, 250, 250, toggle_cowl_l)

--LEFT COWL FLAP ANIMATION

function getLCowl(pos)
    cowl_l_val = pos
    if pos == 0 then
        rotate(lever_l_id, -90, "LINEAR", 0.04)
        rotate(shadow_l_id, -90, "LINEAR", 0.04)
        timer_start(400, function()move(lever_l_id, 40, 200, 278, 85, "LINEAR", 0.04) move(shadow_l_id, 95, 200, 278, 85, "LINEAR", 0.04) end)
    elseif pos == 100 then
        move(lever_l_id, 76, 175, 250, 74)
        move(shadow_l_id, 95, 195, 250, 74)
        timer_start(400, function()rotate(lever_l_id, 0, "LINEAR", 0.04) rotate(shadow_l_id, 0, "LINEAR", 0.04) end)
    end
end

fs2020_variable_subscribe("A:RECIP ENG COWL FLAP POSITION:1", "Percent", getLCowl)

--RIGHT COWL EVENT
function toggle_cowl_r()
   if cowl_r_val ==  0 then
        fs2020_variable_write("RECIP ENG COWL FLAP POSITION:2", "Percent", 100)
    elseif cowl_r_val == 100 then
        fs2020_variable_write("RECIP ENG COWL FLAP POSITION:2", "Percent", 0)
   end
end
lever_btn = button_add(nil, nil, 476, 120, 250, 250, toggle_cowl_r)

--RIGHT COWL FLAP ANIMATION

function getRCowl(pos)
    cowl_r_val = pos
    if pos == 0 then
        rotate(lever_r_id, -90, "LINEAR", 0.04)
        rotate(shadow_r_id, -90, "LINEAR", 0.04)
        timer_start(400, function()move(lever_r_id, 436, 200, 278, 85, "LINEAR", 0.04) move(shadow_r_id, 495, 200, 278, 85, "LINEAR", 0.04) end)
    elseif pos == 100 then
        move(lever_r_id, 476, 175, 250, 74, "LINEAR", 0.04)
        move(shadow_r_id, 495, 195, 250, 74, "LINEAR", 0.04)
        timer_start(400, function()rotate(lever_r_id, 0, "LINEAR", 0.04) rotate(shadow_r_id, 0, "LINEAR", 0.04) end)
    end
end
fs2020_variable_subscribe("A:RECIP ENG COWL FLAP POSITION:2", "Percent", getRCowl)