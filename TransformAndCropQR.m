% Rotate and translate the given FIPs to correct positions
% Return a new set of FIP:s and an image that have been transformed and cropped.
function [croppedImage] = TransformFIPs(fips, AP, image)
%% Calculate the distances between pair of points
distancesFips = pdist(fips);
% distancesFips(1) = distance between 2 and 1
% distancesFips(2) = distance between 3 and 1
% distancesFips(3) = distance between 3 and 2

%% Get the length of the shortest path. That's our scaling
[minA,ind] = min(distancesFips(:));
[m,n] = ind2sub(size(distancesFips),ind);
minlength = distancesFips(m,n);

%% Create perfect positioned points for mapping.
perfect_top_left = fips(1,:);
perfect_top_right = [perfect_top_left(1) + minlength, perfect_top_left(2)];
perfect_bottom_left = [perfect_top_left(1), perfect_top_left(2) + minlength];
% perfect_bottom_right = [perfect_top_right(1), perfect_top_right(2) + minlength];
perfect_bottom_right = [perfect_top_left(1) + minlength*34.5/41, perfect_top_left(2) + minlength*34.5/41];

perfect_qr = [perfect_top_left; perfect_top_right; perfect_bottom_left; perfect_bottom_right];

%% Create the transformation matrix 
tPoints = [fips; AP];
T = maketform('projective', tPoints, perfect_qr);

%% Transform and crop the image
% xdata and ydata from imtransform are how much imtransform have translated
% the image. In CropImage we compensate for those values.
[tformedImage,xdata,ydata] = imtransform(image, T, 'XYScale', 1);

tformedFips = perfect_qr;
croppedImage = CropImage(int32(tformedFips), tformedImage, int32(xdata), int32(ydata));

