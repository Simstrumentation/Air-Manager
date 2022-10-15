
function draw_face()

    --START CABIN ALT TICKS
    local majorTickStartAngle = 342 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
    local majorTickSpace = 77 --degrees between major ticks
    local majorTickOD = 530 -- outer diameter of circle that terminates major tick marks
    local majorTickLength = 50 -- length of major tick marks
    local majorTickQuantity = 2 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
    local majorTickThickness = 7 -- pixel width of major tick line
    
    local minorTickOD = 530 -- outer diameter of circle that terminates minor tick marks
    local minorTickLength = 50 -- length of minor tick marks
    local minorTicksPerMajor = 5 -- how many minor tick divisions between major ticks
    local minorTicksGroups = majorTickQuantity -- how many groups of minor ticks (before mirroring)
    local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
    local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
    local minorTickThickness = 5 -- pixel width of minor tick line
    
    local majorTickColor = customWhite
    local minorTickColor = customWhite
    
        -- Green Arc
    green_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 25,63,244)
        _stroke(customGreen, 56)
    end)
    
    --Brignt Green Arc
    bright_green_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 162,208,246)
        _stroke(customBrightGreen, 50)
    end)

    txt0 = txt_add("0", font_Num, 108, 312, 100, 100)
    txt5 = txt_add("5", font_Num, 190, 100, 100, 100)
    txt10 = txt_add("10", font_Num, 406, 125, 100, 100)
    txt15 = txt_add("15", font_Num, 450, 320, 100, 100)
    txt20 = txt_add("20", font_Num, 296, 424, 100, 100)
    
    oxgen_txt = txt_add("OXYGEN CYL", font_maintxt, 150, 230, 300, 200)
    eleven_txt = txt_add("11", font_maintxt, -38, 400, 400, 200)
    capacity_txt = txt_add("CU FT CAPACITY", font_maintxt, 110, 400, 400, 200)
    psi_txt = txt_add("PSI X 100", font_psi, 150, 250, 300, 200)
    period1_txt = txt_add(".", font_period, 208, 394, 44, 44)
    period2_txt = txt_add(".", font_period, 264, 394, 44, 44)
    
    tas_ticks_id = canvas_add(0, 0, 600, 600, function()
        _rotate(majorTickStartAngle)
        
        --Ticks 0-10
        for i=1,minorTickQuantity do
          _move_to((600-minorTickOD)/2, 300)
          _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
          _stroke(minorTickColor, minorTickThickness)
          _rotate(minorTickSpace)
        end
        _rotate(- (minorTickQuantity * minorTickSpace))
        for i=1,majorTickQuantity + 1 do
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
        --Ticks 10-20
        majorTickSpace = 64
        majorTickQuantity = 2
        minorTicksGroups = majorTickQuantity
        minorTickQuantity = minorTicksGroups * minorTicksPerMajor 
        minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity)
        for i=1,minorTickQuantity do
            _move_to((600-minorTickOD)/2, 300)
            _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
            _stroke(minorTickColor, minorTickThickness)
            _rotate(minorTickSpace)
        end
        _rotate(- (minorTickQuantity * minorTickSpace))
        for i=1,majorTickQuantity + 1 do
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            if i == 3 then
                _stroke(customRed, majorTickThickness + 2)
            else
                _stroke(majorTickColor, majorTickThickness)
            end
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)

    end)
end
    