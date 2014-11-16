% For when we want to test many images.
% function[strout] = tnm034(image)

image = im2double(rgb2gray(imread('images/set5/Hus_4d.png')));

% Calculate positions of the FIP:s.
FIP_positions = GetFIPPositions(image);

% Transform the given FIP:s for easier computation later.
[tformed_fips, tformed_image] = TransformFIPs(FIP_positions, image);

figure
imshow(tformed_image)

% Convert to grayscale and compensate for uneven illumination.
% [scaled_fips, gray_image] = ToGrayScale(tformed_fips, tformed_image);

% Create a 41*41 matrix of all points after rotation and translation.
% QR_data = CreateBitmap(scaled_fips, gray_image);

% Determine text from perfect points by reading QR_data pixel by pixel.
% Convert to ASCII symbols.
% Put strout as the resulting text.
% strout = readQR(QR_data);