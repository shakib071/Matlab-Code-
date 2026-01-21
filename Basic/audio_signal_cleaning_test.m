%% Audio Signal Cleaning Using Fourier Transform
clc; clear; close all;

%% Step 1: Load Audio
% You can use your own audio file (wav format)
[originalAudio, Fs] = audioread('noisy_audio.wav'); % Fs = sampling rate
audio = originalAudio(:,1); % If stereo, take first channel

t = (0:length(audio)-1)/Fs; % Time vector

%% Step 2: Plot Original Audio
figure;
plot(t, audio);
title('Original Noisy Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

%% Step 3: Compute Fourier Transform
N = length(audio);
Y = fft(audio);
f = (0:N-1)*(Fs/N); % Frequency vector

%% Step 4: Plot Magnitude Spectrum
figure;
plot(f, abs(Y));
title('Magnitude Spectrum of Original Audio');
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');

%% Step 5: Filter Out High-Frequency Noise
% Simple low-pass filter example
cutoff = 4000; % frequency in Hz
Y_filtered = Y;
Y_filtered(f > cutoff & f < Fs-cutoff) = 0; % zero out high-frequency noise

%% Step 6: Inverse Fourier Transform to get Clean Audio
cleanAudio = ifft(Y_filtered, 'symmetric');

%% Step 7: Plot Cleaned Audio
figure;
plot(t, cleanAudio);
title('Cleaned Audio Signal');
xlabel('Time (s)');
ylabel('Amplitude');

%% Step 8: Compare Before and After
figure;
subplot(2,1,1);
plot(t, audio); title('Original Noisy Audio');
xlabel('Time (s)'); ylabel('Amplitude');

subplot(2,1,2);
plot(t, cleanAudio); title('Cleaned Audio');
xlabel('Time (s)'); ylabel('Amplitude');

%% Step 9: Play Original and Cleaned Audio
disp('Playing Original Audio...');
sound(audio, Fs);
pause(length(audio)/Fs + 1);

disp('Playing Cleaned Audio...');
sound(cleanAudio, Fs);

%% Step 10: Save Cleaned Audio
audiowrite('cleaned_audio.wav', cleanAudio, Fs);
audiowrite('noisy_audio.wav',audio,Fs);
disp('Cleaned audio saved as "cleaned_audio.wav"');
  