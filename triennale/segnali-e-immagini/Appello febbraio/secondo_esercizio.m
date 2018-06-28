% Esercizio 1

% Creiamo un immagine 512x512, a 256 livelli di grigio, con sfondo colore 128
image = 128 * ones(512, 512);

% Disegniamo un triangolo isoscele al centro
% Creiamo una variabile pad che ci farà da offset
pad = 156; % (512/2)-(200/2)

for i = 1:200
    image(pad:pad+i,pad+i)=200;
end 

% Convertiamo l'immagine
image = mat2gray(image, [0 256]);

% Mostriamo l'immagine
subplot(1, 3, 1);
imshow(image);
title('Original image');

% Calcoliamo la trasformata di Fourier dell'immagine
imageFFT = fftshift(fft2(image));

% Calcoliamo la magnitude e la phase dell'immagine
imageMagnitude = abs(imageFFT);
imagePhase = angle(imageFFT);

% Mostriamo la porzione [1:128,1:128] della magnitude
subplot(1, 3, 2);
imshow(imageMagnitude(1:128, 1:128));
title('Image Magnitude');

% Mostriamo la fase
subplot(1, 3, 3);
imshow(imagePhase, []);
title('Image Phase');

% Ora facciamo lo zero padding fino a raggiungere le dimensioni 612x612
imageFFT = fftshift(fft2(image, 612, 612));

% Calcoliamo la magnitude e la phase dell'immagine
imageMagnitude = abs(imageFFT);
imagePhase = angle(imageFFT);

% Mostriamo la porzione della magnitude
figure;
subplot(1, 3, 1);
imshow(imageMagnitude);
title('Image Magnitude with zero-padding');

% Ricostriuamo l'immagine di partenza a partire dalla magnitude
subplot(1, 3, 2);
imshow(abs(ifft2(ifftshift(imageFFT))));
title('Image reconstruction from magnitude spectrum (zero-padded)');

% Ricostruiamo l'immagine di partenza a partire dalla fase
imagePhase = cos(imagePhase) + 1i * sin(imagePhase);
subplot(1, 3, 3);
imshow(ifft2(ifftshift(imagePhase)), []);
title('Image reconstruction from phase spectrum (zero-padded)');

% Esercizio 2

% Aggiungiamo rumore gaussiano all'immagine
image = imnoise(image, 'gaussian', 0, 0.1);

% Mostriamolo
figure;
subplot(3, 4, 1);
imshow(image);
title('Image with gaussian noise');

% Ora filtriamo l'immagine con un filtro gaussiano 8-5
subplot(3, 4, 2);
filter = fspecial('gaussian', 8, 5);
image1 = imfilter(image, filter);
imshow(image1);
title('Image with gaussian filter (8, 5)');

% Ora filtriamo l'immagine con un filtro gaussiano 8-1
subplot(3, 4, 3);
filter = fspecial('gaussian', 8, 1);
image2 = imfilter(image, filter);
imshow(image2);
title('Image with gaussian filter (8, 1)');

% Ora filtriamo l'immagine con un filtro gaussiano 12-5
subplot(3, 4, 4);
filter = fspecial('gaussian', 12, 5);
image3 = imfilter(image, filter);
imshow(image3);
title('Image with gaussian filter (12, 5)');

% Visualizziamo gli errori del filtraggio, quello minore è il migliore (il secondo)
mean(sum(abs(image-image1)))
mean(sum(abs(image-image2)))
mean(sum(abs(image-image3)))

% Visualizziamo per ogni filtro l'istogramma e il grafico 3d
subplot(3,4,5);
imhist(image);

subplot(3,4,6);
imhist(image1);

subplot(3,4,7);
imhist(image2);

subplot(3,4,8);
imhist(image3);

subplot(3,4,9);
surf(image);

subplot(3,4,10);
surf(image1);

subplot(3,4,11);
surf(image2);

subplot(3,4,12);
surf(image3);