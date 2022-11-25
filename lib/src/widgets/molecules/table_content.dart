import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TableContent extends StatelessWidget {
  final String label;
  final String labelvalue;

  const TableContent({Key? key, required this.label, required this.labelvalue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13.sp),
        ),
        Text(
          labelvalue,
          style: TextStyle(fontSize: 13.sp),
        ),
      ],
    );
  }
}
