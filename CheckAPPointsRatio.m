% Check AP points ratio
% Returns true if the distance ratio between the points is similar to 
% AP points i.e. 1:1:1.
% strictness determines how much a distance is allowed to vary compared
% to the average distance. For example strictness = 0.2 means that the
% distance can vary +- 0.2 times the average distance.
function isAP = CheckAPPointsRatio(pointsArray, strictness)
assert(all(size(pointsArray) == [4 2]));
assert(isa(strictness, 'double'));

if all(pointsArray(:,1) == pointsArray(1,1))
    pointsArray = pointsArray(:,2);
else
    pointsArray = pointsArray(:,1);
end

distances = [pointsArray(2) - pointsArray(1),
             pointsArray(3) - pointsArray(2),
             pointsArray(4) - pointsArray(3)];

distances = abs(distances);
      
meanDistance = abs(pointsArray(4) - pointsArray(1))/3;

isAP = true;
for i = 1:3
    dist = distances(i);
   
    if dist > meanDistance*(1+strictness) || dist < meanDistance*(1-strictness)
        isAP = false;
        break;
    end
end

