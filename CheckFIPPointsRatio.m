% Check FIP points ratio
% Returns true if the distance ratio between the points is similar to 
% FIP points i.e. 1:1:3:1:1.
% strictness determines how much a distance is allowed to vary compared
% to the average distance. For example strictness = 0.2 means that the
% distance can vary +- 0.2 times the average distance.
function isFIP = CheckFIPPointsRatio(pointsArray, strictness)
assert(all(size(pointsArray) == [6 2]));
assert(isa(strictness, 'double'));

if all(pointsArray(:,1) == pointsArray(1,1))
    pointsArray = pointsArray(:,2);
else
    pointsArray = pointsArray(:,1);
end

distances = [pointsArray(2) - pointsArray(1),
             pointsArray(3) - pointsArray(2),
             pointsArray(4) - pointsArray(3),
             pointsArray(5) - pointsArray(4),
             pointsArray(6) - pointsArray(5)];

distances = abs(distances);
      
meanDistance = abs(pointsArray(6) - pointsArray(1))/7;

isFIP = true;
for i = 1:5
    if i == 3
        dist = distances(3)/3;
    else
        dist = distances(i);
    end
    
    %fprintf('dist: %d \n', dist);
    %fprintf('meanDist: %d \n', meanDistance);
    
    if dist > meanDistance*(1+strictness) || dist < meanDistance*(1-strictness)
        %fprintf('NO TANGO DISTANCE');
        isFIP = false;
        break;
    end
end

