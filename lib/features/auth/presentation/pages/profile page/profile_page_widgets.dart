import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/widgets/common.dart';

class ProfilePageWidgets {
  static Widget profilePageItem({
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: Colors.black12,
            width: 1.r,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 23.r,
              color: Colors.black45,
            ),
            kWidth(25.w),
            kText(
              text: title,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xff444444),
            ),
          ],
        ),
      ),
    );
  }
}
