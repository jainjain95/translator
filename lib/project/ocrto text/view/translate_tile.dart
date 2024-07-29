import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocrtotext/project/ocrto%20text/constant/app_data.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_cubit.dart';
import 'package:ocrtotext/project/ocrto%20text/logic/cubit/translate_cubit/translate_state.dart';

class TranslateTile extends StatefulWidget {
  String text;
  TranslateTile({super.key, required this.text});

  @override
  State<TranslateTile> createState() => _TranslateTileState();
}

class _TranslateTileState extends State<TranslateTile> {
  Map<String, dynamic>? _selectedItem = null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TranslateCubit(),
      child: Column(
        children: [
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
                            BlocProvider.of<TranslateCubit>(context).translate(
                                widget.text.toString(),
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
          Container(
              // height: 500,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(
                  //     color: Colors.black26, width: 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  )),
              child: BlocBuilder<TranslateCubit, TranslateState>(
                builder: (context, state) {
                  if (state is TranslateLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TranslateResponseState) {
                    return Text(state.text);
                  }
                  if (state is TranslateErrorState) {
                    return Center(child: Text(state.error));
                  }
                  return const SizedBox();
                },
              ))
        ],
      ),
    );
  }
}
