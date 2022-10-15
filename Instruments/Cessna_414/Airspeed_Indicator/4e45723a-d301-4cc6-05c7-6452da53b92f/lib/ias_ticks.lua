    
function draw_static_face()

    local majorTickStartAngle = 121.5 -- degrees for first tick mark position, starts at 9 o'clock, positive clockwise
    local majorTickSpace = 14.5 --degrees between major ticks
    local majorTickOD = 560 -- outer diameter of circle that terminates major tick marks
    local majorTickLength = 64 -- length of major tick marks
    local majorTickQuantity = 1 -- number of tick marks in one direction (i.e. before mirroring), including the "zero" tick
    local majorTickThickness = 5 -- pixel width of major tick line
    
    local minorTickOD = 560 -- outer diameter of circle that terminates minor tick marks
    local minorTickLength = 42 -- length of minor tick marks
    local minorTicksPerMajor = 2 -- how many minor tick divisions between major ticks
    local minorTicksGroups = majorTickQuantity -- how many groups of minor ticks (before mirroring)
    local minorTickQuantity = minorTicksGroups * minorTicksPerMajor -- calculates how many ticks to use
    local minorTickSpace = (majorTickSpace * (minorTicksGroups))/(minorTickQuantity) -- calculates how many degrees between minor ticks
    local minorTickThickness = 4 -- pixel width of minor tick line
    
    local majorTickColor = customWhite
    local minorTickColor = customWhite

    ias40 = txt_add("40", font_ias, 306, 126, 200, 200)
    ias60 = txt_add("60", font_ias, 370, 200, 200, 200)
    ias80 = txt_add("80", font_ias, 390, 326, 200, 200)
    ias100 = txt_add("100", font_ias, 330, 426, 200, 200)
    ias120 = txt_add("120", font_ias, 236, 478, 200, 200)
    ias140 = txt_add("140", font_ias, 132, 466, 200, 200)
    ias160 = txt_add("160", font_ias, 52, 406, 200, 200)
    ias200 = txt_add("200", font_ias, 18, 254, 200, 200)
    ias260 = txt_add("260", font_ias, 114, 112, 200, 200)
    
    airspeed_txt = txt_add("AIRSPEED", font_ias, 206, 132, 200, 200)
    knots_txt = txt_add("KNOTS", font_knots, 206, 172, 200, 200)
    ias_txt = txt_add("IAS", font_ias, 206, 68, 200, 200)
    tas_txt = txt_add("TAS", font_ias, 276, 392, 200, 200)
       
    --IAS Triangle
    local triangleSize = 14
     
    ias_triangle_id = canvas_add(336, 74, 60,60, function()
      _triangle(0, 0, 0, triangleSize, triangleSize,triangleSize/2)
      _fill(customWhite)
    end)
    
    --TAS Triangle
     
    tas_triangle_id = canvas_add(324, 400, 60,60, function()
      _triangle(triangleSize, 0, triangleSize, triangleSize, 0,triangleSize/2)
      _fill(customWhite)
    end)
    
    -- Draw arcs
    -- Green Arc
    green_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 0,192.5,259)
        _stroke(customGreen, 42)
    end)
    
    --Yellow Arc
    yellow_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 192.5,217,259)
        _stroke(customYellow, 42)
    end)
    
    --White Arc
    white_arc_id = canvas_add(0,0,600,600, function()
        _arc(300, 300, 0,113,244)
        _stroke(customWhite, 12)
    end)
    
    --Bottom of white arc
    white_radial_id = canvas_add(0, 0, 600, 600, function()
        _move_to(((600-minorTickOD)/2), 300)
        _line_to(((600-minorTickOD)/2)+ minorTickLength, 300)
        _stroke(customWhite, 12)
    end)
    rotate(white_radial_id,180)

    --START IAS TICKS
    
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
        _rotate(-(minorTickQuantity * minorTickSpace))
        for i=1,majorTickQuantity + 1 do
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
        _rotate(-(minorTickQuantity * minorTickSpace))
        for i=1,majorTickQuantity + 1 do
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
        _rotate(-(minorTickQuantity * minorTickSpace))
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
        _rotate(-(minorTickQuantity * minorTickSpace))
        for i=1,majorTickQuantity + 1 do
            _move_to((600-majorTickOD)/2, 300)
            _line_to(((600-majorTickOD)/2)+ majorTickLength, 300)
            _stroke(majorTickColor, majorTickThickness)
            _rotate(majorTickSpace)
        end
        _rotate(-majorTickSpace)

        -- 200-260
        majorTickSpace = 56.5
        majorTickQuantity = 1
        minorTicksPerMajor = 6 -- how many minor tick divisions between major ticks
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
    end)

        --Vstall red radial
    stall_radial_id = canvas_add(0, 0, 600, 600, function()
        _move_to(((600-majorTickOD)/2), 300)
        _line_to(((600-majorTickOD)/2)+ majorTickLength+5, 300)
        _stroke(customRed, 10)
    end)
    rotate(stall_radial_id,182)

    --Vne red radial
    vne_radial_id = canvas_add(0, 0, 600, 600, function()
        _move_to(((600-majorTickOD)/2), 300)
        _line_to(((600-majorTickOD)/2)+ majorTickLength+5, 300)
        _stroke(customRed, 10)
    end)
    rotate(vne_radial_id,37)

    --Vblue radial
    blue_radial_id = canvas_add(0, 0, 600, 600, function()
        _move_to(((600-majorTickOD)/2), 300)
        _line_to(((600-majorTickOD)/2)+ majorTickLength+8, 300)
        _stroke(customBlue, 10)
    end)
    rotate(blue_radial_id,248.5)
end
    