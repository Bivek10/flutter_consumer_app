import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widgets/molecules/header.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({Key? key}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Track Order",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
      ),
    );
  }
}
