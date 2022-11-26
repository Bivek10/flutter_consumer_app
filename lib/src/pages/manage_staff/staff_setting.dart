import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../config/api/manage_staff_api.dart';
import '../../widgets/atoms/loader.dart';
import '../../widgets/molecules/header.dart';
import 'staff_view_template.dart';

class StaffSetting extends StatefulWidget {
  static const pageUrl = "/Staffsetting";
  const StaffSetting({Key? key}) : super(key: key);

  @override
  State<StaffSetting> createState() => _StaffSettingState();
}

class _StaffSettingState extends State<StaffSetting> {
  ManageStaffAPI manageStaffAPI = ManageStaffAPI();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(
        title: "Manage StaffSetting",
        showMenu: false,
        showAction: false,
        onPressedAction: () {},
        onPressedLeading: () {},
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: manageStaffAPI.getStaffInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Map<String, dynamic>> staffuids =
                  snapshot.data!.docs.map((e) {
                Map<String, dynamic> v = {"uid": e.id};

                return v;
              }).toList();
              List<Map<String, dynamic>> data = snapshot.data!.docs.map((e) {
                return e.data() as Map<String, dynamic>;
              }).toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 2.w,
                      mainAxisSpacing: 8.sp,
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return StaffBase(
                        staffInfo: data[index],
                        staffuid: staffuids[index]["uid"],
                      );
                    }),
              );
            }
            return const Center(
              child: Loader(),
            );
          }),
    );
  }
}
