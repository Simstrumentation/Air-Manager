--[[
--******************************************************************************************
-- ****************** Cessna 310R (Milviz) Fuel Quantity Gauge *************************
--******************************************************************************************
    Made by SIMSTRUMENTATION based on graphics and code originally by
    Snack Stack Simulations
    
    GitHub: https://github.com/simstrumentation
    
       Fuel Quantity Gauge for Cessna 130R by Milviz
    
    NOTE:
        - Only guaranteed to work correctly with Milviz C130R 
        - Readaptation of the C402  guage by Snake Stack Simulations. Some graphics 
          and some code used in this project originally created by Snake Stack Simulations.
          
    V1.01 - Released 2022-05-15
        - Fixed error in dial graphic
        - Main tank level can now be checked when aux tanks are in use
    V1.0 - Released 2022-05-14
        Initial release
    

    KNOWN ISSUES:
    
   --******************************************************************************************
--]]

--local variables
local auxGauge   = 0
local fuelQuant1 = 0
local fuelQuant2 = 0
local fuelQuant4 = 0
local fuelQuant5 = 0
local busVolt    = 0
local switchposition = 1
local aux_l
local aux_r


img_add("C310R_fuel_gauge.png",3,3, 620, 620)
img_add("C310R_bezel.png",01, 0, 606, 606)
img_needle_L = img_add("C402_fuel_quant_needle_L.png", 113, 188, 66, 290)
img_needle_R = img_add("C402_fuel_quant_needle_R.png", 418, 188, 66, 290)

-- add switch text label
txt_add("AUX", "font:MS33558.ttf; size:22; color: white; halign:center;",210, 700, 200, 200)
txt_add("FUEL QTY", "font:MS33558.ttf; size:22; color: white; halign:center;",210, 726, 200, 200)

--FUEL QTY SWITCH
    -- reset timer and return switch to mid position
function clr_ind()
    timer_stop(timer_id1)
    fs2020_variable_write( "L:C310_SW_FUEL_IND", "ENUM", 1)
    visible(sw_up, false)
end

-- set switch to aux and start 2 second timer to reset switch
-- does not animate switch in virtual cockpit, but indicators work
function switch_activate()
    if aux_l == 1 and aux_r == 1 then
        fs2020_variable_write( "L:C310_SW_FUEL_IND", "ENUM", 0)
        visible(sw_up, true)
        timer_id1 = timer_start(2000, clr_ind)
    else
        if switchposition == 1 then
            fs2020_variable_write( "L:C310_SW_FUEL_IND", "ENUM", 2)
            timer_id1 = timer_start(2000, clr_ind)
        elseif switchposition == 2 then
            fs2020_variable_write( "L:C310_SW_FUEL_IND", "ENUM", 1)
        end

    end

    update_gui()
end
sw_fuel = switch_add("sm_sw_c.png", "sm_sw_dn.png", 260, 600, 100, 100, switch_activate)
sw_up = img_add("sm_sw_up.png", 260, 600, 100, 100, "visible:false")
--[[
-- placeholder for future functionality
function test_l()
    fs2020_variable_write( "L:C310_Fuel_Aux_L_Test", "Number", 1)
    fs2020_variable_write( "L:C310_Fuel_Aux_L_Test", "Number", 0)
end
]]--

btn_l_aux = switch_add("overheat.png", "overheat_on.png",20, 550, 125, 125, test_l)
btn_r_aux = switch_add("overheat.png", "overheat_on.png",460, 550, 125, 125, test_l)

-- control indicator lights
function set_indicators(left, right)
    aux_l = left
    aux_r = right
    if left == 1  then
        switch_set_position(btn_l_aux, 1)
    else
        switch_set_position(btn_l_aux, 0)
    end
    
    if right == 1   then
        switch_set_position(btn_r_aux, 1)
    else
        switch_set_position(btn_r_aux, 0)
    end
        print(aux_l)
end

fs2020_variable_subscribe("L:C310_WL_FUEL_AUX_LEFT", "Number",
                                              "L:C310_WL_FUEL_AUX_RIGHT", "Number", 
                                               set_indicators)
-- Functions --
function update_gui(switchpos)
    if busVolt >= 18 then
        rotate(img_needle_L, (-fuelQuant1 * (180/300)))
        rotate(img_needle_R, (fuelQuant2 * (180/300) ))
    end
end


function new_fuelGauge_fsx(eBusVolt, fuel_main_left, fuel_main_right, switchpos)
    busVolt = eBusVolt
    --convert gallons to lbs - 1 gal = 6.01 lbs @ 15ºC
     fuelQuant1 = var_cap(fuel_main_left * 6.01, 0, 300)
     fuelQuant2 = var_cap(fuel_main_right* 6.01, 0, 300)
     switchposition = switchpos
     
     if switchposition == 2 then
         switch_set_position(sw_fuel, 1)
     else
         switch_set_position(sw_fuel, 0)
     end
     update_gui()
end

--variable subscribe

fs2020_variable_subscribe("ELECTRICAL MAIN BUS VOLTAGE", "Volts", 
                          "L:C310_FUEL_DISP_L", "Gallons",
                          "L:C310_FUEL_DISP_R", "Gallons",
                          "L:C310_SW_FUEL_IND", "ENUM",
                           new_fuelGauge_fsx)                       
update_gui()