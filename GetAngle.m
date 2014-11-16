% Return the angle to the point based on the origin
% If angle > 180 it returns negative angle
function [angle] = GetAngle(position)

angle = (atan2(position(2), position(1)) * 180 )/ pi;

if (angle > 180)
    angle = -(360 - angle);
end