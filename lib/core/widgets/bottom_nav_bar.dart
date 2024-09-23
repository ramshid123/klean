import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:klean/core/routes/route_names.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';

Widget kustomBottomNavBar({
  required int index,
  required BuildContext context,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    margin: EdgeInsets.symmetric(vertical: 20.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF000000).withOpacity(0.1),
          offset: Offset(0, 0),
          blurRadius: 14,
          spreadRadius: -1,
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _kustomBottomNavBar(
          icon: Icons.home,
          text: 'Home',
          isSelected: index == 0,
          route: RouteNames.homePage,
          context: context,
        ),
        _kustomBottomNavBar(
          icon: Icons.calendar_month,
          text: 'Bookings',
          isSelected: index == 1,
          route: RouteNames.homePage,
          context: context,
        ),
        _kustomBottomNavBar(
          icon: Icons.person,
          text: 'Account',
          isSelected: index == 2,
          route: RouteNames.profilePage,
          context: context,
        ),
      ],
    ),
  );
}

Widget _kustomBottomNavBar({
  required IconData icon,
  required String text,
  required BuildContext context,
  required String route,
  required isSelected,
}) {
  return GestureDetector(
    onTap: () => context.goNamed(route),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
      decoration: BoxDecoration(
        color: isSelected ? ColorConstants.liteGreenColor : Colors.transparent,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25.r,
            color: isSelected ? ColorConstants.greenColor : Colors.black45,
          ),
          kWidth(5.w),
          kText(
            text: text,
            color: isSelected ? Colors.black : Colors.black45,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    ),
  );
}
