import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:klean/core/constants/dummy/products.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/providers/user.dart';
import 'package:klean/core/routes/route_names.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/pages/service%20list%20page/services_page_widgets.dart';
import 'package:klean/features/cart/presentation/provider/cart_provider.dart';

class ServicesPage extends ConsumerStatefulWidget {
  const ServicesPage({super.key});

  @override
  ConsumerState<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends ConsumerState<ServicesPage> {
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
    final productsInCart = ref.watch(cartNotifierProvider);
    final totalAmount = ref.watch(cartTotalProvider);
    return Scaffold(
      backgroundColor: ColorConstants.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                kHeight(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.goNamed(RouteNames.homePage),
                        child: Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.navigate_before,
                            color: Colors.black,
                            size: 25.r,
                          ),
                        ),
                      ),
                      kWidth(20.w),
                      kText(
                        text: 'Cleaning Services',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                kHeight(20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: ColorConstants.liteGreenColor,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        kWidth(10.w),
                        ServicesPageWidgets.filterSelectorItem(
                            text: 'Deep Cleaning'),
                        ServicesPageWidgets.filterSelectorItem(
                            text: 'Maid Services', isSelected: true),
                        ServicesPageWidgets.filterSelectorItem(
                            text: 'Car Cleaning'),
                        ServicesPageWidgets.filterSelectorItem(
                            text: 'Carpet Cleaning'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: dummyProducts.length,
                    itemBuilder: (context, index) {
                      return index == dummyProducts.length - 1
                          ? kHeight(130.h)
                          : ServicesPageWidgets.itemContainer(
                              product: dummyProducts[index],
                              uid: ref.read(currentUserNotifierProvider)!.uid,
                              productsInCart: productsInCart,
                              ref: ref,
                            );
                    },
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF000000).withOpacity(0.5),
                      offset: Offset(0, 0),
                      blurRadius: 14,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 13.h),
                      child: kText(
                        text: '2 items  |  ₹$totalAmount',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.goNamed(RouteNames.cartPage,
                          extra: RouteNames.serviceListPage),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: ColorConstants.orangeColor,
                        ),
                        child: Row(
                          children: [
                            kWidth(10.w),
                            Icon(
                              Icons.arrow_right,
                              size: 25.r,
                              color: Colors.transparent,
                            ),
                            const Spacer(),
                            kText(
                              text: 'VIEW CART',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            const Spacer(),
                            Icon(
                              Icons.arrow_right,
                              size: 25.r,
                              color: Colors.white,
                            ),
                            kWidth(10.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
