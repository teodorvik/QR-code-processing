% For when we want to test many images.
% function[strout] = tnm034(image)

image = im2double(imread('images/set5/Husannons_full.png'));
% image = im2double(imread('images/set5/Hus_4e.png'));

% Make sure the image is in grayscale
[X, Y, dim] = size(image);
if(dim == 3) 
    image = rgb2gray(image);
end

% Calculate positions of the FIP:s.
FIP_positions = GetFIPPositions(image);

% Transform the given FIP:s for easier computation later.
[tformed_fips, tformed_image] = TransformFIPs(FIP_positions, image);

figure; imshow(tformed_image)

% Convert to grayscale and compensate for uneven illumination.
% [scaled_fips, gray_image] = ToGrayscale(tformed_fips, tformed_image);

% Create a 41*41 matrix of all points after rotation and translation.
% QR_data = CreateBitmap(tformed_fips, tformed_image);

% Determine text from perfect points by reading QR_data pixel by pixel.
% Convert to ASCII symbols.
% Put strout as the resulting text.
% strout = readQR(QR_data);