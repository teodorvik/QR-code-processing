% Rotate and translate the given FIP to correct positions
% Return a new set of rotated and translated FIP:s
% function [fip_rotated] = RotateFIP(fips)

% Get the shortest distance from/to each big FIP
% inorder to determine which one is which.
clear all;
% Input (bad_qr.png)
% fips = [172, 58; 75, 230; 450, 58; 333, 212];
fips = [56, 54; 332, 54; 56, 333];
topfip = [1:3];

% Calculate the distances
distancesFips = zeros(4,4);

for i = 1:length(fips)
    for j = 1:length(fips)
        distancesFips(i,j) = sqrt((fips(i,1)-fips(j,1))^2 + (fips(i,2)-fips(j,2))^2);
    end
end

% If zero set it to nan
distancesFips(distancesFips <= 0) = nan;

% Since we know which FIPs that got the most distance between them we also
% know that the remaining FIP is the top left FIP.
[maxA,ind] = max(distancesFips(:));
[m,n] = ind2sub(size(distancesFips),ind);
topfip(m) = 0;
topfip(n) = 0;

% Get the length of the shortest path. That's our scaling
[minA,ind] = min(distancesFips(:));
[m,n] = ind2sub(size(distancesFips),ind);
minlength = distancesFips(m,n);

% Make perfect positioned points for mapping.
topleft = fips(sum(topfip),:);
topright = [topleft(1) + minlength, topleft(2)];
bottomleft = [topleft(1), topleft(2)+ minlength];
perfect_qr = [topleft; topright; bottomleft];

% Transformation matrix 
trans_matrix = fips\perfect_qr;

% image = imread('images/test/perfect_qr.jpg');
% imshow(image);
% pause();
% newImage = image*trans_matrix;
% imshow(newImage)

% Some plots
% figure(1)
% imshow('images/test/perfect_qr.jpg');
% hold on;
% plot(fips(:,1), fips(:,2), 'o');
% plot(fips(m,:),fips(n,:), 'y');

%%
% Gammal BoB-labb.
% cr500 �r koordinater
% CS1 = [cr500 cc512 ones(8,1)];
% HS1 = [hr500 hc512 ones(8,1)];
% x = CS1\HS1;
% 
% newImage = zeros(500,512);
% 
% % Coordinat vectors to all positions 
% [X Y] = meshgrid(1:500, 1:512);
% M = cat(2, X(:), Y(:));
% M = [ M ones(500*512,1) ];
% 
% newCoords = M*x;
% newCoords = floor(newCoords);
%%

