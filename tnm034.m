% For when we want to test many images.
function[strout] = tnm034(image)

try
    
% Make sure the image is in grayscale
[X, Y, dim] = size(image);
if(dim == 3) 
    image = rgb2gray(image);
end

%% Calculate positions of the FIP:s.
FIPPositions = GetFIPPositions(image);
% imshow(image);
% hold on;
% plot(FIPPositions(:,1), FIPPositions(:,2),  'rs', 'MarkerSize', 10, 'LineWidth', 3);

%% Get the four corners of QR-pattern.
QRCorners = GetQRCorners(image, FIPPositions);
% figure;
% imshow(image);
% hold on;
% plot(QRCorners(:,1), QRCorners(:,2),  'rs', 'MarkerSize', 10, 'LineWidth', 3);
% 
% for i = 1:length(QRCorners)
%     t(i) = text(QRCorners(i,1),QRCorners(i,2),int2str(i));
% end
% set(t(:),'fontw','bold','fonts',12)

%% Get the alignment point (AP)
APPosition = GetAPPosition(image, QRCorners);

%% Transform the given FIP:s for easier computation later.
tformedImage = TransformAndCropQR(QRCorners, APPosition, image);
% figure; imshow(tformedImage);

% Compensate for uneven illumination. Returns an image containing only 0:s
% and 1:s
blackAndWhiteImage = RemoveIllumination(tformedImage);
% figure;imshow(blackAndWhiteImage);
% Create a 41*41 matrix of all points after rotation and translation.
QRData = CreateBitmap(blackAndWhiteImage);
% figure;imshow(QRData)
% Determine text from perfect points by reading QR_data pixel by pixel.
% Convert to ASCII symbols.
% Put strout as the resulting text.
% figure;
% imshow(QRData);
strout = ReadQR(QRData);

catch
    strout = 'An error occurred.';
end

