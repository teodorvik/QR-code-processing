% For when we want to test many images.
% Right now it is only hardcoding of the image.
%
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Teodor
% Calculate positions of the FIP:s.
% FIP_positions = GetFIPPositions();

% Mikael
% Calculate rotation and translation at the given FIP:s.
% FIP_rotated = rotate(FIP_positions);

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