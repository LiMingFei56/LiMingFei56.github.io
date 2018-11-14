#include <iostream>
#include <string>
#include <sstream>
using namespace std;

#include "opencv2/core.hpp"
#include "opencv2/highgui.hpp"
using namespace cv;

Mat img;
bool applyGray = false;
bool applyBlur = false;
bool applySobel = false;
int blurAmount = 15;
static void onChange(int pos, void* userInput);
static void onMouse(int event, int x, int y, int, void* userInput);


int main( int argc, const char** argv )
{
    Mat lena = imread("../lena.jpg");

    namedWindow("Lena");

    createTrackbar("Lena", "Lena", &blurAmount, 30, onChange, &lena);

    setMouseCallback("Lena", onMouse, &lena);

    onChange(blurAmount, &lena);

    waitKey(0);

    destroyWindow("Lena");

    return 0;
}

static void onChange(int pos, void* userInput)
{
    if (pos <= 0 )
        return;
    Mat imgBlur;
    Mat* img = (Mat *)userInput;
    blur(*img, imgBlur, Size(pos, pos));
    imshow("Lena", imgBlur);
}
