% Tills när vi vill prova många bilder. Just nu
% hårdkodar vi bilden.
%
% function[strout] = tnm034(image)

image = im2double(imread('images/set1/Bygg_1.png'));

% Hitta intressanta punkter m.h.a. Viola-Jones och deras Haar figurer.
% Letar efter ansikten just nu. Det ska det inte göra. Vi måste hitta en annan fil
% att kolla efter.
filename = 'HaarCascades/haarcascade_frontalface_alt.mat';
objects = ObjectDetection(image, filename, 0);

% Välj ut FIP

% Beräkna position av FIP:arna
%
% FIP_positions = []

% Räkna ut rotation och translation vid givna FIP:ar.
% Gör om till gråskala
% Skapa en 41*41 matris av alla punkter efter rotation och translation.
%
% QR_data = translate(FIP_positions);

% Få ut text från perfekta punkter.
% Sätt strout till texten
%
% strout = readQR(QR_data);