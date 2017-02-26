#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/calib3d/calib3d.hpp"
#include "opencv2/opencv.hpp"
#include <iostream>
#include <vector>
#include "opencv2/features2d/features2d.hpp"
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
using namespace std;
using namespace cv;

int main()
{
	//Step1: read the 2 images as input
	Mat I1 = imread("D:\\Google Drive\\NCSU Courses\\Spring 2017\\Digital Image Processing and Introduction to Computer Vision\\project\\Intro-to-CV-Project1\\box.JPG");
	// Check for invalid input
	if (!I1.data)
	{
		cout << "Could not open or find the image" << endl;
		return -1;
	}
	// Create a window for display.
	namedWindow("Image 1", WINDOW_AUTOSIZE);
	// Show our image inside it.
	imshow("Image 1", I1);
	waitKey(0);
	return 0;
}
