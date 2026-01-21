% ============================================
% IMAGE RESTORATION USING FOURIER TRANSFORMS
% ============================================
clc; clear; close all;

% ==============================
% 1. LOAD AND PREPARE IMAGE
% ==============================
fprintf('=== FOURIER TRANSFORM IMAGE RESTORATION ===\n');

% Load image
I = imread('tom extra noice.png');
I = imresize(I, [512 512]);
I_original = im2double(I);

% Convert to grayscale or process each channel
if size(I_original, 3) == 3
    I_gray = rgb2gray(I_original);
    fprintf('Color image detected. Processing in Fourier domain...\n');
    
    % We'll process each color channel separately
    I_denoised_color = zeros(size(I_original));
else
    I_gray = I_original;
    fprintf('Grayscale image detected.\n');
end

figure('Position', [100 100 1400 500]);

% ==============================
% 2. FOURIER TRANSFORM DENOISING
% ==============================
fprintf('\n1. Applying Fourier Transform denoising...\n');

if size(I_original, 3) == 3
    % Process each color channel
    for channel = 1:3
        fprintf('   Processing channel %d...\n', channel);
        I_channel = I_original(:,:,channel);
        
        % Get Fourier Transform
        F = fft2(I_channel);
        F_shifted = fftshift(F);  % Center zero frequency
        
        % Get magnitude spectrum (for display)
        magnitude = log(1 + abs(F_shifted));
        
        % Create frequency grid
        [M, N] = size(I_channel);
        [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), ...
                          -floor(M/2):floor((M-1)/2));
        D = sqrt(u.^2 + v.^2);  % Distance from center
        
        % ====================================
        % CHOOSE FILTER TYPE:
        % ====================================
        
        % OPTION A: Gaussian Low-Pass Filter
        D0 = 30;  % Cutoff frequency (adjust: 20-50)
        H = exp(-(D.^2) / (2 * D0^2));
        
        % OPTION B: Butterworth Low-Pass Filter
        % D0 = 40;  % Cutoff frequency
        % n = 2;    % Filter order
        % H = 1 ./ (1 + (D ./ D0).^(2*n));
        
        % OPTION C: Ideal Low-Pass Filter (causes ringing)
        % D0 = 35;
        % H = double(D <= D0);
        
        % Apply filter in frequency domain
        F_filtered = F_shifted .* H;
        
        % Inverse Fourier Transform
        I_filtered = real(ifft2(ifftshift(F_filtered)));
        
        % Store result
        I_denoised_color(:,:,channel) = I_filtered;
        
        % Display spectrum for first channel
        if channel == 1
            subplot(2,4,2);
            imagesc(magnitude);
            colormap('hot'); colorbar;
            title('Original Magnitude Spectrum');
            axis image;
            
            subplot(2,4,6);
            imagesc(log(1 + abs(F_filtered)));
            colormap('hot'); colorbar;
            title('Filtered Spectrum');
            axis image;
        end
    end
    
    I_denoised = I_denoised_color;
    
else
    % Process grayscale image
    % Get Fourier Transform
    F = fft2(I_gray);
    F_shifted = fftshift(F);
    
    % Display original spectrum
    subplot(2,4,2);
    imagesc(log(1 + abs(F_shifted)));
    colormap('hot'); colorbar;
    title('Original Magnitude Spectrum');
    axis image;
    
    % Create frequency grid
    [M, N] = size(I_gray);
    [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), ...
                      -floor(M/2):floor((M-1)/2));
    D = sqrt(u.^2 + v.^2);
    
    % Apply Gaussian Low-Pass Filter
    D0 = 30;
    H = exp(-(D.^2) / (2 * D0^2));
    
    % Apply filter
    F_filtered = F_shifted .* H;
    
    % Display filtered spectrum
    subplot(2,4,6);
    imagesc(log(1 + abs(F_filtered)));
    colormap('hot'); colorbar;
    title('Filtered Spectrum');
    axis image;
    
    % Inverse Fourier Transform
    I_denoised = real(ifft2(ifftshift(F_filtered)));
end

% Display images
subplot(2,4,1);
imshow(I_original);
title('Original Noisy Image');

subplot(2,4,5);
imshow(I_denoised);
title('Fourier Denoised (Low-Pass Filter)');

% ==============================
% 3. FREQUENCY DOMAIN SHARPENING
% ==============================
fprintf('2. Applying frequency domain sharpening...\n');

if size(I_original, 3) == 3
    I_sharpened_color = zeros(size(I_denoised));
    
    for channel = 1:3
        I_channel = I_denoised(:,:,channel);
        
        % Get Fourier Transform
        F = fft2(I_channel);
        F_shifted = fftshift(F);
        
        % Create High-Pass Filter for sharpening
        [M, N] = size(I_channel);
        [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), ...
                          -floor(M/2):floor((M-1)/2));
        D = sqrt(u.^2 + v.^2);
        
        % High-Pass Filter (emphasize high frequencies)
        D0_sharp = 60;  % Different cutoff for sharpening
        alpha = 1.5;    % Sharpening strength
        
        % Laplacian in frequency domain: H(u,v) = -4π²(u²+v²)
        % We'll use a simple high-emphasis filter instead
        H_sharp = 1 + alpha * (1 - exp(-(D.^2) / (2 * D0_sharp^2)));
        
        % Apply sharpening filter
        F_sharpened = F_shifted .* H_sharp;
        
        % Inverse Fourier Transform
        I_sharpened_color(:,:,channel) = real(ifft2(ifftshift(F_sharpened)));
    end
    
    I_sharpened = I_sharpened_color;
    
else
    % Grayscale sharpening
    F = fft2(I_denoised);
    F_shifted = fftshift(F);
    
    [M, N] = size(I_denoised);
    [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), ...
                      -floor(M/2):floor((M-1)/2));
    D = sqrt(u.^2 + v.^2);
    
    % High-emphasis filter
    D0_sharp = 60;
    alpha = 1.5;
    H_sharp = 1 + alpha * (1 - exp(-(D.^2) / (2 * D0_sharp^2)));
    
    F_sharpened = F_shifted .* H_sharp;
    I_sharpened = real(ifft2(ifftshift(F_sharpened)));
end

% Display sharpened
subplot(2,4,3);
imshow(I_sharpened);
title('Frequency Domain Sharpened');

% ==============================
% 4. NOTCH FILTERING (Remove Periodic Noise)
% ==============================
fprintf('3. Checking for periodic noise...\n');

if size(I_original, 3) == 3
    I_notch_color = zeros(size(I_sharpened));
    
    for channel = 1:3
        I_channel = I_sharpened(:,:,channel);
        F = fftshift(fft2(I_channel));
        
        [M, N] = size(I_channel);
        [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), ...
                          -floor(M/2):floor((M-1)/2));
        
        % Look for bright spots in spectrum (periodic noise)
        magnitude = abs(F);
        threshold = 0.8 * max(magnitude(:));
        
        % Create notch filter to remove bright spots
        notch_filter = ones(size(F));
        
        % Check for periodic patterns (stripes, grids)
        % Remove frequencies at specific locations
        for freq = 50:10:150  % Check common periodic frequencies
            % Remove vertical stripe patterns
            mask_v = abs(u) > freq-5 & abs(u) < freq+5;
            % Remove horizontal stripe patterns
            mask_h = abs(v) > freq-5 & abs(v) < freq+5;
            
            notch_filter(mask_v | mask_h) = 0.1; 
        end
        
        % Apply notch filter
        F_notch = F .* notch_filter;
        I_notch_color(:,:,channel) = real(ifft2(ifftshift(F_notch)));
    end
    
    I_final_ft = I_notch_color;
    
else
    % Grayscale notch filtering
    F = fftshift(fft2(I_sharpened));
    
    % Display spectrum to identify periodic noise
    subplot(2,4,8);
    imagesc(log(1 + abs(F)));
    colormap('hot'); colorbar;
    title('Spectrum for Periodic Noise');
    axis image;
    
    % Simple notch filter example
    [M, N] = size(I_sharpened);
    [u, v] = meshgrid(-floor(N/2):floor((N-1)/2), ...
                      -floor(M/2):floor((M-1)/2));
    
    % Remove specific frequency (example: 50 cycles/image)
    notch_filter = ones(size(F));
    freq_to_remove = 50;
    mask = (abs(u) > freq_to_remove-10 & abs(u) < freq_to_remove+10) | ...
           (abs(v) > freq_to_remove-10 & abs(v) < freq_to_remove+10);
    notch_filter(mask) = 0.01;
    
    F_notch = F .* notch_filter;
    I_final_ft = real(ifft2(ifftshift(F_notch)));
end

subplot(2,4,7);
imshow(I_final_ft);
title('After Notch Filtering');

% ==============================
% 5. FINAL ENHANCEMENT
% ==============================
fprintf('4. Final enhancement...\n');

% Adjust contrast (spatial domain)
I_final = imadjust(I_final_ft, stretchlim(I_final_ft, 0.01), []);

subplot(2,4,4);
imshow(I_final);
title('Final Enhanced Image');

% ==============================
% 6. COMPARE METHODS
% ==============================
fprintf('\n=== COMPARISON ===\n');

% Display filter profiles
figure('Position', [100 100 800 400]);

% Create frequency axis
freq_axis = linspace(0, 256, 512);

% Low-pass filter profile
D0_low = 30;
H_low = exp(-(freq_axis.^2) / (2 * D0_low^2));

% High-emphasis filter profile
D0_high = 60;
alpha = 1.5;
H_high = 1 + alpha * (1 - exp(-(freq_axis.^2) / (2 * D0_high^2)));

subplot(1,2,1);
plot(freq_axis, H_low, 'b-', 'LineWidth', 2);
hold on;
plot(freq_axis, H_high, 'r-', 'LineWidth', 2);
xlabel('Frequency');
ylabel('Filter Response');
title('Frequency Domain Filters');
legend('Low-Pass (Denoising)', 'High-Emphasis (Sharpening)', 'Location', 'best');
grid on;
xlim([0 150]);

% Show frequency response of combined filtering
H_combined = H_low .* H_high;
subplot(1,2,2);
plot(freq_axis, H_combined, 'g-', 'LineWidth', 2);
xlabel('Frequency');
ylabel('Combined Response');
title('Overall Frequency Response');
grid on;
xlim([0 150]);

% ==============================
% 7. QUALITY METRICS
% ==============================
fprintf('\n=== QUALITY METRICS ===\n');

if size(I_original, 3) == 3
    I_orig_gray = rgb2gray(I_original);
    I_final_gray = rgb2gray(I_final);
else
    I_orig_gray = I_original;
    I_final_gray = I_final;
end

% Calculate metrics in frequency domain
F_orig = fft2(I_orig_gray);
F_final = fft2(I_final_gray);

% Energy in different frequency bands
low_freq_mask = D < 30;
mid_freq_mask = D >= 30 & D < 100;
high_freq_mask = D >= 100;

energy_orig_low = sum(abs(F_orig(low_freq_mask)).^2);
energy_orig_high = sum(abs(F_orig(high_freq_mask)).^2);

energy_final_low = sum(abs(F_final(low_freq_mask)).^2);
energy_final_high = sum(abs(F_final(high_freq_mask)).^2);

fprintf('Frequency Domain Analysis:\n');
fprintf('  Low-frequency energy (preserved): %.2f%%\n', ...
    energy_final_low/energy_orig_low * 100);
fprintf('  High-frequency reduction (noise removed): %.2f%%\n', ...
    (1 - energy_final_high/energy_orig_high) * 100);

% Spatial domain metrics
mse = mean((I_orig_gray(:) - I_final_gray(:)).^2);
psnr_val = 10 * log10(1/mse);
fprintf('\nSpatial Domain Metrics:\n');
fprintf('  PSNR: %.2f dB\n', psnr_val);

% ==============================
% 8. SAVE RESULTS
% ==============================
imwrite(I_original, '1_original.jpg', 'Quality', 95);
imwrite(I_denoised, '2_fourier_denoised.jpg', 'Quality', 95);
imwrite(I_final, '3_final_restored.jpg', 'Quality', 95);

fprintf('\n=== RESULTS SAVED ===\n');
fprintf('1. 1_original.jpg - Original image\n');
fprintf('2. 2_fourier_denoised.jpg - After Fourier denoising\n');
fprintf('3. 3_final_restored.jpg - Final restored image\n');