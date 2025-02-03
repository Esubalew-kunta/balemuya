
import 'package:blaemuya/utils/colors.dart';
import 'package:flutter/material.dart';

class SliderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;
  const SliderButton({
    super.key,
    required this.onTap,
    required this.text,
     required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          width: 115,
          height: 40,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 184, 188, 204) : const Color.fromARGB(0, 255, 255, 255),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255),
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isSelected ? Colors.white : const Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}