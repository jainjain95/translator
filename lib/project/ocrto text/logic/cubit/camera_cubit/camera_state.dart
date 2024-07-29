
import 'dart:io';

abstract class CameraState{

}

class CameraInitState extends CameraState {

}
class CameraLoadingState extends CameraState {
  
}
class CameraResponseState extends CameraState {
  final File image;
  String ocrText;
  CameraResponseState(this.image, this.ocrText);
}
class CameraErrorState extends CameraState {
  final String error;
  CameraErrorState(this.error);
}