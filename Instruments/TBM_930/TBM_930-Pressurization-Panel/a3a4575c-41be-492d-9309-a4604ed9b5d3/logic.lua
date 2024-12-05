--[[
******************************************************************************************
******************TBM 930 - Pressurization Panel ****************************
******************************************************************************************
    
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://github.com/simstrumentation
   
- **v1.0**  01-30-2022 
    - Original Panel Created


## Left To Do:
    - Bleed Switch doesn't change in Virtural Cockpit
    	
## Notes:
    - Click on the hinge to open/close the cover.
--]]

snd_click = sound_add("click.wav")
snd_fail = sound_add("fail.wav")
cover_open_snd = sound_add("cover_open.wav")
cover_close_snd = sound_add("cover_close.wav")

img_add_fullscreen("background.png")

img_bleed_auto = img_add("bld_swtch_up.png", 360, 100, 51, 169)
img_bleed_maxdiff = img_add("bld_swtch_md.png", 360, 100, 51, 169)
img_bleed_off = img_add("bld_swtch_dn.png", 360, 100, 51, 169)
img_dump_norm = img_add("dump_norm.png", 80, 140, 115, 118)
img_dump_dump = img_add("dump_dump.png", 80, 140, 115, 118)
img_cover_closed = img_add("cover_closed.png", 80, 30, 114, 227)
img_cover_open = img_add("cover_open.png", 80, 30, 114, 227)

local dump_cover = 0
visible(img_cover_closed, true)
visible(img_cover_open, false)

function callback_cover_toggle()
    if dump_cover == 0 then
        dump_cover =1
        visible(img_cover_closed, false)
        visible(img_cover_open, true)
        sound_play(cover_open_snd)
     else
        dump_cover = 0
        visible(img_cover_closed, true)
        visible(img_cover_open, false)
        sound_play(cover_close_snd)
     end
end
button_add(nil, nil , 80, 110, 115, 60, callback_cover_toggle)        

function dump()
    if dump_cover == 0 then    --if button cover is down, play fail sound 
        sound_play(snd_fail)
    elseif dump_cover == 1 then
        msfs_event("K:PRESSURIZATION_PRESSURE_DUMP_SWITCH")
        sound_play(snd_click)
    end
end
button_add(nil,nil, 80, 150, 115,118, dump)
 
msfs_variable_subscribe("A:PRESSURIZATION DUMP SWITCH", "bool",
    function (dump_sw)
        if dump_sw then    
            opacity(img_dump_norm,0)
            opacity(img_dump_dump,1)
        else 
            opacity(img_dump_norm,1)
            opacity(img_dump_dump,0)
        end
 end)


msfs_variable_subscribe("A:BLEED AIR SOURCE CONTROL", "enum",
    function (bleed)
        if bleed == 0  then
            visible(img_bleed_auto, true)
            visible(img_bleed_maxdiff, false)       
            visible(img_bleed_off, false)                 
        elseif bleed == 3 then
            visible(img_bleed_auto, false)
            visible(img_bleed_maxdiff, true)       
            visible(img_bleed_off, false)            
        elseif bleed == 1 then
            visible(img_bleed_auto, false)
            visible(img_bleed_maxdiff, false)       
            visible(img_bleed_off, true)                   
        end
 end)
 

 function btn_bleed_auto()
    msfs_event("K:BLEED_AIR_SOURCE_CONTROL_SET", 0)
    sound_play(snd_click)
end
button_add(nil,nil, 310, 110, 120, 50, btn_bleed_auto)

function btn_bleed_maxdiff()
    msfs_event("K:BLEED_AIR_SOURCE_CONTROL_SET", 3)
    sound_play(snd_click)
end
button_add(nil,nil, 310, 160, 120, 50, btn_bleed_maxdiff)

function btn_bleed_off()
    msfs_event("K:BLEED_AIR_SOURCE_CONTROL_SET", 1)
    sound_play(snd_click)
end
button_add(nil,nil, 310, 210, 120, 50, btn_bleed_off)