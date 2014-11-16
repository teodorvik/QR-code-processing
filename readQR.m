function strout = readQR(QR_data)
% Input: bitmap (QR code)
% Output: decoded message
%
% Reads bitmap, 41x41, column by column.
% The FIP:s and the AP should not be read.
% Use a mask to tell which areas not to read.
% Read every string of 8bits and save to a matrix.
% Every row of the matrix contains 8bits, which is 1 ASCII symbol.
% Convert to ASCII symbols and save symbol to message string.
% Return message.

% Create decodeMask
decodeMask = imread('images/decode_mask.png');

% Position tracking
[rows columns] = size(decodeMask);
k = l = 0;

% Create matrix and allocate space to store binary strings
bitstring = zeros(183, 8);


% --- Code not tested yet (have to update matlab) ---

% TO-DO
%% matlab reads binary black as 1 and white as 0, or? 
%% should be the other way round to intrepret the ASCII correct.
% Therefore; convert 1 to 0, and 0 to 1
% Perform a small test case with images/perfect_test_qr.png
%% which should give the message 'test QR'

for j = 1:rows
	for i = 1:columns
		% If it is a white space in the decode mask we read the save the bit information
		if decodeMask(j, i) == 0
			bitstring(k, l) = QR_data(j, i);
			l++;
			if l/8==1
				k++;
				l=0;
	end
end

% Convert to ASCII symbols/characters
mess = char(bin2dec(reshape(bitstring,7,[]).').');
