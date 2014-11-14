TO DO
=====

## Teodor, Mikael
Beräkna position av FIP:arna

#### Strategi:
https://www.inf.u-szeged.hu/ipcg/publications/papers/KatonaNyulISMM2013.pdf
http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5403098

* Gaussian smoothing
* Gradient calculation (sobel)
* Binarization
* Line sweep, get FIP candidates

#### Output:
FIP_positions = []

## Mikael
Räkna ut rotation och translation vid givna FIP:ar.
FIP_rotated = rotate(FIP_positions);

## Oscar
Gör om till gråskala
Kompensera för ojämn belysning

## Oscar
Skapa en 41*41 matris av alla punkter efter rotation och translation.
QR_data = CreateBitmap(FIP_rotated);

## Anton
Få ut text från perfekta punkter genom att läsa av QR_data pixel för pixel.
Konvertera till ASCII
Sätt strout till texten
strout = readQR(QR_data);