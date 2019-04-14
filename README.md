# BMEProject
Project for BIOEN 3301 
Zebrafish tracking via video

Reads in .tif file with image frames.
Filters images based on both an intensity threshold and a motion filter applied to each pixel frame-by-frame.

Filtered images are dilated using a square neighborhood 'strel' object, then further filtered using bwareaopen to remove pixel groups of an insufficient area.

Finally, filtered and dilated images are fed into a tracking function that tracks centroids of individual fish frame-by-frame and plots them over original video.

Implementation of user-defined functions is within driver file zfish_driver.m.
