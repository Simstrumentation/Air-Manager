--[[
******************************************************************************************
**********************CESSNA 414AW CHANCELLOR CABIN RATE***********************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Cabin pressure vertical speed rate for the  Cessna 414AW Chancellor

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed


KNOWN ISSUES:
- None

ATTRIBUTION:
Based on an instrument by Sim Innovations. Graphics and extra coding by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************
]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************
-- Add images --
img_add_fullscreen("blank_face.png")
--orig = img_add_fullscreen("bg.png")
--opacity(orig, 0.4)

-- Color Definitions
--customGreen = "green"
--local customGreen = "#00ff00"
--customRed = "#B8350D"
customWhite = "white"
--customYellow = "#F2CB2F"
customBlue = "#329EF6"

-- Fonts
font_cabin = "size:40px; font:MS33558.ttf; color:"..customWhite.."; halign:center;"
font_rateNum = "size:44px; font:MS33558.ttf; color:"..customWhite.."; halign:left;valign:center"
font_rate_pt = "size:44px; font:inconsolata_bold.ttf; color:"..customWhite.."; halign:left;valign:center"
font_ftmin = "size:32px; font:MS33558.ttf; color:"..customBlue.."; halign:center;valign:center"

local majorTickStartAngle = 0 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
local majorTickSpace = 24.5 --degrees between major ticks
local majorTickOD = 530 -- outer diameter of circle that terminates major tick marks
local majorTickLength = 40-- length of major tick marks
local majorTickQuantity = 8 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
local majorTickMirror = true -- mirror major tick marks?
local majorTickThickness = 7 -- pixel width of major tick line

local minorTickOD = 530 -- outer diameter of circle that terminates minor tick marks
local minorTickLength = 22 -- length of minor tick marks
local minorTicksPerMajor = 5 -- how many minor tick divisions between major ticks
local minorTicksGroups = 2 -- how many groups of minor ticks (before mirroring)
local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
local minorTickMirror = true -- mirror minor tick marks?
local minorTickThickness = 5 -- pixel width of minor tick line

local majorTickColor = customWhite
local minorTickColor = customWhite

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

minorTickQuantity2 = 14
minorTickSpace2 = minorTickSpace * 5/2
minorTick_id2 = canvas_add(0, 0, 600, 600, function()
  for i=1,minorTickQuantity2 do
      _rotate(minorTickSpace2)
      if i >= 5 then
          _move_to((600-minorTickOD)/2, 300)
          _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
          _stroke(minorTickColor, minorTickThickness)
      end
  end
  if minorTickMirror then
      _rotate((-1)*(minorTickQuantity2*minorTickSpace2) + minorTickSpace2)
      for i=1,minorTickQuantity2 do
          _rotate(-minorTickSpace2)
      if i >= 5 then
          _move_to((600-minorTickOD)/2, 300)
          _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
          _stroke(minorTickColor, minorTickThickness)
      end
      end
  end
end)
rotate(minorTick_id2, -minorTickSpace2 + majorTickStartAngle)

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
    _arc(300,300,352,8,246)
    _stroke(majorTickColor, majorTickThickness)
end)

    rate0 = txt_add("0", font_rateNum, 90, 250, 100, 100)
    rate_pt = txt_add(".", font_rate_pt, 96, 175, 100, 100)
    rate5 = txt_add("5", font_rateNum, 112, 175, 100, 100)
    rate1 = txt_add("1", font_rateNum, 164, 100, 100, 100)
    rate2 = txt_add("2", font_rateNum, 236, 62, 100, 100)
    rate4 = txt_add("4", font_rateNum, 394, 84, 100, 100)
    rate6 = txt_add("6", font_rateNum, 490, 250, 100, 100)
    
    nrate_pt = txt_add(".", font_rate_pt, 96, 330, 100, 100)
    nrate5 = txt_add("5", font_rateNum, 112, 330, 100, 100)
    nrate1 = txt_add("1", font_rateNum, 164, 400, 100, 100)
    nrate2 = txt_add("2", font_rateNum, 236, 438, 100, 100)
    nrate4 = txt_add("4", font_rateNum, 394, 414, 100, 100)

    cabin_txt = txt_add("CABIN", font_cabin, 200, 196, 200, 200)
    ftmin_txt = txt_add("FT/MIN", font_ftmin, 200, 262, 200, 200)
    x1000_txt = txt_add("X 1000", font_ftmin, 200, 300, 200, 200)




shadow_needle_id = img_add("needle_shadow.png", 30, 30, 560, 560)
opacity(shadow_needle_id, 0.5)
needle_id = img_add("vsineedle.png", 20, 20, 560, 560)

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle_id = img_add("vsineedle.png", 15, 15, 560, 560)
    opacity(reflect_needle_id, 0.08)
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)    
end    


    --outer bezel
img_add_fullscreen("bezel.png")    

    -- show bezel screws if user prop selected. Screw rotation is randomized
if user_prop_get(showScrews ) then  
    screw_tl_id = img_add("screw.png", 34, 34, 70, 70)
    math.randomseed(os.clock()*100000000000)
    rotate(screw_tl_id, math.random(1,360))
    screw_tr_id = img_add("screw.png", 496, 34, 70, 70)
    math.randomseed(os.clock()*200000000000)
    rotate(screw_tr_id, math.random(1,360))
    screw_bl_id = img_add("screw.png", 34, 500, 70, 70)
    math.randomseed(os.clock()*300000000000)
    rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end   

--    lookup table for non-linear gauge
local table = {{-100000,-24.5*7},
               {-6000,-24.5*7},
               {-1000,-24.5*2},
               {0,0},
               {1000,24.5*2},
               {6000,24.5*7},
               {100000,24.5*7}}
           
function moveNeedle(rate)
    vspeed = var_cap(rate*60, -6000, 6000)
    --    rotate needle and shadow
    rotate(needle_id, interpolate_linear(table, vspeed), "LINEAR", 0.04)
    rotate(shadow_needle_id, interpolate_linear(table, vspeed), "LINEAR", 0.04)
    --    rotate needle reflection
    if user_prop_get(showBezelGlare )then
        rotate(reflect_needle_id, interpolate_linear(table, vspeed), "LINEAR", 0.04)
    end
end

msfs_variable_subscribe("A:PRESSURIZATION CABIN ALTITUDE RATE", "Feet", moveNeedle)