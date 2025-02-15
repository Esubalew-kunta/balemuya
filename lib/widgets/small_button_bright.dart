import 'package:blaemuya/utils/colors.dart';
import 'package:flutter/material.dart';

class SmallButtonBright extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
    final bool isSelected;

  const SmallButtonBright({
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
          width: 125,
          height: 35,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 184, 188, 204) :primaryColor,
          border: Border.all(
            color:primaryColor,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromRGBO(255, 255, 255, 1),
              fontWeight: FontWeight.w200, 
            ),
          ),
        ),
      ),
    );
  }
}
