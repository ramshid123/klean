import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/core/widgets/loading.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/login_page_widgets.dart';
import 'package:klean/features/auth/presentation/provider/provider.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/provider/filter_provider.dart';

class OtpPage extends ConsumerWidget {
  final String verificationId;
  OtpPage({super.key, required this.verificationId});

  final TextEditingController otpTextCont = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                            Icon(Icons.arrow_back,
                                color: Colors.black, size: 25.r),
                            kText(
                              text: 'Verify Phone',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                            Icon(Icons.arrow_back,
                                color: Colors.transparent, size: 25.r),
                          ],
                        ),
                      ),
                      kHeight(35.h),
                      kText(
                        text: 'Code is sent to 985 093 3203',
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        color: const Color(0xff444444),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LoginPageWidgets.otpField(
                            context: context,
                            text: ref.watch(otpNotifierProvider).isNotEmpty
                                ? ref.watch(otpNotifierProvider)[0]
                                : '',
                          ),
                          LoginPageWidgets.otpField(
                            context: context,
                            text: ref.watch(otpNotifierProvider).length > 1
                                ? ref.watch(otpNotifierProvider)[1]
                                : '',
                          ),
                          LoginPageWidgets.otpField(
                            context: context,
                            text: ref.watch(otpNotifierProvider).length > 2
                                ? ref.watch(otpNotifierProvider)[2]
                                : '',
                          ),
                          LoginPageWidgets.otpField(
                            context: context,
                            text: ref.watch(otpNotifierProvider).length > 3
                                ? ref.watch(otpNotifierProvider)[3]
                                : '',
                          ),
                          LoginPageWidgets.otpField(
                            context: context,
                            text: ref.watch(otpNotifierProvider).length > 4
                                ? ref.watch(otpNotifierProvider)[4]
                                : '',
                          ),
                          LoginPageWidgets.otpField(
                            context: context,
                            text: ref.watch(otpNotifierProvider).length > 5
                                ? ref.watch(otpNotifierProvider)[5]
                                : '',
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          kText(
                            text: 'Didn\'t receive code? ',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black45,
                          ),
                          kText(
                            text: 'Request again',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          final otp = ref.read(otpNotifierProvider);
                          if (otp.length == 6) {
                            ref
                                .read(loadingStateProvider.notifier)
                                .startLoader();
                            await ref
                                .read(loginPageNotifierProvider.notifier)
                                .verifyOtp(
                                    context: context,
                                    otp: otp.trim(),
                                    ref: ref,
                                    verificationId: verificationId);
                            ref
                                .read(loadingStateProvider.notifier)
                                .stopLoader();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              horizontal: 25.w, vertical: 15.h),
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          decoration: BoxDecoration(
                            color: ColorConstants.greenColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: kText(
                              text: 'Verify and Create Account',
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '2',
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '3',
                      ref: ref,
                    ),
                  ],
                ),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '4',
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '5',
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '6',
                      ref: ref,
                    ),
                  ],
                ),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '7',
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '8',
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '9',
                      ref: ref,
                    ),
                  ],
                ),
                Row(
                  children: [
                    LoginPageWidgets.numberDialItem(
                      text: '.',
                      ref: ref,
                    ),
                    LoginPageWidgets.numberDialItem(
                      text: '0',
                      ref: ref,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          final otpValue = ref.watch(otpNotifierProvider);
                          if (otpValue.isNotEmpty) {
                            ref.read(otpNotifierProvider.notifier).removeLast();
                          }
                          // if (otpTextCont.text.isNotEmpty) {
                          //   otpTextCont.text = otpTextCont.text
                          //       .substring(0, otpTextCont.text.length - 1);
                          // }
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
                                color: Color(0xFF000000).withOpacity(0.1),
                                offset: Offset(0, 0),
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

// final authOutlineInputBorder = OutlineInputBorder(
//   borderSide: const BorderSide(color: Color(0xFF757575)),
//   borderRadius: BorderRadius.all(Radius.circular(12.r)),
// );

// class OtpForm extends StatelessWidget {
//   const OtpForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           SizedBox(
//             height: 64.r,
//             width: 64.r,
//             child: TextFormField(
//               onSaved: (pin) {},
//               onChanged: (pin) {
//                 if (pin.isNotEmpty) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                   hintText: "0",
//                   hintStyle: const TextStyle(color: Color(0xFF757575)),
//                   border: authOutlineInputBorder,
//                   enabledBorder: authOutlineInputBorder,
//                   focusedBorder: authOutlineInputBorder.copyWith(
//                       borderSide: const BorderSide(color: Color(0xFFFF7643)))),
//             ),
//           ),
//           SizedBox(
//             height: 64,
//             width: 64,
//             child: TextFormField(
//               onSaved: (pin) {},
//               onChanged: (pin) {
//                 if (pin.isNotEmpty) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                   hintText: "0",
//                   hintStyle: const TextStyle(color: Color(0xFF757575)),
//                   border: authOutlineInputBorder,
//                   enabledBorder: authOutlineInputBorder,
//                   focusedBorder: authOutlineInputBorder.copyWith(
//                       borderSide: const BorderSide(color: Color(0xFFFF7643)))),
//             ),
//           ),
//           SizedBox(
//             height: 64,
//             width: 64,
//             child: TextFormField(
//               onSaved: (pin) {},
//               onChanged: (pin) {
//                 if (pin.isNotEmpty) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                   hintText: "0",
//                   hintStyle: const TextStyle(color: Color(0xFF757575)),
//                   border: authOutlineInputBorder,
//                   enabledBorder: authOutlineInputBorder,
//                   focusedBorder: authOutlineInputBorder.copyWith(
//                       borderSide: const BorderSide(color: Color(0xFFFF7643)))),
//             ),
//           ),
//           SizedBox(
//             height: 64,
//             width: 64,
//             child: TextFormField(
//               onSaved: (pin) {},
//               onChanged: (pin) {
//                 if (pin.isNotEmpty) {
//                   FocusScope.of(context).nextFocus();
//                 }
//               },
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//               inputFormatters: [
//                 LengthLimitingTextInputFormatter(1),
//                 FilteringTextInputFormatter.digitsOnly,
//               ],
//               style: Theme.of(context).textTheme.titleLarge,
//               textAlign: TextAlign.center,
//               decoration: InputDecoration(
//                   hintText: "0",
//                   hintStyle: const TextStyle(color: Color(0xFF757575)),
//                   border: authOutlineInputBorder,
//                   enabledBorder: authOutlineInputBorder,
//                   focusedBorder: authOutlineInputBorder.copyWith(
//                       borderSide: const BorderSide(color: Color(0xFFFF7643)))),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
