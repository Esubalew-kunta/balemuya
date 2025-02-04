import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  

  // Constructor
  const CustomTextFormField({
    Key? key,
    required this.controller,
    required this.keyboardType,
    required this.labelText,
    required this.prefixIcon,
    this.validator,
    this.obscureText = false,
     this.onChanged,
  
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
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
      borderSide: BorderSide(color: const Color.fromARGB(255, 222, 228, 233), width: 2), // Change color here
    ),
     focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color.fromARGB(255, 198, 206, 212), width: 2), // Change color when focused
    ),
    
    

        
      ),
      validator: validator,
      onChanged: onChanged, 
    );
  }
}



