% Convert cropped grayscale image to only ones and zeros
% Input is a cropped image, grayscaled and using double instead of uint8

function[grayImage] = RemoveIllumination(image)

localMaxImage = imdilate(image, true(size(image, 1)));
grayImage = image./localMaxImage;
grayImage = grayImage>0.48;