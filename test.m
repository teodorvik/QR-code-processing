% test all images!

% searches recursively through all subdirectories of the given directory
% collecting a list of all file names it finds
fileList = getAllFiles('images/set3', '*.png');

for i = 2:(size(fileList))
    close all;
	disp(sprintf('Test %d: ', i)), disp(fileList(i));
	    
    % Convert image to double
    image = im2double(imread(fileList{i}));
    
    % Write current date/time, file read, and strout to out.txt
    fid = fopen('testout.txt','a+');
    datetime=datestr(now);
    str = sprintf('%s %s\n   %s \n\n',datetime,fileList{i},tnm034(image));
    encoded_str = unicode2native(str, 'UTF-8');
		fwrite(fid, encoded_str, 'uint8'); 

	pause();
end

fclose(fid);
