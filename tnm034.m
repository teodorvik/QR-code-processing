% Tills när vi vill prova många bilder. Just nu
% hårdkodar vi bilden.
%
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Teodor
% Beräkna position av FIP:arna
% FIP_positions = GetFIPPositions();

% Mikael
% Räkna ut rotation och translation vid givna FIP:ar.
% FIP_rotated = rotate(FIP_positions);

% Oscar
% Gör om till gråskala
% Linjär interpolation mellan färgerna på FIParna

% Oscar
% Skapa en 41*41 matris av alla punkter efter rotation och translation.
% QR_data = CreateBitmap(FIP_rotated);

% Anton
% Få ut text från perfekta punkter genom att läsa av QR_data pixel för pixel.
% Konvertera till ASCII
% Sätt strout till texten
% strout = readQR(QR_data);