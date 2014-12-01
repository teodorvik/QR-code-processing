function[centerPoints] = GetFIPCenterPoints(fipPoints)
    fipLength = fipPoints(1,3,1)*4;
    numberOfPoints = length(fipPoints);
    
    % Add index on fipPoints
    fipPointsX = [(1:numberOfPoints)', fipPoints];
    fipPointsY = [(1:numberOfPoints)', fipPoints];
    
    %Sort fipPoints based on x and y. 1 = index
    fipPointsX = sortrows(fipPointsX,2);
    fipPointsY = sortrows(fipPointsY,3);
     
    indexX = zeros(0,1); indexX = [indexX, 1];
    indexY = zeros(0,1); indexY = [indexY, 1];
    %% Calculate distance on both axis
    distX = zeros(1, length(fipPoints));
    distY = zeros(1, length(fipPoints));
    for i = 2:length(fipPoints)
        distX(i) = sqrt((fipPointsX(i-1,2)-fipPointsX(i,2)).^2);
        distY(i) = sqrt((fipPointsY(i-1,3)-fipPointsY(i,3)).^2);
    end
    
    %% X axis
    % Save the index of the largest distance in X
    ind = find(distX == max(distX(:)));
    indexX = [indexX, ind(end)];
    
    % Save the second largest distance in X
    distX(ind) = 0;
    if(max(distX(:)) > fipLength)
        ind = find(distX == max(distX(:)));
        indexX = [indexX, ind(end)];
    end
    
    if(ind(end) ~= numberOfPoints)
        indexX = [indexX, numberOfPoints];
    end
    indexX = sort(indexX);
    
    %% Y axis
    % Save the index of the largest distance in Y
    ind = find(distY == max(distY(:)));
    indexY = [indexY, ind(end)];
    
    % Save the second largest distance in Y
    distY(ind) = 0;
    if(max(distY(:)) > fipLength)
        ind = find(distY == max(distY(:)));
        indexY = [indexY, ind(end)];
    end
    
    if(ind(end) ~= numberOfPoints)
        indexY = [indexY, numberOfPoints];
    end
    indexY = sort(indexY);
    
    %% Extract the groups and calculate center points
    centerPoints = zeros(0,3);
    for i = 2:length(indexX)
        for j = 2:length(indexY)
            
            pointsX  = fipPointsX(indexX(i-1):indexX(i)-1, 2:3);
            pointsY  = fipPointsY(indexY(j-1):indexY(j)-1, 2:3);
   
            pointsInRange = intersect(pointsX, pointsY, 'rows');

            if length(pointsInRange) > 0
                centerX = (max(pointsInRange(:,1)) + min(pointsInRange(:,1)))/2;
                centerY = (max(pointsInRange(:,2)) + min(pointsInRange(:,2)))/2;
                
                centerPoints = [centerPoints; centerX, centerY, length(pointsInRange)];
            end
        end
    end
    
    %% Remove center points that lays to close to each other
    while length(centerPoints) > 3    
        leastPoints = find(centerPoints(:,3) == min(centerPoints(:,3)));
        centerPoints(leastPoints,:) = [];
    end
    centerPoints = centerPoints(:,1:2);
    centerPoints = sortrows(centerPoints);
end