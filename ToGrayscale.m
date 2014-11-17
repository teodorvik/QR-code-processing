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
%

function[grayImage] = ToGrayscale(points, image)

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
% image = imerode(image,[1, 1; 1, 1]);
% image = imdilate(image,[1, 1; 1, 1]);

imageSize = size(image); % imageSize(1) = length in y

% Obtain the value of a black QR-pixel for each corner
topLeftBlack = image(round(stepSize * 0.5), round(stepSize * 0.5));
topRightBlack = image(round(stepSize * 0.5), imageSize(2) - round(stepSize * 0.5));
bottomLeftBlack = image(imageSize(1) - round(stepSize * 0.5),  round(stepSize * 0.5));
bottomRightBlack = image(imageSize(1) - round(stepSize * 5.5), imageSize(2) - round(stepSize * 5.5));

% -----------------------------
% Perform operations on the entire image
% -----------------------------

% Perform billinear interpolation
one = [1 - (1:imageSize(2))/imageSize(2); (1:imageSize(2))/imageSize(2)];
two = [topLeftBlack, bottomLeftBlack; topRightBlack, bottomRightBlack];
three = [1-(1:imageSize(1))/imageSize(1); (1:imageSize(1))/imageSize(1)];

% Background matrix for debugging
background = (two*three)'*one;    

% If the image's value is higher than what a black QR-pixel *should*
% be in this position then we are dealing with a white QR-pixel
grayImage = (image > background*1.2);

% TODO: make this dynamic
% Remove white border
%grayImage = grayImage(3:imageSize(1), 3:imageSize(2));
