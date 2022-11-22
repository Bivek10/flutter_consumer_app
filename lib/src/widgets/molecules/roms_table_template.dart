import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

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
    double height = MediaQuery.of(context).size.height;
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
            borderRadius: BorderRadius.circular(height * 0.01)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Table Name",
                  style: TextStyle(fontSize: height * 0.017),
                ),
                // Icon(Icons.accessible_forward),
                Text(
                  widget.tableName,
                  style: TextStyle(fontSize: height * 0.017),
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
                  style: TextStyle(fontSize: height * 0.017),
                ),
                // Icon(Icons.person),
                Text(
                  widget.tableCapacity,
                  style: TextStyle(fontSize: height * 0.017),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Bill Amount:",
                  style: TextStyle(fontSize: height * 0.017),
                ),
                Text(
                  "Rs. " + widget.totalBill.toString(),
                  style: TextStyle(fontSize: height * 0.017),
                )
              ],
            ),
            widget.isTableEngaged == 1
                ? InkWell(
                    onTap: () {
                      widget.onviewRunningOrderClick();
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.004),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            stops: [
                              0,
                              1
                            ],
                            colors: [
                              Color.fromRGBO(142, 14, 0, 1),
                              Color.fromRGBO(31, 28, 24, 1),
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(height * 0.1),
                            topRight: Radius.circular(height * 0.1),
                            bottomLeft: Radius.circular(height * 0.01),
                            bottomRight: Radius.circular(height * 0.01)),
                      ),
                      child: Center(
                          child: Text(
                        "Running Order",
                        style: TextStyle(
                            color: Colors.white, fontSize: height * 0.02),
                      )),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      widget.onstartOderClick();
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width,
                      margin: EdgeInsets.only(bottom: height * 0.004),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            stops: [
                              0,
                              1
                            ],
                            colors: [
                              Color.fromRGBO(240, 255, 0, 1),
                              Color.fromRGBO(88, 207, 251, 1)
                            ]),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(height * 0.1),
                            topRight: Radius.circular(height * 0.1),
                            bottomLeft: Radius.circular(height * 0.01),
                            bottomRight: Radius.circular(height * 0.01)),
                      ),
                      child: Center(
                          child: Text(
                        "Start Order",
                        style: TextStyle(
                            color: Colors.black, fontSize: height * 0.02),
                      )),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
