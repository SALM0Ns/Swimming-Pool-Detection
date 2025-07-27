**detect swimming pool in In the city area by using dataset for kaggle.**

kaggle: Swimming Pool detection - Algarve's Landscape
https://www.kaggle.com/datasets/cici118/swimming-pool-detection-algarves-landscape

In this studies aim to developing tools for swinning pooldetection, in situation when firefigther need emergency water in large city area when there's forest fire or large fire accident. and we using MATLAB for Experimental tools.

**Dataset**
we checking dataset files and we founf that we have 289 pool image that capture from Google Maps.
And 173 images with actual swimming pools location that we about to use it for acuracy test.


 **Flow Chart**
<img width="723" height="563" alt="Image" src="https://github.com/user-attachments/assets/ef2c96e1-e411-4cb6-9369-92c350fbec1a" />

start with ideas we saw are and found that 80-90% of city area are covered with red-orange-green-gray color only swimming pool is blue.
so we decide that we'll create blue mask for morphology loop all picture area.

By Convert the RGB image to the HSV color space because HSV is more robust for color-based segmentation (especially hue).
	hsv_img(:,:,1) = Hue channel (color type)
	hsv_img(:,:,2) = Saturation channel (color intensity)
	hsv_img(:,:,3) = Value channel (brightness)

And we Define a range in the HSV color space that corresponds to the “blue” region (usually water or sky).
	• Hue for blue is around 0.5–0.7 in normalized HSV.
	•	Saturation and Value thresholds help exclude pale or dark areas.

Then we create Binary Mask base on thresholds and apply the mask to original image.
And we'll have Segmented Image Result.


Originals Image
<img width="641" height="643" alt="Screenshot 2568-07-27 at 22 03 43" src="https://github.com/user-attachments/assets/49639e12-6956-43d7-bb91-bc7a5101c842" />

Segmented 

<img width="640" height="640" alt="Screenshot 2568-07-27 at 22 03 36" src="https://github.com/user-attachments/assets/e308204b-7bfc-4b3d-b46f-53ff8289f161" />

after first try image result are not precise enought, we can still spot some fake pool area.

Then we adjust our HSV value

	•	Sets narrow HSV thresholds for blue hues:
	•	Hue range (0.5–0.57): Targets a narrower slice of blue hues than before.
	•	Saturation ≥ 0.3 and Value ≥ 0.5: Filters out dull or dark regions.

Result After HSV Adjustment

<img width="640" height="643" alt="Screenshot 2568-07-27 at 22 11 31" src="https://github.com/user-attachments/assets/82c28d6f-01bd-4ab6-aec5-349de4bee806" />

After we satisfy with our result we add Bounding Boxes on area with that use to be pool or blue area red boxs.

<img width="600" height="416" alt="Screenshot 2568-07-27 at 22 04 58" src="https://github.com/user-attachments/assets/9f18bff8-af8e-447d-9b62-a362dddeebc8" />

As we can see Bounding Boxes are cover all of pool spot 
Then we add XML files that tell us the exactly pool areas and we create Bounding Boxes on it for checking accuracy.

<img width="594" height="415" alt="Screenshot 2568-07-27 at 22 04 19" src="https://github.com/user-attachments/assets/7fdb5ec7-04fe-439a-b161-043ceb84b932" />




