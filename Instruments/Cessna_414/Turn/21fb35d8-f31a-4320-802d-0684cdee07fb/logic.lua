--[[
******************************************************************************************
*********CESSNA 414AW CHANCELLOR RPM TURN AND SLIP COORDINATOR********
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Turn and slip coordinator for the Cessna 414AW Chancellor by FlySimware

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

--LOCAL VARIABLES
local ballCenterX = 300
local ballCenterY = 480
local ballSize = 66
local trackCenterY = -100
local trackRadius = 580
local ballpos = 0

local turnCenterX = 300
local turnCenterY = 502
local turnRadius = 290

--ADD GRAPHICS
img_add_fullscreen("bg.png")
ball_id=img_add("ball.png", ballCenterX - ballSize/2, ballCenterY - ballSize/2, ballSize, ballSize)
ball_3d_id=img_add("sphere_effect.png", ballCenterX - ballSize/2, ballCenterY - ballSize/2, ballSize, ballSize)

img_add_fullscreen("dial_face.png")

needle_shadow_id = img_add("needle_shadow.png", 10, 10, 600, 600)
needle_id = img_add_fullscreen("needle.png")
yd_id = img_add_fullscreen("yd_indicator_on.png")
gyro_id = img_add_fullscreen("gyro_indicator_on.png")
img_add("ball_track_glass_cover.png", -10, -40, 620, 650)
img_add_fullscreen("cage.png")

    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle_left = img_add("needle.png", -5, -5, 600, 600)   
    opacity(reflect_needle_left, 0.08)

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
    math.randomseed(os.clock()*300000000000)
    rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end    


--Temporary construction lines
--[[
ballTrackRange_id = canvas_add(0, 0, 600,600, function()
  _circle(ballCenterX, trackCenterY, trackRadius-ballSize/2)
  _circle(ballCenterX, trackCenterY, trackRadius)
  _circle(ballCenterX, trackCenterY, trackRadius+ballSize/2)
  _stroke("red",1)
  end)

turnRange_id = canvas_add(0, 0, 600,600, function()
  _circle(turnCenterX, turnCenterY, turnRadius-20)
  _circle(turnCenterX, turnCenterY, turnRadius)
  _stroke("green",1)
  end)
--End temporary construction lines
]]--
function new_ball_callback(pos,turn,suction, yd)
    pos = var_cap(pos, -8.1, 8.1)
    ballpos = -(10*(pos * 360/256)) + 90
    slip_rad = math.rad(ballpos)
    x = (ballCenterX - ballSize/2) + ((trackRadius - ballSize/2) * math.cos(slip_rad))
    y = (ballCenterY - ballSize/2) + ((trackRadius - ballSize/2) * (1-math.sin(slip_rad)))*(-1)
    deltaS = (slip_rad - (math.pi)/2) * (trackRadius+ballSize/2)
    rotation = (360 * deltaS) / (2 * math.pi *(ballSize/2))
    move(ball_id, x, y,ballSize,ballSize, "LOG", 0.1)
    move(ball_3d_id, x, y,ballSize,ballSize, "LOG", 0.1)
    rotate(ball_id, (-1)*rotation, "LOG", 0.1)
    rotate(needle_id, var_cap(turn, -0.135, 0.135) * 170, turnCenterX, turnCenterY, nil, "LOG", 0.1, "DIRECT")
    rotate(needle_shadow_id, var_cap(turn, -0.135, 0.135) * 170, turnCenterX, turnCenterY, nil, "LOG", 0.1, "DIRECT")
    rotate(reflect_needle_left, var_cap(turn, -0.135, 0.135) * 170, turnCenterX, turnCenterY, nil, "LOG", 0.1, "DIRECT")
           
    if suction >= 2.3 then
        visible(gyro_id, 0)
    else
        visible(gyro_id, 1)
    end
    if yd == 1 then
        visible(yd_id, 0)
    else
        visible(yd_id, 1)
    end
      
end

fs2020_variable_subscribe("TURN COORDINATOR BALL", "Position", -- -127 to +127
                          "TURN INDICATOR RATE", "Radians", -- radians per second
                          "SUCTION PRESSURE", "inhg", -- flag goes off at less than 2.3
                          "AUTOPILOT YAW DAMPER", "Number", new_ball_callback)