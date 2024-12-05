--*****************************************************************************
--******************ATR 42/72-600 FMS MCDU Overlay*****************************
--*****************************************************************************
      
-- **v1.0** 13/07/2023 P A Bevington
-- Original Panel Created

-- **v1.1** 13/07/2023 P A Bevington
-- New Image with Nav and Com


--Backgroud Image 
img_add_fullscreen("background.png")

--Sounds   
snd_click = sound_add("click.wav")
snd_press = sound_add("press.wav")


--START OF BUTTONS************
--LSK1L Button
function MCDU1_LSK1L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L1", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L1_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK1L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L1", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L1_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 30,120,55,40, MCDU1_LSK1L_PRESS, MCDU1_LSK1L_RELEASE)

--LSK2L Button
function MCDU1_LSK2L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L2", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L2_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK2L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L2", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L2_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 30,180,55,40, MCDU1_LSK2L_PRESS, MCDU1_LSK2L_RELEASE)

--LSK3L Button
function MCDU1_LSK3L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L3", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L3_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK3L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L3", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L3_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 30,240,55,40, MCDU1_LSK3L_PRESS ,MCDU1_LSK3L_RELEASE)

--LSK4L Button
function MCDU1_LSK4L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L4", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L4_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK4L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L4", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L4_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 30,300,55,40, MCDU1_LSK4L_PRESS,MCDU1_LSK4L_RELEASE)

--LSK5L Button
function MCDU1_LSK5L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L5", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L5_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK5L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L5", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L5_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 30,360,55,40, MCDU1_LSK5L_PRESS,MCDU1_LSK5L_RELEASE)

--LSK6L Button
function MCDU1_LSK6L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L6", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L6_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK6L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L6", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L6_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 30,420,55,40, MCDU1_LSK6L_PRESS,MCDU1_LSK6L_RELEASE)

--LSK1R Button
function MCDU1_LSK1R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R1", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R1_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK1R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R1", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R1_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 715,120,55,40, MCDU1_LSK1R_PRESS,MCDU1_LSK1R_RELEASE)

--LSK2R Button
function MCDU1_LSK2R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R2", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R2_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK2R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R2", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R2_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 715,180,55,40, MCDU1_LSK2R_PRESS,MCDU1_LSK2R_RELEASE)

--LSK3R Button
function MCDU1_LSK3R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R3", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R3_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK3R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R3", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R3_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 715,240,55,40, MCDU1_LSK3R_PRESS,MCDU1_LSK3R_RELEASE)

--LSK4R Button
function MCDU1_LSK4R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R4", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R4_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK4R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R4", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R4_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 715,300,55,40, MCDU1_LSK4R_PRESS,MCDU1_LSK4R_RELEASE)

--LSK5R Button
function MCDU1_LSK5R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R5", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R5_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK5R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R5", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R5_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 715,360,55,40, MCDU1_LSK5R_PRESS,MCDU1_LSK5R_RELEASE)

--LSK6R Button
function MCDU1_LSK6R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R6", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R6_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_LSK6R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R6", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R6_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 715,420,55,40, MCDU1_LSK6R_PRESS,MCDU1_LSK6R_RELEASE)

--Function Buttons
--MENU
function MCDU1_MENU_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_MENU", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_MENU_Set", "Enum", 1)
   sound_play(snd_press)
      print ("MENU")
end
function MCDU1_MENU_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_MENU", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_MENU_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 40,550,65,45, MCDU1_MENU_PRESS,MCDU1_MENU_RELEASE)

--PREV
function MCDU1_PREV_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_PREV", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PREV_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_PREV_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_PREV", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PREV_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 120,550,65,45, MCDU1_PREV_PRESS,MCDU1_PREV_RELEASE)

--NEXT
function MCDU1_NEXT_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_NEXT", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_NEXT_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_NEXT_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_NEXT", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_NEXT_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 200,550,65,45, MCDU1_NEXT_PRESS,MCDU1_NEXT_RELEASE)

--RMS
function MCDU1_RMS_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_RMS", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_RMS_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_RMS_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_RMS", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_RMS_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 285,550,65,45, MCDU1_RMS_PRESS,MCDU1_RMS_RELEASE)

--FPLN
function MCDU1_FPLN_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_FPLN", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_FPLN_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_FPLN_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_FPLN", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_FPLN_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 370,550,65,45, MCDU1_FPLN_PRESS,MCDU1_FPLN_RELEASE)

--DTO
function MCDU1_DTO_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_DTO", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_DTO_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_DTO_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_DTO", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_DTO_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 455,550,65,45, MCDU1_DTO_PRESS,MCDU1_DTO_RELEASE)

--PERF
function MCDU1_PERF_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_PERF", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PERF_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_PERF_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_PERF", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PERF_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 540,550,65,45, MCDU1_PERF_PRESS,MCDU1_PERF_RELEASE)

--MSG
function MCDU1_MSG_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_MSG", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_MSG_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_MSG_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_MSG", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_MSG_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 620,550,65,45, MCDU1_MSG_PRESS,MCDU1_MSG_RELEASE)

--EXEC
function MCDU1_EXEC_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_EXEC", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_EXEC_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_EXEC_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_EXEC", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_EXEC_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 700,550,65,45, MCDU1_EXEC_PRESS,MCDU1_EXEC_RELEASE)

--PROG
function MCDU1_PROG_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_PROG", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PROG_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_PROG_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_PROG", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PROG_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 370,610,65,45, MCDU1_PROG_PRESS,MCDU1_PROG_RELEASE)

--DATA
function MCDU1_DATA_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_DATA", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_DATA_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_DATA_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_DATA", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_DATA_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 455,610,65,45, MCDU1_DATA_PRESS,MCDU1_DATA_RELEASE)

--VNAV
function MCDU1_VNAV_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_VNAV", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_VNAV_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_VNAV_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_VNAV", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_VNAV_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 540,610,65,45, MCDU1_VNAV_PRESS,MCDU1_VNAV_RELEASE)

--MRK
function MCDU1_MRK_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_MRK", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_MRK_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_MRK_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_MRK", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_MRK_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 620,610,65,45, MCDU1_MRK_PRESS,MCDU1_MRK_RELEASE)


--BRIGHT
--BRTUP
function MCDU1_BRTUP_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_BRT_UP", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_BRT_UP_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_BRTUP_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_BRT_UP", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_BRT_UP_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 700,610,32,45, MCDU1_BRTUP_PRESS,MCDU1_BRTUP_RELEASE)

--BRTDN
function MCDU1_BRTDN_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_BRT_DN", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_BRT_DN_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_BRTDN_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_BRT_DN", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_BRT_DN_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 733,610,32,45, MCDU1_BRTDN_PRESS,MCDU1_BRTDN_RELEASE)




--ONE Button
function MCDU1_ONE_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_1", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_1_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_ONE_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_1", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_1_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 85,610,49,49, MCDU1_ONE_PRESS,MCDU1_ONE_RELEASE)

--TWO Button
function MCDU1_TWO_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_2", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_2_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_TWO_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_2", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_2_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 150,610,49,49, MCDU1_TWO_PRESS,MCDU1_TWO_RELEASE)

--THREE Button
function MCDU1_THREE_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_3", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_3_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_THREE_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_3", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_3_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 215,610,49,49, MCDU1_THREE_PRESS,MCDU1_THREE_RELEASE)

--FOUR Button
function MCDU1_FOUR_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_4", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_4_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_FOUR_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_4", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_4_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 85,670,49,49, MCDU1_FOUR_PRESS,MCDU1_FOUR_RELEASE)

--FIVE Button
function MCDU1_FIVE_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_5", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_5_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_FIVE_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_5", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_5_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 150,670,49,49, MCDU1_FIVE_PRESS,MCDU1_FIVE_RELEASE)

--SIX Button
function MCDU1_SIX_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_6", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_6_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_SIX_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_6", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_6_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 215,670,49,49, MCDU1_SIX_PRESS,MCDU1_SIX_RELEASE)

--SEVEN Button
function MCDU1_SEVEN_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_7", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_7_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_SEVEN_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_7", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_7_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 85,730,49,49, MCDU1_SEVEN_PRESS,MCDU1_SEVEN_RELEASE)

--EIGHT Button
function MCDU1_EIGHT_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_8", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_8_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_EIGHT_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_8", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_8_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 150,730,49,49, MCDU1_EIGHT_PRESS,MCDU1_EIGHT_RELEASE)

--NINE Button
function MCDU1_NINE_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_9", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_9_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_NINE_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_9", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_9_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 215,730,49,49, MCDU1_NINE_PRESS,MCDU1_NINE_RELEASE)

--PERIOD Button
function MCDU1_PERIOD_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_PERIOD", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PERIOD_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_PERIOD_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_PERIOD", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PERIOD_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 85,800,49,49, MCDU1_PERIOD_PRESS,MCDU1_PERIOD_RELEASE)

--ZERO Button
function MCDU1_ZERO_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_0", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_0_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_ZERO_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_0", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_0_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 150,800,49,49, MCDU1_ZERO_PRESS,MCDU1_ZERO_RELEASE)

--PLUSMINUS Button
function MCDU1_PLUSMINUS_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_PLUSMINUS", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PLUSMINUS_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_PLUSMINUS_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_PLUSMINUS", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_PLUSMINUS_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 215,800,49,49, MCDU1_PLUSMINUS_PRESS,MCDU1_PLUSMINUS_RELEASE)


--SLASH Button
function MCDU1_SLASH_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_SLASH", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_SLASH_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_SLASH_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_SLASH", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_SLASH_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 150,860,50,50, MCDU1_SLASH_PRESS,MCDU1_SLASH_RELEASE)


--SP Button
function MCDU1_SP_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_SP", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_SP_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_SP_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_SP", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_SP_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 215,860,50,50, MCDU1_SP_PRESS,MCDU1_SP_RELEASE)


--Letter Buttons
--A Button
function MCDU1_A_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_A", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_A_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_A_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_A", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_A_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 285,670,55,55, MCDU1_A_PRESS,MCDU1_A_RELEASE)

--B Button
function MCDU1_B_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_B", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_B_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_B_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_B", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_B_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 355,670,55,55, MCDU1_B_PRESS,MCDU1_B_RELEASE)

--C Button
function MCDU1_C_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_C", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_C_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_C_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_C", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_C_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 425,670,55,55, MCDU1_C_PRESS,MCDU1_C_RELEASE)

--D Button
function MCDU1_D_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_D", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_D_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_D_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_D", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_D_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 495,670,55,55, MCDU1_D_PRESS,MCDU1_D_RELEASE)

--E Button
function MCDU1_E_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_E", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_E_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_E_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_E", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_E_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 565,670,55,55, MCDU1_E_PRESS,MCDU1_E_RELEASE)

--F Button
function MCDU1_F_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_F", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_F_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_F_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_F", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_F_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 635,670,55,55, MCDU1_F_PRESS,MCDU1_F_RELEASE)

--G Button
function MCDU1_G_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_G", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_G_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_G_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_G", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_G_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 705,670,55,55, MCDU1_G_PRESS,MCDU1_G_RELEASE)

--H Button
function MCDU1_H_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_H", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_H_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_H_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_H", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_H_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 285,730,55,55, MCDU1_H_PRESS,MCDU1_H_RELEASE)

--I Button
function MCDU1_I_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_I", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_I_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_I_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_I", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_I_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 355,730,55,55, MCDU1_I_PRESS,MCDU1_I_RELEASE)

--J Button
function MCDU1_J_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_J", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_J_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_J_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_J", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_J_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 425,730,55,55, MCDU1_J_PRESS,MCDU1_J_RELEASE)

--K Button
function MCDU1_K_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_K", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_K_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_K_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_K", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_K_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 495,730,55,55, MCDU1_K_PRESS,MCDU1_K_RELEASE)

--L Button
function MCDU1_L_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_L", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_L_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_L", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_L_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 565,730,55,55, MCDU1_L_PRESS,MCDU1_L_RELEASE)

--M Button
function MCDU1_M_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_M", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_M_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_M_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_M", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_M_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 635,730,55,55, MCDU1_M_PRESS,MCDU1_M_RELEASE)

--N Button
function MCDU1_N_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_N", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_N_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_N_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_N", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_N_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 705,730,55,55, MCDU1_N_PRESS,MCDU1_N_RELEASE)

--O Button
function MCDU1_O_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_O", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_O_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_O_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_O", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_O_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 285,790,55,55, MCDU1_O_PRESS,MCDU1_O_RELEASE)

--P Button
function MCDU1_P_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_P", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_P_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_P_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_P", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_P_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 355,790,55,55, MCDU1_P_PRESS,MCDU1_P_RELEASE)

--Q Button
function MCDU1_Q_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_Q", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_Q_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_Q_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_Q", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_Q_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 425,790,55,55, MCDU1_Q_PRESS,MCDU1_Q_RELEASE)

--R Button
function MCDU1_R_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_R", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_R_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_R", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_R_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 495,790,55,55, MCDU1_R_PRESS,MCDU1_R_RELEASE)

--S Button
function MCDU1_S_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_S", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_S_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_S_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_S", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_S_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 565,790,55,55, MCDU1_S_PRESS,MCDU1_S_RELEASE)

--T Button
function MCDU1_T_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_T", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_T_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_T_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_T", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_T_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 635,790,55,55, MCDU1_T_PRESS,MCDU1_T_RELEASE)

--U Button
function MCDU1_U_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_U", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_U_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_U_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_U", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_U_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 705,790,55,55, MCDU1_U_PRESS,MCDU1_U_RELEASE)

--V Button
function MCDU1_V_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_V", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_V_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_V_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_V", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_V_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 285,855,55,55, MCDU1_V_PRESS,MCDU1_V_RELEASE)

--W Button
function MCDU1_W_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_W", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_W_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_W_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_W", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_W_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 355,855,55,55, MCDU1_W_PRESS,MCDU1_W_RELEASE)

--X Button
function MCDU1_X_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_X", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_X_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_X_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_X", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_X_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 425,855,55,55, MCDU1_X_PRESS,MCDU1_X_RELEASE)

--Y Button
function MCDU1_Y_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_Y", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_Y_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_Y_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_Y", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_Y_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 495,855,55,55, MCDU1_Y_PRESS,MCDU1_Y_RELEASE)

--Z Button
function MCDU1_Z_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_Z", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_Z_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_Z_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_Z", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_Z_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 565,855,55,55, MCDU1_Z_PRESS,MCDU1_Z_RELEASE)


--CLR Button
function MCDU1_CLR_PRESS()
   msfs_variable_write("L:MSATR_MCDU1_CLR", "Enum", 1)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_CLR_Set", "Enum", 1)
   sound_play(snd_press)
end
function MCDU1_CLR_RELEASE()
   msfs_variable_write("L:MSATR_MCDU1_CLR", "Enum", 0)
   msfs_variable_write("L:MSATR_MCDU1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_MCDU_Key_CLR_Set", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 635,855,55,55, MCDU1_CLR_PRESS,MCDU1_CLR_RELEASE)


--COM and NAV Section For MCP1
--COM Button
function MCP1_COM_PRESS()
   msfs_variable_write("L:MSATR_MCP1_COM", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_com_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_COM_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_COM", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_com_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 100,985,65,55, MCP1_COM_PRESS,MCP1_COM_RELEASE)

--NAV Button
function MCP1_NAV_PRESS()
   msfs_variable_write("L:MSATR_MCP1_NAV", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_nav_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_NAV_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_NAV", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_nav_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 100,1045,65,55, MCP1_NAV_PRESS,MCP1_NAV_RELEASE)

--SURV Button
function MCP1_SURV_PRESS()
   msfs_variable_write("L:MSATR_MCP1_SURV", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_surv_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_SURV_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_SURV", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_surv_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 100,1110,65,55, MCP1_SURV_PRESS,MCP1_SURV_RELEASE)


--TOP
function MCP1_TOP_PRESS()
   msfs_variable_write("L:MSATR_MCP1_UP", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_top_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_TOP_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_UP", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_top_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 240,990,65,25, MCP1_TOP_PRESS,MCP1_TOP_RELEASE)

--DOWN
function MCP1_DOWN_PRESS()
   msfs_variable_write("L:MSATR_MCP1_DOWN", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_down_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_DOWN_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_DOWN", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_down_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 240,1085,65,25, MCP1_DOWN_PRESS,MCP1_DOWN_RELEASE)

--LEFT
function MCP1_LEFT_PRESS()
   msfs_variable_write("L:MSATR_MCP1_LEFT", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_left_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_LEFT_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_LEFT", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_left_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 205,1010,25,65, MCP1_LEFT_PRESS,MCP1_LEFT_RELEASE)

--RIGHT
function MCP1_RIGHT_PRESS()
   msfs_variable_write("L:MSATR_MCP1_RIGHT", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_right_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_RIGHT_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_RIGHT", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_right_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 310,1010,25,65, MCP1_RIGHT_PRESS,MCP1_RIGHT_RELEASE)

--ENTER
function MCP1_ENTER_PRESS()
   msfs_variable_write("L:MSATR_MCP1_ENTER", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_Enter_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_ENTER_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_ENTER", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_Enter_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 245,1020,55,55, MCP1_ENTER_PRESS,MCP1_ENTER_RELEASE)


--ESC
function MCP1_ESC_PRESS()
   msfs_variable_write("L:MSATR_MCP1_ESC", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_esc_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_ESC_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_ESC", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_esc_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 345,1110,65,55, MCP1_ESC_PRESS,MCP1_ESC_RELEASE)


--MCP1_ONE
function MCP1_ONE_PRESS()
   msfs_variable_write("L:MSATR_MCP1_1", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_ONE_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_1", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 465,985,55,55, MCP1_ONE_PRESS,MCP1_ONE_RELEASE)

--MCP1_TWO
function MCP1_TWO_PRESS()
   msfs_variable_write("L:MSATR_MCP1_2", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_2", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_TWO_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_2", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_2_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 530,985,55,55, MCP1_TWO_PRESS,MCP1_TWO_RELEASE)

--MCP1_THREE
function MCP1_THREE_PRESS()
   msfs_variable_write("L:MSATR_MCP1_3", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_3", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_THREE_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_3", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_3_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 595,985,55,55, MCP1_THREE_PRESS,MCP1_THREE_RELEASE)

--MCP1_FOUR
function MCP1_FOUR_PRESS()
   msfs_variable_write("L:MSATR_MCP1_4", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_4", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_FOUR_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_4", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_4_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 465,1045,55,55, MCP1_FOUR_PRESS,MCP1_FOUR_RELEASE)

--MCP1_FIVE
function MCP1_FIVE_PRESS()
   msfs_variable_write("L:MSATR_MCP1_5", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_5", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_FIVE_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_5", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_5_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 530,1045,55,55, MCP1_FIVE_PRESS,MCP1_FIVE_RELEASE)

--MCP1_SIX
function MCP1_SIX_PRESS()
   msfs_variable_write("L:MSATR_MCP1_6", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_6", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_SIX_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_6", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_6_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 595,1045,55,55, MCP1_SIX_PRESS,MCP1_SIX_RELEASE)

--MCP1_SEVEN
function MCP1_SEVEN_PRESS()
   msfs_variable_write("L:MSATR_MCP1_7", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_7", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_SEVEN_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_7", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_7_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 465,1110,55,55, MCP1_SEVEN_PRESS,MCP1_SEVEN_RELEASE)

--MCP1_EIGHT
function MCP1_EIGHT_PRESS()
   msfs_variable_write("L:MSATR_MCP1_8", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_8", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_EIGHT_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_8", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_8_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 530,1110,55,55, MCP1_EIGHT_PRESS,MCP1_EIGHT_RELEASE)

--MCP1_NINE
function MCP1_NINE_PRESS()
   msfs_variable_write("L:MSATR_MCP1_9", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_9", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_NINE_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_9", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_9_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 595,1110,55,55, MCP1_NINE_PRESS,MCP1_NINE_RELEASE)

--MCP1_ZERO
function MCP1_ZERO_PRESS()
   msfs_variable_write("L:MSATR_MCP1_0", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_0", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_ZERO_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_0", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_1_0_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 660,1015,55,55, MCP1_ZERO_PRESS,MCP1_ZERO_RELEASE)

--MCP1_DOT
function MCP1_PERIOD_PRESS()
   msfs_variable_write("L:MSATR_MCP1_PERIOD", "Enum", 1)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 1)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_dot_1", "Enum", 1)
   sound_play(snd_press)
end
function MCP1_PERIOD_RELEASE()
   msfs_variable_write("L:MSATR_MCP1_PERIOD", "Enum", 0)
   msfs_variable_write("L:MSATR_MCP1_INPUT", "Enum", 0)
   msfs_variable_write("B:INSTRUMENT_NavCom_Push_dot_1_KEY_Release", "Enum", 0)
   sound_play(snd_click)
end
button_add(nil,nil, 660,1075,55,55, MCP1_PERIOD_PRESS,MCP1_PERIOD_RELEASE)









