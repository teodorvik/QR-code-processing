% For when we want to test many images.
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_4e.png'));
% image = im2double(imread('images/set5/Hus_4e.png'));

% Make sure the image is in grayscale
[X, Y, dim] = size(image);
if(dim == 3) 
    image = rgb2gray(image);
end

% Calculate positions of the FIP:s.
FIPPositions = GetFIPPositions(image);

% Transform the given FIP:s for easier computation later.
[tformedFips, tformedImage] = TransformFIPs(FIPPositions, image);

% Convert to grayscale and compensate for uneven illumination.
grayImage = ToGrayscale(tformedFips, tformedImage);
imshow(grayImage);

% Create a 41*41 matrix of all points after rotation and translation.
QRData = CreateBitmap(grayImage);

% Determine text from perfect points by reading QR_data pixel by pixel.
% Convert to ASCII symbols.
% Put strout as the resulting text.
figure;
imshow(QRData);
strout = ReadQR(QRData)
