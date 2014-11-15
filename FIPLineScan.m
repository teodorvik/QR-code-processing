function positions = FIPLineScan(binaryImage)
positions = zeros(0, 2);
strictness = 0.1;
[rows columns] = size(binaryImage);
% horizontal scan
for j = 1:rows
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(1, 6);
    
    for i = 1:columns
        if i + 1 < columns
            if binaryImage(j, i) == 0 && binaryImage(j, i + 1) == 1
                %fprintf('edge found at row %d, column %d \n', j, i)
                currentPoints = [currentPoints(2:6), i];
                if(~any(currentPoints == 0))
                    %fprintf('no zeros: \n')
                    %currentPoints
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        positions = [positions; j, i];
                    end
                else
                    %fprintf('zeros: \n')
                    %currentPoints
                end
            end
        end
    end
end

% vertical scan
for i = 1:columns
    % collect every six points as a group and check the
    % ratio to identify the feature patterns (1:1:3:1:1)
    currentPoints = zeros(1, 6);
    
    for j = 1:rows
        if j + 1 < rows
            if binaryImage(j, i) == 0 && binaryImage(j + 1, i) == 1
                %fprintf('edge found at row %d, column %d \n', j, i)
                currentPoints = [currentPoints(2:6), j];
                if(~any(currentPoints == 0))
                    %fprintf('no zeros: \n')
                    %currentPoints
                    if(CheckFIPPointsRatio(currentPoints, strictness))
                        % Fip candidate found
                        positions = [positions; j, i];
                    end
                else
                    %fprintf('zeros: \n')
                    %currentPoints
                end
            end
        end
    end
end

% TO DO
% Diagonal scan in both directions