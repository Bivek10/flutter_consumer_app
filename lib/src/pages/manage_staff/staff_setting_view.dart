import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/manage_staff_api.dart';
import '../../config/routes/routesname.dart';
import '../../widgets/atoms/dialoug.dart';
import '../../widgets/molecules/header.dart';

class StaffSettingView extends StatefulWidget {
  final Map<String, dynamic> data;
  final String staffuid;
  const StaffSettingView({
    Key? key,
    required this.data,
    required this.staffuid,
  }) : super(key: key);

  @override
  State<StaffSettingView> createState() => _StaffSettingViewState();
}

class _StaffSettingViewState extends State<StaffSettingView> {
  bool isverified = false;
  String role = "Admin";

  ManageStaffAPI manageStaffAPI = ManageStaffAPI();

  @override
  void initState() {
    isverified = widget.data["isVerify"];
    role = widget.data["role"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Setting",
        showMenu: false,
        showAction: false,
        onPressedLeading: () {},
        onPressedAction: () {},
        bgColor: Colors.grey.shade200,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text(
              'Account',
              style: TextStyle(fontSize: 14.sp),
            ),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.person),
                title: Text(
                  'Role',
                  style: TextStyle(fontSize: 14.sp),
                ),
                value: Text(
                  role,
                  style: TextStyle(fontSize: 10.sp),
                ),
                trailing: PopupMenuButton(
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Admin"),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 1,
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Staff"),
                      ),
                    ),
                  ],
                  onSelected: (value) async {
                    if (value == 0) {
                      widget.data["role"] = "Admin";
                      bool status = await manageStaffAPI.updateStaff(
                          data: widget.data,
                          isRole: true,
                          staffuid: widget.staffuid);

                      if (status) {
                        setState(() {
                          role = "Admin";
                        });
                      }
                    } else {
                      widget.data["role"] = "Staff";
                      bool status = await manageStaffAPI.updateStaff(
                          data: widget.data,
                          isRole: true,
                          staffuid: widget.staffuid);
                      if (status) {
                        setState(() {
                          role = "Staff";
                        });
                      }
                    }
                  },
                ),
              ),
              SettingsTile.switchTile(
                onToggle: (value) async {
                  if (isverified) {
                    widget.data["isVerify"] = false;
                    bool status = await manageStaffAPI.updateStaff(
                        data: widget.data,
                        isRole: false,
                        staffuid: widget.staffuid);
                    if (status) {
                      setState(() {
                        isverified = false;
                      });
                    }
                  } else {
                    widget.data["isVerify"] = true;
                    bool status = await manageStaffAPI.updateStaff(
                        data: widget.data,
                        isRole: false,
                        staffuid: widget.staffuid);
                    if (status) {
                      setState(() {
                        isverified = true;
                      });
                    }
                  }
                },
                initialValue: isverified,
                leading: Icon(
                  Icons.verified,
                  color: isverified ? Colors.green : Colors.black,
                ),
                title: Text(
                  'Activate Account',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
              SettingsTile.navigation(
                leading: const Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                title: Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return ConfirmDialog(
                            content: "Are you sure to delete ?",
                            onYes: () async {
                              manageStaffAPI.deleteStaffTable(
                                  widget.staffuid, context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
