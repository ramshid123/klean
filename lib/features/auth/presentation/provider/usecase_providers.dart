import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klean/core/providers/user.dart';
import 'package:klean/core/routes/route_names.dart';
import 'package:klean/core/entity/user_entity.dart';
import 'package:klean/features/auth/domain/use%20cases/get_current_user.dart';
import 'package:klean/features/auth/domain/use%20cases/log_out.dart';
import 'package:klean/features/auth/domain/use%20cases/login_with_google.dart';
import 'package:klean/features/auth/domain/use%20cases/login_with_phone.dart';
import 'package:klean/features/auth/domain/use%20cases/update_bio.dart';
import 'package:klean/features/auth/domain/use%20cases/verify_otp.dart';
import 'package:klean/init_dependencies.dart';
import 'package:go_router/go_router.dart';

final loginWithGoogleProvider = Provider((ref) async {
  final UseCaseLoginWithGoogle useCaseLoginWithGoogle =
      UseCaseLoginWithGoogle(serviceLocator());
  await useCaseLoginWithGoogle(UseCaseLoginWithGoogleParams());
});

final loginPageNotifierProvider =
    StateNotifierProvider<LoginPageNotifier, UserEntity?>(
        (ref) => serviceLocator());

class LoginPageNotifier extends StateNotifier<UserEntity> {
  final UseCaseGetCurrentUser _useCaseGetCurrentUser;
  final UseCaseLoginWithGoogle _useCaseLoginWithGoogle;
  final UseCaseLoginWithPhone _useCaseLoginWithPhone;
  final UseCaseVerifyOtp _useCaseVerifyOtp;
  final UseCaseUpdateBio _useCaseUpdateBio;
  final UseCaseLogout _useCaseLogout;

  LoginPageNotifier({
    required UseCaseGetCurrentUser useCaseGetCurrentUser,
    required UseCaseLoginWithGoogle useCaseLoginWithGoogle,
    required UseCaseUpdateBio useCaseUpdateBio,
    required UseCaseVerifyOtp useCaseVerifyOtp,
    required UseCaseLoginWithPhone useCaseLoginWithPhone,
    required UseCaseLogout useCaseLogout,
  })  : _useCaseGetCurrentUser = useCaseGetCurrentUser,
        _useCaseLoginWithGoogle = useCaseLoginWithGoogle,
        _useCaseUpdateBio = useCaseUpdateBio,
        _useCaseLoginWithPhone = useCaseLoginWithPhone,
        _useCaseVerifyOtp = useCaseVerifyOtp,
        _useCaseLogout = useCaseLogout,
        super(UserEntity(name: '', email: '', phoneNo: '', uid: ''));

  Future loginWithGoogle({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    await _useCaseLoginWithGoogle(UseCaseLoginWithGoogleParams());
    if (context.mounted) {
      await checkCurrentuser(context: context, ref: ref);
    }
  }

  Future checkCurrentuser({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final response =
        await _useCaseGetCurrentUser(UseCaseGetCurrentUserParams());

    response.fold(
      (l) {
        log(l.message);
        context.goNamed(RouteNames.loginPage);
      },
      (r) {
        ref.read(currentUserNotifierProvider.notifier).changeUser(r);
        if (r == null) {
          context.goNamed(RouteNames.loginPage);
        } else {
          if (r.name.isEmpty) {
            context.goNamed(RouteNames.infoPage);
          } else {
            context.goNamed(RouteNames.homePage);
          }
        }
      },
    );
  }

  Future verifyOtp({
    required String verificationId,
    required String otp,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    await _useCaseVerifyOtp(
        UseCaseVerifyOtpParams(verificationId: verificationId, otp: otp));

    if (context.mounted) {
      await checkCurrentuser(context: context, ref: ref);
    }
  }

  Future updateBio({
    required String name,
    required BuildContext context,
    required WidgetRef ref,
    String email = '',
    String phone = '',
  }) async {
    if (name.isEmpty) {
      return;
    }

    final response = await _useCaseUpdateBio(
        UseCaseUpdateBioParams(name: name, phoneNo: phone, email: email));

    response.fold(
      (l) async {
        log(l.message);
        await logout(context: context, ref: ref);
      },
      (r) async {
        await checkCurrentuser(context: context, ref: ref);
      },
    );
  }

  Future loginWithPhone({
    required String phone,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final verificationId = await _useCaseLoginWithPhone(
        UseCaseLoginWithPhoneParams(phoneNo: '+91 $phone'));

    verificationId.fold(
      (l) async {
        log(l.message);
        await logout(context: context, ref: ref);
        if (context.mounted) {
          await checkCurrentuser(context: context, ref: ref);
        }
      },
      (r) async {
        if (r.isEmpty) {
          await logout(context: context, ref: ref);
          if (context.mounted) {
            await checkCurrentuser(context: context, ref: ref);
          }
        } else {
          context.goNamed(RouteNames.otpNoPage, extra: r);
        }
      },
    );
  }

  Future logout({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    await _useCaseLogout(UseCaseLogoutParams());
    // await checkCurrentuser(context: context, ref: ref);
    if (context.mounted) {
      context.goNamed(RouteNames.splashScreen);
    }
  }
}
