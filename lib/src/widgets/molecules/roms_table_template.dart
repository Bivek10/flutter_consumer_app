import 'package:flutter/material.dart';
import 'package:flutter_skeleton/src/config/routes/routesname.dart';

import 'package:sizer/sizer.dart';

import '../../config/api/manage_table_api.dart';
import '../../config/api/user_info_api.dart';
import '../../config/themes/colors.dart';
import '../../core/utils/snack_bar.dart';
import '../../pages/manage_table/add_table.dart';
import '../atoms/menu_button.dart';
import 'table_content.dart';

class TableStructure extends StatefulWidget {
  final String tableuid;
  final String tableID;
  final String tableName;
  final Function onstartOderClick;
  final Function onviewRunningOrderClick;
  final String tableCapacity;
  final int? elementIndex;
  final bool isTableEngaged;
  final String totalBill;

  const TableStructure({
    Key? key,
    required this.tableuid,
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
  ManageTableApi manageTableApi = ManageTableApi();

  @override
  Widget build(BuildContext context) {
    // print(widget.tableID);

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
                      widget.isTableEngaged ? Colors.red : Colors.green,
                ),
              ),
              TableContent(label: "Table ID:", labelvalue: widget.tableID),
              TableContent(
                  label: "Capacity:", labelvalue: widget.tableCapacity),
              TableContent(
                label: "Total Bill:",
                labelvalue: widget.totalBill,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.isTableEngaged
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
                          }),
                  UserCached.userrole == "Admin" && !widget.isTableEngaged
                      ? PopupMenuButton(
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.red,
                          ),
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 0,
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text("Edit"),
                              ),
                            ),
                            const PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text("Delete"),
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 0) {
                              Navigator.pushNamed(
                                context,
                                RouteName.addtable,
                                arguments: EditFormValue(
                                    true,
                                    {
                                      "table_id": widget.tableID,
                                      "capacity": widget.tableCapacity
                                    },
                                    widget.tableuid),
                              );
                            } else {
                              manageTableApi.deleteTable(widget.tableuid);
                            }
                          },
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      ),
    );
 
  }
}
