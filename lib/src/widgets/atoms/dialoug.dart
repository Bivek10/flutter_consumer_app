import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Function onYes;
  final String content;
  const ConfirmDialog({Key? key, required this.onYes, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: Text(content),
      actions: [
        // The "Yes" button
        TextButton(
            onPressed: () {
              onYes();
            },
            child: const Text('Yes')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'))
      ],
    );
  }
}
