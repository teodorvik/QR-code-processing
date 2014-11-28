% Converts image to 41x41 matrix

function[bitmap] = CreateBitmap(image)

% Preallocate for speed
bitmap = zeros(41,41);
[yMax, xMax] = size(image);

% The size of one QR-pixel in pixels
stepSize = yMax / 41;

for i = 1:41
    posX = round(stepSize * (i - 1)) + 1;
    posXNext = round(posX + stepSize);
    
    % We don't want to go out of bounds
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
        bitmap(j,i) = mean(mean(tempImage));
    end
end

bitmap = bitmap > 0.5;
