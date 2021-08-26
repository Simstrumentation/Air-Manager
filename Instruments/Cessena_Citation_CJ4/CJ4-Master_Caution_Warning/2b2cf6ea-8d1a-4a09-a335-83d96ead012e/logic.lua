--[[
   Generic Warning/Caution Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 8-22-2021
  

--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")

Warning_On = img_add("warning.png", 15,15,188,160)
Caution_On = img_add("caution.png", 248,15,188,160)

click_snd = sound_add("Asobo_CJ4_WT.PC_63.wav")

--Warning Select    
function Warning()
   --fs2020_event("MOBIFLIGHT.WT_CJ4_MASTER_WARNING_PUSH")
   fs2020_event("H:Generic_Master_Warning_Push")
   sound_play(click_snd)
end
button_add(nil,"warning.png", 15,15,188,160, Warning)


--Caution Select    
function Caution()
   --fs2020_event("MOBIFLIGHT.WT_CJ4_MASTER_CAUTION_PUSH")
    fs2020_event("H:Generic_Master_Caution_Push")
    sound_play(click_snd)
end
button_add(nil,"caution.png", 248,15,188,160, Caution)



--Test if Gen is On         
function warningtrue(warningactive,Battery_Status) 
  if (warningactive == 1 and Battery_Status == true) then 
        visible(Warning_On, true)
  else 
        visible(Warning_On, false)
  end
end

function cautiontrue(cautionactive,Battery_Status) 
    if (cautionactive == 1 and Battery_Status == true) then 
        visible(Caution_On, true)
    else 
        visible(Caution_On, false)
    end
end



--fs2020_variable_subscribe("Generic_Master_Caution_Active","INT", cautiontrue)
--fs2020_variable_subscribe("Generic_Master_Warning_Active","INT", warningtrue) 

--fs2020_variable_subscribe("MOBIFLIGHT.WT_CJ4_MASTER_CAUTION_PUSH","Int", cautiontrue)
--fs2020_variable_subscribe("MOBIFLIGHT.WT_CJ4_MASTER_WARNING_PUSH","Int", warningtrue)

fs2020_variable_subscribe("L:Generic_Master_Caution_Active","Int",
                          "ELECTRICAL MASTER BATTERY","Bool", cautiontrue)
                          
fs2020_variable_subscribe("L:Generic_Master_Warning_Active","Int", 
                          "ELECTRICAL MASTER BATTERY","Bool",warningtrue)  






  
    
      
          