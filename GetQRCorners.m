function cornerPoints = GetQRCorners(image, centerPoints)

% find a good value for the radius in which the entire fip should be
% located
d = sort(pdist(centerPoints));
d = d(2);
r = int16(d*5/34);

allCorners = zeros(2,12);
for fipIndex = 1:3
    % Create a binary image with the FIP as a filled square
    I = image((centerPoints(fipIndex,2)-r):(centerPoints(fipIndex,2)+r),...
              (centerPoints(fipIndex,1)-r):(centerPoints(fipIndex,1)+r));
    Ibw = ~im2bw(I,graythresh(I));
    Ifill = imfill(Ibw,'holes');
    Iarea = bwareaopen(Ifill, floor(max(size(I))*0.5)^2); % Removes small objects 
    Ifinal = bwlabel(Iarea);

    % Find corners of the square by finding out how far the centroid is
    % from points in each quadrant.
    % Doesnt work for squares that are rotated a lot.
    % Could be possible to use one of matlabs build in corner detection
    % functions
    
    % First get all the points.
    [rows columns] = find(Ifinal);
    
    % Have the center of the image as the center of the square
    [xCentroid yCentroid] = size(Ifinal);
    xCentroid = floor(xCentroid/2);
    yCentroid = floor(yCentroid/2);
    xCorners = [0 0 0 0]; % X coordinate of corners in each quadrant.
    yCorners = [0 0 0 0]; % X coordinate of corners in each quadrant.
    maxDistance = [0 0 0 0]; % Distance of furthers X coordinate from centroid in each quadrant.
    for k = 1 : length(columns)
        rowk = rows(k);
        colk = columns(k);
        distanceSquared = (colk - xCentroid)^2 + (rowk - yCentroid)^2;
        if rowk < yCentroid
            % It's in the top half
            if colk < xCentroid
                % It's in the upper left quadrant
                if distanceSquared > maxDistance(1)
                    % Record the new furthest point in quadrant #1.
                    maxDistance(1) = distanceSquared;
                    xCorners(1) = colk;
                    yCorners(1) = rowk;
                end
            else
                % It's in the upper right quadrant
                if distanceSquared > maxDistance(2)
                    % Record the new furthest point in quadrant #2.
                    maxDistance(2) = distanceSquared;
                    xCorners(2) = colk;
                    yCorners(2) = rowk;
                end
            end
        else
            % It's in the bottom half.
            if colk < xCentroid
                % It's in the lower left quadrant
                if distanceSquared > maxDistance(3)
                    % Record the new furthest point in quadrant #3.
                    maxDistance(3) = distanceSquared;
                    xCorners(3) = colk;
                    yCorners(3) = rowk;
                end
            else
                % It's in the lower right quadrant
                if distanceSquared > maxDistance(4)
                    % Record the new furthest point in quadrant #4.
                    maxDistance(4) = distanceSquared;
                    xCorners(4) = colk;
                    yCorners(4) = rowk;
                end
            end
        end
    end
     
%     figure;
%     imshow(Ifinal);
%     hold on;
%     plot(xCorners, yCorners,  'rs', 'MarkerSize', 10, 'LineWidth', 3);
    
    xTranslate = centerPoints(fipIndex,1) - double(r);
    yTranslate = centerPoints(fipIndex,2) - double(r);

    % Add the four corner points found to the array
    allCorners(:,1+(fipIndex-1)*4:fipIndex*4) = [xCorners + xTranslate; yCorners + yTranslate];
end

% Create centroid in the middle of all fips.
centroid = sum(centerPoints)/3;

% Use centroid to find the outmost corners of the fips. (Four corner points
% are stored in allPoints for each FIP).
cornerDistFromCentroid = sqrt((allCorners(1,:) - centroid(1)).^2+(allCorners(2,:) - centroid(2)).^2);
cornerPoints(1,:) = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid(1:4))));
cornerPoints(2,:) = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid(5:8))));
cornerPoints(3,:) = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid(9:12))));

%% Calculate the distances between pair of points
distancesCorners = pdist(cornerPoints(1:3,:));
% distancesCorners(1) = distance between 2 and 1
% distancesCorners(2) = distance between 3 and 1
% distancesCorners(3) = distance between 3 and 2

%% Since we know which corner that got the most distance between them we also
% know that the remaining corner is the top left corner.
[maxVal ind] = max(distancesCorners);
if ind == 1
    topLeftIndex = 3;
elseif ind == 2
    topLeftIndex = 2;
elseif ind == 3
    topLeftIndex = 1;
end

cornerIndices = [1 2 3];
unknownCorners = cornerIndices(cornerIndices~=topLeftIndex);

%% Set the cornerpoints in the correct order so we can translate them later
% correct order: topleft, topright, bottomleft, bottomright
topLeft = cornerPoints(topLeftIndex,:);
unknownCorner1 = cornerPoints(unknownCorners(1),:);
unknownCorner2 = cornerPoints(unknownCorners(2),:);

if (GetAngle(unknownCorner1-topLeft) < GetAngle(unknownCorner2-topLeft))
    cornerPoints(1,:) = topLeft;
    cornerPoints(2,:) = unknownCorner1;
    cornerPoints(3,:) = unknownCorner2;
    topRightIndex = unknownCorners(1);
    bottomLeftIndex = unknownCorners(2);
else
    cornerPoints(1,:) = topLeft;
    cornerPoints(2,:) = unknownCorner2;
    cornerPoints(3,:) = unknownCorner1;
    topRightIndex = unknownCorners(2);
    bottomLeftIndex = unknownCorners(1);
end

%% Find the the other points that will form a line towards the fourth corner
% It's a bit hard to explain. I think an educational illustration is
% required here:
% 

% Create centroid in the top left corner.
centroid = topLeft;

% Use centroid to find the outmost corners of the fips. (Four corner points
% are stored in allPoints for each FIP).
cornerDistFromCentroid = sqrt((allCorners(1,:) - centroid(1)).^2+(allCorners(2,:) - centroid(2)).^2);
find(cornerDistFromCentroid==max(cornerDistFromCentroid((topRightIndex-1)*4+1:(topRightIndex-1)*4+4)))
find(cornerDistFromCentroid==max(cornerDistFromCentroid((bottomLeftIndex-1)*4+1:(bottomLeftIndex-1)*4+4)))
topRightSecondPoint = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid((topRightIndex-1)*4+1:(topRightIndex-1)*4+4))));
bottomLeftSecondPoint = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid((bottomLeftIndex-1)*4+1:(bottomLeftIndex-1)*4+4))));

%% Calculate where the two lines intersect to find the fourth corner
% line equations i.e. y = k*x + m
dx1 = cornerPoints(2,2)-topRightSecondPoint(2);
dx2 = cornerPoints(3,2)-bottomLeftSecondPoint(2);
dy1 = cornerPoints(2,1)-topRightSecondPoint(1);
dy2 = cornerPoints(3,1)-bottomLeftSecondPoint(1);

if  dy1 == 0.0
    fprintf('DELA MED NOLL!');
    % H�r beh�ver g�ras lite skit
end

k1 = dx1/dy1
m1 = (topRightSecondPoint(2)-k1*topRightSecondPoint(1));
k2 = dx2/dy2;
m2 = (bottomLeftSecondPoint(2)-k2*bottomLeftSecondPoint(1));

fourthCornerX = (m2 - m1)/(k1 - k2);
fourthCornerY = k1*fourthCornerX+m1;

cornerPoints(4,:) = [fourthCornerX, fourthCornerY];


