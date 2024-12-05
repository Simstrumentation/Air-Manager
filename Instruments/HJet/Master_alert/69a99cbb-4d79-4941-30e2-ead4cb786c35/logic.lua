--[[
******************************************************************************************
********* HJet (MG FlightFX) MASTER  ALERT PANEL *****************
******************************************************************************************
    Made by SIMSTRUMENTATION
    GitHub: https://simstrumentation.com

Master alert panel and baro knob for the HJet

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
-- User Properties

play_sounds = user_prop_add_boolean("Play Sounds", true, "Play sounds in Air Manager")                    

--    sound config
if user_prop_get(play_sounds) then
    press_snd = sound_add("press.wav")
    release_snd = sound_add("release.wav")
    dial_snd = sound_add("dial.wav")
else
    press_snd = sound_add("silence.wav")
    release_snd = sound_add("silence.wav")
    dial_snd = sound_add("silence.wav")
end

--    variables
local revIndicatorLF = 0
local revIndicator = 0
local muteIndicator = 0
local cautionIndicator = 0
local warningIndicator = 0
local elecState = 0

img_add_fullscreen("background.png")

--    annunciators
revAnnun = img_add("rev_indicator.png", 64, 66, 38, 22)
muteAnnun = img_add("mute_indicator.png", 152, 66, 38, 22)
warnAnnun = img_add("warning_indicator.png", 290, 50, 78, 22)
cautAnnun = img_add("caution_indicator.png", 290, 72, 78, 25)

rate = 0.02
opacity(revAnnun, 1.0, "LOG", rate)
opacity(muteAnnun, 1.0, "LOG", rate)
opacity(warnAnnun, 1.0, "LOG", rate)
opacity(cautAnnun, 1.0, "LOG", rate)
visible(revAnnun, false)
visible(muteAnnun, false)
visible(warnAnnun, false)
visible(cautAnnun, false)

--    buttons
function releaseAction()
    sound_play(release_snd)
end

--    display reversion
function revAction()
    sound_play(press_snd)
    
end
btn_rev_id = button_add(nil, "pressed.png", 40, 40, 80, 80, revAction, releaseAction)

--    Chime mute
function muteAction()
    sound_play(press_snd)
    msfs_event("H:HPFD_WARNING_MUTE")
end
btn_mute_id = button_add(nil, "pressed.png", 130, 40, 80, 80, muteAction, releaseAction)

function warnAction()
    sound_play(press_snd)
    msfs_event("H:HPFD_Master_Warning_Push")
    msfs_event("K:MASTER_CAUTION_ACKNOWLEDGE")
    msfs_event("K:MASTER_WARNING_ACKNOWLEDGE")
end
btn_warn_id = button_add(nil, "pressed.png", 290, 50, 80, 52, warnAction, releaseAction)
--    baro knob
knob_shadow_id = img_add("knob_shadow.png", 456, 58, 125, 102 )
rotate(knob_shadow_id, 40)
opacity(knob_shadow_id, .85)
knob_id = img_add("knob.png", 462, 30, 95, 122 )
function baroAction(direction)
    if direction == 1 then
        msfs_event("H:AS3000_PFD_1_BARO_INC")
    else
         msfs_event("H:AS3000_PFD_1_BARO_DEC")
    end
    sound_play(dial_snd)
end
baro_id = dial_add(nil, 472, 41, 75, 75, baroAction)

function baroPressAction()
    sound_play(press_snd)
    msfs_event("H:AS3000_PFD_1_BARO_PUSH")
end
baro_press_id = button_add(nil, nil, 482, 51, 55, 55, baroPressAction, releaseAction)

function setTest(testA, testB)
    if testA ~= 0 or testB ~= 0 then
		visible(revAnnun, true)
		visible(muteAnnun, true)
		visible(warnAnnun, true)
		visible(cautAnnun, true)
		opacity(revAnnun, 1)
		opacity(muteAnnun, 1)
		opacity(warnAnnun, 1)
		opacity(cautAnnun, 1)
    else
		visible(revAnnun, false)
		visible(muteAnnun, false)
		visible(warnAnnun, false)
		visible(cautAnnun, false)
		opacity(revAnnun, 0)
		opacity(muteAnnun, 0)
		opacity(warnAnnun, 0)
		opacity(cautAnnun, 0)

        setVars(revIndicatorLF,revIndicator,muteIndicator,cautionIndicator,warningIndicator,elecState)
    end
end


function setVars(revLF, rev, mute, caut, warn, elecSt)
    -- set local variables
    revIndicatorLF = revLF
    revIndicator = rev
    muteIndicator = mute
    cautionIndicator = caut
    warningIndicator = warn
	elecState = elecSt
    
    -- set annunciator states
    if (revIndicator ~= revIndicatorLF) and elecState ~=0 then
        visible(revAnnun, true)
		opacity(revAnnun, 1)
    else
        visible(revAnnun, false)
		opacity(revAnnun, 0)
    end
    
    if muteIndicator == 1 then
        visible(muteAnnun, true)
		opacity(muteAnnun, 1)
    else
        visible(muteAnnun, false)
		opacity(muteAnnun, 0)
    end
    
    if cautionIndicator == 1 then
        visible(cautAnnun, true)
		opacity(cautAnnun, 1)
    else
        visible(cautAnnun, false)
		opacity(cautAnnun, 0)
    end
    
    if warningIndicator == 1 then
        visible(warnAnnun, true)
		opacity(warnAnnun, 1)
    else
        visible(warnAnnun, false)
		opacity(warnAnnun, 0)
    end
end
msfs_variable_subscribe("L:REVERSION Pushed LF", "NUMBER",
                            "L:REVERSION Pushed", "NUMBER",
                                              "L:HJET_MUTE_VISIBLE", "NUMBER",
                                              "L:HJET_MASTER_CAUTION_ACTIVE", "NUMBER", 
                                              "L:HJET_MASTER_WARNING_ACTIVE", "NUMBER", 
											  "L:HJET_ELECTRICITY_ESTABLISHED", "NUMBER",
                                              setVars)

msfs_variable_subscribe("L:lightTestInProgress_6", "NUMBER",
							"L:lightTestInProgress_0", "NUMBER",                                   
                                              setTest)