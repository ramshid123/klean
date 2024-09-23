import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/core/entity/user_entity.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/pages/home%20page/home_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      ref.read(loginPageNotifierProvider.notifier).checkCurrentuser(
            context: context,
            ref: ref,
          );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/ic_launcher/ic_launcher.png',
          height: 100.r,
          width: 100.r,
        ),
      ),
    );
  }
}
