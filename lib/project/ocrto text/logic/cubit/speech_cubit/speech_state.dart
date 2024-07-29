
abstract class SpeechState{

}

class SpeechInitState extends SpeechState {

}
class SpeechLoadingState extends SpeechState {
  
}
class SpeechResponseState extends SpeechState {
  final lastWords;
  SpeechResponseState(this.lastWords);
}
class SpeechErrorState extends SpeechState {
  final String error;
  SpeechErrorState(this.error);
}