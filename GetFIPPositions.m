% Den här funktionen returnerar de 3 FIP:arna och 4 punkten på QR-koden.
% Input: Image
% Output: FIP_positions [4,2]
% function FIP_positions = GetFIPPositions()

image = im2double(imread('images/set1/Bygg_3.png'));

%% Apply sobel filters in both directions
sobel_x = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
sobel_y = [1, 2, 1; 0, 0, 0; -1, -2, -1];

filtered_x = filter2(sobel_x,image);
filtered_y = filter2(sobel_y,image);

filtered_image = sqrt(filtered_x.^2) + sqrt(filtered_y.^2);

%%
imshow(filtered_image)