% test all images!

% searches recursively through all subdirectories of the given directory
% collecting a list of all file names it finds
fileList = getAllFiles('images/set3', '*.png');

for i = 2:(size(fileList))
    close all;
	disp(sprintf('Test %d: ', i)), disp(fileList(i));
	    
    % Convert image to double
    image = im2double(imread(fileList{i}));
    
    tnm034(image)

	pause();
end