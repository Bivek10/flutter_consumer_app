import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../config/themes/colors.dart';
import '../../core/utils/dimensions.dart';

class CostumHeader extends StatelessWidget {
  const CostumHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 200,
              width: Dimensions.width(context),
            ),
            Positioned(
              right: -10,
              top: -5,
              child: SizedBox(
                height: 200,
                width: Dimensions.width(context) / 1.85,
                child: SvgPicture.asset("assets/icons/backsvg.svg"),
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: CircleAvatar(
                radius: 25.sp,
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  "assets/images/logo.png",
                ),
              ),
            ),
            Positioned(
              top: 130,
              left: 15,
              child: Text(
                "Hey,\nWel-come.",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
