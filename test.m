% test all images!

% searches recursively through all subdirectories of the given directory
% collecting a list of all file names it finds
% make sure it is only images, png/jpg, in the given directory
fileList = getAllFiles('images');

for i = 1:(size(fileList))
	disp(sprintf('Test %d: ', i)), disp(fileList(i));
	tnm034(fileList(i));
	pause()
end