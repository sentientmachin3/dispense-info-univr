% Esercizio 1

% Passo di campionamento 1 ogni 10ms, quindi 0.01s
samplingPeriod = 0.01;
samplingFrequency = 1 / samplingPeriod;

% Il periodo del segnale invece è di 2s
signalPeriod = 2;
signalFrequency = 1 / signalPeriod;

% Dobbiamo rappresentare il segnale per un tempo di 5 periodi del segnale
timeDomain = 0:samplingPeriod:(signalPeriod * 5);

% Calcoliamo il segnale del punto a)
y_a = sin(2 * pi * signalFrequency * timeDomain) + 2 * cos(2 * pi * signalFrequency * timeDomain);

% Calcoliamo il segnale del punto b)
y_b = 3 * cos(2 * pi * (signalFrequency * 2) * timeDomain);

% Calcoliamo il segnale somma dei segnali y_a e y_b
y = y_a + y_b;

% Rappresentiamo il segnale
figure('Name', 'Exercise 1.1-1.2');
subplot(1, 3, 1);
plot(timeDomain, y);
title('Signal y');
xlabel('Time (s)');
ylabel('Amplitude');

% Esercizio 2

% Calcoliamo la trasformata di Fourier del segnale y
yFFT = fft(y);

% Calcoliamo la magnitude del segnale y
yMagnitude = abs(yFFT / length(y));

% Calcoliamo il dominio delle frequenze sul quale è definito il segnale
frequencyDomain = (0:length(y) - 1) * (samplingFrequency / length(y));

% Rappresentiamo la magnitude
subplot(1, 3, 2);
plot(frequencyDomain, yMagnitude * 2);
title('Magnitude FFT');
xlabel('Frequency (Hz)');
xlim([0, samplingFrequency / 2]);

% Calcoliamo la shifted magnitude e la rappresentiamo
yMagnitudeShifted = abs(fftshift(yFFT) / length(y));
subplot(1, 3, 3);
plot(frequencyDomain, yMagnitudeShifted * 2);
title('Shifted Magnitude FFT');
xlabel('Frequency (Hz)');
xlim([0, samplingFrequency]);

% Esercizio 3
clear;

% Passo di campionamento 1 ogni 10ms, quindi 0.01s
samplingPeriod = 0.01;
samplingFrequency = 1 / samplingPeriod;

% La frequenza dei due segnali è 1Hz e 1.5Hz
signalFrequency1 = 1;
signalPeriod1 = 1 / signalFrequency1;
signalFrequency2 = 1.5;
signalPeriod2 = 1 / signalFrequency2;

% Usiamo lo stesso asse temporale del punto precedente
timeDomain = 0:samplingPeriod:signalPeriod2 * 5;

% Definiamo i due segnali singoli e quello totale
y1 = sin(2 * pi * signalFrequency1 * timeDomain);
y2 = sin(2 * pi * signalFrequency2 * timeDomain);
y = y1 + y2;

% Rappresentiamo il segnale totale
figure('Name', 'Exercise 1.3');
subplot(1, 3, 1);
plot(timeDomain, y);
title('Signal y');
xlabel('Time (s)');
ylabel('Amplitude');

% Ora calcoliamo e rappresentiamo la sua amplitude
yFFT = fft(y);
frequencyDomain = (0:length(y) - 1) * (samplingFrequency / length(y));
yMagnitude = abs(yFFT / length(y));

subplot(1, 3, 2);
plot(frequencyDomain, yMagnitude * 2);
title('Magnitude FFT');
xlabel('Frequency (Hz)');
xlim([0, samplingFrequency / 2]);
ylim([0, ceil(max(yMagnitude))]);

% Stessa cosa con zero padding
yFFT = fft(y, 5000);
frequencyDomain = (0:length(yFFT) - 1) * (samplingFrequency / length(yFFT));
yMagnitude = abs(yFFT / length(y));

subplot(1, 3, 3);
plot(frequencyDomain, yMagnitude * 2);
title('Zero padded magnitude FFT');
xlabel('Frequency (Hz)');
xlim([0, 3]);
