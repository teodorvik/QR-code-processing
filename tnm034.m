% Tills när vi vill prova många bilder. Just nu
% hårdkodar vi bilden.
%
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Hitta intressanta punkter m.h.a. Viola-Jones och deras Haar figurer.
filename = 'HaarCascades/haarcascade_frontalface_alt.mat';
objects = ObjectDetection(image, filename, 0);

% Välj ut FIP

% Beräkna position av FIP:arna

% Transformera/Rotera bilden efter position av FIP:arna

% Gör om till gråskala

% Extrahera informationen
