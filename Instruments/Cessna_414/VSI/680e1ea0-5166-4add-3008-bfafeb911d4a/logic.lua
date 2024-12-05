--[[
******************************************************************************************
***************CESSNA 414AW CHANCELLOR VERTICAL SPEED INDICATOR***********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Vertical speed indicator for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- None

ATTRIBUTION:
Code and graphics by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************
img_add_fullscreen("nub.png")
img_add_fullscreen("dial_face.png")

local majorTickStartAngle = 0 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
local majorTickSpace = 28.5 --degrees between major ticks
local majorTickOD = 530 -- outer diameter of circle that terminates major tick marks
local majorTickLength = 72-- length of major tick marks
local majorTickQuantity = 7 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
local majorTickMirror = true -- mirror major tick marks?
local majorTickThickness = 8 -- pixel width of major tick line

local minorTickOD = 530 -- outer diameter of circle that terminates minor tick marks
local minorTickLength = 47 -- length of minor tick marks
local minorTicksPerMajor = 5 -- how many minor tick divisions between major ticks
local minorTicksGroups = 2 -- how many groups of minor ticks (before mirroring)
local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
local minorTickMirror = true -- mirror minor tick marks?
local minorTickThickness = 6 -- pixel width of minor tick line

local majorTickColor = "white"
local minorTickColor = "white"

minorTick_id = canvas_add(0, 0, 600, 600)
canvas_draw(minorTick_id, function()
  for i=1,minorTickQuantity do
      _rotate(minorTickSpace)
      _move_to((600-minorTickOD)/2, 300)
      _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
      _stroke(minorTickColor, minorTickThickness)
  end
  if minorTickMirror then
      _rotate((-1)*(minorTickQuantity*minorTickSpace) + minorTickSpace)
      for i=1,minorTickQuantity do
          _rotate(-minorTickSpace)
          _move_to((600-minorTickOD)/2, 300)
          _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
          _stroke(minorTickColor, minorTickThickness)
      end
  end
end)
rotate(minorTick_id, -minorTickSpace + majorTickStartAngle)

majorTick_id = canvas_add(0, 0, 600, 600)
canvas_draw(majorTick_id, function()
    for i=1,majorTickQuantity do
        _rotate(majorTickSpace)
        _move_to((600-majorTickOD)/2, 300)
        _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
        _stroke(majorTickColor, majorTickThickness)
    end
    if majorTickMirror then
        _rotate((-1)*(majorTickQuantity*majorTickSpace) + (majorTickSpace * 2))
        for i=1,majorTickQuantity do
            _rotate(-majorTickSpace)
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
        end
    end
end)
rotate(majorTick_id, -majorTickSpace + majorTickStartAngle)

-- Add the connector between the 3000 tick marks
majorTickConnector_id = canvas_add(0, 0, 600, 600)
canvas_draw(majorTickConnector_id, function()
    _move_to(492, 266)
    _line_to(492, 334)
    _stroke(majorTickColor, majorTickThickness)
end)


img_needle_shadow = img_add("needle_shadow.png", 60, 60, 500, 500)
img_needle = img_add("needle.png", 50, 50, 500, 500)


    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle = img_add("needle.png", 40, 40, 500, 500)   
    opacity(reflect_needle, 0.08)

     --glass glare
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)    
end    

    --outer bezel frame 
img_add("bezel.png", -1, -1, 600, 600)

    -- show bezel screws if user prop selected. Screw rotation is randomized
if user_prop_get(showScrews ) then  
    screw_tl_id = img_add("screw.png", 34, 34, 70, 70)
    math.randomseed(os.clock()*100000000000)
    rotate(screw_tl_id, math.random(1,360))
    screw_tr_id = img_add("screw.png", 496, 34, 70, 70)
    math.randomseed(os.clock()*200000000000)
    rotate(screw_tr_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end    


-- FUNCTIONS
function new_data(vspeed)

    vspeed = var_cap(vspeed, -3000, 3000)

    rotate(img_needle, 57 / 1000 * (vspeed))
    rotate(img_needle_shadow, 57 / 1000 * (vspeed))
    rotate(reflect_needle, 57 / 1000 * (vspeed))
end

-- DATA BUS SUBSCRIBE
msfs_variable_subscribe("VERTICAL SPEED", "Feet per minute", new_data)