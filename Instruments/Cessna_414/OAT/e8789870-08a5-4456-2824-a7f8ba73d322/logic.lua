--[[
******************************************************************************************
**********CESSNA 414AW CHANCELLOR OUTSIDE AIR TEMPERATURE GAUGE********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

OAT gauge for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on an instrument by Snake Stack Simulations. Other code and graphics by Simstrumentation
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

--LOCAL VARS
local text_format_string = "font:MS33558.ttf; size:12; color:white; halign:center;"
local scale = 1.55
local vertOffset = 150 -- TO MATCH THE VC, USE 130, BUT 150 GIVES MORE ROOM FOR NUMBERS ON TOP!!!
local majorTickStartAngle = 90 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
local majorTickSpace = 18 --degrees between major ticks
local majorTickOD = 536 -- outer diameter of circle that terminates major tick marks
local majorTickLength = 32-- length of major tick marks
local majorTickQuantity = 3 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
local majorTickMirror = true -- mirror major tick marks?
local majorTickThickness = 10 -- pixel width of major tick line
local minorTickOD = majorTickOD -- outer diameter of circle that terminates minor tick marks
local minorTickLength = 15 -- length of minor tick marks
local minorTicksPerMajor = 2 -- how many minor tick divisions between major ticks
local minorTicksGroups = 2 -- how many groups of minor ticks (before mirroring)
local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
local minorTickMirror = true -- mirror minor tick marks?
local minorTickThickness = 6 -- pixel width of minor tick line
local majorTickColor = "#2c91d3" -- the light blue color.  Pick another one if you want.
local minorTickColor = "#2c91d3"

--BACKGROUND IMAGE
    --   other images are added further down to maintain correct z-order
img_add_fullscreen("blank_face.png")

--TEMPERATURE SCALE DRAW
    --Construction stuff -- This is the little red cross at the bottom, which is the center of the arc
arcCenter_id = canvas_add(-20,vertOffset-20, 640,640)
canvas_draw(arcCenter_id, function()
    _move_to(300,320)
    _line_to(340,320)
    _move_to(320,300)
    _line_to(320,340)
    _stroke("red",1)
end)
--End Construction Stuff
   
    -- Celcius scale
minorTick_id = canvas_add(-20,vertOffset-20, 640,640)
canvas_draw(minorTick_id, function()
  for i=1,minorTickQuantity do
      _rotate(minorTickSpace)
      _move_to((640-minorTickOD)/2, 320)
      _line_to(((640-minorTickOD)/2)+ minorTickLength, 320)
      _stroke(minorTickColor, minorTickThickness)
  end
  if minorTickMirror then
      _rotate((-1)*(minorTickQuantity*minorTickSpace) + minorTickSpace)
      for i=1,minorTickQuantity do
          _rotate(-minorTickSpace)
          _move_to((640-minorTickOD)/2, 320)
          _line_to(((640-minorTickOD)/2)+ minorTickLength, 320)
          _stroke(minorTickColor, minorTickThickness)
      end
  end
end)
rotate(minorTick_id, -minorTickSpace + majorTickStartAngle)

majorTick_id = canvas_add(-20,vertOffset-20, 640,640)
canvas_draw(majorTick_id, function()
    for i=1,majorTickQuantity do
        _rotate(majorTickSpace)
        _move_to((640-majorTickOD)/2, 320)
        _line_to(((640-majorTickOD)/2)+ majorTickLength, 320)
        _stroke(majorTickColor, majorTickThickness)
    end
    if majorTickMirror then
        _rotate((-1)*(majorTickQuantity*majorTickSpace) + (majorTickSpace * 2))
        for i=1,majorTickQuantity do
            _rotate(-majorTickSpace)
            _move_to((640-majorTickOD)/2, 320)
            _line_to(((640-majorTickOD)/2)+ majorTickLength, 320)
            _stroke(majorTickColor, majorTickThickness)
        end
    end
end)
rotate(majorTick_id, -majorTickSpace + majorTickStartAngle)

-- Freedom units scale
majorTickStartAngle = ((majorTickSpace/20)*(5/9) * (-32)) + majorTickStartAngle -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
majorTickSpace = (5/2)*majorTickSpace*5/9 --degrees between major ticks
majorTickOD = 625 -- outer diameter of circle that terminates major tick marks
majorTickLength = 40-- length of major tick marks
majorTickQuantity = 3 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
majorTickMirror = true -- mirror major tick marks?
majorTickThickness = 10 -- pixel width of major tick line
minorTickOD = majorTickOD - 30 -- outer diameter of circle that terminates minor tick marks
minorTickLength = 24 -- length of minor tick marks
minorTicksPerMajor = 5 -- how many minor tick divisions between major ticks
minorTicksGroups = 2.6 -- how many groups of minor ticks (before mirroring)
minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
minorTickMirror = true -- mirror minor tick marks?
minorTickThickness = 6 -- pixel width of minor tick line

majorTickColor = "white"
minorTickColor = "white"

minorTick_id2 = canvas_add(-20,vertOffset-20, 640,640)
canvas_draw(minorTick_id2, function()
  for i=1,minorTickQuantity do
      _rotate(minorTickSpace)
      _move_to((640-minorTickOD)/2, 320)
      _line_to(((640-minorTickOD)/2)+ minorTickLength, 320)
      _stroke(minorTickColor, minorTickThickness)
  end
  if minorTickMirror then
      _rotate((-1)*(minorTickQuantity*minorTickSpace) + minorTickSpace)
      for i=1,5 do
          _rotate(-minorTickSpace)
          _move_to((640-minorTickOD)/2, 320)
          _line_to(((640-minorTickOD)/2)+ minorTickLength, 320)
          _stroke(minorTickColor, minorTickThickness)
      end
  end
end)
rotate(minorTick_id2, -minorTickSpace + majorTickStartAngle)

majorTick_id2 = canvas_add(-20,vertOffset-20, 640,640)
canvas_draw(majorTick_id2, function()
    for i=1,majorTickQuantity do
        _rotate(majorTickSpace)
        _move_to((640-majorTickOD)/2, 320)
        _line_to(((640-majorTickOD)/2)+ majorTickLength, 320)
        _stroke(majorTickColor, majorTickThickness)
    end
    if majorTickMirror then
        _rotate((-1)*(majorTickQuantity*majorTickSpace) + (majorTickSpace * 2))
        for i=1,2 do
            _rotate(-majorTickSpace)
            _move_to((640-majorTickOD)/2, 320)
            _line_to(((640-majorTickOD)/2)+ majorTickLength, 320)
            _stroke(majorTickColor, majorTickThickness)
        end
    end
end)
rotate(majorTick_id2, -majorTickSpace + majorTickStartAngle)

    -- Draw arc
arc_id = canvas_add(-20,vertOffset-20, 640,640)
canvas_draw(arc_id, function()
    _arc(320, 320, 180 - majorTickSpace + majorTickStartAngle - 1.1, 180 + (2.4*majorTickSpace) + majorTickStartAngle + 0.8, (majorTickOD/2)-majorTickLength)
    _stroke("majorTickColor", 10)

end)
rotate(majorTick_id2, -majorTickSpace + majorTickStartAngle)
-- End tick marks and arc

    --temp scale text
    --    Freedom Units
txt_deg_label =txt_add("º", "font:roboto_regular.ttf; size:46; color: white; halign:center;",240, 40,90,90)        
txt_F_label =txt_add("F", "font:MS33558.ttf; size:36; color: white; halign:center;",260, 50,90,90)    
txt_m50 = txt_add("-", "font:	roboto_regular.ttf; size:46; color: white; halign:center;",60, 176,90,90)   
rotate(txt_m50 , -33) 
txt_m50f = txt_add("50", "font:MS33558.ttf; size:36; color: white; halign:center;",95, 160,90,90)
rotate(txt_m50f , -33)
txt_0f = txt_add("0", "font:MS33558.ttf; size:36; color: white; halign:center;",172, 112,90,90)
rotate(txt_0f, -14)
txt_50f = txt_add("50", "font:MS33558.ttf; size:36; color: white; halign:center;",305, 108,90,90)
rotate(txt_50f, 14)
txt_100f = txt_add("100", "font:MS33558.ttf; size:36; color: white; halign:center;",415, 154,110,110)
rotate(txt_100f , 33)

    --    Celcius
txt_m40 = txt_add("-", "font:	roboto_regular.ttf; size:46; color: #2c91d3; halign:center;",100, 250,110,110)   
txt_m40c = txt_add("40", "font:MS33558.ttf; size:36; color: #2c91d3; halign:center;",130, 260,110,110)
txt_m20 = txt_add("-", "font:	roboto_regular.ttf; size:46; color: #2c91d3; halign:center;",160, 225,110,110)   
txt_m20c = txt_add("20", "font:MS33558.ttf; size:36; color: #2c91d3; halign:center;",190, 230,110,110)
txt_0c = txt_add("0", "font:MS33558.ttf; size:36; color: #2c91d3; halign:center;",248, 216,110,110)
txt_20c = txt_add("20", "font:MS33558.ttf; size:36; color: #2c91d3; halign:center;",325, 230,110,110)
txt_40c = txt_add("40", "font:MS33558.ttf; size:36; color: #2c91d3; halign:center;",386, 260,110,110)
        
--ADD REMAINING GRAPHICS
    --needle
img_needle_shadow = img_add("needle_shadow.png", 276,180, 65, 550)
img_needle = img_add("needle.png", 263,170, 65, 550)

if user_prop_get(showBezelGlare )then
    -- if bezel glass and reflection is on
    reflect_needle = img_add("needle.png", 261,165, 65, 550)   
    opacity(reflect_needle, 0.08)
end

img_cover_id = img_add("cover.png", -3, 1, 600, 600)
    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
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
    screw_bl_id = img_add("screw.png", 34, 500, 70, 70)
    math.randomseed(os.clock()*200000000000)
    rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end    

--ANIMATE NEEDLE

function new_OAT(tempc)
   rotate(img_needle, (tempc *(18/20)), "LINEAR", 0.04) -- this is (or should be) the correct rotation but need to work out the center offset of the needle once you get the graphics
   rotate(img_needle_shadow, (tempc *(18/20)), "LINEAR", 0.04)
   rotate(reflect_needle, (tempc *(18/20)), "LINEAR", 0.04)
end

-- VARIABLE SUBSCRIBE
fs2020_variable_subscribe("AMBIENT TEMPERATURE", "Celsius", new_OAT)