--[[
   CJ4 Controls Panel
   Author Rob Verdon
   rob.verdon@gmail.com
   
   Version 1.0
   Functonal as of 3-13-2021
   
   Version 1.1
   Modified by Joe "Crunchmeister" Gilker
   - Fixed start functionality that had been broken by a previous update
   
   Version 1.2
   Modified by Joe "Crunchmeister" Gilker
   - New custom graphics
   - functional covers added to run buttons. Touch or click the cover hinges to open and close.
      Run switches will be INOP until covers are open.
   

   Modified by Todd "Toddimus831" Lorey  9/17/2021
   - Slight tweaks to PIC_EngineX_ and PIC_StarterX positions to center them better in their buttons
   - Refactored code to adapt to native A: variable and K: events and remove MobiFlight dependency
	RPN Code from https://hubhop.mobiflight.com/
	MobiFlight Command: WT_CJ4_ENG_RUNSTOP_L_PUSH

	MobiFlight RPN Code for command:
		(A:GENERAL ENG MIXTURE LEVER POSITION:1, Percent) 0 > 
			if{ (>K:MIXTURE1_LEAN) 
				(A:GENERAL ENG FUEL VALVE:1, Bool) 
					if{ (>K:TOGGLE_FUEL_VALVE_ENG1) } 
				(A:TURB ENG IGNITION SWITCH EX1:1, enum) 0 == 
					if{ 0 (>K:TURBINE_IGNITION_SWITCH_SET1) } 
					} 
			els{ (>K:MIXTURE1_RICH) 
				(A:GENERAL ENG FUEL VALVE:1, Bool) ! 
					if{ (>K:TOGGLE_FUEL_VALVE_ENG1) } 
				(A:TURB ENG IGNITION SWITCH EX1:1, enum) 0 == 
					if{ 1 (>K:TURBINE_IGNITION_SWITCH_SET1) } 
					}
--]]
  
--Backgroud Image before anything else
img_add_fullscreen("background.png")

local  left_run = 0
local right_run = 0

--PIC_Engine1_Run = img_add("Engine_Run.png", 160,33,90,70) -- original position
PIC_Engine1_Run = img_add("Engine_Run.png", 158,33,90,70)
--PIC_Engine1_Stop = img_add("Engine_Stop.png", 167,69,70,50) -- original position
PIC_Engine1_Stop = img_add("Engine_Stop.png", 169,69,70,50)

--PIC_Engine2_Run = img_add("Engine_Run.png", 425,33,90,70) -- original position
PIC_Engine2_Run = img_add("Engine_Run.png", 422,33,90,70)
PIC_Engine2_Stop = img_add("Engine_Stop.png", 433,69,70,50)
visible(PIC_Engine1_Run, false)
visible(PIC_Engine2_Run, false)
visible(PIC_Engine1_Stop, false)
visible(PIC_Engine2_Stop, false)

--PIC_Starter1_On = img_add("LTS_On.png", 203,258,50,10)  -- original position
PIC_Starter1_On = img_add("LTS_On.png", 205,258,50,10)
--PIC_Starter2_On = img_add("LTS_On.png", 403,258,50,10)  -- original position
PIC_Starter2_On = img_add("LTS_On.png", 410,258,50,10)
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
fail_snd = sound_add("beepfail.wav")
cover_open_snd = sound_add("cover_open.wav")
cover_close_snd = sound_add("cover_close.wav")

--Locals
local L_Starter1_Status = false
local L_Starter2_Status = false
local L_Mix1_Status = false 
local L_Mix2_Status = false
local L_Fuel_Valve1_Status = false
local L_Fuel_Valve2_Status = false
local L_Ign_Switch1_Status = false
local L_Ign_Switch2_Status = false
local L_Battery_Master_Status = false

--------ENGINES---  Determine and set variable states and visibilities
function Engine_Status( Starter1_Status, Starter2_Status, 
			Mix1_Status, Mix2_Status,
			Fuel_Valve1_Status, Fuel_Valve2_Status,
			Ign_Switch1_Status, Ign_Switch2_Status,
			Battery_Status)
	--BATTERY
		L_Battery_Master_Status = Battery_Status

	--STARTER1
		if Starter1_Status == true and L_Battery_Master_Status == true then 
			visible(PIC_Starter1_On, true)
			L_Starter1_Status = true
		else 
			visible(PIC_Starter1_On, false)
			L_Starter1_Status = false        
		end 

	--STARTER2
		if Starter2_Status == true and L_Battery_Master_Status == true then 
			visible(PIC_Starter2_On, true)
			L_Starter2_Status = true        
		else 
			visible(PIC_Starter2_On, false)
			L_Starter2_Status = false        
		end 

	--MIXTURES -- For determining run/stop status
		if Mix1_Status > 0 then
			L_Mix1_Status = true
		else
			L_Mix1_Status = false
		end
		if Mix2_Status > 0 then
			L_Mix2_Status = true
		else
			L_Mix2_Status = false
		end

	--FUEL VALVES -- For determining run/stop status
		L_Fuel_Valve1_Status = Fuel_Valve1_Status
		L_Fuel_Valve2_Status = Fuel_Valve2_Status

	--IGNITION SWITCHES (NOT MANUAL IGNITION) -- For determining run/stop status
		if Ign_Switch1_Status == 0 then
			L_Ign_Switch1_Status = false
		else
			L_Ign_Switch1_Status = true
		end
		if Ign_Switch2_Status == 0 then
			L_Ign_Switch2_Status = false
		else
			L_Ign_Switch2_Status = true
		end

	--SET RUN/STOP STATUS
		if L_Battery_Master_Status == true then  --Battery is On	
			if (L_Starter1_Status == true or L_Starter2_Status == true) and L_Mix1_Status == false and L_Mix2_Status == false then
				visible(PIC_Engine1_Run, false)
				visible(PIC_Engine1_Stop, false) 
				visible(PIC_Engine2_Run, false)
				visible(PIC_Engine2_Stop, false)      
			else		
			--Engine 1
				if L_Starter1_Status == false then
					if L_Mix1_Status == true  then 
						visible(PIC_Engine1_Run, true)
						visible(PIC_Engine1_Stop, false)
					elseif L_Mix1_Status == false then
						visible(PIC_Engine1_Run, false)
						visible(PIC_Engine1_Stop, true)         
					end 
				else --turn off when starter is on
					if L_Mix1_Status == true  then 
						visible(PIC_Engine1_Run, true)
						visible(PIC_Engine1_Stop, false)
					elseif L_Mix1_Status == false  then 
						visible(PIC_Engine1_Run, false)
						visible(PIC_Engine1_Stop, false)                 
					end
				end				
			--Engine 2
				if L_Starter2_Status == false then
					if L_Mix2_Status == true  then 
						visible(PIC_Engine2_Run, true)
						visible(PIC_Engine2_Stop, false)
					elseif L_Mix2_Status == false then
						visible(PIC_Engine2_Run, false)
						visible(PIC_Engine2_Stop, true)         
					end 
				else --turn off when starter is on
					if L_Mix2_Status == true  then 
						visible(PIC_Engine2_Run, true)
						visible(PIC_Engine2_Stop, false) 
					elseif L_Mix2_Status == false  then 
						visible(PIC_Engine2_Run, false)
						visible(PIC_Engine2_Stop, false)                 
					end
				end    
			end
			if L_Fuel_Valve1_Status == false and L_Mix1_Status == false and L_Starter2_Status == true then -- this is weird but it's what the sim does
						visible(PIC_Engine1_Run, false)
						visible(PIC_Engine1_Stop, false)
			end	     
			if L_Fuel_Valve2_Status == false and L_Mix2_Status == false and L_Starter1_Status == true then -- this is weird but it's what the sim does
						visible(PIC_Engine2_Run, false)
						visible(PIC_Engine2_Stop, false)
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
                          "GENERAL ENG MIXTURE LEVER POSITION:1", "Percent",  
                          "GENERAL ENG MIXTURE LEVER POSITION:2", "Percent",  
                          "GENERAL ENG FUEL VALVE:1", "Bool",
                          "GENERAL ENG FUEL VALVE:2", "Bool",
                          "TURB ENG IGNITION SWITCH EX1:1", "enum",
                          "TURB ENG IGNITION SWITCH EX1:2", "enum",
                          "ELECTRICAL MASTER BATTERY","Bool",Engine_Status)

--ENGINE 1
function Engine1_Run_Toggle()
    if left_run == 0 then    --if button cover is down, play fail sound and don't start the engine
		sound_play(fail_snd)
    else    -- run toggle logic if cover is open
		if  L_Battery_Master_Status == true then
			if L_Mix1_Status == true then
				fs2020_event("MIXTURE1_LEAN")
				if L_Fuel_Valve1_Status == true then
					fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
				end
				if L_Ign_Switch1_Status == true then
					fs2020_event("TURBINE_IGNITION_SWITCH_SET1",0)
				end
			else
				fs2020_event("MIXTURE1_RICH")
				if L_Fuel_Valve1_Status ~= true then
					fs2020_event("TOGGLE_FUEL_VALVE_ENG1")
				end
				if L_Ign_Switch1_Status == false then
					fs2020_event("TURBINE_IGNITION_SWITCH_SET1",1)
				end	
			end
		end
		sound_play(click_snd)
    end
end
button_add(nil,nil, 151,30,100,100, Engine1_Run_Toggle)

--ENGINE 2
function Engine2_Run_Toggle()
    if right_run==0 then    --if button cover is down, play fail sound and don't start the engine
        sound_play(fail_snd)
    else    -- run toggle logic if cover is open
		if  L_Battery_Master_Status == true then
			if L_Mix2_Status == true then
				fs2020_event("MIXTURE2_LEAN")
				if L_Fuel_Valve2_Status == true then
					fs2020_event("TOGGLE_FUEL_VALVE_ENG2")
				end
				if L_Ign_Switch2_Status == true then
					fs2020_event("TURBINE_IGNITION_SWITCH_SET2",0)
				end
			else
				fs2020_event("MIXTURE2_RICH")
				if L_Fuel_Valve2_Status ~= true then
					fs2020_event("TOGGLE_FUEL_VALVE_ENG2")
				end
				if L_Ign_Switch2_Status == false then
					fs2020_event("TURBINE_IGNITION_SWITCH_SET2",1)
				end	
			end
		end
		sound_play(click_snd)
	end
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

-- Engine run button covers
function cover_l_id()

end

-- Engine run button covers--

--Add graphics for both states

L_Closed = img_add("cover_l_closed.png", 120 ,5,152,146)
L_Open = img_add("cover_l_open.png", 120 ,5,152,146)
visible(L_Closed, true)
visible(L_Open, false)

R_Closed = img_add("cover_r_closed.png", 400 ,5,152,146)
R_Open = img_add("cover_r_open.png", 400 ,5,152,146)
visible(R_Closed, true)
visible(R_Open, false)


function cover_l_toggle()
    if left_run == 0 then
        left_run =1
        visible(L_Closed, false)
        visible(L_Open, true)
        sound_play(cover_open_snd)
     else
        left_run = 0
        visible(L_Closed, true)
        visible(L_Open, false)
        sound_play(cover_close_snd)
     end

end


button_add(nil, nil ,120 ,5,30,146, cover_l_toggle)                                                                                                                                                          

function cover_r_toggle()
    if right_run == 0 then
        right_run =1
        visible(R_Closed, false)
        visible(R_Open, true)
        sound_play(cover_open_snd)
    else
        right_run = 0
        visible(R_Closed, true)
        visible(R_Open, false)
        sound_play(cover_close_snd)
    end    

end

button_add(nil, nil, 525 ,5,30,146, cover_r_toggle)                                                                                                                                                          
                                                                                                                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                   