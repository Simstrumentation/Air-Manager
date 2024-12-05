--[[
******************************************************************************************
********************* HJet (MG FlightFX) MASTER ELECTRICAL PANEL *****************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Master electrical panel for the HJet

- **v1.0** - 2023-04-07
    - Original Release
    
NOTES: 
- Designed for the HJet by Marwan Gharib. Will not work with any other aircraft.

KNOWN ISSUES:
- None

ATTRIBUTION:
All graphics, sounds and code original work by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--

img_add_fullscreen("background.png")
-- User Properties
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

--    sound config
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    dial_snd = sound_add("dial.wav")
    cover_open_snd = sound_add("cover_open.wav")
    cover_close_snd = sound_add("cover_close.wav")
    fail_snd = sound_add("fail.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
    cover_open_snd = sound_add("silence.wav")
    cover_close_snd = sound_add("silence.wav")
    fail_snd = sound_add("silence.wav")
end
sound_volume(fail_snd, 0.3)

--variables
local powerState = false
local batteryState = 0
local elecState = 0
local gPowerAvail = 0
local gPowerPush = 0
local groundPState = 0
local genLState = 0
local genRState = 0
local busState = 0
local cabinPush = 0
local cabinState = 0
local busTieCover = 0
local cPowerCover = 0

-- BUTTONS

function releaseAction()
    sound_play(release_snd)
end
        --    battery
function batteryAction()
    sound_play(press_snd)
    msfs_event("TOGGLE_MASTER_BATTERY")
end    
battery_id = button_add(nil, "pressed.png", 50, 84, 60, 60, batteryAction, releaseAction)    
    --    gen L
function genLAction()
    sound_play(press_snd)
    if genLState == 1 then
        msfs_variable_write("L:GENL Pushed", "Number", 3)
        msfs_variable_write("L:GENL Pushed", "Number", 0)
    else
        msfs_variable_write("L:GENL Pushed", "Number", 3)
        msfs_variable_write("L:GENL Pushed", "Number", 1)
    end
end    
gen_l_id = button_add(nil, "pressed.png", 130, 84, 60, 60, genLAction, releaseAction)        

    --     gen R
function genRAction()
    sound_play(press_snd)
    if genRState == 1 then
        msfs_variable_write("L:GENR Pushed", "Number", 3)
        msfs_variable_write("L:GENR Pushed", "Number", 0)
    else
        msfs_variable_write("L:GENR Pushed", "Number", 3)
        msfs_variable_write("L:GENR Pushed", "Number", 1)
    end
end    
gen_r_id = button_add(nil, "pressed.png", 208, 84, 60, 60, genRAction, releaseAction)      

    --    ext power

    
function gndPowerAction()
    sound_play(press_snd)
    if gPowerPush == 1 then
        msfs_variable_write("L:GPOW PUSHED", "Number", 3)
        msfs_variable_write("L:GPOW PUSHED", "Number", 0)
    else
        msfs_variable_write("L:GPOW PUSHED", "Number", 3)
        msfs_variable_write("L:GPOW PUSHED", "Number", 1)
    end
end    
gpower_id = button_add(nil, "pressed.png", 316, 84, 60, 60, gndPowerAction, releaseAction)        

        --    bus tie
function busTieReleaseAction()
    if busTieCover == 1 then
        sound_play(release_snd)
    end
end       

function cPowerReleaseAction()
    if cPowerCover == 1 then
        sound_play(release_snd)
    end
end    
                
function busAction()
    if busTieCover == 1 then
        sound_play(press_snd)
        if busState == 1 then
            msfs_variable_write("L:HJET_BUSTIE", "Number", 3)
            msfs_variable_write("L:HJET_BUSTIE", "Number", 0)
        else
            msfs_variable_write("L:HJET_BUSTIE", "Number", 3)
            msfs_variable_write("L:HJET_BUSTIE", "Number", 1)
        end 
    else
        sound_play(fail_snd)
    end
end    

bus_id = button_add(nil, "pressed.png", 394, 84, 60, 60, busAction, busTieReleaseAction)        
    
    --    cabin power
function cabinAction()
    if cPowerCover == 1 then
        sound_play(press_snd)
        if cabinPush == 0 then
            msfs_variable_write("L:CPOW PUSHED", "Number", 3)
            msfs_variable_write("L:CPOW PUSHED", "Number", 1)
        else
            msfs_variable_write("L:CPOW PUSHED", "Number", 3)
            msfs_variable_write("L:CPOW PUSHED", "Number", 0)
        end 
    else
        sound_play(fail_snd)
    end
end    
cabin_id = button_add(nil, "pressed.png", 480, 84, 60, 60, cabinAction, cPowerReleaseAction)            

function setVars(battery, elecSt, gpowAvail, gpowPush, gpowSt, genL, genR, bus, cabPush, cabSt)
    if battery or gpowSt == 1 or elecSt == 1 then
        powerState = true
    else
        powerState = false
    end
    --assign vars
    batteryState = battery
    elecState = elecSt
    gPowerAvail = gpowAvail
    gPowerPush = gpowPush
    groundPState = gpowSt
    genLState = genL
    genRState = genR
    busState = bus
    cabinPush = cabPush
    cabinState = cabSt    

print ("cstate:" ..cabinState)
print ("cpush:" ..cabinPush)
    -- annunciators
    if powerState then
        if battery then
            visible(battery_on_id, true)
	    opacity(battery_on_id, 1)
            visible(battery_off_id, false)
            opacity(battery_off_id, 0)
        else
            visible(battery_on_id, false)
            opacity(battery_on_id, 0)
            visible(battery_off_id, true)
            opacity(battery_off_id, 1)
       end
        
        if genLState == 1 then
            visible(genL_norm_id, true)
            opacity(genL_norm_id, 1)
            visible(genL_off_id, false)
            opacity(genL_off_id, 0)
       else
            visible(genL_norm_id, false)
            opacity(genL_norm_id, 0)
            visible(genL_off_id, true)
            opacity(genL_off_id, 1)
        end 

        if genRState == 1 then
            visible(genR_norm_id, true)
            opacity(genR_norm_id, 1)
            visible(genR_off_id, false)
            opacity(genR_off_id, 0)
        else
            visible(genR_norm_id, false)
            opacity(genR_norm_id, 0)
            visible(genR_off_id, true)
            opacity(genR_off_id, 1)
        end     
        
        if groundPState == 1 then
            visible(gpower_on_id, true)
            opacity(gpower_on_id, 1)
        else
            visible(gpower_on_id, false)
            opacity(gpower_on_id, 0)
        end   
        if gPowerAvail == 1 and groundPState ~=1 then
            visible(gpower_avail_id, true)
            opacity(gpower_avail_id, 1)
        else
            visible(gpower_avail_id, false)                      
            opacity(gpower_avail_id, 0)
        end   

        if busState == 1 then
            visible(bus_open_id, false)
            opacity(bus_open_id, 0)
        else
            visible(bus_open_id, true)
            opacity(bus_open_id, 1)
        end
        
        if cabinState == 1 then
            visible(cpower_off_id, true)
            opacity(cpower_off_id, 1)
        else
            visible(cpower_off_id, false)
            opacity(cpower_off_id, 0)
        end
    else
        visible(battery_on_id, false)
        visible(battery_off_id, false)
        visible(genL_norm_id, false)
        visible(genL_off_id, false)
        visible(genR_norm_id, false)
        visible(genR_off_id, false)
        visible(gpower_on_id, false)
        visible(gpower_avail_id, false)
        visible(bus_open_id, false)
        visible(cpower_off_id, false)
    end
end
 -- Annunciator Test
function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
        visible(battery_on_id, true)
        visible(battery_off_id, true)
        visible(genL_norm_id, true)
        visible(genL_off_id, true)
        visible(genR_norm_id, true)
        visible(genR_off_id, true)
        visible(gpower_on_id, true)
        visible(gpower_avail_id, true)
        visible(bus_open_id, true)
        visible(cpower_off_id, true)
		
	opacity(battery_on_id, 1)
        opacity(battery_off_id, 1)
        opacity(genL_norm_id, 1)
        opacity(genL_off_id, 1)
        opacity(genR_norm_id, 1)
        opacity(genR_off_id, 1)
        opacity(gpower_on_id, 1)
        opacity(gpower_avail_id, 1)
        opacity(bus_open_id, 1)
        opacity(cpower_off_id, 1)
    
    else
        visible(battery_on_id, false)
        visible(battery_off_id, false)
        visible(genL_norm_id, false)
        visible(genL_off_id, false)
        visible(genR_norm_id, false)
        visible(genR_off_id, false)
        visible(gpower_on_id, false)
        visible(gpower_avail_id, false)
        visible(bus_open_id, false)
        visible(cpower_off_id, false)
				
	opacity(battery_on_id, 0)
        opacity(battery_off_id, 0)
        opacity(genL_norm_id, 0)
        opacity(genL_off_id, 0)
        opacity(genR_norm_id, 0)
        opacity(genR_off_id, 0)
        opacity(gpower_on_id, 0)
        opacity(gpower_avail_id, 0)
        opacity(bus_open_id, 0)
        opacity(cpower_off_id, 0)

        setVars(batteryState, elecState, gPowerAvail, gPowerPush, groundPState, genLState,genRState, busState, cabinPush, cabinState)
    end
end
--    switch covers

function toggleBusCover()
    if busTieCover == 0 then
        sound_play(cover_open_snd)
        visible(bus_cover_id, false)
        busTieCover = 1
    else
        sound_play(cover_close_snd)
        visible(bus_cover_id, true)
        busTieCover = 0
    end
end
bus_cover_id = img_add("switch_cover.png", 390, 70, 71, 76)
bus_cover_toggle_id = button_add(nil, nil, 394, 50, 60, 30, toggleBusCover)


function toggleCPowerCover()
    if cPowerCover == 0 then
        sound_play(cover_open_snd)
        visible(cpower_cover_id, false)
        cPowerCover = 1
    else
        sound_play(cover_close_snd)
        visible(cpower_cover_id, true)
        cPowerCover = 0
    end
end
cpower_cover_toggle_id = button_add(nil, nil, 480, 50, 60, 30, toggleCPowerCover)

cpower_cover_id = img_add("switch_cover.png", 476, 70, 71, 76)


--ANNUNCIATORS
local rate = 0.02

battery_on_id = img_add("annun_on_white.png", 64, 86, 32, 23, "visible:false;")
battery_off_id = img_add("annun_off_yellow.png", 64, 110, 32, 23, "visible:false;")
genL_norm_id = img_add("annun_norm_white.png", 134, 86, 55, 23, "visible:false;")
genL_off_id = img_add("annun_off_yellow.png", 144, 110, 32, 23, "visible:false;")
genR_norm_id = img_add("annun_norm_white.png", 210, 86, 55, 23, "visible:false;")
genR_off_id = img_add("annun_off_yellow.png", 222, 110, 32, 23, "visible:false;")
gpower_on_id = img_add("annun_on_white.png", 330, 86, 32, 23, "visible:false;")
gpower_avail_id = img_add("annun_avail_yellow.png", 322, 110, 46, 23, "visible:false;")
bus_open_id = img_add("annun_open_yellow.png", 404, 110, 46, 23, "visible:false;")
cpower_off_id = img_add("annun_off_yellow.png", 494, 110, 39, 23, "visible:false;")

opacity(battery_on_id, 1.0, "LOG", rate)
opacity(battery_off_id, 1.0, "LOG", rate)
opacity(genL_norm_id, 1.0, "LOG", rate)
opacity(genL_off_id, 1.0, "LOG", rate)
opacity(genR_norm_id, 1.0, "LOG", rate)
opacity(genR_off_id, 1.0, "LOG", rate)
opacity(gpower_on_id, 1.0, "LOG", rate)
opacity(gpower_avail_id, 1.0, "LOG", rate)
opacity(bus_open_id, 1.0, "LOG", rate)
opacity(cpower_off_id, 1.0, "LOG", rate)

msfs_variable_subscribe("L:lightTestInProgress_6","NUMBER",
                                              "L:lightTestInProgress_0","NUMBER",
                                              setTest)

msfs_variable_subscribe("A:ELECTRICAL MASTER BATTERY", "BOOL",
                                              "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",
                                              "L:GroundPowerAvailable", "NUMBER",
                                              "L:GPOW PUSHED", "NUMBER",
                                              "L:GROUNDPOWER", "NUMBER", 
                                              "L:GENL Pushed", "NUMBER", 
                                              "L:GENR Pushed", "NUMBER", 
                                              "L:HJET_BUSTIE", "NUMBER", 
                                              "L:CPOW PUSHED", "NUMBER", 
                                              "L:HJET_CABINRELAY", "NUMBER", 
                                              setVars)
                                              
                                              

