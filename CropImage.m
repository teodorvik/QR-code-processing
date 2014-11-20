% Input: Fips in the order [topLeft; topRight; bottomLeft; bottomRight]
function[tformedFips, croppedImage] = CropImage(fips, image)

% Cut out a rectangle. Only need 3 corners.
topLeft = fips(1,:);
topRight = fips(2,:);
bottomLeft = fips(3,:);

% Crop the image
croppedImage = image(topLeft(2):bottomLeft(2),topLeft(1):topRight(1));

% Set new fip values to the corners of the image
[X, Y] = size(croppedImage);
newTopLeft = [1,1];
newTopRight = [X,1];
newBottomLeft = [1,Y];
newBottomRight = [X,Y];

% New fips
tformedFips = [newTopLeft; newTopRight; newBottomLeft; newBottomRight];
