function[grayImage] = ToGrayscale(image, points)

% stepSize is the size of one QR-pixel in the image
stepSize = (points(1,2) - points(1,1))/34;
stepSize = round(stepSize);

% Top left starting position, bottom right end position
startX = points(1,1) - stepSize * 3 - stepSize / 2;
startY = points(2,1) - stepSize * 3 - stepSize / 2;
endX = points(1,2) + stepSize * 3 + stepSize / 2;
endY = points(2,3) + stepSize * 3 + stepSize / 2;

% Crop away unnecessary parts of the image and make gray
image = image(startY:endY, startX:endX, 1:3);
image = rgb2gray(image);
imageSize = size(image); % imageSize(1) = length in y

% Fetch the white value for every corner
% These try to land on the closest white QR-pixel in the image for every
% corner except the bottom right
topLeftWhite = image(round(stepSize * 1.5), round(stepSize * 1.5));
topRightWhite = image(imageSize(2) - round(stepSize * 1.5), round(stepSize * 1.5));
bottomLeftWhite = image(round(stepSize * 1.5), imageSize(1) - round(stepSize * 1.5));

% Find black values
topLeftBlack = image(round(stepSize * 0.5), round(stepSize * 0.5));
topRightBlack = image(imageSize(2) - round(stepSize * 0.5), round(stepSize * 0.5));
bottomLeftBlack = image(round(stepSize * 0.5), imageSize(1) - round(stepSize * 0.5));

% Create linear arrays between the max and min black and white values
linearXW = linspace(double(topLeftWhite),double(topRightWhite),imageSize(2));
linearYW = linspace(double(topLeftWhite),double(bottomLeftWhite),imageSize(1));
linearXB = linspace(double(topLeftBlack),double(topRightBlack),imageSize(2));
linearYB = linspace(double(topLeftBlack),double(bottomLeftBlack),imageSize(1));

% Initialize return matrix for speed
grayImage = zeros(imageSize);

for x = 1:imageSize(2)
    for y = 1:imageSize(1)
        
        % *change*
        white = (linearXW(x) + linearYW(y)) / 2;
        black = (linearXB(x) + linearYB(y)) / 2;
        
        % Correct? Maybe *change*
        if(image(y,x) > (black + white) / 2)
            grayImage(y,x) = 1;
        else
            grayImage(y,x) = 0;
        end
    end
end

imshow(grayImage);