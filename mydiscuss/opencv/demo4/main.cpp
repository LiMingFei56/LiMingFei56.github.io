#include "opencv2/core/utility.hpp"
#include "opencv2/imgproc.hpp"
#include "opencv2/highgui.hpp"
using namespace std;
using namespace cv;

const char* keys =
{
    "{help h usage ? | | print this message}"
    "{@image | | Image to process}"
};

void showHistoCallback(int state, void* userData);
void equalizeCallback(int state, void* userData);
void lomoCallback(int state, void* userData);

Mat img;

int main(int argc, const char** argv)
{
    CommandLineParser parser(argc, argv, keys);
    parser.about("Chapter 4. PhotoTool v1.0.0");
    if(parser.has("help"))
    {
        parser.printMessage();
        return 0;
    }

    String imgFile = parser.get<String>(0);

    if(!parser.check())
    {
        parser.printErrors();
        return 0;
    }

    img = imread(imgFile);
    namedWindow("Input");

//    showHistoCallback(0, NULL);
//    equalizeCallback(0, NULL);
    lomoCallback(0, NULL);
//    createButton("Show histogram", showHistoCallback, NULL, QT_PUSH_BUTTON, 0);
//    createButton("Equalize histogram", equalizeCallback, NULL, QT_PUSH_BUTTON, 0);
//    createButton("Lomogragphy effect", lomoCallback, NULL, QT_PUSH_BUTTON, 0);
//    createButton("Cartonize effect", cartoonCallback, NULL, QT_PUSH_BUTTON, 0);

    imshow("Input", img);
    waitKey(0);
    return 0;
}

void showHistoCallback(int state, void* userData)
{
    vector<Mat> bgr;
    split(img, bgr);
    int numbins = 256;
    float range[] = {0, 256};
    const float* histRange = {range};

    Mat b_hist, g_hist, r_hist;

    calcHist(&bgr[0], 1, 0, Mat(), b_hist, 1, &numbins, &histRange);
    calcHist(&bgr[1], 1, 0, Mat(), g_hist, 1, &numbins, &histRange);
    calcHist(&bgr[2], 1, 0, Mat(), r_hist, 1, &numbins, &histRange);

    int width = 512;
    int height = 300;

    Mat histImage(height, width, CV_8UC3, Scalar(20, 20, 20));

    normalize(b_hist, b_hist, 0 , height, NORM_MINMAX);
    normalize(g_hist, g_hist, 0 , height, NORM_MINMAX);
    normalize(r_hist, r_hist, 0 , height, NORM_MINMAX);

    int binStep = cvRound((float)width / (float)numbins);

    for(int i = 1; i < numbins; i++)
    {
        line(histImage, 
            Point( binStep * (i-1), height-cvRound( b_hist.at<float>(i-1))),
                Point( binStep * (i), height-cvRound( b_hist.at<float>(i))),
                    Scalar(255,0,0));
        line(histImage, 
            Point( binStep * (i-1), height-cvRound( g_hist.at<float>(i-1))),
                Point( binStep * (i), height-cvRound( g_hist.at<float>(i))),
                    Scalar(255,0,0));
        line(histImage, 
            Point( binStep * (i-1), height-cvRound( r_hist.at<float>(i-1))),
                Point( binStep * (i), height-cvRound( r_hist.at<float>(i))),
                    Scalar(255,0,0));
    }
    imshow("Histogram", histImage);
}

void equalizeCallback(int state, void* userData)
{
    Mat result;
    Mat ycrcb;
    cvtColor(img, ycrcb, COLOR_BGR2YCrCb);
    vector<Mat> channels;
    split(ycrcb, channels);

    equalizeHist(channels[0], channels[0]);

    merge(channels, ycrcb);

    cvtColor(ycrcb, result, COLOR_YCrCb2BGR);

    imshow("Equalized", result);
}

void lomoCallback(int state, void* userData)
{
    Mat result;
    const double exponential_e = std::exp(1.0);
    Mat lut(1, 256, CV_8UC1);
    for( int i=0; i<256; i++)
    {
        float x = (float) i / 256.0;
        lut.at<uchar>(i) = cvRound( 256 * (1/(1 + pow(exponential_e, -((x-0.5)/0.1)))));
    }

    vector<Mat> bgr;
    split(img, bgr);
    LUT(bgr[2], lut, bgr[2]);
    merge(bgr, result);

    Mat halo(img.rows, img.cols, CV_32FC3, Scalar(0.3, 0.3, 0.3));
    circle(halo, Point(img.cols/2, img.rows/2), img.cols/3, Scalar(1,1,1), -1);
    blur(halo, halo, Size(img.cols/3, img.cols/3));

    Mat resultf;
    result.convertTo(resultf, CV_32FC3);
    multiply(resultf, halo, resultf);
    resultf.convertTo(result, CV_8UC3);
    imshow("Lomograpy", result);
}
