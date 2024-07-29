
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/text_cubit/text_state.dart';

class TextCubit extends Cubit<TextState> {
  TextCubit():super((TextInitState())){
    // getAreaList();
  }

  void getText() async {
    emit(TextResponseState());
  }
}