import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      backgroundColor: Color.fromARGB(255, 188, 71, 255),
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation(Colors.white),
    );
  }
}
