import 'package:go_router/go_router.dart';
import 'package:klean/core/routes/route_names.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/login_page.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/name_info_page.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/otp_page.dart';
import 'package:klean/features/auth/presentation/pages/login%20page/phone%20login%20page.dart';
import 'package:klean/features/auth/presentation/pages/splash%20screen/splash_screen.dart';
import 'package:klean/features/cart/presentation/pages/cart%20page/cart_page.dart';
import 'package:klean/features/cart/presentation/pages/home%20page/home_page.dart';
import 'package:klean/features/auth/presentation/pages/profile%20page/profile_page.dart';
import 'package:klean/features/cart/presentation/pages/service%20list%20page/services_page.dart';

class Routes {
  static final goRoutes = GoRouter(
    initialLocation: RouteNames.splashScreen,
    routes: [
      GoRoute(
        path: RouteNames.splashScreen,
        name: RouteNames.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.loginPage,
        name: RouteNames.loginPage,
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
            path: RouteNames.phoneNoPage,
            name: RouteNames.phoneNoPage,
            builder: (context, state) => PhoneLoginPage(),
            routes: [
              GoRoute(
                path: RouteNames.otpNoPage,
                name: RouteNames.otpNoPage,
                builder: (context, state) => OtpPage(
                  verificationId: state.extra as String,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.homePage,
        name: RouteNames.homePage,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: RouteNames.serviceListPage,
            name: RouteNames.serviceListPage,
            builder: (context, state) => const ServicesPage(),
            routes: [
              GoRoute(
                path: RouteNames.cartPage,
                name: RouteNames.cartPage,
                builder: (context, state) => CartPage(
                  parentRoute: state.extra.toString(),
                ),
              ),
            ],
          ),
          // GoRoute(
          //   path: RouteNames.cartPage,
          //   name: RouteNames.cartPage,
          //   builder: (context, state) => CartPage(),
          // ),
        ],
      ),
      GoRoute(
        path: RouteNames.profilePage,
        name: RouteNames.profilePage,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.infoPage,
        name: RouteNames.infoPage,
        builder: (context, state) =>  NameInfoPage(),
      ),
    ],
  );
}
