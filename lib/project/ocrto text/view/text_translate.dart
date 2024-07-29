import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocrtotext/project/ocrto%20text/constant/app_data.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/view/widget/translated_box.dart';

class TextTranslate extends StatefulWidget {
  const TextTranslate({super.key});

  @override
  State<TextTranslate> createState() => _TextTranslateState();
}

class _TextTranslateState extends State<TextTranslate> {
  Map<String, dynamic>? _selectedItem = null;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // height: 500,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: Colors.black26, width: 1),
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
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              hintText: 'Enter text here',
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // TranslateTile(text: textController.text.trim())
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Translate to -"),
            const SizedBox(width: 10),
            SizedBox(
              width: 200,
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(width: 1.0, color: Colors.blue),
                  ),
                  
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Map<String, dynamic>>(
                      value: _selectedItem,
                      hint: const Text('Select Language'),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      items: lngList.map((Map<String, dynamic> item) {
                        return DropdownMenuItem<Map<String, dynamic>>(
                          value: item,
                          child: Row(
                            children: [
                              Text(item['lng']),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedItem = newValue;
                          // translate(_selectedItem!['value']
                          //     .toString());
                          BlocProvider.of<TranslateCubit>(context).translate(
                              textController.text.trim(),
                              newValue!['value'].toString());
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const TranslatedFeild()
        
      ],
    );
  }
}
