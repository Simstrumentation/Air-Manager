
function draw_cabin_alt_face()

    --START CABIN ALT TICKS
    local majorTickStartAngle = 180 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
    local majorTickSpace = 60 --degrees between major ticks
    local majorTickOD = 530 -- outer diameter of circle that terminates major tick marks
    local majorTickLength = 40 -- length of major tick marks
    local majorTickQuantity = 3 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
    local majorTickThickness = 7 -- pixel width of major tick line
    
    local minorTickOD = 530 -- outer diameter of circle that terminates minor tick marks
    local minorTickLength = 22 -- length of minor tick marks
    local minorTicksPerMajor = 5 -- how many minor tick divisions between major ticks
    local minorTicksGroups = majorTickQuantity -- how many groups of minor ticks (before mirroring)
    local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
    local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
    local minorTickThickness = 5 -- pixel width of minor tick line
    
    local majorTickColor = customWhite
    local minorTickColor = customWhite
    alt0 = txt_add("0", font_altNum, 486, 250, 100, 100)
    alt5 = txt_add("5", font_altNum, 390, 420, 100, 100)
    alt10 = txt_add("10", font_altNum, 180, 414, 100, 100)
    alt15 = txt_add("15", font_altNum, 90, 250, 100, 100)
    alt20 = txt_add("20", font_altNum, 140, 114, 100, 100)
    alt25 = txt_add("25", font_altNum, 246, 60, 100, 100)
    alt30 = txt_add("30", font_altNum, 370, 90, 100, 100)
    alt35 = txt_add("35", font_altNum, 440, 140, 100, 100)
    
    cabin_txt = txt_add("CABIN", font_cabinAlt, 400, 214, 200, 200)
    alt_txt = txt_add("ALT", font_cabinAlt, 400, 246, 200, 200)
    x_txt = txt_add("X", font_x1000f, 400, 248, 200, 200)
    label1000_txt = txt_add("1000", font_x1000f, 380, 280, 200, 200)
    labelf_txt = txt_add("F", font_x1000f, 430, 280, 200, 200)
    psi_txt = txt_add("PSI", font_psi, 200, 70, 200, 200)
    
    tas_ticks_id = canvas_add(0, 0, 600, 600, function()
        _rotate(majorTickStartAngle)
        
        --Ticks 0-15
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
        --Ticks 15-30
        majorTickSpace = 41
        majorTickQuantity = 3
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
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
         
        --Ticks 30-35
        majorTickSpace = 32
        majorTickQuantity = 1
        minorTicksGroups = majorTickQuantity
        minorTickQuantity = minorTicksGroups * minorTicksPerMajor 
        minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity)

        for i=1,minorTickQuantity + 1 do
            _move_to((600-minorTickOD)/2, 300)
            _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
            _stroke(minorTickColor, minorTickThickness)
            _rotate(minorTickSpace)
        end
        _rotate(- ((minorTickQuantity + 1)* minorTickSpace))
        _move_to((600-majorTickOD)/2, 300)
        _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
        _stroke(majorTickColor, majorTickThickness)
        _rotate(majorTickSpace)
        _rotate(-majorTickSpace)
    end)
end
    