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

% Create decode_mask
imread('images/decode_mask.png');



