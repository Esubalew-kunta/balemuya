import 'package:flutter/material.dart';

class ReportDialog extends StatefulWidget {
  final VoidCallback onReport;

  ReportDialog({required this.onReport});

  @override
  _ReportDialogState createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Report User"),
      content: TextField(
        controller: _reportController,
        maxLines: 5, // Large text input field
        decoration: InputDecoration(
          hintText: "Enter your report details here...",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the popup
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onReport(); // Handle report action
            Navigator.of(context).pop(); // Close the popup after reporting
          },
          child: Text("Report"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Red for report action
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }
}
