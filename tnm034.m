% Tills n�r vi vill prova m�nga bilder. Just nu
% h�rdkodar vi bilden.
%
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Hitta intressanta punkter m.h.a. Viola-Jones och deras Haar figurer.
filename = 'HaarCascades/haarcascade_frontalface_alt.mat';
objects = ObjectDetection(image, filename, 0);

% V�lj ut FIP

% Ber�kna position av FIP:arna

% Transformera/Rotera bilden efter position av FIP:arna

% G�r om till gr�skala

% Extrahera informationen
