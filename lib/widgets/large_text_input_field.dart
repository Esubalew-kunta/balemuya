import 'package:flutter/material.dart';

class LargeTextInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final int maxLines; 

  // Constructor
  const LargeTextInputField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.maxLines = 4, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines, 
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 222, 228, 233), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 198, 206, 212), width: 2),
        ),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
