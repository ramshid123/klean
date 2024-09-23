import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klean/core/constants/dummy/products.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/providers/user.dart';
import 'package:klean/core/routes/route_names.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/bottom_nav_bar.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/pages/home%20page/home_page_widgets.dart';
import 'package:klean/features/cart/presentation/provider/cart_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _scrollController = ScrollController();

  List<CartEntity> productsInCart = [];
  late String uid;

  @override
  void initState() {
    uid = ref.read(currentUserNotifierProvider)!.uid;
    ref.read(cartNotifierProvider.notifier).getAllKarts(uid: uid);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productsInCart =
        ref.watch(cartNotifierProvider).where((p) => p.counts > 0).toList();
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SingleChildScrollView(
                clipBehavior: Clip.none,
                child: Column(
                  children: [
                    // kHeight(20.h),
                    SizedBox(
                      height: 5.h,
                      width: double.infinity,
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 20.h),
                      child: kText(
                        text: '👋',
                        fontSize: 20,
                        applyHorizontalSpace: false,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        kText(
                          text: '406, Skyline Park Dale, MM Road....',
                          fontSize: 15,
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                        Transform.rotate(
                          angle: math.pi / 2,
                          child: Icon(
                            Icons.navigate_next,
                            size: 25.r,
                            color: ColorConstants.greenColor,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => context.goNamed(RouteNames.cartPage,
                              extra: RouteNames.homePage),
                          child: Container(
                            padding: EdgeInsets.all(10.r),
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
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  size: 30.r,
                                  color: ColorConstants.greenColor,
                                ),
                                Transform.translate(
                                  offset: Offset(5.r, -10.r),
                                  child: Visibility(
                                    visible: productsInCart.isNotEmpty,
                                    child: Container(
                                      padding: EdgeInsets.all(5.r),
                                      decoration: const BoxDecoration(
                                        color: ColorConstants.redColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: kText(
                                        text: '${productsInCart.length}',
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    kHeight(40.h),
                    Image.asset(
                      'assets/images/banners/banner_pic_1.png.png',
                      width: double.infinity,
                    ),
                    kHeight(30.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.2),
                            offset: Offset(0, 0),
                            blurRadius: 14,
                            spreadRadius: -1,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: ColorConstants.greenColor,
                                decoration: InputDecoration(
                                  hintText: 'Search for a service',
                                  hintStyle: GoogleFonts.nunito(
                                    color: Colors.black38,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  // suffix: Container(
                                  //   decoration: BoxDecoration(
                                  //     gradient: ColorConstants.greenGradient,
                                  //   ),
                                  //   child: Icon(
                                  //     Icons.search,
                                  //     color: Colors.black,
                                  //     size: 25.r,
                                  //   ),
                                  // ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.w),
                              padding: EdgeInsets.all(5.r),
                              decoration: BoxDecoration(
                                gradient: ColorConstants.greenGradient,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 25.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    kHeight(30.h),
              
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 15.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.2),
                            offset: Offset(0, 0),
                            blurRadius: 14,
                            spreadRadius: -1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          kWidth(double.infinity),
                          kText(
                            text: 'Available Services',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          kHeight(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomePageWidgets.availableServiceItem(
                                  text: 'Cleaning', svgIcon: 'cleaning.svg'),
                              HomePageWidgets.availableServiceItem(
                                  text: 'Waste Disposal',
                                  svgIcon: 'waste_disposal.svg'),
                              HomePageWidgets.availableServiceItem(
                                  text: 'Plumbing', svgIcon: 'plumbing.svg'),
                              HomePageWidgets.availableServiceItem(
                                  text: 'Plumbing', svgIcon: 'plumbing.svg'),
                            ],
                          ),
                          kHeight(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomePageWidgets.availableServiceItem(
                                  text: 'Cleaning', svgIcon: 'cleaning.svg'),
                              HomePageWidgets.availableServiceItem(
                                  text: 'Waste Disposal',
                                  svgIcon: 'waste_disposal.svg'),
                              HomePageWidgets.availableServiceItem(
                                  text: 'Plumbing', svgIcon: 'plumbing.svg'),
                              GestureDetector(
                                onTap: () => context
                                    .goNamed(RouteNames.serviceListPage),
                                child: HomePageWidgets.availableServiceItem(
                                  text: 'See All',
                                  svgIcon: 'right_arrow.svg',
                                  greenText: true,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              
                    kHeight(30.h),
                    Row(
                      children: [
                        kText(
                          text: 'Cleaning Services',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () =>
                              context.goNamed(RouteNames.serviceListPage),
                          child: Row(
                            children: [
                              kText(
                                text: 'See All',
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: ColorConstants.greenColor,
                              ),
                              kWidth(5.w),
                              Icon(
                                Icons.navigate_next,
                                size: 20.r,
                                color: ColorConstants.greenColor,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    kHeight(20.h),
                    SingleChildScrollView(
                      clipBehavior: Clip.none,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            HomePageWidgets.cleaningServiceItem(
                                text: dummyProducts[i].title,
                                imageUrl: dummyProducts[i].imageUrl),
                          // HomePageWidgets.cleaningServiceItem(
                          //     text: 'Carpet Cleaning',
                          //     imageUrl:
                          //         'assets/images/services images/service2.png'),
                          // HomePageWidgets.cleaningServiceItem(
                          //     text: 'Sofa Cleaning',
                          //     imageUrl:
                          //         'assets/images/services images/service3.png'),
                        ],
                      ),
                    ),
                    kHeight(120.h),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: kustomBottomNavBar(context: context, index: 0),
            ),
          ],
        ),
      ),
    );
  }
}
