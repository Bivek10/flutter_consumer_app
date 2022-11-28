import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/manage_table_api.dart';
import '../../widgets/atoms/dialoug.dart';

class OnRunningOperation extends StatefulWidget {
  final Map<String, dynamic> tabledata;
  OnRunningOperation({
    Key? key,
    required this.tabledata,
  }) : super(key: key);

  @override
  State<OnRunningOperation> createState() => _OnRunningOperationState();
}

class _OnRunningOperationState extends State<OnRunningOperation> {
  ManageTableApi manageTableApi = ManageTableApi();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0.sp,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Order Running Operation",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return ConfirmDialog(
                      onYes: () {
                        Map<String, dynamic> reupdateTable = {
                          "tableid": widget.tabledata["tableid"],
                          "isRunning": false,
                          "totalbill": "0",
                          "capacity": widget.tabledata["capacity"]
                        };
                        manageTableApi.onCancleOrder(
                          tableuid: widget.tabledata["uid"],
                          tabledata: reupdateTable,
                          context: context,
                        );
                      },
                      content: "Are you sure to cancle order ?",
                    );
                  });
            },
            leading: const Icon(
              Icons.cancel,
              color: Colors.red,
              size: 20,
            ),
            title: const Text(
              "Cancle Order",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Map<String, dynamic> reupdateTable = {
                "tableid": widget.tabledata["tableid"],
                "isRunning": false,
                "totalbill": "0",
                "capacity": widget.tabledata["capacity"]
              };

              manageTableApi.onCompleteOrder(
                tableuid: widget.tabledata["uid"],
                tabledata: reupdateTable,
                totalbill: widget.tabledata["totalbill"],
                context: context,
              );
            },
            leading: const Icon(
              Icons.delivery_dining,
              color: Colors.red,
              size: 20,
            ),
            title: const Text(
              "Complete Order",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
