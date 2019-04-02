# Adaptive-Binarize

Adaptive binarize using Bradley's algorithm from Bradley, D., G. Roth, "Adapting Thresholding Using the Integral Image", Journal of Graphics Tools. Vol. 12, No. 2, 2007, pp.13-21.

Use `adaptive_threshold(image,s,t)`.

Image must be a 2 dimensional array.

s and t are optional parameters.

s is window size which defaults to 1/8 of image width, calculated by `(2*floor(width/16 + 1))`. Can be reduced in order to capture smaller details in the image. It must be an even positive non-zero integer, which is less than the length and width of the image.

t is comparison % which defaults to 15. Can be increased to become less sensitive to contrast differences. It must be an integer between 0 and 100. 
