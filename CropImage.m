% Input: Fips in the order [topLeft; topRight; bottomLeft; bottomRight]
function[croppedImage] = CropImage(fips, image, xdata, ydata)

% Compensate for imtransform
translation = [xdata(1), ydata(1)];

% Cut out a rectangle. Only need 3 corners.
topLeft = fips(1,:)- translation;
topRight = fips(2,:)- translation;
bottomLeft = fips(3,:)- translation;

% Crop the image
croppedImage = image(topLeft(2):bottomLeft(2),topLeft(1):topRight(1));

