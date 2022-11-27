import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/routes/routesname.dart';

import '../../widgets/molecules/roms_table_template.dart';

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
      child:
       GridView.builder(
          itemCount: widget.tabledata.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 2.w, mainAxisSpacing: 8.sp, crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTapUp: (TapUpDetails details) {},
              child: TableStructure(
                onstartOderClick: () {
                  Navigator.pushNamed(context, RouteName.menulist);
                  
                },
                onviewRunningOrderClick: () {},
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
