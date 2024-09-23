import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/routes/routes.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/login_page.dart';
import 'package:klean/features/cart/presentation/pages/home%20page/home_page.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 803.6363636363636),
      child: MaterialApp.router(
        title: F.title,
        routerConfig: Routes.goRoutes,
      ),
    );
  }
}