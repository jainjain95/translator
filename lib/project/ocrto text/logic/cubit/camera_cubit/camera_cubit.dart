import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/camera_cubit/camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit():super(CameraInitState()){
    // getAreaList();
  }
  final ImagePicker picker = ImagePicker();
  File? _image;
  String ocrText="";

  void geteImage() async {
    try{
      // emit(AreaListLoadingState());
      // AreaListModel res = await RestroRepository.getAreaList();
      // if(res.statusCode == 200){
      //   emit(AreaListResponseState(res));
      // } else {
      //   emit(AreaListErrorState("Error"));
      // }
    } catch (e){
      // emit(AreaListErrorState(e.toString())); 
    }
  }

  void getImage(ImageSource source) async {
    emit(CameraLoadingState());
    XFile? pickedImage = await picker.pickImage(source: source);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    // setState(() {
      if (pickedImage != null) {
        // print("not null");
        _image = File(pickedImage.path);
        final InputImage inputImage = InputImage.fromFile(_image!);
        final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
        ocrText = recognizedText.text;
        emit(CameraResponseState(_image!, ocrText));
      } 
      else {
        // print("null");
        emit(CameraErrorState("Error Occure"));
      }
    // });
  }

  // Future<String?> getText(File? file) async {
    
  //   final InputImage inputImage = InputImage.fromFile(file!);
  //   final RecognizedText recognizedText =
  //       await textRecognizer.processImage(inputImage);
  //   String text = recognizedText.text;
  //   print(text);
  //   // setState(() {
  //   ocrText = text;
  //   // });
  //   textRecognizer.close();
  //   return text;
  // }

}