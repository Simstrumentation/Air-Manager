
function draw_tas_face()

    --START TAS TICKS
    local majorTickStartAngle = 121.5 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
    local majorTickSpace = 14.5 --degrees between major ticks
    local majorTickOD = 320 -- outer diameter of circle that terminates major tick marks
    local majorTickLength = 30 -- length of major tick marks
    local majorTickQuantity = 1 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
    local majorTickThickness = 4 -- pixel width of major tick line
    
    local minorTickOD = 320 -- outer diameter of circle that terminates minor tick marks
    local minorTickLength = 18 -- length of minor tick marks
    local minorTicksPerMajor = 2 -- how many minor tick divisions between major ticks
    local minorTicksGroups = majorTickQuantity -- how many groups of minor ticks (before mirroring)
    local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
    local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
    local minorTickThickness = 4 -- pixel width of minor tick line
    
    local majorTickColor = customWhite
    local minorTickColor = customWhite
    
    tas_ticks_id = canvas_add(0, 0, 600, 600, function()
        _rotate(majorTickStartAngle)
        
        --Ticks 40-50
        _txt("40", font_tas, 176,300)
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
    
        --Ticks 50-100
        majorTickSpace = 18.3
        majorTickQuantity = 5
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
            if i==2 then
                _txt("60", font_tas, 176,300)
            end
            if i==4 then
                _txt("80", font_tas, 176,300)
            end
            if i==6 then
                _txt("100", font_tas, 176,300)
            end
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
         
        --Ticks 100-110
        majorTickSpace = 17
        majorTickQuantity = 1
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

        -- 110 - 140
        majorTickSpace = 16
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
            if i==2 then
                _txt("120", font_tas, 176,300)
            end
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
          
        -- 140 - 160
        majorTickSpace = 14
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
            if i==1 then
                _txt("140", font_tas, 176,300)
            end
            if i==3 then
                _txt("160", font_tas, 176,300)
            end
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
          
        -- 160-180
        majorTickSpace = 12.5
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
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
          
        -- 180-200
        majorTickSpace = 11.4
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
            if i==3 then
                _txt("200", font_tas, 176,300)
            end
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)

        -- 200-250
        majorTickSpace = 56.5/6
        majorTickQuantity = 5
        minorTicksPerMajor = 2 -- how many minor tick divisions between major ticks
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
            if i==6 then
                _txt("250", font_tas, 176,300)
            end
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)

        -- 250-350
        majorTickSpace = 24
        majorTickQuantity = 2
        minorTicksPerMajor = 5 -- how many minor tick divisions between major ticks
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
            if i==2 then
                _txt("300", font_tas, 176,300)
            end
            if i==3 then
                _txt("350", font_tas, 176,300)
            end
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)
    end)
end
    