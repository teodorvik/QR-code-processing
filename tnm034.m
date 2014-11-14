% Tills n�r vi vill prova m�nga bilder. Just nu
% h�rdkodar vi bilden.
%
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Hitta intressanta punkter m.h.a. Viola-Jones och deras Haar figurer.
% Letar efter ansikten just nu. Det ska det inte g�ra. Vi m�ste hitta en annan fil
% att kolla efter.
filename = 'HaarCascades/haarcascade_frontalface_alt.mat';
objects = ObjectDetection(image, filename, 0);

% Teodor
% Ber�kna position av FIP:arna
% FIP_positions = []

% Mikael
% R�kna ut rotation och translation vid givna FIP:ar.
% FIP_rotated = rotate(FIP_positions);

%
% G�r om till gr�skala
% Linj�r interpolation mellan f�rgerna p� FIParna

% Oscar
% Skapa en 41*41 matris av alla punkter efter rotation och translation.
% QR_data = scale(FIP_rotated);

% 
% F� ut text fr�n perfekta punkter genom att l�sa av QR_data pixel f�r pixel.
% Konvertera till ASCII
% S�tt strout till texten
% strout = readQR(QR_data);