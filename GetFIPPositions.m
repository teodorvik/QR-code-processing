% Den här funktionen returnerar de 3 FIP:arna och 4 punkten på QR-koden.
% Input: Image
% Output: FIP_positions [4,2] 
% function FIP_positions = GetFIPPositions()

image = im2double(imread('images/set1/Bygg_1.png'));

%% Apply Gaussian smoothing
gaussian_filter = fspecial('gaussian',[3 3], 0.7);
image = imfilter(image, gaussian_filter, 'replicate');
%# Display
%imshow(Ig) 

%% Apply sobel filters in both directions

edgeImage = Sobel(image, 0.95);
%imshow(edgeImage)

%% Search for FIP

fipPoints = FIPLineScan(edgeImage);
imshow(edgeImage);
hold on;
plot(fipPoints(:,2), fipPoints(:,1), 'x');

