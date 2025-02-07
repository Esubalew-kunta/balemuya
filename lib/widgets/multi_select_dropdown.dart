import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final List<String> items;
  final int maxSelection;
  final Function(List<String>) onSelectionChanged;
  final List<String> initialValue;

  const MultiSelectDropdown({
    Key? key,
    required this.labelText,
    required this.prefixIcon,
    required this.items,
    this.maxSelection = 3,
    required this.initialValue,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedOptions = [];
  String? _validationMessage;

  void _onItemSelected(String value) {
    setState(() {
      if (_selectedOptions.contains(value)) {
        _selectedOptions.remove(value); // Deselect if already selected
      } else {
        if (_selectedOptions.length < widget.maxSelection) {
          _selectedOptions.add(value);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "You can select up to ${widget.maxSelection} options only")),
          );
        }
      }

      // Call the callback function to send selected values to the parent
      widget.onSelectionChanged(_selectedOptions);

      // Validation check
      _validationMessage =
          _selectedOptions.isEmpty ? "Please select at least one option" : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => _showDropdownDialog(context),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.labelText,
              prefixIcon: Icon(widget.prefixIcon),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorText: _validationMessage, // Show validation error
            ),
            child: _selectedOptions.isEmpty
                ? Text("Tap to select", style: TextStyle(color: Colors.grey))
                : Wrap(
                    spacing: 6.0,
                    children: _selectedOptions
                        .map((option) => Chip(
                              label: Text(option),
                              deleteIcon: Icon(Icons.close, size: 18),
                              onDeleted: () => _onItemSelected(option),
                            ))
                        .toList(),
                  ),
          ),
        ),
      ],
    );
  }

  void _showDropdownDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Options"),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              children: widget.items.map((option) {
                bool isSelected = _selectedOptions.contains(option);
                return FilterChip(
                  label: Text(option),
                  selected: isSelected,
                  selectedColor: Colors.blue.withOpacity(0.3),
                  onSelected: (_) => _onItemSelected(option),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
