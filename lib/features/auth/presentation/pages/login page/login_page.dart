import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/core/widgets/loading.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/phone%20login%20page.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/provider/filter_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: LoadingContainer(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ic_launcher/ic_launcher.png',
                height: 100.r,
                width: 100.r,
              ),
              kHeight(15.h),
              kText(
                text: 'Klean',
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: const Color(0xff888888),
                family: 'Titillium Web',
              ),
              kText(
                text: 'Klean at your service!',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: const Color(0xff888888),
                family: 'Titillium Web',
              ),
              // Container(
              //   height: 50.h,
              //   width: 50.w,
              //   color: ColorConstants.greenColor,
              // ),
              kHeight(size.height / 5),
              GestureDetector(
                onTap: () async {
                  ref.read(loadingStateProvider.notifier).startLoader();
                  await ref
                      .read(loginPageNotifierProvider.notifier)
                      .loginWithGoogle(context: context, ref: ref);
                  ref.read(loadingStateProvider.notifier).stopLoader();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icons/google.png',
                        height: 20.r,
                        width: 20.r,
                      ),
                      kWidth(25.w),
                      kText(
                        text: 'Continue with Google',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
              ),
              kHeight(25.h),
              GestureDetector(
                onTap: () async => await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PhoneLoginPage())),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  decoration: BoxDecoration(
                    color: ColorConstants.greenColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: kText(
                      text: 'Phone',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
