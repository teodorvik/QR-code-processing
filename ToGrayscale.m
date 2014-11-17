% TODO: remove loop to increase speed?
%
% Input:
% Translated and rotated image
% Points for the FIPs in the following format:
% points = [topLeftX topLeftY;
%           topRightX topRightY;
%           bottomLeftX bottomLeftY];
%
% Output:
% This function will return an image consisting of ones and zeros
% And the new image's stepSize
%

function[grayImage, stepSize] = ToGrayscale(image, points)

% -----------------------------
% Initialize variables
% -----------------------------

% stepSize is the size of one QR-pixel in the image
stepSize = (points(2,1) - points(1,1)) / 34;
stepSize = round(stepSize);

% Used to crop the image
startX = points(1,1) - stepSize * 3 - stepSize / 2;
startY = points(1,2) - stepSize * 3 - stepSize / 2;
endX = points(2,1) + stepSize * 3 + stepSize / 2;
endY = points(3,2) + stepSize * 3 + stepSize / 2;

% Crop away unnecessary parts of the image
image = image(startY:endY, startX:endX);

imageSize = size(image); % imageSize(1) = length in y

% Obtain the value of a black QR-pixel for each corner
topLeftBlack = image(round(stepSize * 0.5), round(stepSize * 0.5));
topRightBlack = image(round(stepSize * 0.5), imageSize(2) - round(stepSize * 0.5));
bottomLeftBlack = image(imageSize(1) - round(stepSize * 0.5),  round(stepSize * 0.5));
bottomRightBlack = image(imageSize(1) - round(stepSize * 5.5), imageSize(2) - round(stepSize * 5.5));

% Initialize images for speed
background = zeros(imageSize);
grayImage = zeros(imageSize);

% -----------------------------
% Loop through the image and determine color
% -----------------------------

for x = 1:imageSize(2)
    for y = 1:imageSize(1)
        
        % Perform billinear interpolation
        one = [1 - x/imageSize(2), x/imageSize(2)];
        two = [topLeftBlack, bottomLeftBlack; topRightBlack, bottomRightBlack];
        three = [1-y/imageSize(1); y/imageSize(1)];
        
        % Background matrix for debugging
        background(y,x) = one*two*three;
        
        % If the image's value is higher than what a black QR-pixel *should*
        % be in this position then we are dealing with a white QR-pixel
        if image(y,x) > background(y,x)*1.1
            grayImage(y,x) = 1;
        else
            grayImage(y,x) = 0;
        end
    end
end

imshow(grayImage);