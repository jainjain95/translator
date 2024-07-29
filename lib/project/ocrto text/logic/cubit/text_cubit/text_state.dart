

abstract class TextState{

}

class TextInitState extends TextState {

}
class TextLoadingState extends TextState {
  
}
class TextResponseState extends TextState {

  TextResponseState();
}
class TextErrorState extends TextState {
  final String error;
  TextErrorState(this.error);
}