--[[
******************************************************************************************
******************Bombardier CRJ Pedestal-Blank Panel*****************************
******************************************************************************************

    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation

- **v1.0** 09-19-2022
    - Original Panel Created


##Left To Do:
    - N/A
	
##Notes:
    - N/A
        
--]]

img_add_fullscreen("background.png")
img_bg_night = img_add_fullscreen("background_night.png")

-- Ambient Light Control
function ss_ambient_darkness(value)
    opacity(img_bg_night, value, "LOG", 0.04)
        
end
si_variable_subscribe("sivar_ambient_darkness", "FLOAT", ss_ambient_darkness)

--------------------------------------------------------------------------------------------
