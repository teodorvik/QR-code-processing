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

% V�lj ut FIP

% Ber�kna position av FIP:arna

% R�kna ut rotation och translation vid givna FIP:ar.

% G�r om till gr�skala
% Skapa en matris av alla punkter efter rotation och translation.

% F� ut text fr�n perfekta punkter.