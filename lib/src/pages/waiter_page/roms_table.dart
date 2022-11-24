import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/routes/routesname.dart';
import '../../widgets/molecules/roms_table_template.dart';

class TableViews extends StatefulWidget {
  const TableViews({Key? key}) : super(key: key);

  @override
  State<TableViews> createState() => _TableViewsState();
}

class _TableViewsState extends State<TableViews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: 2,
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
                tableID: "Table" + index.toString(),
                tableName: index.toString(),
                totalBill: "500",
                tableCapacity: "4",
                isTableEngaged: index == 0 ? 1 : 0,
              ),
            );
          }),
    );
  }
}
