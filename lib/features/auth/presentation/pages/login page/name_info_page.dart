import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/core/widgets/loading.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/login_page_widgets.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/provider/filter_provider.dart';

class NameInfoPage extends ConsumerWidget {
  NameInfoPage({super.key});

  final nameController = TextEditingController();
  final emailPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final uid = ref.read(currentUserNotifierProvider)!.uid;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: LoadingContainer(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // kHeight(100.h),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_launcher/ic_launcher.png',
                          height: 50.r,
                          width: 50.r,
                        ),
                        kWidth(20.w),
                        kText(
                          text: 'Klean',
                          color: const Color(0xff888888),
                          family: 'Titillium Web',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ],
                    ),
                    kHeight(100.h),
                    LoginPageWidgets.textField(
                      hintText: 'John Doe',
                      textController: nameController,
                      titleText: 'Your name',
                    ),
                    kHeight(30.h),
                    LoginPageWidgets.textField(
                      hintText: 'example@gmail.com',
                      textController: emailPhoneController,
                      titleText: 'Your email address',
                    ),
                    kHeight(60.h),
                    Opacity(
                      // opacity: 0.5,
                      opacity: .8,
                      child: GestureDetector(
                        onTap: () async {
                          ref.read(loadingStateProvider.notifier).startLoader();
                          await ref
                              .read(loginPageNotifierProvider.notifier)
                              .updateBio(
                                context: context,
                                ref: ref,
                                name: nameController.text.trim(),
                              );
                          ref.read(loadingStateProvider.notifier).stopLoader();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorConstants.greenColor,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                            child: kText(
                              text: 'Continue',
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
