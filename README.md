# Number-Plate-Detection
This project is an implementation of the technical paper "RECOGNITION OF VEHICLE NUMBER PLATE USING MATLAB" by " Ragini Bhat 1, Bijender Mehandia2". 

STEPS FOLLOWED:

1) Capturing the car image and converting it to a binary image.
2) Using SobelEdge detetction and Morphological operations to isolate the number plate.
3) Dilating the image and filling up the holes.
4) Using segmentation and bounding box techniqe to extract each digit/alphabet from the number plate.
5) Comparing the extracted alphabets to the character templates from the database.
