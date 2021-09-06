--[[
Carenado Mooney M20R elevator trim indicator for MSFS 2020 

By Joe "Crunchmester" Gilker

Based on the C172 trim indicator by Jason Tatum
]]--

img_add_fullscreen("bg.png")
img_trim =  img_add("indicator.png", 0,0 , 184, 512)
img_add_fullscreen("Foreground.png")

function new_trim(trim)
    move(img_trim, 0, 226 + (-220 * var_cap(trim, -1, 1)), nil, nil)
end

function new_trim_fs2020(trim)
    trim = trim
    new_trim(trim)
    
end

fs2020_variable_subscribe("ELEVATOR TRIM INDICATOR", "Position", new_trim_fs2020)
