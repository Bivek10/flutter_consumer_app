import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/routes/routesname.dart';

import '../../widgets/molecules/roms_table_template.dart';
import '../manage_table/on_running_operation.dart';

class TableViews extends StatefulWidget {
  final List<Map<String, dynamic>> tabledata;
  const TableViews({Key? key, required this.tabledata}) : super(key: key);

  @override
  State<TableViews> createState() => _TableViewsState();
}

class _TableViewsState extends State<TableViews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: widget.tabledata.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 2.w, mainAxisSpacing: 8.sp, crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTapUp: (TapUpDetails details) {},
              child: TableStructure(
                onstartOderClick: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.foodmenu,
                    arguments: TableModel(
                      widget.tabledata[index]["uid"],
                      "${widget.tabledata[index]["tableid"]}",
                      widget.tabledata[index]["totalbill"],
                      widget.tabledata[index]["capacity"],
                      widget.tabledata[index]["isRunning"],
                    ),
                  );
                },
                onviewRunningOrderClick: () {
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => OnRunningOperation(
                          tabledata: widget.tabledata[index],
                        )),
                  );
                },
                tableuid: widget.tabledata[index]["uid"],
                tableID: "${widget.tabledata[index]["tableid"]}",
                tableName: index.toString(),
                totalBill: widget.tabledata[index]["totalbill"],
                tableCapacity: widget.tabledata[index]["capacity"],
                isTableEngaged: widget.tabledata[index]["isRunning"],
              ),
            );
          }),
    );
  }
}

class TableModel {
  final String uid;
  final String tableid;
  final String totalbill;
  final String capacity;
  final bool isRunning;

  TableModel(
      this.uid, this.tableid, this.totalbill, this.capacity, this.isRunning);
}
