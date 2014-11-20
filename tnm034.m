% For when we want to test many images.
function[strout] = tnm034(image)

% Make sure the image is in grayscale
[X, Y, dim] = size(image);
if(dim == 3) 
    image = rgb2gray(image);
end

% Calculate positions of the FIP:s.
FIPPositions = GetFIPPositions(image);

%% Get the four corners of QR-pattern. Not done
QRCorners = GetQRCorners(image, FIPPositions);
% imshow(image);
% hold on;
% plot(QRCorners(:,1), QRCorners(:,2),  'rs', 'MarkerSize', 10, 'LineWidth', 3);
% 
% 
% for i = 1:length(QRCorners)
%     t(i) = text(QRCorners(i,1),QRCorners(i,2),int2str(i));
% end
% set(t(:),'fontw','bold','fonts',12)


%% Transform the given FIP:s for easier computation later.
[tformedFips, tformedImage] = TransformFIPs(FIPPositions, image);
figure; imshow(tformedImage)

% Convert to grayscale and compensate for uneven illumination.
grayImage = ToGrayscale(tformedFips, tformedImage);

% Create a 41*41 matrix of all points after rotation and translation.
QRData = CreateBitmap(grayImage);

% Determine text from perfect points by reading QR_data pixel by pixel.
% Convert to ASCII symbols.
% Put strout as the resulting text.
figure;
imshow(QRData);
strout = ReadQR(QRData);

