function positions = FIPLineScan(binaryImage, strictness)
assert(isa(binaryImage, 'logical'));
assert(isa(strictness, 'double'));

[rows columns] = size(binaryImage);
positions = zeros(0, 2);
verticalScanPoints = zeros(0,3);
horizontalScanPoints = zeros(0,3);
diagonalScanPoints1 = zeros(0,3);
diagonalScanPoints2 = zeros(0,3);

%% horizontal scan
% scan one row at a time
for j = 1:rows
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(6, 2);
    
    % iterate through each pixel in the row
    for i = 1:columns
        if i + 1 <= columns
            % En edge is found if 0 and 1 are next to each other
            if binaryImage(j, i) == 0 && binaryImage(j, i + 1) == 1
                % throw the first point in the array and push back the new
                currentPoints = [currentPoints(2:6,:); j, i];

                % If there are no zeros in the currentPoints array it
                % is filled with 6 edge points
                if(~any(currentPoints == 0))
                    % Check if the distance ratio between all points
                    % matches the ratio of a FIP
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        % Add to the positions array
                        % positions = [positions; 0.5*(currentPoints(1,:)+currentPoints(6,:))];
                        bigSquareLength = length(currentPoints(4,:) - currentPoints(3,:));
                        horizontalScanPoints = [horizontalScanPoints; 0.5*(currentPoints(1,:)+currentPoints(6,:)), bigSquareLength];
                    end
                end
            end
        else
            break;
        end
    end
end

%% vertical scan
% scan one column at a time
for i = 1:columns
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(6, 2);
    
    % iterate through each pixel in the column
    for j = 1:rows
        if j + 1 <= rows
            if binaryImage(j, i) == 0 && binaryImage(j + 1, i) == 1
                currentPoints = [currentPoints(2:6,:); j, i];
                
                % If there are no zeros in the currentPoints array it
                % is filled with 6 edge points
                if(~any(currentPoints == 0))
                    % Check if the distance ratio between all points
                    % matches the ratio of a FIP
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        % Add to the positions array
                        % positions = [positions; 0.5*(currentPoints(1,:)+currentPoints(6,:))];
                        bigSquareLength = length(currentPoints(4,:) - currentPoints(3,:));
                        verticalScanPoints = [verticalScanPoints; 0.5*(currentPoints(1,:)+currentPoints(6,:)), bigSquareLength];                    
                    end
                end
            end
        else
            break;
        end
    end
end

%% diagonal scan, from top left to bottom right
% first step: iterate through each column except the first one
for currCol = columns: -1: 2
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(6, 2);
    
    for j = 1:rows
        i = currCol + j;
        if j + 1 <= rows && i + 1 <= columns
            if binaryImage(j, i) == 0 && binaryImage(j + 1, i + 1) == 1
                currentPoints = [currentPoints(2:6,:); j, i];
                
                % If there are no zeros in the currentPoints array it
                % is filled with 6 edge points
                if(~any(currentPoints == 0))
                    % Check if the distance ratio between all points
                    % matches the ratio of a FIP
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        % Add to the positions array
                        % positions = [positions; 0.5*(currentPoints(1,:)+currentPoints(6,:))];
                        bigSquareLength = length(currentPoints(4,:) - currentPoints(3,:));
                        diagonalScanPoints1 = [diagonalScanPoints1; 0.5*(currentPoints(1,:)+currentPoints(6,:)), bigSquareLength];
                    end
                end
            end
        else
            break;
        end
    end
end

% second step: iterate through each row
for currRow = 1:rows
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(6, 2);
    
    for i = 1:columns
        j = currRow + i;
        if j + 1 <= rows && i + 1 <= columns
            if binaryImage(j, i) == 0 && binaryImage(j + 1, i + 1) == 1
                currentPoints = [currentPoints(2:6,:); j, i];
                
                % If there are no zeros in the currentPoints array it
                % is filled with 6 edge points
                if(~any(currentPoints == 0))
                    % Check if the distance ratio between all points
                    % matches the ratio of a FIP
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        % Add to the positions array
                        % positions = [positions; 0.5*(currentPoints(1,:)+currentPoints(6,:))];
                        bigSquareLength = length(currentPoints(4,:) - currentPoints(3,:));
                        diagonalScanPoints1 = [diagonalScanPoints1; 0.5*(currentPoints(1,:)+currentPoints(6,:)), bigSquareLength];
                    end
                end
            end
        else
            break;
        end
    end
end

%% diagonal scan, from top right to bottom left
% first step: iterate through each column except the last one
for currCol = 1:(columns - 1)
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(6, 2);
    
    for j = 1:rows
        i = currCol - j;
        if j + 1 <= rows && i - 1 > 0
            if binaryImage(j, i) == 0 && binaryImage(j + 1, i - 1) == 1
                currentPoints = [currentPoints(2:6,:); j, i];
                % If there are no zeros in the currentPoints array it
                % is filled with 6 edge points
                if(~any(currentPoints == 0))
                    
                    % Check if the distance ratio between all points
                    % matches the ratio of a FIP
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        % Add to the positions array
                        % positions = [positions; 0.5*(currentPoints(1,:)+currentPoints(6,:))];
                        bigSquareLength = length(currentPoints(4,:) - currentPoints(3,:));
                        diagonalScanPoints2 = [diagonalScanPoints2; 0.5*(currentPoints(1,:)+currentPoints(6,:)), bigSquareLength];
                    end
                end
            end
        else
            break;
        end
    end
end

% second step: iterate through each row
for currRow = 1:rows
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(6, 2);
    
    for i = columns:-1:1
        j = currRow + (columns - i);
        if j + 1 <= rows && i - 1 > 0
            if binaryImage(j, i) == 0 && binaryImage(j + 1, i - 1) == 1
                currentPoints = [currentPoints(2:6,:); j, i];
                
                % If there are no zeros in the currentPoints array it
                % is filled with 6 edge points
                if(~any(currentPoints == 0))
                    % Check if the distance ratio between all points
                    % matches the ratio of a FIP
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        % Add to the positions array
                        % positions = [positions; 0.5*(currentPoints(1,:)+currentPoints(6,:))];
                        bigSquareLength = length(currentPoints(4,:) - currentPoints(3,:));
                        diagonalScanPoints2 = [diagonalScanPoints2; 0.5*(currentPoints(1,:)+currentPoints(6,:)), bigSquareLength];
                    end
                end
            end
        else
            break;
        end
    end
end

%% Remove unwanted points
fipLength = (sum(sum(verticalScanPoints(:,3))/length(verticalScanPoints) + ...
                sum(horizontalScanPoints(:,3))/length(horizontalScanPoints) + ...
                sum(diagonalScanPoints1(:,3))/length(diagonalScanPoints1) + ...
                sum(diagonalScanPoints2(:,3))/length(diagonalScanPoints2))/4)*2;

indices = zeros(1,0);

positions = RemoveBadPoints(verticalScanPoints, horizontalScanPoints, ...
                            diagonalScanPoints1, diagonalScanPoints2, fipLength);

%positions = [verticalScanPoints; horizontalScanPoints; diagonalScanPoints1; diagonalScanPoints2];
% figure;
% imshow(binaryImage);
% hold on;
% plot(positions(:,2),positions(:,1),'r.','MarkerSize',12)
% hold off
