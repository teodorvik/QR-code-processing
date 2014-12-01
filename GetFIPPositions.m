% Den här funktionen returnerar de 3 FIP:arna och 4 punkten på QR-koden.
% Input: Image
% Output: FIP_positions [4,2] 
function centerPoints = GetFIPPositions(image)
%% Compensate for uneven illumination


%% Remove noise
image = wiener2(image, [3 3]);

%% Apply sobel filter
edgeImage = Sobel(mat2gray(image), 0.5);

%% Search for FIP candidates
fipPoints = FIPLineScan(edgeImage, 0.1);

%% Find three clusters of points
[idx,centerPoints] = kmeans(fipPoints,3,'Distance','cityblock',...
    'Replicates',4);

centerPoints = GetFIPCenterPoints(fipPoints);
centerPoints = [centerPoints(:,2) centerPoints(:,1)];
% 
% figure;
% imshow(edgeImage);
% hold on;
% plot(fipPoints(:,2),fipPoints(:,1),'r.','MarkerSize',12)
% plot(centerPoints(:,1),centerPoints(:,2),'wx',...
%      'MarkerSize',15,'LineWidth',3)
%  
% legend('Cluster 1','Cluster 2', 'Cluster3', 'Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
% hold off
