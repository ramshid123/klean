import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/auth/presentation/provider/provider.dart';

class LoginPageWidgets {
  static Widget numberDialItem({
    required String text,
    TextEditingController? textController,
    WidgetRef? ref,
    bool isOtp = false,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (textController != null && int.tryParse(text) != null) {
            if (textController.text.length <= 9) {
              textController.text += text;
            }
          } else if (ref != null) {
            ref.read(otpNotifierProvider.notifier).addNum(text);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
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
            child: kText(
              text: text,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  static Widget otpField({
    required BuildContext context,
    required String text,
  }) {
    final authOutlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF757575)),
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
    );
    final textController = TextEditingController(text: text);
    return SizedBox(
      height: 60.r,
      width: 60.r,
      child: TextFormField(
        controller: textController,
        onSaved: (pin) {},
        onChanged: (pin) {
          if (pin.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
        },
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
        readOnly: true,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder,
        ),
      ),
    );
  }

  static Widget textField({
    required TextEditingController textController,
    required String hintText,
    required String titleText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kText(
          text: titleText,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
        kHeight(10.h),
        TextFormField(
          controller: textController,
          style: GoogleFonts.nunito(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xff444444),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.nunito(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xff888888)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.r),
              borderSide: BorderSide(
                color: Colors.black54,
                width: 3.r,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.r),
              borderSide: BorderSide(
                color: Colors.black38,
                width: 2.r,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.r),
              borderSide: BorderSide(
                color: Colors.black87,
                width: 3.r,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
