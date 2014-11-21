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
image = double(image);
% -----------------------------
% Initialize variables
% -----------------------------

% stepSize is the size of one QR-pixel in the image
stepSize = round((points(2,1) - points(1,1)) / 41);

imageSize = size(image); % imageSize(1) = length in y

% Obtain the value of a black QR-pixel for each corner
% sometimes tries to access image(0,0) that doesnt exist. should it be ceil
% instead of round?
topLeftBlack = image(round(stepSize * 0.5), round(stepSize * 0.5));
topRightBlack = image(round(stepSize * 0.5), imageSize(2) - round(stepSize * 0.5));
bottomLeftBlack = image(imageSize(1) - round(stepSize * 0.5),  round(stepSize * 0.5));
bottomRightBlack = image(imageSize(1) - round(stepSize * 5.5), imageSize(2) - round(stepSize * 5.5));

% -----------------------------
% Perform operations on the entire image
% -----------------------------

% TODO: Divide the image into smaller parts and perform billinear 
% interpolation on these smaller areas, thus also accounting for e.g 
% specular highlights in the middle of the image 

% Perform billinear interpolation
one = [1 - (1:imageSize(2))/imageSize(2); (1:imageSize(2))/imageSize(2)];
two = [topLeftBlack, bottomLeftBlack; topRightBlack, bottomRightBlack];
three = [1-(1:imageSize(1))/imageSize(1); (1:imageSize(1))/imageSize(1)];

% Background matrix for debugging
background = (two*three)'*one;    

% If the image's value is higher than what a black QR-pixel *should*
% be in this position then we are dealing with a white QR-pixel
grayImage = (image > background*1.2);

% Removes white borders in both x and y
% TODO: Make this better
% for y = 1:imageSize(1)
%     if sum(grayImage(y,:)) > imageSize(1) * 0.9
%         grayImage = grayImage(2:imageSize(1),:);
%         imageSize(1) = imageSize(1) - 1;
%     else
%         break;
%     end
% end
% 
% for x = 1:imageSize(2)
%     if sum(grayImage(:,x)) > imageSize(2) * 0.9
%         grayImage = grayImage(:,2:imageSize(2));
%         imageSize(2) = imageSize(2) - 1;
%     else
%         break;
%     end
% end
