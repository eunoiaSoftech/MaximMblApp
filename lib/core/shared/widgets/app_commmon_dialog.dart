import 'package:flutter/material.dart';

class CommonAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onOkPressed;
  final VoidCallback? onCancelPressed;

  const CommonAlertDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.onOkPressed,
    this.onCancelPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: Colors.black), // Title text color
      ),
      content: Text(
        message,
        style: const TextStyle(color: Colors.black), // Message text color
      ),
      actions: <Widget>[
        if (onCancelPressed != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // Cancel button background color
            ),
            onPressed: onCancelPressed ?? () => Navigator.of(context).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black), // Cancel button text color
            ),
          ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // OK button background color
          ),
          onPressed: onOkPressed,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white), // OK button text color
          ),
        ),
      ],
    );
  }
}
