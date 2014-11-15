% Den här funktionen returnerar de 3 FIP:arna och 4 punkten på QR-koden.
% Input: Image
% Output: FIP_positions [4,2] 
% function FIP_positions = GetFIPPositions()

image = im2double(imread('images/set1/Bygg_3.png'));

%% Apply Gaussian smoothing
%# Create the gaussian filter with hsize = [5 5] and sigma = 2
G = fspecial('gaussian',[10 10],5);
%# Filter it
Ig = filter2(G, image);
%# Display
imshow(Ig) 

%% Apply sobel filters in both directions

edge_image = sobel(image, 0.95);

%%
imshow(edge_image)
