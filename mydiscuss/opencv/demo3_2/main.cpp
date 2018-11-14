#include <iostream>
#include <string>
#include <sstream>
using namespace std;

#include "opencv2/core.hpp"
#include "opencv2/highgui.hpp"
using namespace cv;

int main( int argc, const char** argv )
{
    // 读取图像
    Mat lena = imread("../lena.jpg");

    namedWindow("Lena", CV_GUI_NORMAL);

    moveWindow("Lena", 10, 10);

    imshow("Lena", lena);

    resizeWindow("Lena", 512, 512);

    waitKey(0);

    destroyWindow("Lena");

    return 0;
}
