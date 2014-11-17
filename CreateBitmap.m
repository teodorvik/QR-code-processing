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

function[bitmap] = CreateBitmap(image, stepSize)

% -----------------------------
% Loop through the entire QR image
% -----------------------------

% Preallocate for speed
bitmap = zeros(41,41);

for i = 1:41
    posX = stepSize * (i - 1) + 1;
    posXNext = posX + stepSize;
    
    for j = 1:41
        posY = stepSize * (j - 1) + 1;
        posYNext = posY + stepSize;
    
        % Summarize a pixel area in the image
        tempImage = image(posY:posYNext, posX:posXNext); 
        meanValue = mean(mean(tempImage));
        
        if (meanValue >= 0.5)
            bitmap(j,i) = 1;
        else
            bitmap(j,i) = 0;
        end
    end
end

imshow(bitmap)
