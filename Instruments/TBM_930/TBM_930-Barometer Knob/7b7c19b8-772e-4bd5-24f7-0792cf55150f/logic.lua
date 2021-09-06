img_add_fullscreen("background.png")
click_snd = sound_add("knobclick.wav")

  function turn_baroknob_cb (knobdirection)
    if knobdirection > 0 then
      fs2020_event("KOHLSMAN_INC")
    else
      fs2020_event("KOHLSMAN_DEC")
    end
  end
  
  dial_baro = dial_add("knob.png" , 42 , 42 , 70 , 70 , turn_baroknob_cb)
  dial_click_rotate(dial_baro, 6)
  
 function baro_click()
   fs2020_event("BAROMETRIC")
   sound_play(click_snd)
end
button_add(nil,nil, 42 , 42 , 70 , 70, baro_click)