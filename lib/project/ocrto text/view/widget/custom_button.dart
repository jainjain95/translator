import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String name;
  Icon icon;
  Function() onTap;
  CustomButton(
      {super.key, required this.name, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
              Radius.circular(30),
            )),
            child: Center(child: icon),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
