TO DO
=====
Write all tests to file.

### Mikael
Calculate positions of the FIP:s.

##### Strategy:
https://www.inf.u-szeged.hu/ipcg/publications/papers/KatonaNyulISMM2013.pdf
http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5403098

1. ~~Gaussian smoothing~~
2. ~~Gradient calculation (sobel)~~
3. ~~Binarization~~
4. ~~Line sweep, get FIP candidates~~
 * Needs improval. It's shit with noisy images.
 * Removal of outliers might be needed.

### Mikael
~~Find corners of QR~~

### Teodor
~~Calculate rotation and translation at the given FIP:s.~~
Change the function to use the four corners instead.

### Oscar
Convert to grayscale.
Look at the lecture slides. Base illumination on maxvalue.
Compensate for uneven illumination.
Move the cropping from ToGrayscale to the TransformFIPS function instead? Makes more sense.

### Oscar
Create a 41*41 matrix of all points after rotation and translation.

### Anton
Determine text from perfect points by reading QR_data pixel by pixel.
Convert to ASCII symbols.
Put strout as the resulting text.
strout = readQR(QRData);

### Known errors
'images/set5/Hus_4e.png' doesn't transform correctly. Needs a fourth FIP inorder to work.
