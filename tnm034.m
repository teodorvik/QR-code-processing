% For when we want to test many images.
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Mikael
% Calculate positions of the FIP:s.
FIP_positions = GetFIPPositions(image);

% Teodor
% Calculate rotation and translation at the given FIP:s.
[tformed_fips, tformed_image] = TransformFIPs(FIP_positions, image);

imshow(tformed_image);
hold on;
plot(tformed_fips(:, 1), tformed_fips(:, 2), 'r');
% Oscar
% Convert to grayscale.
% Compensate for uneven illumination.

% Oscar
% Create a 41*41 matrix of all points after rotation and translation.
% QR_data = CreateBitmap(FIP_rotated);

% Anton
% Determine text from perfect points by reading QR_data pixel by pixel.
% Convert to ASCII symbols.
% Put strout as the resulting text.
% strout = readQR(QR_data);