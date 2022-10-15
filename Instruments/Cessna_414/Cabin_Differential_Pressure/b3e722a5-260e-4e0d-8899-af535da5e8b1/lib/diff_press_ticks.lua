    
function draw_diff_press_face()

    local majorTickStartAngle = 180 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
    local majorTickSpace = 30 --degrees between major ticks
    local majorTickOD = 280 -- outer diameter of circle that terminates major tick marks
    local majorTickLength = 32 -- length of major tick marks
    local majorTickQuantity = 6 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
    local majorTickThickness = 5 -- pixel width of major tick line
    
    local minorTickOD = 280 -- outer diameter of circle that terminates minor tick marks
    local minorTickLength = 28 -- length of minor tick marks
    local minorTicksPerMajor = 1 -- how many minor tick divisions between major ticks
    local minorTicksGroups = majorTickQuantity -- how many groups of minor ticks (before mirroring)
    local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
    local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
    local minorTickThickness = 4 -- pixel width of minor tick line
    
    local majorTickColor = customWhite
    local minorTickColor = customWhite

    diff0 = txt_add("0", font_diffPressNum, 386, 250, 100, 100)
    diff1 = txt_add("1", font_diffPressNum, 378, 294, 100, 100)
    diff2 = txt_add("2", font_diffPressNum, 342, 324, 100, 100)
    diff3 = txt_add("3", font_diffPressNum, 292, 339, 100, 100)
    diff4 = txt_add("4", font_diffPressNum, 242, 328, 100, 100)
    diff5 = txt_add("5", font_diffPressNum, 214, 294, 100, 100)

    diff_txt = txt_add("DIFF", font_diffPressWord, 200, 168, 200, 200)
    diff_txt = txt_add("PRESS", font_diffPressWord, 200, 246, 200, 200)
    
    green_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 30.5,149.5,128)
        _stroke(customGreen, 22)
    end)
    
    white_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 0,180,137)
        _stroke(customWhite, 6)
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
        _move_to(196, 300)
        _line_to(160, 300)
        _stroke(customRed, 8)
    end)
    rotate(red_radial_id,330)
end
    