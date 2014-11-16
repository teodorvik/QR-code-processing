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
[row column] = size(decodeMask);
k = 1; l = 1;

% Create matrix and allocate space to store binary strings
bitstring = zeros(183, 8);

% SMALL TEST
% testQR = imread('images/perfect_test_qr.png');
% test case can be performed by putting testQR as input
% should give 'test QR' as output

for j = 1:column
	for i = 1:row
		% If it is a white space in the decode mask we read the save the bit information
		if(decodeMask(i, j) ~= 0)
			bitstring(k, l) = QR_data(i, j);
			%bitstring(k, l) = testQR(i, j);
            l=l+1;
            if((l-1)/8==1)
                k=k+1;
                l=1;
            end
        end
	end
end

mess = cell(1,(k-1));

% Convert to ASCII symbols/characters
for i = 1:(k-1)
	mess{i} = char(bin2dec(num2str(bitstring(i,:))));
end

strout = strjoin(mess);

% TO-DO
% Only ASCII DEC 32-127 should be valid. Other values should not be added to mess{}.
% It is only hardcoded so far and coded for a very specific case,
% would be great to write so it works for for a more general case,
% no static allocations etc.
