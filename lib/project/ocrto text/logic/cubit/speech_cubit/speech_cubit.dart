import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/speech_cubit/speech_state.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechCubit extends Cubit<SpeechState> {
  SpeechCubit():super(SpeechInitState()){
    // getAreaList();
  }

  final SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false;
  String _lastWords = 'Listening...';


  void getSpeech() async {
    _lastWords = 'Listening...';
    speechEnabled = await _speechToText.initialize();
    print("aaaaaaaaaaaaaaa");
    if (speechEnabled) {
      print("bbbbbbbbbbbbbbbbbb");
      emit(SpeechResponseState(_lastWords));
      await _speechToText.listen(onResult: ((result) {
        _lastWords = result.recognizedWords;
        emit(SpeechResponseState(_lastWords));
      })
      );
      // .whenComplete(() => stopListening());
    }
  }

  void stopListening() async {
    await _speechToText.stop();
  }

}