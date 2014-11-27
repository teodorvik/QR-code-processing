% Convert cropped grayscale image to only ones and zeros
% Input is a cropped image, grayscaled and using double instead of uint8

function[grayImage] = RemoveIllumination(image)

background = imdilate(image, true(size(image, 1)));
grayImage = image./background;
grayImage = grayImage > 0.44;