import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final Function onYes;
  final String title;
  final String content;
  const AppAlertDialog(
      {Key? key,
      required this.onYes,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        // The "Yes" button
        TextButton(
            onPressed: () {
              onYes();
            },
            child: const Text('Allow')),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Deny'))
      ],
    );
  }
}
