--[[
Illumination estimation based on sun position and aircraft altitude
By Todd "Toddimus831" Lorey
v1.3 10/5/2021
    Based loosely on an algorithm for home automation found here:
    https://www.domoticz.com/forum/viewtopic.php?f=59&t=19220
v1.4 10/10/2021
    Cleanup of code and addition of more commenting for sumbission to AM store
    
    *** PLEASE DO NOT STEAL OUR WORK.  GIVE CREDIT WHERE CREDIT IS DUE.  THANKS! ***    
]]--

-- Adjustable values
local okta0_vis_threshold = 4000 -- visibility in meters above which okta is set to 0
local okta8_vis_threshold = 200 -- visibility in meters below which okta is set to 8
local offset_minutes = 0 -- offset to either skew time forward or backward for sun calcs

local lux_scale_params =   	{ {150000  , 1      }, -- lookup table for linear interpolation of lux value to scaled lux value
				{  75000   , 0.8    }, -- 
				{  4000    , 0.6    }, -- 
				{  1000    , 0.40   }, -- 
				{  700     , 0.25   }, -- 
				{  450     , 0.06   }, -- 
				{  0       , 0.0005 }, -- 
				{  -100000 , 0      } } -- 

-- Initialize values -- DONT MESS AROUND BELOW HERE!!!!!!!
local latitude = 37	-- decimal degrees
local longitude = -121	-- decimal degrees
local altitude = 60	-- Meters above sea level.

local press_rel = 1011.5 -- sea level pressure in mb
local okta = 1 --  a measure of cloudiness and thereby obscuration of sunlight (range 0->8)
local visibility = nil
local function leapYear(year) -- determine if it's a leap year
	return year%4==0 and (year%100~=0 or year%400==0)
end
local year = 2021
local daynum = 263 -- the day this program was created 9/19/2021
local days_in_year = (leapYear(year) and 366 or 365)
local decimalTime = (os.date('!%H') + os.date('!%M') / 60) --(UTC)

-- Constants
local twilight_radiation = 6.4 --W/m²
local rotation_speed = 360/365.25 -- rotation of the earth in degrees per day

-- Interim calculation value initialization
local press_abs = press_rel - (altitude/ 8.3) -- in millibars  -- only a crude initial estimate which blows up above 8000m or so.  Will be overwritten by sim data

-- Main sun position and radiation calculation
function calculate()
	local init_radiation = 1361 * (1 + 0.034 * math.cos( math.rad( 360 * daynum / days_in_year ))) -- Sun radiation  (W/m²) at the entrance to the atmosphere.
	local sin_lat = math.sin(math.rad(latitude)) -- calculate commonly used values
	local cos_lat = math.cos(math.rad(latitude))
	local earth_radius = math.sqrt((((6378137^2)*cos_lat)^2 + ((6356752^2)*sin_lat)^2) / (((6378137)*cos_lat)^2 + ((6356752)*sin_lat)^2)) -- the radius of the earth at a given latitude.  Might be overkill and I don't know if MSFS actually uses this.
	local earth_latitude_radius = earth_radius * cos_lat -- the radius of the slice of earth along the latitude line
	local relative_horizon = math.deg(math.acos((earth_latitude_radius)/(earth_latitude_radius + (altitude * 1.5)))) -- (the 1.5 is a fudge factor) the downward angle of the horizon as you go up in altitude.  More accurate at equator, not accurate at poles.
	local declination = math.deg(math.asin(0.3978 * math.sin(math.rad(rotation_speed) *(daynum - (81 - 2 * math.sin((math.rad(rotation_speed) * (daynum - 2)))))))) -- sun's declination angle
	local sin_declination = 0.3978 * math.sin(math.rad(rotation_speed) *(daynum - (81 - 2 * math.sin((math.rad(rotation_speed) * (daynum - 2)))))) -- interim value used in calcs
	local hourlyAngle = 15 * ( 12 - (decimalTime + (4 * longitude / 60 )) ) -- determine sun's position dependent upon time and longitude (i.e. time zone/time of day adjustment)
	local sunAltitude = math.deg(math.asin(sin_lat* sin_declination + cos_lat * math.cos(math.rad(declination)) * math.cos(math.rad(hourlyAngle))))-- the height of the sun in degrees above horizon
	local sunAltitude_corrected = sunAltitude + relative_horizon -- correct apparent sun angle above horizon due to aircraft altitude (you can see further over the horizon, the higher you go)
	local sinSunAltitude = math.sin(math.rad(sunAltitude_corrected)) -- interim value
	local M = (math.sqrt(1229 + (614 * sinSunAltitude)^2) - 614 * sinSunAltitude) * press_rel/press_abs -- scaling value used in lux weighting
	local Kc = 1-0.75*((okta/8)^3.4)  -- Add the effect of clouds/visibility

	local weightedLux = nil
	if (sunAltitude_corrected) > 1 then -- Sun is up
		weightedLux = (((init_radiation * (0.271 - 0.294 * (0.6^M)) * sinSunAltitude) + (init_radiation * (0.6^M) * sinSunAltitude)) / 0.0079) * Kc   
	elseif (sunAltitude_corrected) <= 1 and (sunAltitude_corrected) >= -7  then -- It's twilight time
		weightedLux = ((twilight_radiation-(1-(sunAltitude_corrected))/8*twilight_radiation) / 0.0079) * Kc   
	elseif (sunAltitude_corrected) < -7 then  -- it's dark
		weightedLux = 0  
	end
        -- update output value
	ready_for_output = (1- (interpolate_linear(lux_scale_params, math.abs(var_round(weightedLux,2))))) -- lux value is inverted by subtracting it from one to create an effective "darkness" value
end

-- Process values from sim and update variables used in calcs above
function update_callback(var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12)
        --initial setting of okta value using bitmask from sim ambient precip state
        if var_2 == 2 then -- no precip
            okta = 0
        elseif var_2 == 4 then -- raining
            okta = 6
        elseif var_2 == 8 then -- snowing
            okta = 4
        end
        decimalTime  = var_3 + (offset_minutes/60) -- allow for offset of decimal hour value to account for time skew between sim and this algorithm
        visibility = var_4
        if var_4 < 50000 then -- hack to handle visibility from the sim only working with live weather, not presets.  Live weather seems to give a value of 50000m or less
            if var_4 > 16000 then -- clear skies
                okta = 0 -- overwrite okta value to set no obscuration
            else
                okta = (var_4 * (-8/(okta0_vis_threshold-okta8_vis_threshold))) + (8 * okta0_vis_threshold/(okta0_vis_threshold-okta8_vis_threshold))  -- scale linearly from okta 0 at okta0_vis_threshold vis down to okta 8 at okta8_vis_threshold vis
            end
        else
            -- stick with the crude rain or snow adjustment to okta set by var_2
        end
        okta = var_cap(okta, 0, 8) -- cap the value in case anything is messed up above
        daynum     = var_6
        latitude   = var_7
        longitude  = var_8
        altitude   = var_9
	press_abs  = var_10
	press_rel  = var_11
	year       = var_12
end

-- Get new values from sim
fs2020_variable_subscribe("AMBIENT PRECIP STATE", "Number",
                          "ZULU TIME", "Hours",                          
                          "AMBIENT VISIBILITY", "Meters",
                          "AMBIENT IN CLOUD", "Bool",
                          "ZULU DAY OF YEAR", "Number",
                          "PLANE LATITUDE", "Degrees",
                          "PLANE LONGITUDE", "Degrees",
                          "PLANE ALTITUDE", "Meters",
                          "AMBIENT PRESSURE", "Millibars",
                          "SEA LEVEL PRESSURE", "Millibars",
                          "ZULU YEAR", "Year", update_callback)
