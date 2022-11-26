import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../config/api/user_info_api.dart';
import '../../injector.dart';
import 'staff_setting.dart';
import 'staff_setting_view.dart';

class StaffBase extends StatefulWidget {
  final Map<String, dynamic> staffInfo;
  final String staffuid;
  const StaffBase({
    Key? key,
    required this.staffInfo,
    required this.staffuid,
  }) : super(key: key);

  @override
  State<StaffBase> createState() => _StaffBaseState();
}

class _StaffBaseState extends State<StaffBase> {
  late Map<String, dynamic> data;
  late String currentuid;

  @override
  void initState() {
    data = widget.staffInfo;
    currentuid = sharedPreferences.getString('uid')!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.sp),
        // color: Colors.grey.shade200,
      ),
      child: Card(
        color: Colors.grey.shade200,
        elevation: 3,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200, width: 2.0),
            borderRadius: BorderRadius.circular(8.sp)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  height: 80.sp,
                ),
                Container(
                  height: 60.sp,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                    color: Color.fromARGB(255, 137, 29, 21),
                  ),
                ),
                Positioned(
                  top: 35,
                  left: 50,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue.shade200,
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                ),
                currentuid == widget.staffuid
                    ? const Positioned(
                        top: 5,
                        right: 10,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 25,
                        ),
                      )
                    : Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => StaffSettingView(
                                      data: data,
                                      staffuid: widget.staffuid,
                                    )),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                data["username"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                data["phone"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                data["email"],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Position: ${data["role"]}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: data["isVerify"]
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.verified,
                          color: Colors.green,
                          size: 20,
                        ),
                        Text(
                          "Verified",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                          size: 20,
                        ),
                        Text(
                          "Unverified",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
