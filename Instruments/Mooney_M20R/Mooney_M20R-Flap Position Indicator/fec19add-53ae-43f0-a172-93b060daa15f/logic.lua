--[[

Flap position indicator for the Carenado Mooney M20R
By Joe 'Crunchmeister' Gilker

]]--

img_add_fullscreen ("bg.png")
arrow = img_add("indicator.png", 0,-150, 184, 512)
img_add_fullscreen ("Foreground.png")

function callback_flap(pos) 
    move(arrow, nil, pos * 444, nil, nil)
end


msfs_variable_subscribe("TRAILING EDGE FLAPS LEFT PERCENT", "Percent over 100", callback_flap)