import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';

class HomePageWidgets {
  static Widget availableServiceItem({
    required String text,
    required String svgIcon,
    bool greenText = false,
  }) {
    final svgUrl = 'assets/images/svg icons/$svgIcon';
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: ColorConstants.bgColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.1),
                offset: const Offset(0, 0),
                blurRadius: 14,
                spreadRadius: -1,
              ),
            ],
          ),
          child: SvgPicture.asset(
            svgUrl,
            height: 35.r,
            width: 35.r,
          ),
        ),
        kHeight(5.h),
        kText(
          text: text,
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: greenText ? ColorConstants.greenColor : Colors.black,
        ),
      ],
    );
  }

  static Widget cleaningServiceItem({
    required String text,
    required String imageUrl,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.r),
            child: Image.asset(
              imageUrl,
              width: 139.w,
              height: 154.h,
              fit: BoxFit.cover,
            ),
          ),
          kHeight(10.h),
          kText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
