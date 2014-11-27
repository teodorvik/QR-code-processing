function centerPoint = GetAPPosition(image, cornerPoints)

dxPixel = (abs(cornerPoints(2,1)-cornerPoints(1,1)))/41;
dyPixel = (abs(cornerPoints(3,2)-cornerPoints(1,2)))/41;
apCenter = round([cornerPoints(1,1)+dxPixel*34.5, cornerPoints(1,2)+dyPixel*34.5]);
r = ceil(max([dxPixel dyPixel])*10);
[rows cols] = size(image);
if apCenter(2) + r > rows
    r = rows - apCenter(2)
end
if apCenter(1) + r > cols
    r = cols - apCenter(1)
end

apImageCrop = image((apCenter(2)-r):(apCenter(2)+r), (apCenter(1)-r):(apCenter(1)+r));
% imshow(apImageCrop);

perfectAP = [1 1 1 1 1; 1 0 0 0 1; 1 0 1 0 1; 1 0 0 0 1; 1 1 1 1 1];
perfectAP = imresize(perfectAP, [5*dyPixel 5*dxPixel], 'box');
rotation = atan((cornerPoints(1,2)-cornerPoints(2,2))/(cornerPoints(2,1)-cornerPoints(1,1)));
perfectAP = imrotate(perfectAP, rotation);
apImageCropBw = im2bw(apImageCrop, graythresh(apImageCrop));

% Correlation / template matching
c = normxcorr2(perfectAP, apImageCropBw);
[ypeak, xpeak] = find(c==max(c(:)));
xpeak = xpeak - size(perfectAP,2)/2;
ypeak = ypeak - size(perfectAP,1)/2;
xpeak = apCenter(1) - r + xpeak;
ypeak = apCenter(2) - r + ypeak;
% figure;
% imshow(image);
% hold on;
% plot(xpeak, ypeak, 'rx');
% plot(apCenter(1), apCenter(2), 'bx');
centerPoint = [xpeak, ypeak];