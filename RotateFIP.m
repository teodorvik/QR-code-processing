% Rotate and translate the given FIP to correct positions
% Return a new set of rotated and translated FIP:s and an image
% function [image_rotated, fip_rotated] = RotateFIP(fips)

clear all;
% Input (bad_qr.png)
% fips = [172, 58; 75, 230; 450, 58; 333, 212];
% Input (perfect_qr.png)
% fips = [56, 54; 332, 54; 56, 333];
% Input (set1/Bygg_3e.png)
 fips = [70, 240; 369, 243;  66, 614];
% Input (set1/Bygg_2c.png)
% fips = [84,225; 133, 611; 471, 178];

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
% sum(topfip) returnes the index of the top right FIP
perfect_top_left = fips(sum(topfip),:);
perfect_top_right = [floor(perfect_top_left(1) + minlength), perfect_top_left(2)];
perfect_bottom_left = [perfect_top_left(1), floor(perfect_top_left(2)+ minlength)];
perfect_qr = [perfect_top_left; perfect_top_right; perfect_bottom_left];

% Transformation matrix 
perfect_qr = [perfect_qr ones(3,1)];
fips = [fips ones(3,1)];
tform = fips\perfect_qr;

image = imread('images/set1/Bygg_3e.png');
imshow(image); pause()
trans_image = imwarp(image,affine2d(tform));
imshow(trans_image);