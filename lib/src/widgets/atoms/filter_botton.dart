import 'package:flutter/material.dart';

import '../../config/themes/colors.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({Key? key, required this.onPressed}) : super(key: key);

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.greyDark, width: 1),
        ),
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 8,
          top: 8,
        ),
        child: const Center(
          child: Icon(
            Icons.sort,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
