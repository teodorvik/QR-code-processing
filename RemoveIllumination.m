% Convert cropped grayscale image to only ones and zeros
% Input is a cropped image, grayscaled and using double instead of uint8

function[grayImage] = RemoveIllumination(image)

% Expand white background over black QR-pixels
background = imdilate(image, true(size(image, 1)));
% Normalize image with background
grayImage = image./background;
% Make grayImage ones and zeros
grayImage = grayImage > 0.44;