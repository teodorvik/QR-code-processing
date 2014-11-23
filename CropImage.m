% Input: Fips in the order [topLeft; topRight; bottomLeft; bottomRight]
function[croppedImage] = CropImage(fips, image)

% Cut out a rectangle. Only need 3 corners.
topLeft = fips(1,:);
topRight = fips(2,:);
bottomLeft = fips(3,:);

% Crop the image
croppedImage = image(topLeft(2):bottomLeft(2),topLeft(1):topRight(1));

