import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocrtotext/project/ocrto%20text/constant/app_color.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/camera_cubit/camera_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/speech_cubit/speech_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/text_cubit/text_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/view/image_translate.dart';
import 'package:ocrtotext/project/ocrto%20text/view/speech_translate.dart';
import 'package:ocrtotext/project/ocrto%20text/view/text_translate.dart';
import 'package:ocrtotext/project/ocrto%20text/view/widget/custom_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool speechEnabled = false;
  int btn = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/bg.jpg"), fit: BoxFit.fill)
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                      height: 60,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: const Center(
                        child: Text("Translator",style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),)
                      )
                    ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomButton(
                                    icon: const Icon(Icons.camera, size: 30,
                                    color: blueColor
                                    ),
                                    name: 'Camera',
                                    onTap: () {
                                          setState(() {
                                            btn = 1;
                                            BlocProvider.of<CameraCubit>(context)
                                          .getImage(ImageSource.camera);
                                          BlocProvider.of<TranslateCubit>(context).reset();
                                          });
                                    }),
                                CustomButton(
                                    icon: const Icon(Icons.image, color: yellowColor, size: 30,),
                                    name: 'Gallery',
                                    onTap: () {
                                      btn = 1;
                                      BlocProvider.of<CameraCubit>(context)
                                          .getImage(ImageSource.gallery);
                                          BlocProvider.of<TranslateCubit>(context).reset();
                                    }),
                                CustomButton(
                                    icon: const Icon(Icons.mic, color: redColor, size: 30,),
                                    name: 'Mic',
                                    onTap: () {
                                      setState(() {
                                        btn = 2;
                                        BlocProvider.of<SpeechCubit>(context)
                                          .getSpeech();
                                          BlocProvider.of<TranslateCubit>(context).reset();
                                      });
                                      // initSpeech();
                                    }),
                                CustomButton(
                                    icon: const Icon(Icons.edit, color: greenColor, size: 30,), 
                                    name: 'Text', onTap: () {
                                      setState(() {
                                        btn = 3;
                                        BlocProvider.of<TextCubit>(context).getText();
                                        BlocProvider.of<TranslateCubit>(context).reset();
                                      });
                                    })
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          btn == 1 ? const ImageTranslate() : btn == 2 ? 
                          const SpeechTranslate() : btn == 3 ? const TextTranslate() : const SizedBox()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
