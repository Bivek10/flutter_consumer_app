import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Color.fromARGB(255, 188, 71, 255),
      strokeWidth: 5.0,
      valueColor: AlwaysStoppedAnimation(Colors.white),
    );
  }
}
