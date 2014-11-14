% 
% Input:
% * Correctly translated and rotated image
% * Points for the FIPs in the following format:
% points = [topLeftX topRightX bottomLeftX bottomRightX;
%           topLeftY topRightY bottomLeftY bottomRightY];
% 
% Output:
% * This function will return a 41x41 matrix of ones and zeros
%

% Points for testImage(n).png
% points1 = [7 41 7 38; 20 20 54 51] (this image is too small though)
% points2 = [10 61 10 57; 30 30 81 76]
% points4 = [40 243 40 225; 117 117 321 304] (this image works great)
% points5 = [66 406 66 375; 195 195 536 506] (this image works great)

function[bitmap] = CreateBitmap(image, points)

% -----------------------------
% Initialize variables
% -----------------------------

bitmap = zeros(41,41);

% stepSize is the size of one QR-pixel in the image
stepSize = (points(1,2) - points(1,1))/34;
stepSize = round(stepSize);

% Top left starting position
startX = points(1,1) - stepSize * 3 - stepSize / 2;
startY = points(2,1) - stepSize * 3 - stepSize / 2;

% -----------------------------
% Loop through the entire QR image
% -----------------------------

for i = 1:41
    posX = startX + stepSize * (i - 1);
    posXNext = posX + stepSize;
    
    for j = 1:41
        posY = startY + stepSize * (j - 1);
        posYNext = posY + stepSize;
    
        % Summarize a pixel area in the image
        tempImage = image(posY:1:posYNext, posX:1:posXNext); 
        meanValue = mean(mean(tempImage));
        
        if (meanValue >= 255/2)
            bitmap(j,i) = 1;
        else
            bitmap(j,i) = 0;
        end
    end
end

% imshow(bitmap)
