
function collision( x1, y1, x2, y2 )
    distance = ( (x2 - x1)^2 + (y2 - y1)^2 )^(0.5)
    
    if ( distance < 16 ) then
        return true
    else
        return false
    end
end
