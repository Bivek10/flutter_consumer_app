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

class ErrorContainer extends StatelessWidget {
  final String error;
  const ErrorContainer({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: error.isNotEmpty ? 35 : 30,
      child: error.isNotEmpty
          ? TextFormError(
              errorMessage: error,
            )
          : Container(),
    );
  }
}
