% Rotate and translate the given FIPs to correct positions
% Return a new set of transformed FIP:s and an new image
function [tformed_fips, tformed_image] = TransformFIPs(fips,image)
distancesFips = zeros(4,4);
topfip = [1:3];

%% Calculate the distances
for i = 1:length(fips)
    for j = 1:length(fips)
        distancesFips(i,j) = sqrt((fips(i,1)-fips(j,1))^2 + (fips(i,2)-fips(j,2))^2);
    end
end

% If zero set it to nan
distancesFips(distancesFips <= 0) = nan;

%% Since we know which FIPs that got the most distance between them we also
% know that the remaining FIP is the top left FIP.
[maxA,ind] = max(distancesFips(:));
[m,n] = ind2sub(size(distancesFips),ind);
topfip(m) = 0;
topfip(n) = 0;

%% Set the FIPs in the correct order so we can translate them later
top_fip = fips(sum(topfip),:);
unknown_fip1 = fips(m,:);
unknown_fip2 = fips(n,:);

if (GetAngle(unknown_fip1-top_fip) < GetAngle(unknown_fip2-top_fip))
    fips(1,:) = top_fip;
    fips(2,:) = unknown_fip1;
    fips(3,:) = unknown_fip2;
else
    fips(1,:) = top_fip;
    fips(2,:) = unknown_fip2;
    fips(3,:) = unknown_fip1;
end

%% Get the length of the shortest path. That's our scaling
[minA,ind] = min(distancesFips(:));
[m,n] = ind2sub(size(distancesFips),ind);
minlength = distancesFips(m,n);

%% Create perfect positioned points for mapping.
perfect_top_left = fips(1,:);
perfect_top_right = [floor(perfect_top_left(1) + minlength), perfect_top_left(2)];
perfect_bottom_left = [perfect_top_left(1), floor(perfect_top_left(2)+ minlength)];
perfect_qr = [perfect_top_left; perfect_top_right; perfect_bottom_left];

%% Create the transformation matrix 
perfect_qr = [perfect_qr ones(3,1)];
fips = [fips ones(3,1)];
tform = fips\perfect_qr;
last_column = [0.0; 0.0; 1.0];
tform = [tform(:,1:2) last_column];

%% Transform the image
% The transformed fips will have the same values as perfect_qr. Just return
% to columns we want from prefect_qr. 
tformed_fips = floor(perfect_qr(:, 1:2));
tformed_image = imwarp(image, affine2d(tform), 'OutputView', imref2d(size(image)));

