import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/config/themes/colors.dart';

class CategoryButton extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isSelected;
  const CategoryButton({Key? key, required this.data, required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.redAccent : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            data["categoryname"],
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
