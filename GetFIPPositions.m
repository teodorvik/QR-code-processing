% Den här funktionen returnerar de 3 FIP:arna och 4 punkten på QR-koden.
% Input: Image
% Output: FIP_positions [4,2] 
function centerPoints = GetFIPPositions(image)
%% Pre-processing
% Apply Gaussian smoothing
%gsize = floor(size(image)*0.05)
%gaussian_filter = fspecial('gaussian',gsize, 0.7);
%image = imfilter(image, gaussian_filter, 'replicate');
%# Display
%imshow(Ig) 

% Remove noise
image = wiener2(image, [3 3]);

%% Apply sobel filter
edgeImage = Sobel(mat2gray(image), 0.5);

%% Search for FIP candidates
fipPoints = FIPLineScan(edgeImage, 0.1);

%% Find three clusters of points
% Is four replicates enough?
[idx,centerPoints] = kmeans(fipPoints,3,'Distance','cityblock',...
    'Replicates',4);

centerPoints = [centerPoints(:,2) centerPoints(:,1)];

% figure;
% imshow(edgeImage);
% hold on;
% plot(fipPoints(idx==1,2),fipPoints(idx==1,1),'r.','MarkerSize',12)
% plot(fipPoints(idx==2,2),fipPoints(idx==2,1),'g.','MarkerSize',12)
% plot(fipPoints(idx==3,2),fipPoints(idx==3,1),'b.','MarkerSize',12)
% plot(centerPoints(:,1),centerPoints(:,2),'wx',...
%      'MarkerSize',15,'LineWidth',3)
% legend('Cluster 1','Cluster 2', 'Cluster3', 'Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off

