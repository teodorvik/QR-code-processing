% Rotate and translate the given FIPs to correct positions
% Return a new set of FIP:s and an image that have been transformed and cropped.
function [croppedImage] = TransformFIPs(fips,image)
%% Calculate the distances between pair of points
distancesFips = pdist(fips);
% distancesFips(1) = distance between 2 and 1
% distancesFips(2) = distance between 3 and 1
% distancesFips(3) = distance between 3 and 2

%% Get the length of the shortest path. That's our scaling
[minA,ind] = min(distancesFips(:));
[m,n] = ind2sub(size(distancesFips),ind);
minlength = distancesFips(m,n);

%% Create perfect positioned points for mapping.
perfect_top_left = fips(1,:);
perfect_top_right = [perfect_top_left(1) + minlength, perfect_top_left(2)];
perfect_bottom_left = [perfect_top_left(1), perfect_top_left(2) + minlength];
perfect_bottom_right = [perfect_top_right(1), perfect_top_right(2) + minlength];

perfect_qr = [perfect_top_left; perfect_top_right; perfect_bottom_left; perfect_bottom_right];

%% Create the transformation matrix 
%perfect_qr = [perfect_qr ones(length(perfect_qr), 1)];
%fips = [fips ones(length(perfect_qr),1)];
tform = fips\perfect_qr;
%last_column = [0.0; 0.0; 1.0];
%tform = [tform(:,1:2) last_column];

%% Transform and crop the image
% The transformed fips will have the same values as perfect_qr. Just return
% to columns we want from prefect_qr.
% tform = tform';
T = maketform('projective', fips, perfect_qr); 
% cp2tform(fips, perfect_qr, 'projective');
%tformedImage = imwarp(image, T, 'OutputView', imref2d(size(image)));
tformedImage = imtransform(image, T);
figure; imshow(tformedImage)
prutt = fips*tform;
fips*tform - perfect_qr
hold on;
plot(prutt(:,1), prutt(:,2),  'rs', 'MarkerSize', 10, 'LineWidth', 3);

for i = 1:length(prutt)
    t(i) = text(prutt(i,1),prutt(i,2),int2str(i));
end
set(t(:),'fontw','bold','fonts',12)

tformedFips = perfect_qr(:, 1:2);

croppedImage = CropImage(tformedFips, tformedImage);

