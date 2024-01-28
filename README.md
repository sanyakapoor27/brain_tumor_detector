# Brain Tumor Detector App

This is an app created using flutter to detect brain tumors in MRI scans. A yolov5 model is trained and converted to tflite using ONNX format which is integrated with the flutter app. 

In this project, the ImagePicker plugin is used to create two fuctions for importing images from gallery or clicking them promptly. These functions are integrated with the "Gallery" and "Camera" button. On choosing an image, the yolov5 model is loaded and used to predict the likeliness of the tumor by showing the confidence percentage and display the detected outcome. A total of 8 classes are present in the dataset from 0-7 with class 6 indicating the detected tumor. The tflite library is used to run the model on the image with a defined threshold metric of 0.5 to help with predictions. As the prediction is made, the loading is turned false and the result displayed. The predictions are stored in a dynamic list and the most recent is showcased with our selected image.

## App Demo

<img src="https://github.com/sanyakapoor27/brain_tumor_detector/assets/138278818/da31eaf2-5ccd-4048-af32-4c719653c77d.png" width="400" height="700">
