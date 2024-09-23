import 'package:recase/recase.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/entity/user_entity.dart';
import 'package:klean/core/providers/user.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/bottom_nav_bar.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/auth/presentation/pages/profile%20page/profile_page_widgets.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late UserEntity? currentUser;

  @override
  void initState() {
    
    currentUser = ref.read(currentUserNotifierProvider);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      appBar: PreferredSize(
        preferredSize: Size(50.h, size.width),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
          color: ColorConstants.bgColor,
          child: SafeArea(
            child: kText(
              text: 'My Account',
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  kHeight(10.h),
                  Row(
                    children: [
                      Container(
                        height: 45.r,
                        width: 45.r,
                        decoration: BoxDecoration(
                          gradient: ColorConstants.greenGradient,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Center(
                          child: kText(
                            text: 'FE',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      kWidth(15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kText(
                            // text: 'Fathima Ebrahim',
                            text: ReCase(currentUser!.name).titleCase,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          kText(
                            // text: '+91 908 786 4233',
                            text: currentUser!.email.isNotEmpty
                                ? currentUser!.email
                                : currentUser!.phoneNo,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  kHeight(15.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: ColorConstants.liteGreenColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        kText(
                          text: 'Wallet',
                          color: ColorConstants.greenColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                        const Spacer(),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: kText(
                            text: 'Balance - 125',
                            color: ColorConstants.greenColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  kHeight(20.h),
                  ProfilePageWidgets.profilePageItem(
                      icon: Icons.person, title: 'Edit Profile'),
                  ProfilePageWidgets.profilePageItem(
                      icon: Icons.location_on, title: 'Saved Address'),
                  ProfilePageWidgets.profilePageItem(
                      icon: Icons.note_alt_rounded,
                      title: 'Terms & Conditions'),
                  ProfilePageWidgets.profilePageItem(
                      icon: Icons.policy, title: 'Privacy Policy'),
                  ProfilePageWidgets.profilePageItem(
                      icon: Icons.group_sharp, title: 'Refer a friend'),
                  ProfilePageWidgets.profilePageItem(
                      icon: Icons.phone, title: 'Customer Support'),
                  GestureDetector(
                    onTap: () async {
                      await ref
                          .read(loginPageNotifierProvider.notifier)
                          .logout(context: context, ref: ref);
                    },
                    child: ProfilePageWidgets.profilePageItem(
                        icon: Icons.logout, title: 'Log Out'),
                  ),
                  kHeight(150.h),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: kustomBottomNavBar(context: context, index: 2),
          ),
        ],
      ),
    );
  }
}
