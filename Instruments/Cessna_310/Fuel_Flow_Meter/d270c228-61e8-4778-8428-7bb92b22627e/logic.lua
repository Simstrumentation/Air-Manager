--[[
--******************************************************************************************
--************************* Cessna 310R (Milviz) Fuel Flow Meter ***************************
--******************************************************************************************
    Made by Greg Jackson (Arathald) and SIMSTRUMENTATION

    GitHub: https://github.com/simstrumentation

    Fuel flow meter for Cessna 130R by Milviz

    NOTE:
        - Only guaranteed to work correctly with Milviz C130R

    V1.0 - Released 2022-05-15

    KNOWN ISSUES:
    - none
   --******************************************************************************************
--]]

---------------------------------------------
-- Add images --
---------------------------------------------
img_add_fullscreen("C310R_fuel_flow_face.png")
img_add_fullscreen("C310R_bezel.png")
local img_needle_left = img_add_fullscreen("C310R_needle_L.png")
local img_needle_right = img_add_fullscreen("C310R_needle_R.png")


---------------------------------------------
-- Calculate needle rotation --
-- The needle rotation isn't linear across the entire scale, so a simple rotation
-- doesn't work. However, it is linear or nearly so between each set of tick marks
-- (as measured in game), so we find the bounding tick marks then interpolate linearly
-- between them to find the angle
---------------------------------------------

-- Starting with the 5th tick, each entry corresponds to the flow when the needle
-- is centered on each tick (as measured in game), and the degrees of rotation from
-- the zero point as measured in this instrument
local ff_to_degrees_lut = {
  {50,  50},
  {56.81, 60},
  {67.45, 74.5},
  {78.89, 90},
  {89.53, 105},
  {99.77, 119.5},
  {110, 142},
  {120, 164},
  {130, 194},
  {140, 218.5},
  {150, 248},
  {160, 270}
}

function ff_to_degrees(ff)
  -- value can go to 190 but the needle stops at 160
  ff = var_cap(ff, 0, 160)

  -- Below 50 is linear and conveniently lines up perfectly with 1 degree
  -- from the zero point corresponding to 1 lb/hr
  if ff <= 50 then return ff
  else
    local prev_flow = 50
    for i, entry in ipairs(ff_to_degrees_lut) do
      local flow = entry[1]
      local offset = entry[2]

      -- walk through the LUT until finding a set of entries that bounds
      -- the current fuel flow
      if ff <= flow then
        local prev_entry = ff_to_degrees_lut[i - 1]
        local prev_flow = prev_entry[1]
        local prev_offset = prev_entry[2]

        -- find how far we are from the previous tick mark to the next one,
        -- expressed as a ratio (e.g. 0.5 for being halfway between)
        local flow_diff = flow - prev_flow
        local proportion_of_offset_diff = (ff - prev_flow) / flow_diff

        -- apply the same proportion to the difference in offsets to find the
        -- appropriate rotation angle (first from the previous tick, then from)
        -- the zero point
        local offset_diff = offset - prev_offset
        local offset_from_prev = offset_diff * proportion_of_offset_diff

        return prev_offset + offset_from_prev
      end
    end
  end
end


---------------------------------------------
-- Calculate needle rotation --
-- The needle rotation isn't linear across the entire scale, so a simple rotation
-- doesn't work. However, it is linear or nearly so between each set of tick marks
-- (as measured in game), so we find the bounding tick marks then interpolate linearly
-- between them to find the angle
---------------------------------------------
local zero_point_offset_degrees = -43

-- animation variables
local rotation_target_left = 0
local rotation_target_right = 0
local current_rotation_left = 0
local current_rotation_right = 0
local rotation_timer = timer_start(0, nil) -- initialize the timer

local timer_period = 33.33 -- 30 fps
local max_degrees_per_second = 40 -- hand tuned to closely match the in-game instrument
local prev_timer_tick

function set_flow(ff1, ff2)
    ff1 = var_cap(ff1, 0, 190)
    ff2 = var_cap(ff2, 0, 190)

    rotation_target_left = ff_to_degrees(ff1) + zero_point_offset_degrees
    rotation_target_right = ff_to_degrees(ff2) + zero_point_offset_degrees

    -- only start the timer when not already handling a rotation animation
    -- for efficiency, also don't start it when there's no rotation to handle
    if (rotation_target_left ~= current_rotation_left or rotation_target_right ~= current_rotation_right) and not timer_running(rotation_timer) then
      rotation_timer = timer_start(timer_period, timer_period, handle_rotation)
      prev_timer_tick = os.clock()
    end
end

-- the linear interpolation in Air Manager slows down as the needle nears its target,
-- so this instrument handles its own animation by capping the rotation speed
function handle_rotation()
  -- use the delta time so the rotation speed is constant if the timer period
  -- changes or the timer isn't precise
  local now = os.clock()
  local delta_time = now - prev_timer_tick
  prev_timer_tick = now

  local max_rotation = max_degrees_per_second * delta_time
  local rotation_delta_left = var_cap(rotation_target_left - current_rotation_left, max_rotation * -1, max_rotation)
  local rotation_delta_right = var_cap(rotation_target_right - current_rotation_right, max_rotation * -1, max_rotation)

  -- if done rotating, stop the timer
  if rotation_delta_left == 0 and rotation_delta_right == 0 then
    timer_stop(rotation_timer)
    prev_time = nil
  else
    -- update rotations
    current_rotation_left = current_rotation_left + rotation_delta_left
    current_rotation_right = current_rotation_right + rotation_delta_right

    rotate(img_needle_left, current_rotation_left)
    rotate(img_needle_right, current_rotation_right)
  end
end


---------------------------------------------
-- Bus subscribe --
---------------------------------------------
fs2020_variable_subscribe("L:C310_Fuel_Flow_Left", "Pounds per hour",
                          "L:C310_Fuel_Flow_Right", "Pounds per hour", set_flow)
