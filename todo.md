TO DO
=====

### Mikael
Calculate positions of the FIP:s.

##### Strategy:
https://www.inf.u-szeged.hu/ipcg/publications/papers/KatonaNyulISMM2013.pdf
http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5403098

1. ~~Gaussian smoothing~~
2. ~~Gradient calculation (sobel)~~
3. Binarization
  * Must find a way to find better threshold value dependant of the image
4. Line sweep, get FIP (finder pattern) candidates
  * Must remove outliers before calculating the final FIP-position
5. Line sweep, get AP (alignment pattern)

##### Output:
FIPPositions = []

### Teodor
Calculate rotation and translation at the given FIP:s.
~~FIP_rotated = TransformFIPs(FIPPositions);~~

### Oscar
Convert to grayscale.
Compensate for uneven illumination.

### Oscar
Create a 41*41 matrix of all points after rotation and translation.
QR_data = CreateBitmap(FIPRotated);

### Anton
Determine text from perfect points by reading QR_data pixel by pixel.
Convert to ASCII symbols.
Put strout as the resulting text.
strout = readQR(QRData);

### Known errors
'images/set5/Hus_4e.png' doesn't transform correctly. Needs a fourth FIP inorder to work.
