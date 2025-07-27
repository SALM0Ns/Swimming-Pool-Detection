clc; clear; close all;

% === Parameters ===
imageFile = '40.PNG';
resizeSize = [1920 1920];
hue_min = 0.5; hue_max = 0.57;
saturation_min = 0.3;
value_min = 0.5;

% === Load Image ===
img = imread(imageFile);

% === Segment Blue Regions ===
blueMask = segmentBlueRegion(img, hue_min, hue_max, saturation_min, value_min);

% === Apply Mask to Image ===
segmentedImg = applyMask(img, blueMask);

% === Display Segmented Image ===
figure, imshow(segmentedImg), title('Segmented Blue Regions');

% === Find and Show Bounding Boxes ===
showBoundingBoxes(img, blueMask, 'Original with Bounding Boxes');

% === Resize and Display Images ===

showResizedImage(segmentedImg, resizeSize, 'Resized Segmented Image');



%% === Functions ===

function blueMask = segmentBlueRegion(img, hMin, hMax, sMin, vMin)
    hsv_img = rgb2hsv(img);
    blueMask = (hsv_img(:,:,1) >= hMin) & (hsv_img(:,:,1) <= hMax) & ...
               (hsv_img(:,:,2) >= sMin) & (hsv_img(:,:,3) >= vMin);
end

function maskedImg = applyMask(img, mask)
    maskedImg = img;
    mask3D = repmat(mask, [1, 1, 3]); % replicate for R, G, B channels
    maskedImg(~mask3D) = 0;
end

function showBoundingBoxes(img, mask, figTitle)
    stats = regionprops(mask, 'BoundingBox');
    figure, imshow(img), title(figTitle);
    hold on;
    for k = 1:length(stats)
        rectangle('Position', stats(k).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
    end
    hold off;
end

function showResizedImage(img, sizeVec, figTitle)
    resizedImg = imresize(img, sizeVec);
    figure, imshow(resizedImg), title(figTitle);
end