import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_state.dart';

class TranslatedFeild extends StatefulWidget {
  const TranslatedFeild({super.key});

  @override
  State<TranslatedFeild> createState() => _TranslatedFeildState();
}

class _TranslatedFeildState extends State<TranslatedFeild> {
  double isize = 35;
  double asize = 120;
  bool speackStatus = false;
  FlutterTts flutterTts = FlutterTts();
  String str = '';

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
    flutterTts.setCompletionHandler(() {
      setState(() {
        speackStatus = !speackStatus;
      });
    });
  }

  Future _speak() async {
    var result = await flutterTts.speak(str);
    // if (result == 1) setState(() => speackStatus = !speackStatus);
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    // if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Text copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
                // height: 500,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26, width: 1),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: const Offset(0, 5), // Offset in x and y direction
                ),
              ],
                ),
                child: BlocConsumer<TranslateCubit, TranslateState>(
                  listener: (context, state) {
                    if (state is TranslateResponseState) {
                      str = state.text;
                    }
                  },
                  builder: (context, state) {
                    if (state is TranslateLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is TranslateResponseState) {
                      return SelectableText(state.text);
                    }
                    if (state is TranslateErrorState) {
                      return Center(child: Text(state.error));
                    }
                    return const SizedBox();
                  },
                )),
            const SizedBox(height: 15),
          ],
        ),
        BlocBuilder<TranslateCubit, TranslateState>(
          builder: (context, state) {
            if( state is TranslateResponseState){
          return Positioned(
            right: 20,
            bottom: 0,
            child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.green,
                    boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3), // Shadow color
                  spreadRadius: 2, // Spread radius
                  blurRadius: 6, // Blur radius
                  offset: const Offset(0, 5), // Offset in x and y direction
                ),
              ],
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          copyText(str);
                        },
                        child: const Icon(
                          Icons.copy_all,
                          color: Colors.white,
                        )),
                    InkWell(
                        onTap: () {
                          setState(() {
                            speackStatus ? _stop() : _speak();
                            speackStatus = !speackStatus;
                          });
                        },
                        child: Icon(
                          speackStatus ? Icons.stop : Icons.mic,
                          color: Colors.white,
                        )),
                  ],
                )),
          );
            }
          return const SizedBox();
        })
      ],
    );
  }
}
