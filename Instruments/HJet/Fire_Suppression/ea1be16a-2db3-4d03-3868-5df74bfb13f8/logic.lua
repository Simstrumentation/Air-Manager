--[[
******************************************************************************************
********************* HJet (MG FlightFX) FIRE SUPPRESSION PANEL *******************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Fire suppression panel for the HJet

- **v1.0** - 2023-04-07
    - Original Release
    
NOTES: 
- Designed for the HJet by Marwan Gharib. Will not work with any other aircraft.

KNOWN ISSUES:
- Buttons are currently INOP due to being cotrolled solely by BIO vars / events. 
  This instrument is more for looks than functionality

ATTRIBUTION:
All graphics, sounds and code original work by Simstrumentation. 
Sharing or re-use of any code or assets is not permitted without credit to the original authors.
******************************************************************************************
]]--
--variables

trap_l = true
trap_r = true
local ident = 0
local fireTest0 = 0
local fireTest1 = 0 
local fireTest2 = 0
local fireTest3 = 0
local engFire1 = 0
local engFire2 = 0
local elecState = 0

img_add_fullscreen("background.png")
-- User Properties
play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

--    sound config
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    cover_open_snd = sound_add("cover_open.wav")
    cover_close_snd = sound_add("cover_close.wav")
    fail_snd = sound_add("fail.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    cover_open_snd = sound_add("silence.wav")
    cover_close_snd = sound_add("silence.wav")
    fail_snd = sound_add("silence.wav")
end
sound_volume(fail_snd, 0.3)

ident_shadow_id = txt_add(" ","size:46px; font:arimo_bold.ttf; color: black; halign: center;", 278,62,300,100)
ident_id = txt_add(" ","size:46px; font:arimo_bold.ttf; color: white; halign: center;", 274,56,300,100)


--    annunciators
fire_l_annunciator_id = img_add("l_red_button.png", 66, 66, 82, 62, "visible:false")
fire_r_annunciator_id = img_add("l_red_button.png", 698, 66, 82, 62, "visible:false")

fire_ext_l_id = img_add("annun_ext_push.png", 200, 70, 71, 46, "visible:false")
fire_ext_r_id = img_add("annun_ext_push.png", 576, 70, 71, 46, "visible:false")

rate = 0.04
opacity(fire_l_annunciator_id, 1.0, "LOG", rate)
opacity(fire_r_annunciator_id, 1.0, "LOG", rate)
opacity(fire_ext_l_id, 1.0, "LOG", rate)
opacity(fire_ext_r_id, 1.0, "LOG", rate)

--    trap covers
trap_l_down_id = img_add("trap_down.png", 48, 38, 121, 102)
trap_l_up_id = img_add("trap_up.png", 48, 28, 121, 16, "visible:false")
trap_r_up_id = img_add("trap_up.png", 680, 28, 121, 16, "visible:false")
trap_r_down_id = img_add("trap_down.png", 680, 38, 121, 102)

function releaseAction()
    sound_play(release_snd)
end    

function releaseExtLAction()
    if trap_l == false then
        sound_play(press_snd)
    end
end
function fireLAction()
    if trap_l then
        sound_play(fail_snd)
    else
        sound_play(press_snd)
    end   
end

fire_l_id = button_add(nil, "pressed.png", 66, 66, 82, 62, fireLAction, releaseExtLAction)

function releaseExtRAction()
    if trap_r == false then
        sound_play(press_snd)
    end
end

function fireRAction()
    if trap_r then
        sound_play(fail_snd)
    else
        sound_play(press_snd)
    end
end
fire_r_id = button_add(nil, "pressed.png", 698, 66, 82, 62, fireRAction, releaseExtRAction)


function extLAction()
    sound_play(press_snd)
    msfs_event("K:EXTINGUISH_ENGINE_FIRE:11")
    msfs_event("K:EXTINGUISH_ENGINE_FIRE:21")
end
ext_l_push = button_add(nil, "pressed.png", 180, 50, 112, 86, extLAction, releaseAction)

function extRAction()
    sound_play(press_snd)
    msfs_event("K:EXTINGUISH_ENGINE_FIRE:12")
    msfs_event("K:EXTINGUISH_ENGINE_FIRE:22")
end
ext_r_push = button_add(nil, "pressed.png", 554, 50, 112, 86, extRAction, releaseAction)

--    trap covers
function toggleTrapL()  
    if trap_l then
        sound_play(cover_open_snd)
        trap_l = false
        visible(trap_l_down_id, false)
        visible(trap_l_up_id, true)
    else
        sound_play(cover_close_snd)
        trap_l = true
        visible(trap_l_down_id, true)
        visible(trap_l_up_id, false)        
    end
end
trap_l_toggle_id = button_add(nil, nil, 48, 26, 121, 20, toggleTrapL)

function toggleTrapR()    
    if trap_r then
        sound_play(cover_open_snd)
        trap_r = false
        visible(trap_r_down_id, false)
        visible(trap_r_up_id, true)
    else
        sound_play(cover_close_snd)
        trap_r = true
        visible(trap_r_down_id, true)
        visible(trap_r_up_id, false)        
    end
end
trap_r_toggle_id = button_add(nil, nil, 680, 26, 121, 20, toggleTrapR)

--    variable subscriptions and variable assignment
function setVals(id,test0, test1, test2, test3, fire1, fire2, elecSt)
    ident = id
    fireTest0 = test0
    fireTest1 = test1
    fireTest2 = test2
    fireTest3 = test3
    engFire1 = fire1
    engFire2 = fire2
    elecState = elecSt
    txt_set(ident_shadow_id, id )
    txt_set(ident_id, id )
    
    if fireTest0 ~=0 or engFire1 ~= 0 then
        visible(fire_l_annunciator_id,true)
        opacity(fire_l_annunciator_id, 1)	
    else
        visible(fire_l_annunciator_id,false)
        opacity(fire_l_annunciator_id, 0)	
    end
    if fireTest2 ~=0 or engFire2 ~= 0 then
        visible(fire_r_annunciator_id,true)
        opacity(fire_r_annunciator_id, 1)	
    else
        visible(fire_r_annunciator_id,false)
        opacity(fire_r_annunciator_id, 0)	
    end
    if fireTest1 ~=0 then
        visible(fire_ext_l_id,true)
        opacity(fire_ext_l_id, 1)	
    else
        visible(fire_ext_l_id,false)
        opacity(fire_ext_l_id, 0)	
    end
    if fireTest3 ~=0 then
        visible(fire_ext_r_id,true)
        opacity(fire_ext_r_id, 1)	
    else
        visible(fire_ext_r_id,false)
        opacity(fire_ext_r_id, 0)	
    end
end

function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
		visible(fire_l_annunciator_id, true)
		visible(fire_r_annunciator_id, true)
		visible(fire_ext_l_id, true)
		visible(fire_ext_r_id, true)
		opacity(fire_l_annunciator_id, 1)
		opacity(fire_r_annunciator_id, 1)
		opacity(fire_ext_l_id, 1)
		opacity(fire_ext_r_id, 1)

    else
		visible(fire_l_annunciator_id, false)
		visible(fire_r_annunciator_id, false)
		visible(fire_ext_l_id, false)
		visible(fire_ext_r_id, false)
		opacity(fire_l_annunciator_id, 0)
		opacity(fire_r_annunciator_id, 0)
		opacity(fire_ext_l_id, 0)
		opacity(fire_ext_r_id, 0)
        setVals(ident,fireTest0,fireTest1,fireTest2,fireTest3,engFire1,engFire2,elecState)
    end

end

msfs_variable_subscribe("ATC ID", "STRING", 
                            "L:fireTestInProgress_0", "NUMBER",
                            "L:fireTestInProgress_1", "NUMBER",
                            "L:fireTestInProgress_2", "NUMBER",
                            "L:fireTestInProgress_3", "NUMBER",
                            "A:ENG ON FIRE:1", "NUMBER",
                            "A:ENG ON FIRE:2", "NUMBER",                            
                            "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",
                            setVals)
msfs_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
			"L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)                            