# 3d_ImgProcessing: SIFT keypoint detection:

This collection includes Matlab scripts designed to showcase the practical application of the Scale-Invariant Feature Transform (SIFT) for key points and feature detection. The implementation is rooted in the computer vision algorithm devised by David G. Lowe.

SIFT, introduced by David G. Lowe in his 2004 paper "Distinctive Image Features from Scale-Invariant Keypoints," serves as the foundation for this implementation. It's worth noting that the process of implementing SIFT features differs significantly from understanding the mathematical intricacies that underlie the algorithm.

So, instead of relying on the fancy pre-built SIFT feature detection tools in Matlab and OpenCV, we thought, "Hey, why not reinvent the wheel?!" Our collection of Matlab scripts is like baking a cake from scratch when you could just buy one at the store – it's all about embracing the journey, even if it involves a few extra flour explosions along the way.

## Implementation:
- Image Preprocessing:
  Construct a Gaussian scale space from the input image.
  Create a Difference of Gaussian (DoG) pyramid by subtracting adjacent Gaussian-blurred images.
  
- Octave Generation:
  Divide each scale space into octaves, which are sets of progressively downsampled images.
  Octaves help in handling different scales efficiently and improve algorithm performance.
  Each octave consists of a series of blurred and downsampled images.
  
- Keypoint Detection (Extrema):
  Identify local extrema in the DoG pyramid to locate potential key points.
  Refine keypoint locations with subpixel accuracy using a second-order Taylor series expansion.
  
- Keypoint Elimination:
  Eliminate key points with low contrast or poorly localized edges.
  Use a 2x2 Hessian matrix to check the curvature to eliminate poorly localized key points.
  
- Orientation Assignment:
  Assign consistent orientations to key points based on local image gradients.
  Create an orientation histogram from gradient orientations in a region around each key point.

- Descriptor Computation:
  Compute distinctive descriptors for each key point.
  Sample image gradients and orientations around the key point.
  Apply Gaussian weighting and achieve orientation invariance by rotating coordinates.

- Feature Matching:
  Perform matching tests to test the repeatability and stability of SIFT features.
  Compare key points between an original image and a transformed version using computed descriptors.
  Use matching errors to identify likely key point correspondences and set the transformation.

- Results and Conclusion:
  Evaluate and showcase results, including visual representations of key points.
  Conclude the implementation, emphasizing the distinctiveness and invariance of SIFT features.
  
## References:
1. MENG, YU. (2008). Implementing the Scale Invariant Feature Transform(SIFT) Method.
2. Lowe, D.G. "Distinctive Image Features from Scale-Invariant Keypoints." International Journal of Computer Vision (IJCV) 60.2 (2004): 91–110. DOI: 10.1023/B:VISI.0000029664.99615.94
