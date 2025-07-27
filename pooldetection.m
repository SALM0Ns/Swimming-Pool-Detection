clc; clear; close all;
img = imread('40.PNG');

% HSV conversion and segmentation
hsv_img = rgb2hsv(img); 
hue_min = 0.5; hue_max = 0.57;  
saturation_min = 0.3; 
value_min = 0.5; 

blueMask = (hsv_img(:,:,1) >= hue_min) & (hsv_img(:,:,1) <= hue_max) & ...
          (hsv_img(:,:,2) >= saturation_min) & (hsv_img(:,:,3) >= value_min);

WaterRe = uint8(blueMask) .* img;

% Show segmented image
figure(1);
imshow(WaterRe), title('Segmented ');
hold on;

% Read bounding box from XML
xmlFile = '40.xml';
data = xmlread(xmlFile);
objects = data.getElementsByTagName('object');

for i = 0:objects.getLength-1
   obj = objects.item(i);
   bbox = obj.getElementsByTagName('bndbox');

   xmin = str2double(char(bbox.item(0).getElementsByTagName('xmin').item(0).getFirstChild.getData));
   ymin = str2double(char(bbox.item(0).getElementsByTagName('ymin').item(0).getFirstChild.getData));
   xmax = str2double(char(bbox.item(0).getElementsByTagName('xmax').item(0).getFirstChild.getData));
   ymax = str2double(char(bbox.item(0).getElementsByTagName('ymax').item(0).getFirstChild.getData));

   rectangle('Position', [xmin, ymin, xmax - xmin, ymax - ymin], ...
             'EdgeColor', 'r', 'LineWidth', 2);

   text(xmin, max(1, ymin - 10), 'Pool', 'Color', 'green', 'FontWeight', 'bold');
end
hold off;
