
abstract class TranslateState{

}

class TranslateInitState extends TranslateState {

}
class TranslateLoadingState extends TranslateState {
  
}
class TranslateResponseState extends TranslateState {
  String text;
  TranslateResponseState(this.text);
}
class TranslateErrorState extends TranslateState {
  final String error;
  TranslateErrorState(this.error);
}