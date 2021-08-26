--[[
   CJ4 Controls Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 3-13-2021
   
   Version 1.1
   Modified by Joe "Crunchmeister" Gilker
   - Fixed start functionality that had been broken by a previous update
   
   REQUIRES Mobiflight-event-module in community folder  
   https://www.mobiflight.com/en/download.html
   
   How to in 1st post here:
   https://forums.flightsimulator.com/t/full-g1000-control-now-with-mobiflight/348509

   Secondary Elev Trim Button with shield Not Functional

--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")


PIC_Engine1_Run = img_add("Engine_Run.png", 160,33,90,70)
PIC_Engine1_Stop = img_add("Engine_Stop.png", 167,69,70,50)

PIC_Engine2_Run = img_add("Engine_Run.png", 425,33,90,70)
PIC_Engine2_Stop = img_add("Engine_Stop.png", 433,69,70,50)
visible(PIC_Engine1_Run, false)
visible(PIC_Engine2_Run, false)
visible(PIC_Engine1_Stop, false)
visible(PIC_Engine2_Stop, false)

PIC_Starter1_On = img_add("LTS_On.png", 203,258,50,10)
PIC_Starter2_On = img_add("LTS_On.png", 403,258,50,10)
visible(PIC_Starter1_On, false)
visible(PIC_Starter2_On, false)

Rudder_Trim_Knob = img_add("RudderTrim_Knob.png", 180,668,125,125)
rotate(Rudder_Trim_Knob, 0, "LOG", 0.04)

Elev_Trim_Knob = img_add("Elev_Trim.png", 425,395,95,127)
visible(Elev_Trim_Knob, true)
move(Elev_Trim_Knob, nil, nil, nil, nil, "LOG", 0.04)

AILERON_Trim_Knob = img_add("Aileron_Trim.png", 135,400,127,95)
visible(AILERON_Trim_Knob, true)
move(AILERON_Trim_Knob, nil, nil, nil, nil, "LOG", 0.04)


---Sounds
click_snd = sound_add("Asobo_CJ4_WT.PC_63.wav")

--Locals
local L_Starter1_Status = false 
local L_Starter2_Status = false
local L_Mix1_Status = false
local L_Mix2_Status = false
---------START----------------------------

function Engine1_Run_Toggle()

 fs2020_event("MOBIFLIGHT.WT_CJ4_ENG_RUNSTOP_L_PUSH")
         sound_play(click_snd)

end
button_add(nil,nil, 151,30,100,100, Engine1_Run_Toggle)

  
function Engine2_Run_Toggle()
fs2020_event("MOBIFLIGHT.WT_CJ4_ENG_RUNSTOP_R_PUSH")
         sound_play(click_snd)
end
button_add(nil,nil, 421,30,100,100, Engine2_Run_Toggle)

---------Starters--------------
function Starter1_Toggle()
   fs2020_event("TOGGLE_STARTER1")
   sound_play(click_snd)
end
button_add(nil,nil, 190,250,80,50, Starter1_Toggle)

function Starter2_Toggle()
   fs2020_event("TOGGLE_STARTER2")
   sound_play(click_snd)
end
button_add(nil,nil, 395,250,80,50, Starter2_Toggle)

function Starter_Diseng_Toggle()
   sound_play(click_snd)
   if L_Starter1_Status == true then
       fs2020_event("TOGGLE_STARTER1")
   end
   if L_Starter2_Status == true then
       fs2020_event("TOGGLE_STARTER2")
   end
end
button_add(nil,nil, 295,250,80,50, Starter_Diseng_Toggle)



--Test if Engine Start Stop    


function Engine_Status(Starter1_Status,Starter2_Status,Engine1_Status,Engine2_Status,Battery_Status) 
    if Battery_Status == true then  --Battery is On
    
     if (Starter1_Status == true or Starter2_Status == true) and Engine1_Status == 0 and Engine2_Status == 0 then
        visible(PIC_Engine1_Run, false)
        visible(PIC_Engine1_Stop, false) 
        visible(PIC_Engine2_Run, false)
        visible(PIC_Engine2_Stop, false)      
    else
    
            --Engine 1
        if Starter1_Status == false then
            if Engine1_Status == 100  then 
                visible(PIC_Engine1_Run, true)
                visible(PIC_Engine1_Stop, false)
             elseif Engine1_Status == 0 then
                visible(PIC_Engine1_Run, false)
                visible(PIC_Engine1_Stop, true)         
            end 
        else --turn off when starter is on
            if Engine1_Status == 100  then 
                visible(PIC_Engine1_Run, true)
                visible(PIC_Engine1_Stop, false) 
            elseif Engine1_Status == 0  then 
                visible(PIC_Engine1_Run, false)
                visible(PIC_Engine1_Stop, false)                 
            end
        end
        
        --Engine 2
        if Starter2_Status == false then
            if Engine2_Status == 100  then 
                visible(PIC_Engine2_Run, true)
                visible(PIC_Engine2_Stop, false)
             elseif Engine2_Status == 0 then
                visible(PIC_Engine2_Run, false)
                visible(PIC_Engine2_Stop, true)         
            end 
        else --turn off when starter is on
            if Engine2_Status == 100  then 
                visible(PIC_Engine2_Run, true)
                visible(PIC_Engine2_Stop, false) 
            elseif Engine1_Status == 0  then 
                visible(PIC_Engine2_Run, false)
                visible(PIC_Engine2_Stop, false)                 
            end
        end    

     end
    else --Battery is Off
        visible(PIC_Engine1_Run, false)
        visible(PIC_Engine1_Stop, false) 
        visible(PIC_Engine2_Run, false)
        visible(PIC_Engine2_Stop, false)        
    end
end
fs2020_variable_subscribe("GENERAL ENG STARTER:1","Bool",  
                          "GENERAL ENG STARTER:2","Bool",
                          "GENERAL ENG MIXTURE LEVER POSITION:1","Percent",
                          "GENERAL ENG MIXTURE LEVER POSITION:2","Percent",
                          "ELECTRICAL MASTER BATTERY","Bool",Engine_Status)

function Mixture_Status(Mix1_Status,Mix2_Status)
    if Mix1_Status == 0 then
        L_Mix1_Status = true
    else
        L_Mix1_Status = false
    end
    if Mix2_Status == 0 then
        L_Mix2_Status = true
    else
        L_Mix2_Status = false
    end
end

fs2020_variable_subscribe("GENERAL ENG MIXTURE LEVER POSITION:1","Percent",
                          "GENERAL ENG MIXTURE LEVER POSITION:2","Percent",Mixture_Status)





--Test if Starters are On    
function Starter_Status(Starter1_Status,Starter2_Status) 
    if Starter1_Status == true then 
        visible(PIC_Starter1_On, true)
        L_Starter1_Status = true
    else 
        visible(PIC_Starter1_On, false)
        L_Starter1_Status = false        
    end 
    if Starter2_Status == true then 
        visible(PIC_Starter2_On, true)
        L_Starter2_Status = true        
    else 
        visible(PIC_Starter2_On, false)
        L_Starter2_Status = false        
    end 

end
fs2020_variable_subscribe("GENERAL ENG STARTER:1","Bool",  
                          "GENERAL ENG STARTER:2","Bool",Starter_Status)

                          
------Rudder Trim------------                                                                                    
function Rudder_Trim_Left_Start()
   timer_id1 = timer_start(0, 100,Rudder_Trim_Left)
   rotate(Rudder_Trim_Knob, -90 )
   sound_play(click_snd)
end
function Rudder_Trim_Left_End()
       timer_stop(timer_id1)
       rotate(Rudder_Trim_Knob, 0 )
       sound_play(click_snd)
end
function Rudder_Trim_Left()
   fs2020_event("RUDDER_TRIM_LEFT")
end   
button_add(nil,nil, 130,650,80,150, Rudder_Trim_Left_Start, Rudder_Trim_Left_End) 


                                            
function Rudder_Trim_Right_Start()
   timer_id2 = timer_start(0, 100,Rudder_Trim_Right)
   rotate(Rudder_Trim_Knob, 90 )
   sound_play(click_snd)
end
function Rudder_Trim_Right_End()
       timer_stop(timer_id2)
       rotate(Rudder_Trim_Knob, 0 )       
       sound_play(click_snd)       
end
function Rudder_Trim_Right()
   fs2020_event("RUDDER_TRIM_Right")
end   
button_add(nil,nil, 275,650,80,150, Rudder_Trim_Right_Start, Rudder_Trim_Right_End)                         

                          
-------Elevator Trim---------------                                                    
function Elevator_Trim_Down_Start()
   timer_id3 = timer_start(0, 100,Elevator_Trim_Down)
   move(Elev_Trim_Knob, 425,380,95,127)
   sound_play(click_snd)
end
function Elevator_Trim_Down_End()
       timer_stop(timer_id3)
       move(Elev_Trim_Knob, 425,395,95,127)
       sound_play(click_snd)
end
function Elevator_Trim_Down()
   fs2020_event("ELEV_TRIM_DN")

end   
button_add(nil,nil, 425,400,100,50, Elevator_Trim_Down_Start, Elevator_Trim_Down_End) 


                                            
function Elevator_Trim_Up_Start()
   timer_id4 = timer_start(0, 100,Elevator_Trim_Up)
   move(Elev_Trim_Knob, 425,410,95,127)
   sound_play(click_snd)
end
function Elevator_Trim_Up_End()
       timer_stop(timer_id4)
       move(Elev_Trim_Knob, 425,395,95,127)       
       sound_play(click_snd)       
end
function Elevator_Trim_Up()
   fs2020_event("ELEV_TRIM_UP")

end   
button_add(nil,nil, 425,460,100,50, Elevator_Trim_Up_Start, Elevator_Trim_Up_End)   

                                                                             
------Aileron Trim--------------------

function Aileron_Trim_Left_Start()
   timer_Aileron_L = timer_start(0, 20,Aileron_Trim_Left)
   move(AILERON_Trim_Knob, 125,400,127,95)
   sound_play(click_snd)
end
function Aileron_Trim_Left_End()
       timer_stop(timer_Aileron_L)
       move(AILERON_Trim_Knob, 135,400,127,95)
       sound_play(click_snd)
end
function Aileron_Trim_Left()
   fs2020_event("AILERON_TRIM_LEFT")
end   
button_add(nil,nil, 140,390,60,130, Aileron_Trim_Left_Start, Aileron_Trim_Left_End) 


                                            
function Aileron_Trim_Right_Start()
   timer_Aileron_R = timer_start(0, 20,Aileron_Trim_Right)
   move(AILERON_Trim_Knob, 145,400,127,95)
   sound_play(click_snd)
end
function Aileron_Trim_Right_End()
       timer_stop(timer_Aileron_R)
       move(AILERON_Trim_Knob, 135,400,127,95)    
       sound_play(click_snd)          
end
function Aileron_Trim_Right()
   fs2020_event("AILERON_TRIM_RIGHT")
end   
button_add(nil,nil, 200,390,60,130, Aileron_Trim_Right_Start, Aileron_Trim_Right_End)                         

                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                    
                                   