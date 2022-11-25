import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/utils/snack_bar.dart';
import '../atoms/menu_button.dart';
import 'table_content.dart';

class TableStructure extends StatefulWidget {
  final String tableID;
  final String tableName;
  final Function onstartOderClick;
  final Function onviewRunningOrderClick;
  final String tableCapacity;
  final int? elementIndex;
  final int isTableEngaged;
  final String totalBill;

  const TableStructure({
    Key? key,
    required this.tableID,
    required this.tableName,
    required this.isTableEngaged,
    this.elementIndex,
    required this.tableCapacity,
    required this.onstartOderClick,
    required this.totalBill,
    required this.onviewRunningOrderClick,
  }) : super(key: key);

  @override
  _TableStructureState createState() => _TableStructureState();
}

class _TableStructureState extends State<TableStructure> {
  @override
  Widget build(BuildContext context) {
    // print(widget.tableID);
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        // color: Colors.grey.shade200,
      ),
      child: Card(
        // key: ValueKey(widget.elementIndex),
        color: Colors.grey.shade200,
        elevation: 3,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200, width: 2.0),
            borderRadius: BorderRadius.circular(8.sp)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor:
                      widget.isTableEngaged == 1 ? Colors.red : Colors.green,
                ),
              ),
              const TableContent(label: "Table ID:", labelvalue: "0"),
              const TableContent(label: "Capacity:", labelvalue: "4 Person"),
              const TableContent(label: "Total Bill:", labelvalue: "Rs. 0"),
              widget.isTableEngaged == 1
                  ? MenuButton(
                      color: Colors.red,
                      menuTxt: "Running",
                      iconname: Icons.check,
                      showIcon: false,
                      onClick: () {
                        showError(message: "Table is already booked");
                      })
                  : MenuButton(
                      color: Colors.green,
                      menuTxt: "Start Order",
                      iconname: Icons.check,
                      showIcon: false,
                      onClick: () {
                        showError(message: "");
                      })
            ],
          ),
        ),
      ),
    );
  }
}
