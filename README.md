## yaskawa_mh180_ros2_control
This repository consists of matlab scripts to demonstrate the image processing starting from very basics of Image-data types, colcor-models to calibration of mono and stereo cameras and setting up the multiple camera models for the Husky robot and further processing to SIFT detector and discriptor for image stitching and feature matching.

## Img_datatypes:
This package consists of matlab scripts to understand the different Image types and conversion of images from one type to the other using standard matlab libraries
  - Interconversion of GrayScale img, RGB img, Binary img and image indexing 
  - Thresholding using Otsu principal and histogram creation
  - Introduction to indexing of the image and colormap 

## Img_colormodels:
 This package consists of matlab scripts to understand the different color spaces such as RGB, HSV, LAB, YIQ, YUV, XYZ and GrayScale. Conversion of images from onr colorspace to the other and analysing the image data mathematically using matlab standard libraries. 
  - Extracting the Red, Blue and Green channel from RGB image with and generate corresponding color map 
  - Creating grayscale image with linear combination of different components and averaging methods
  - Conversion of RGB image to HSV colorspace, exctract the Hue, Saturation and Value channels from HSV image, thresholding the individual channels and reconstruct the image
  ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/fba65e48-79f6-4a60-ad7b-6e90eed62215)

## Mon_cam_calibration:
 This package consists of matlab scripts to capture the images and perform the camera calibration using matlab. 
  - Start the usb camera, and record the checkerboard images for camera calibration
  - Detect the corner points of the checkerboard and calculates image_points and boardsize parameters
  - Transform the image points from the corner points into world coordinates
  - Calculate the intrinsic and extrinsic camera parameters
  - Visualize the reprojection error and extrinsic parameters of the calibrated camera
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/f463b51f-ad86-4bd0-88fe-39a2ab2b2056)
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/ff68a685-a92c-40d6-9b46-9b39a4fe6011)

## Stereo_cam_calibration:
 This package consists of matlab scripts to capture the images and perform the stereo camera calibration using matlab. 
  - Start the usb camera, and record the checkerboard images for camera calibration
  - Detect the corner points of the checkerboard and calculates image_points and boardsize parameters
  - Transform the image points from the corner points into world coordinates
  - Calculate the intrinsic and extrinsic camera parameters fro stereo camera pair
  - Visualize the reprojection error and extrinsic parameters of the calibrated stereocamera system
  - Rectification of the stereo image pair
  - Compute the dispariy between stereo image pairs and recostruction of the 3D scene using disparity map and reprojection matrix
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/22341ed7-cd7f-40c7-b260-6d3dc1004b06)
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/18d2038f-e7d1-4a4c-b75c-eca43ddc65f5)
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/e2f01dfb-091c-4475-bb15-c1c9a1c2e668)
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/0089d795-8365-430d-a7ec-85af528c995c)

## Multi_cam_model:
 This package consists of matlab scripts to capture the images and perform the stereo camera calibration of two stereo pair and visualize the extrensics of all cameras with respect to checkere board using matlab. 
  - Stereo camera calibration of the two stereo pair, then visualize the camera extrinsics in the same co-ordinate system using the rotation and translation vectors obtained from the camera calibration process w.r.t checkred board co-ordinate system.
    ![image](https://github.com/borsesaurabh2022/3d_ImgProcessing/assets/103029292/125cf4aa-4ae3-4daf-b9b6-a423df036708)



