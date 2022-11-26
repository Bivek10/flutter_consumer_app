import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Function onYes;
  const ConfirmDialog({Key? key, required this.onYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Please Confirm'),
      content: const Text('Are you sure to delete ?'),
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
