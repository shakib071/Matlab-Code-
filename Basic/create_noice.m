% === SIMPLE NOISE FOR TESTING ===

% 1. Load your image
img = imread('tom 2.jpg');
img = im2double(img);

% 2. Choose ONE noise type (uncomment the one you want)

% Gaussian noise (most common)
noisy = imnoise(img, 'gaussian', 0, 0.2);

% Salt & pepper noise
% noisy = imnoise(img, 'salt & pepper', 0.05);

% Speckle noise
% noisy = imnoise(img, 'speckle', 0.05);

% 3. Show and save
figure; imshow(noisy);
imwrite(noisy, 'noisy_image.jpg');