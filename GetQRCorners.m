function cornerPoints = GetQRCorners(image, centerPoints)

cornerPoints = zeros(4,2);

% find a good value for the radius in which the entire fip should be
% located
d = sort(pdist(centerPoints));
d = d(2);
r = int16(d*5/34);
% sensitivity = 0.001;
% corners = corner(image((centerPoints(1,2)-r):(centerPoints(1,2)+r),(centerPoints(1,1)-r):(centerPoints(1,1)+r)), 'Harris', 50, 'SensitivityFactor', sensitivity);
% subplot(1,3,1); imshow(image((centerPoints(1,2)-r):(centerPoints(1,2)+r),(centerPoints(1,1)-r):(centerPoints(1,1)+r)));
% hold on; plot(corners(:,1),corners(:,2),'bx');
% 
% corners = corner(image((centerPoints(2,2)-r):(centerPoints(2,2)+r),(centerPoints(2,1)-r):(centerPoints(2,1)+r)), 'Harris', 50, 'SensitivityFactor', sensitivity);
% subplot(1,3,2); imshow(image((centerPoints(2,2)-r):(centerPoints(2,2)+r),(centerPoints(2,1)-r):(centerPoints(2,1)+r)));
% hold on; plot(corners(:,1),corners(:,2),'bx');
% 
% corners = corner(image((centerPoints(3,2)-r):(centerPoints(3,2)+r),(centerPoints(3,1)-r):(centerPoints(3,1)+r)), 'Harris', 50, 'SensitivityFactor', sensitivity);
% subplot(1,3,3); imshow(image((centerPoints(3,2)-r):(centerPoints(3,2)+r),(centerPoints(3,1)-r):(centerPoints(3,1)+r)));
% hold on; plot(corners(:,1),corners(:,2),'bx');

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
%     imshow(I);
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
cornerDistFromCentroid = sqrt((allCorners(1,:) - centroid(1)).^2+(allCorners(2,:) - centroid(2)).^2)
cornerPoints(1,:) = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid(1:4))));
cornerPoints(2,:) = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid(5:8))));
cornerPoints(3,:) = allCorners(:,find(cornerDistFromCentroid==max(cornerDistFromCentroid(9:12))));

% TO DO
% Find the fourth corner of the QR-pattern

