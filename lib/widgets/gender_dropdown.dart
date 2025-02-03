import 'package:flutter/material.dart';

class CustomGenderDropdown extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  const CustomGenderDropdown({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(245, 245, 245, 1.0),
        labelText: labelText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 222, 228, 233), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 198, 206, 212), width: 2),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items,
    );
  }
}
