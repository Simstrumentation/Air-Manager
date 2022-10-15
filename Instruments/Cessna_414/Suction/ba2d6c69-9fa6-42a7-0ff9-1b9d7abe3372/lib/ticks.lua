    
function draw_face()

    local majorTickStartAngle = 54 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
    local majorTickSpace = 25 --degrees between major ticks
    local majorTickOD = 500 -- outer diameter of circle that terminates major tick marks
    local majorTickLength = 58 -- length of major tick marks
    local majorTickQuantity = 3 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
    local majorTickThickness = 7 -- pixel width of major tick line
    
    local minorTickOD = 500 -- outer diameter of circle that terminates minor tick marks
    local minorTickLength = 28 -- length of minor tick marks
    local minorTicksPerMajor = 1 -- how many minor tick divisions between major ticks
    local minorTicksGroups = majorTickQuantity -- how many groups of minor ticks (before mirroring)
    local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
    local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
    local minorTickThickness = 4 -- pixel width of minor tick line
    
    local majorTickColor = customWhite
    local minorTickColor = customWhite

    num3 = txt_add("3", font_Num, 188, 124, 100, 100)
    num4 = txt_add("4", font_Num, 250, 98, 100, 100)
    num5 = txt_add("5", font_Num, 332, 100, 100, 100)
    num6 = txt_add("6", font_Num, 396, 132, 100, 100)

    suction_txt = txt_add("SUCTION", font_suction, 210, 122, 200, 200)
    redinop_txt = txt_add("RED INOPERATIVE", font_suction, 100, 280, 400, 200)
    equal_txt = txt_add("=", font_equals, 204, 280, 400, 200)
    
    inhg_txt = txt_add("IN HG", font_inhg, 200, 160, 200, 200)
    l_txt = txt_add("L", font_LR, 70, 352, 200, 200)
    r_txt = txt_add("R", font_LR, 360, 352, 200, 200)
    source_txt = txt_add("SOURCE", font_source, 200, 400, 200, 200)
    
    green_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 275,290,240)
        _stroke(customGreen, 22)
    end)
    --START TICKS
    
    ias_ticks_id = canvas_add(0, 0, 600, 600, function()
        _rotate(majorTickStartAngle)
        
        --Ticks 40-50
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
    end)
    --Red radial
    red_radial_id = canvas_add(0, 0, 600, 600, function()
        _move_to(49.5, 300)
        _line_to(110, 300)
        _stroke(customRed, 12)
    end)
    rotate(red_radial_id,95)
end
    