import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextFormError extends StatelessWidget {
  final String errorMessage;
  const TextFormError({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          errorMessage,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
