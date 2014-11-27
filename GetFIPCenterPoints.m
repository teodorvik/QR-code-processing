function[centerPoints] = GetFIPCenterPoints(fipPoints)
    fipLength = fipPoints(1,3,1)*6;
    
    fipPoints = sortrows(fipPoints);
     
    indexX = zeros(0,1); indexX = [indexX; 1];
    indexY = zeros(0,1); indexY = [indexY; 1];
    %% Calculate distance on both axis
    for i = 2:length(fipPoints)
        distX(i) = sqrt((fipPoints(i-1,1)-fipPoints(i,1)).^2);
        distY(i) = sqrt((fipPoints(i-1,2)-fipPoints(i,2)).^2);
    end

    %% X axis
    % Save the index of the largest distance in X
    ind = find(distX == max(distX(:)));
    indexX = [indexX; ind];
    
    % Save the second largest distance in X
    distX(ind) = 0;
    ind = find(distX == max(distX(:)));
    indexX = [indexX; ind];
    
    indexX = sort([indexX; length(fipPoints)]);
   
    %% Y axis
    % Save the index of the largest distance in Y
    ind = find(distY == max(distY(:)));
    indexY = [indexY; ind];
    
    % Save the second largest distance in Y
    distY(ind) = 0;
    ind = find(distY == max(distY(:)));
    indexY = [indexY; ind];
    
    indexY = sort([indexY; length(fipPoints)]);
    
    %% Extract the groups and calculate center points
    centerPoints = zeros(0,2);
    for i = 2:length(indexX)
        for j = 2:length(indexY)
            
            pointsX  = fipPoints(indexX(i-1):indexX(i)-1, :);
            pointsY  = fipPoints(indexY(j-1):indexY(j)-1, :);
   
            pointsInRange = intersect(pointsX, pointsY, 'rows');

            if length(pointsInRange) > 0
                centerX = (max(pointsInRange(:,1)) + min(pointsInRange(:,1)))/2;
                centerY = (max(pointsInRange(:,2)) + min(pointsInRange(:,2)))/2;
                
                centerPoints = [centerPoints; centerX, centerY];
            end
        end
    end

end