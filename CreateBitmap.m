% TODO: remove loop for speed? 
%
% Input:
% Translated and rotated image consisting of ones and zeros
% stepSize (size of one QR-pixel)
% 
% Output:
% This function will return a 41x41 matrix of ones and zeros
%
% Points for testImage5.png
% points5 = [66 195; 406 195; 66 536];

function[bitmap] = CreateBitmap(image)

% -----------------------------
% Loop through the entire QR image
% -----------------------------

% Preallocate for speed
bitmap = zeros(41,41);
[yMax, xMax] = size(image);

% Used for debugging
%hold on;

stepSize = yMax / 41;

for i = 1:41
    posX = round(stepSize * (i - 1)) + 1;
    posXNext = round(posX + stepSize);
    
    if (posXNext > xMax)
        posXNext = xMax;
    end
    
    for j = 1:41
        posY = round(stepSize * (j - 1)) + 1;
        posYNext = round(posY + stepSize);
        
        if (posYNext > yMax)
            posYNext = yMax;
        end
    
        % Summarize a pixel area in the image
        tempImage = image(posY:posYNext, posX:posXNext); 
        meanValue = mean(mean(tempImage));
        
        % Used for debugging
        %plot(posX, posY, '-r+');
        %plot(posXNext, posYNext, '-r+');
        
        % TODO: Find a good way to determine threshold value
        if (meanValue >= 0.6)
            bitmap(j,i) = 1;
        else
            bitmap(j,i) = 0;
        end
    end
end
