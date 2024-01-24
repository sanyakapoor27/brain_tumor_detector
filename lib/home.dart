import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late File _image;
  final imagepicker = ImagePicker();
  List _predictions = [];

  @override
  void initState() {
    super.initState();
    loadmodel();
  }

loadmodel()async{
  await Tflite.loadModel(model: 'assets/yolov5.tflite', labels: 'assets/labels.txt');
}

detect_image(File image)async{
  var prediction = await Tflite.runModelOnImage(
    path: image.path, 
    numResults: 8,
    threshold: 0.5, 
    imageMean: 127.5, 
    imageStd: 127.5);

  setState(() {
    _loading = false;
    _predictions = prediction ?? [];
    });
}
@override
void dispose(){
  super.dispose();
}


_loadimage_gallery()async{
  var image = await imagepicker.pickImage(source: ImageSource.gallery);
  if (image==null){
    return null;}
  else{
    _image = File(image.path);
  }
  detect_image(_image);
}

_loadimage_camera()async{
  var image = await imagepicker.pickImage(source: ImageSource.camera);
  if (image==null){
    return null;}
  else{
    _image = File(image.path);
  }
  detect_image(_image);
}



  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height; // height of screen
    var w = MediaQuery.of(context).size.width;  // width of screen
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, 
        title: Text('Tumor Detector', style: GoogleFonts.roboto(),),
        ),
        body: Container(
          height: h,
          width: w,
          color: Colors.amberAccent,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 180, width: 180,padding: const EdgeInsets.all(10),
              child: Image.asset('assets/brain.png'),
              ),
              Container(child:Text('Tumor Detector', 
              style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold),)
              ),
              const SizedBox(height: 10),
              Container(
                width:double.infinity,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){
                  _loadimage_gallery();
                },
                style: ElevatedButton.styleFrom(
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.pink, 
                  textStyle: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)), 
                child: const Text('Camera'),)
                ,),
              Container(
                width:double.infinity,
                height: 70,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.pink, 
                  textStyle: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.bold)), 
                child: const Text('Gallery'),)
                ,),
                _loading == false?Container(
                  child: Column(
                    children: [
                      SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.file(_image),),
                                Text('Confidence${_predictions[0]['confidence']}')
                    ],
                  ),
                )
                                     :Container()
            ]),
        ),
    );
  }
}