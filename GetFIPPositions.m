% Den här funktionen returnerar de 3 FIP:arna och 4 punkten på QR-koden.
% Input: Image
% Output: FIP_positions [4,2] 
function centerPoints = GetFIPPositions(image)
%% Apply Gaussian smoothing
%gsize = floor(size(image)*0.05)
%gaussian_filter = fspecial('gaussian',gsize, 0.7);
%image = imfilter(image, gaussian_filter, 'replicate');
%# Display
%imshow(Ig) 

%% Apply sobel filter

edgeImage = Sobel(mat2gray(image), 0.5);
%subplot(1,2,1), imshow(image)
%subplot(1,2,2), imshow(edgeImage)

%% Search for FIP candidates

fipPoints = FIPLineScan(edgeImage, 0.2);
% imshow(edgeImage);
% hold on;
% plot(fipPoints(:,2), fipPoints(:,1), 'x');

%% Find three clusters of points
% Is three replicates enough?
[idx,centerPoints] = kmeans(fipPoints,3,'Distance','cityblock',...
    'Replicates',3);

centerPoints = [centerPoints(:,2) centerPoints(:,1)];

% figure;
% imshow(image);
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

