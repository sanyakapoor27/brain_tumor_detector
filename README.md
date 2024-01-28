# Brain Tumor Detector App

This is an app created using flutter to detect brain tumors in MRI scans. A yolov5 model is trained and converted to tflite using ONNX format which is integrated with the flutter app.

## Getting Started
![1706341073514](https://github.com/sanyakapoor27/brain_tumor_detector/assets/138278818/da31eaf2-5ccd-4048-af32-4c719653c77d){: width="200" height="200"}

In this project, the ImagePicker plugin is used to create two fuctions for importing images from gallery or clicking them promptly. These functions are integrated with the "Gallery" and "Camera" button. On choosing an image, the yolov5 model is loaded and used to predict the likeliness of the tumor by showing the confidence percentage and display the detected outcome.
