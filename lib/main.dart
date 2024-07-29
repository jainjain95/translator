import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/camera_cubit/camera_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/speech_cubit/speech_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/text_cubit/text_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/view/home%20screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CameraCubit>(create: (context) => CameraCubit()),
        BlocProvider<TranslateCubit>(create: (context) => TranslateCubit()),
        BlocProvider<TextCubit>(create: (context) => TextCubit()),
        BlocProvider<SpeechCubit>(create: (context) => SpeechCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

