import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_state.dart';
import 'package:translator/translator.dart';

class TranslateCubit extends Cubit<TranslateState> {
  TranslateCubit():super(TranslateInitState()){
    // getAreaList();
  }
  final translator = GoogleTranslator();


  void translate(String text, String lng) async {
    emit(TranslateLoadingState());
    try {
    var translation =
        await translator.translate(text, from: 'en', to: lng);
    String translated = translation.text;
      emit(TranslateResponseState(translated));
    } catch (e){
      emit(TranslateErrorState(e.toString()));
    }
  }

  void reset(){
    emit(TranslateInitState());
  }

}