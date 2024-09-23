import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/core/widgets/loading.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/login_page_widgets.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/provider/filter_provider.dart';

class PhoneLoginPage extends ConsumerWidget {
  PhoneLoginPage({super.key});

  final TextEditingController phoneTextCont = TextEditingController();

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 249, 243),
      body: LoadingContainer(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.r),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      kHeight(10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () => context.pop(),
                                child: Icon(Icons.clear,
                                    color: Colors.black, size: 25.r)),
                            kText(
                              text: 'Continue with Phone',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            Icon(Icons.clear,
                                color: Colors.transparent, size: 25.r),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Container(
                      //   height: 100.h,
                      //   width: 100.w,
                      //   color: ColorConstants.greenColor,
                      // ),
                      Icon(
                        Icons.lock_open,
                        size: 100.r,
                        color: ColorConstants.greenColor.withOpacity(0.7),
                      ),
                      kHeight(20.h),
                      kText(
                        text: 'You\'ll receive a 6 digit code\nto verify next.',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        color: const Color(0xff444444),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 20.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF000000).withOpacity(0.3),
                              offset: const Offset(0, 0),
                              blurRadius: 14,
                              spreadRadius: -1,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
          cursorColor: Colors.black,

                                controller: phoneTextCont,
                                readOnly: true,
                                style: GoogleFonts.nunito(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  label: kText(
                                    text: 'Enter your phone',
                                    fontSize: 15,
                                    color: const Color(0XFF444444),
                                  ),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (phoneTextCont.text.length == 10) {
                                  ref
                                      .read(loadingStateProvider.notifier)
                                      .startLoader();
                                  await ref
                                      .read(loginPageNotifierProvider.notifier)
                                      .loginWithPhone(
                                          phone: phoneTextCont.text.trim(),
                                          context: context,
                                          ref: ref);
                                  ref
                                      .read(loadingStateProvider.notifier)
                                      .stopLoader();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 15.h),
                                margin: EdgeInsets.symmetric(horizontal: 10.h),
                                decoration: BoxDecoration(
                                  color: ColorConstants.greenColor,
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: kText(
                                  text: 'Continue',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                kHeight(25.h),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '1',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '2',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '3',
                      textController: phoneTextCont,
                    ),
                  ],
                ),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '4',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '5',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '6',
                      textController: phoneTextCont,
                    ),
                  ],
                ),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '7',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '8',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '9',
                      textController: phoneTextCont,
                    ),
                  ],
                ),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '.',
                      textController: phoneTextCont,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '0',
                      textController: phoneTextCont,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (phoneTextCont.text.isNotEmpty) {
                            phoneTextCont.text = phoneTextCont.text
                                .substring(0, phoneTextCont.text.length - 1);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(0.1),
                                offset: const Offset(0, 0),
                                blurRadius: 14,
                                spreadRadius: -1,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.backspace_outlined,
                              size: 25.r,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                kHeight(25.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
