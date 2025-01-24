import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  // final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    Key? key,
    // required this.controller,
    required this.labelText,
    this.validator,
  }) : super(key: key);

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: widget.controller,
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor:  Color.fromRGBO(245, 245, 245, 1.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.labelText,
        prefixIcon: const Icon(Icons.lock),
        enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color.fromARGB(255, 222, 228, 233), width: 2), // Change color here
    ),
     focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: const Color.fromARGB(255, 198, 206, 212), width: 2), // Change color when focused
    ),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: widget.validator,
    );
  }
}