--[[
******************************************************************************************
***************CESSNA 414AW CHANCELLOR TRIPLE ENGINE GAUGE*****************
******************************************************************************************
    Made by SIMSTRUMENTATION "EXTERMINATE THE MICE FROM YOUR COCKPIT!"
    GitHub: https://simstrumentation.com

Triple engine gauge for the Cessna 414AWChancellor by FlySimware

Version info:
- **v1.0** - 2022-10-15

NOTES: 
- Designed to match the appearance of the C414AW
- Select which engine the gauge will be assigned to from the instrument user properties
- Front bezel glass and internal reflection can be disabled in the user properties
- Should work on other MSFS aircraft but compatibility not guaranteed

KNOWN ISSUES:
- None

ATTRIBUTION:
Based on code and graphics from Snake Stack Simulations
Sharing or re-use of any code or assets is not permitted without credit to the original authors.

Font : Mil Spec 33558
http://www.fontsaddict.com/font/MilSpec33558.html
******************************************************************************************

]]--
--***********************************************USER PROPERTY CONFIG***********************************************
engine_num_prop =  user_prop_add_enum("Engine Number","1, 2","1","Select Engine")    -- engine number select
showBezelGlare = user_prop_add_boolean("Show front glass", true, "Choose whether to see the bezel glass and needle reflections")
showScrews = user_prop_add_boolean("Show bezel screws", true, "Choose whether to see the bezel screws")
--********************************************* END USER PROPERTY CONFIG*********************************************

if user_prop_get(engine_num_prop ) == "1" then
   engine_number = "1"
else
    engine_number = "2"
end
--*********************************************END USER PROPERTY CONFIG*********************************************
--add graphics
img_add("bezel_face.png",10, 10, 580, 580)

        --cylinder head temp
shadow_needle_cht = img_add("shadow_small_needle.png", 206, 245, 19, 290)
img_needle_cht = img_add("cht_needle.png", 196, 235, 19, 290)

    --oil temp
shadow_needle_oilTemp = img_add("shadow_small_needle.png", 398, 245, 19, 290)
img_needle_oilTemp = img_add("oiltemp_needle.png", 388, 235, 19, 290)

    --oil pressure
shadow_needle_oilPress = img_add("shadow_needle_top.png", 153, 192 , 309, 68)
--opacity(shadow_needle_oilPress, 0.5)
img_needle_oilPress = img_add("top_needle.png", 143, 182 , 309, 68)


img_add_fullscreen("raised.png")
if user_prop_get(showBezelGlare )then
    --glass glare
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)       
end    
    -- if bezel glass and reflection is on
if user_prop_get(showBezelGlare )then
    reflect_needle_oilPress = img_add("top_needle.png", 133, 192 , 309, 68) 
    opacity(reflect_needle_oilPress, 0.08)
    glare_id=img_add("glass_glare.png", 1, 1, 600, 600)
    rotate(glare_id, -100)
    opacity(glare_id, .3)       
end    


img_add_fullscreen("bezel.png")

    -- show bezel screws if user prop selected. Screw rotation is randomized
if user_prop_get(showScrews ) then  
    screw_tl_id = img_add("screw.png", 34, 34, 70, 70)
    math.randomseed(os.clock()*100000000000)
    rotate(screw_tl_id, math.random(1,360))
    screw_tr_id = img_add("screw.png", 496, 34, 70, 70)
    math.randomseed(os.clock()*200000000000)
    rotate(screw_tr_id, math.random(1,360))
    screw_bl_id = img_add("screw.png", 34, 500, 70, 70)
    math.randomseed(os.clock()*300000000000)
    rotate(screw_bl_id, math.random(1,360))
    screw_br_id = img_add("screw.png", 496, 500, 70, 70)
    math.randomseed(os.clock()*400000000000)
    rotate(screw_br_id, math.random(1,360))
end    

--check for power
function new_electricBus(eBusVolt)
    busVolt = eBusVolt[1]
    return busVolt
end

function new_electricBus_FSX(eBusVolt)
    new_electricBus({eBusVolt})   
end

-- cylinder head temperature
function new_CHT(eCHT)
    CHT = (9/5 *((eCHT[1]) +32))
    CHT = var_cap(CHT, 0, 550)
    if busVolt >= 18 then
        rotate(img_needle_cht, (CHT * (105/500))+3, "LOG", 0.04)
        rotate(shadow_needle_cht, (CHT * (105/500))+3, "LOG", 0.04)
        
    else
        rotate(img_needle_cht, 0, "LOG", 0.04)
        rotate(shadow_needle_cht, 0, "LOG", 0.04)
    end
end

function new_CHT_FSX(CHT1)
    new_CHT({CHT1})  
end

--Oil temperature
function new_oilTemp(eOilTemp)
    oilTemp = (9/5 *((eOilTemp[1]) +32))
    oilTemp = var_cap(oilTemp, 0, 300)
    if busVolt >= 18 then
   
        rotate(shadow_needle_oilTemp, ((oilTemp * (112/240)*-1)+18), "LOG", 0.04)
        rotate(img_needle_oilTemp, ((oilTemp * (112/240)*-1)+18), "LOG", 0.04)
      
        
    else
        rotate(shadow_needle_oilTemp, 0)
        rotate(img_needle_oilTemp, 0)
    end
end

function new_oilTemp_FSX(eOilTemp)
    new_oilTemp({eOilTemp}) 
end

--Oil Pressure
function new_oilPress(eOilPress)
    oilPress = eOilPress[1]
    oilPress = var_cap(oilPress, 0, 120)
    rotate(img_needle_oilPress, ((180/120) * oilPress))
    rotate(shadow_needle_oilPress, ((180/120) * oilPress))
    rotate(reflect_needle_oilPress, ((180/120) * oilPress))
 end

function new_oilPress_FSX(eOilPress)
    new_oilPress({eOilPress})
end
--***********************************************VARIABLE SUBSCRIBE***********************************************
fs2020_variable_subscribe("ELECTRICAL GENALT BUS VOLTAGE:"..tostring(engine_number).."", "Volts", new_electricBus_FSX)
fs2020_variable_subscribe("ENG CYLINDER HEAD TEMPERATURE:"..tostring(engine_number).."", "Celsius", new_CHT_FSX)
fs2020_variable_subscribe("ENG OIL TEMPERATURE:"..tostring(engine_number).."", "Celsius", new_oilTemp_FSX)
fs2020_variable_subscribe("ENG OIL PRESSURE:"..tostring(engine_number).."", "PSI", new_oilPress_FSX)