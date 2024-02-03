# 3d_ImgProcessing: SIFT keypoint detection:

This repository consist of Matlab scripts to demonstrate the implementation of the SIFT(Scale- Invarient Feature TRansform) keypoint/feature detection. The implementation is based on the a computer vision algorithm developed by David G. Lowe.
David G. Lowe introduced SIFT in his paper titled "Distinctive Image Features from Scale-Invariant Keypoints," which was published in 2004. 
Honestly, the implementing the sift feature is quite different compared to calculative approach behind it, t 

## Implementation:
- Image Preprocessing:
  Construct a Gaussian scale space from the input image.
  Create a Difference of Gaussian (DoG) pyramid by subtracting adjacent Gaussian-blurred images.
  
- Octave Generation:
  Divide each scale space into octaves, which are sets of progressively downsampled images.
  Octaves help in handling different scales efficiently and improve algorithm performance.
  Each octave consists of a series of blurred and downsampled images.
  
- Keypoint Detection (Extrema):
  Identify local extrema in the DoG pyramid to locate potential keypoints.
  Refine keypoint locations with subpixel accuracy using a second-order Taylor series expansion.
  
- Keypoint Elimination:
  Eliminate keypoints with low contrast or poorly localized on edges.
  Use a 2x2 Hessian matrix to check the curvature for eliminating poorly localized keypoints.
  
- Orientation Assignment:
  Assign consistent orientations to keypoints based on local image gradients.
  Create an orientation histogram from gradient orientations in a region around each keypoint.

- Descriptor Computation:
  Compute distinctive descriptors for each keypoint.
  Sample image gradients and orientations around the keypoint.
  Apply Gaussian weighting and achieve orientation invariance by rotating coordinates.

- Feature Matching:
  Perform matching tests to test repeatability and stability of SIFT features.
  Compare keypoints between an original image and a transformed version using computed descriptors.
  Use matching errors to identify likely keypoint correspondences and set the transformation.

- Results and Conclusion:
  Evaluate and showcase results, including visual representations of keypoints.
  Conclude the implementation, emphasizing the distinctiveness and invariance of SIFT features.
  
## References:
1. MENG, YU. (2008). Implementing the Scale Invariant Feature Transform(SIFT) Method.
2. Lowe, D.G. "Distinctive Image Features from Scale-Invariant Keypoints." International Journal of Computer Vision (IJCV) 60.2 (2004): 91–110. DOI: 10.1023/B:VISI.0000029664.99615.94
