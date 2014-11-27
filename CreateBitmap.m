% Converts image to 41x41 matrix

function[bitmap] = CreateBitmap(image)

% Preallocate for speed
bitmap = zeros(41,41);
[yMax, xMax] = size(image);

% Used for debugging
%figure;
%imshow(image);
%hold on;

stepSize = yMax / 41;

% TODO: Possible to remove loop?
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
%         plot(posX, posY, '-r+');
%         plot(posXNext, posYNext, '-r+');
        
        if (meanValue >= 0.48)
            bitmap(j,i) = 1;
        else
            bitmap(j,i) = 0;
        end
    end
end

%hold off;
