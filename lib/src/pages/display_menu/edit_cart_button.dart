import 'package:flutter/material.dart';

class EditCartButton extends StatelessWidget {
  final String quantity;
  final String productId;
  final Function onIncrement;
  final Function onDecrement;

  EditCartButton({
    required this.quantity,
    required this.productId,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: 120,
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  onDecrement();
                },
                child: const SizedBox(
                  height: 32,

                  //  width: size.width * 0.1,
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Icon(
                        Icons.remove,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue.shade200,
                child: Center(
                    child: Text(
                  quantity.toString(),
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
                    // SizedBox(
                    //     height: 15,
                    //     width: 15,
                    //     child: CircularProgressIndicator(
                    //       strokeWidth: 2,
                    //       backgroundColor: Colors.white,
                    //       valueColor: AlwaysStoppedAnimation(
                    //         AppColors.appmaincolor,
                    //       ),
                    //     ),
                    //   ),
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  onIncrement();
                },
                child: const SizedBox(
                  height: 32,
                  //  width: size.width * 0.1,
                  child: Material(
                    color: Colors.transparent,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
