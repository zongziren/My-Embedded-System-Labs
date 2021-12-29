#include <opencv2/opencv.hpp>
#include <iostream>
#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;
using namespace cv;

// Functions for facial feature detection
static void help(char** argv);
static Mat detectFaces(Mat&, vector<Rect_<int> >&, string, int&);

string face_cascade_path = "model/haarcascade_frontalface_alt.xml";

int main(int argc, char** argv)
{
    string run_type;
    printf("RUN_TYPE: train OR test OR run\n");
    printf("input your choice >>");
    cin >> run_type;

    Ptr<FaceRecognizer> model = createEigenFaceRecognizer(300);
    string output_path = "model/emded_model_";

    if(run_type == "train"){
        printf("input your train type(test OR run)>>");
        string train_type;
        cin >> train_type;
        
        printf("input train size >>");
        int IMAGE_NUM;
        cin >> IMAGE_NUM;

        string dataset_path = "./dataset/embed_face/";
        if(train_type == "run"){
            dataset_path = "./dataset/bighw_face/";
        }

        printf("begin training\n");

        vector<Mat> images;
        vector<int> labels;

        int i = 0;
        Mat image_in;
        for(i = 0; i < IMAGE_NUM; i++){
            stringstream ss;
            ss << i;
            string image_path = dataset_path + ss.str() + ".jpeg";
            
            cout << ss.str() << endl;

            vector<Rect_<int> > faces_in;
            image_in = imread(image_path, IMREAD_GRAYSCALE);
            int index = 0;
            Mat face_in = detectFaces(image_in, faces_in, face_cascade_path, index);
            if(index == 0){
                printf("no face in %d, pass", i);
                continue;
            }
            
            images.push_back(face_in);
            labels.push_back(i);
        }

        model->train(images, labels);
        model->save(output_path + train_type);
        printf("training finish\n");
    }
    else if(run_type == "test"){
        string test_id_str;
        printf("input your test id >>");
        cin >> test_id_str;
        printf("begin test\n");

        string image_path = "./dataset/embed_face/test/" + test_id_str + ".jpeg";
        vector<Rect_<int> > faces_in;
        
        Mat image_in = imread(image_path, IMREAD_GRAYSCALE);
        int index = 0;
        Mat face_in = detectFaces(image_in, faces_in, face_cascade_path, index);
        if(index == 0){
            cout << "no face in" << test_id_str << ", please try other photos" << endl;
            return 0;
        }

        model->load(output_path + "test");
        int label_predict;double confidence_predict;
        model->predict(face_in, label_predict, confidence_predict);
        cout << "we guess this is " << label_predict << endl;
        cout << "it's score is " << confidence_predict << endl;
    }
    else if(run_type == "run"){
        printf("begin capture, click ENTER to begin\n then click ENTER again to capture your face\n");
        getchar();
        system("/mnt/luvcview -d /dev/video2  -f yuv -s 800x600");
        
        string image_path = "./dataset/camera/cap.pnm";
        vector<Rect_<int> > faces_in;
        
        Mat image_in = imread(image_path, IMREAD_GRAYSCALE);
        int index = 0;
        Mat face_in = detectFaces(image_in, faces_in, face_cascade_path, index);
        while(index == 0){
            cout << "detect no face, please capture again" << endl;
            system("./luvcview -d /dev/video2  -f yuv -s 800x600");
            image_in = imread(image_path, IMREAD_GRAYSCALE);
            face_in = detectFaces(image_in, faces_in, face_cascade_path, index);
        }
        model->load(output_path + "run");
        int label_predict;double confidence_predict;
        model->predict(face_in, label_predict, confidence_predict);
        cout << "we guess this is " << label_predict << endl;
        cout << "it's score is " << confidence_predict << endl;
    }
    else{
        printf("wrong type");
    }
    return 0;
}

static Mat detectFaces(Mat& img, vector<Rect_<int> >& faces, string cascade_path, int& index)
{
    CascadeClassifier face_cascade;
    face_cascade.load(cascade_path);

    if (!face_cascade.empty())
        face_cascade.detectMultiScale(img, faces, 1.15, 3, 0|CASCADE_SCALE_IMAGE, Size(30, 30));

    if(faces.size() != 0){
        Rect face = faces[0];
        Mat cropped_image = img(Range(face.y, face.y+face.height), Range(face.x, face.x+face.width));
        Mat ret_image;
        resize(cropped_image, ret_image, Size(250, 250), 0, 0);
        index = 1;
        return ret_image;
    }
    else{
        cout << "detect no face!" << endl;
        index = 0;
    }
}