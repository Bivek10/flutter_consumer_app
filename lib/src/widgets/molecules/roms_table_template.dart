import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/utils/snack_bar.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Table Name",
                  style: TextStyle(fontSize: 13.sp),
                ),
                // Icon(Icons.accessible_forward),
                Text(
                  widget.tableName,
                  style: TextStyle(fontSize: 13.sp),
                ),
                CircleAvatar(
                  radius: 4,
                  backgroundColor:
                      widget.isTableEngaged == 1 ? Colors.red : Colors.green,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Table Capacity",
                  style: TextStyle(fontSize: 12.sp),
                ),
                // Icon(Icons.person),
                Text(
                  widget.tableCapacity,
                  style: TextStyle(fontSize: 12.sp),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Bill Amount:",
                  style: TextStyle(fontSize: 13.sp),
                ),
                Text(
                  "Rs. " + widget.totalBill.toString(),
                  style: TextStyle(fontSize: 13.sp),
                )
              ],
            ),
            widget.isTableEngaged == 1
                ? InkWell(
                    onTap: () {
                      showError(message: "Table is already booked");
                    },
                    child: Container(
                      height: 40.sp,
                      width: width,
                      margin: EdgeInsets.only(bottom: 3.2.sp),
                      decoration: BoxDecoration(
                        gradient: AppColors.busygradient,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80.sp),
                            topRight: Radius.circular(80.sp),
                            bottomLeft: Radius.circular(8.sp),
                            bottomRight: Radius.circular(8.sp)),
                      ),
                      child: Center(
                          child: Text(
                        "Running Order",
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      )),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      widget.onstartOderClick();
                    },
                    child: Container(
                      height: 40.sp,
                      width: width,
                      margin: EdgeInsets.only(bottom: 3.2.sp),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            stops: [
                              0,
                              1
                            ],
                            colors: [
                              Color.fromARGB(255, 226, 83, 245),
                              Color.fromRGBO(88, 207, 251, 1)
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80.sp),
                            topRight: Radius.circular(80.sp),
                            bottomLeft: Radius.circular(8.sp),
                            bottomRight: Radius.circular(8.sp)),
                      ),
                      child: Center(
                          child: Text(
                        "Start Order",
                        style: TextStyle(color: Colors.black, fontSize: 13.sp),
                      )),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
