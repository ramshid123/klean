import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:klean/core/constants/dummy/products.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/providers/user.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/presentation/pages/cart%20page/cart_page_widgets.dart';
import 'package:klean/features/cart/presentation/provider/cart_provider.dart';

class CartPage extends ConsumerStatefulWidget {
  final String parentRoute;
  CartPage({super.key, required this.parentRoute});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final FocusNode couponFieldFocusNode = FocusNode();

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
    final totalAmount = ref.watch(cartTotalProvider);
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (a, b) {
        context.goNamed(widget.parentRoute);
      },
      child: GestureDetector(
        onTap: () => couponFieldFocusNode.unfocus(),
        child: Scaffold(
          backgroundColor: ColorConstants.bgColor,
          appBar: PreferredSize(
            preferredSize: Size(50.h, size.width),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
              color: ColorConstants.bgColor,
              child: SafeArea(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.goNamed(widget.parentRoute),
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
                      text: 'Cart',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: SingleChildScrollView(
                  clipBehavior: Clip.none,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      kHeight(5.h),
                      if (productsInCart.isEmpty)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 30.h),
                            child: kText(
                              text: 'Your cart is empty',
                              fontSize: 20,
                              color: const Color(0xff333333),
                            ),
                          ),
                        )
                      else
                        for (int i = 0; i < productsInCart.length; i++)
                          CartPageWidgets.cartItem(
                            index: i,
                            ref: ref,
                            productsInCart: productsInCart,
                            uid: uid,
                          ),
                      kHeight(5.h),
                      kText(
                        text: 'Add more Services',
                        color: ColorConstants.greenColor,
                        fontWeight: FontWeight.w600,
                      ),
                      kHeight(20.h),
                      kText(
                        text: 'Frequently added services',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      kHeight(10.h),
                      SingleChildScrollView(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var prdct in dummyProducts.where((product) =>
                                !productsInCart
                                    .map((e) => e.id)
                                    .toList()
                                    .contains(product.id)))
                              CartPageWidgets.frequentServiceItem(
                                product: prdct,
                                productsInCart: productsInCart,
                                ref: ref,
                                uid: uid,
                              ),
                          ],
                        ),
                      ),
                      kHeight(25.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 1.r),
                          borderRadius: BorderRadius.circular(11.r),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.1),
                              offset: Offset(0, 0),
                              blurRadius: 14,
                              spreadRadius: -1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                ),
                                color: Colors.black12,
                              ),
                              child: kText(
                                text: 'Coupon Code',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff444444),
                              ),
                            ),
                            kHeight(20.h),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.r),
                                border: Border.all(
                                  color: Colors.black12,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15.w),
                                child: TextFormField(
                                  focusNode: couponFieldFocusNode,
                                  cursorColor: ColorConstants.greenColor,
                                  style: GoogleFonts.nunito(
                                    fontSize: 17.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                        gradient: ColorConstants.greenGradient,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          kText(
                                            text: 'Apply',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                    hintText: 'Enter Coupon Code',
                                    hintStyle: GoogleFonts.nunito(
                                      fontSize: 13.sp,
                                      color: Colors.black38,
                                    ),
                                    // label: kText(
                                    //   text: 'Enter Coupon Code',
                                    //   color: Colors.black38,
                                    //   fontWeight: FontWeight.w600,
                                    //   fontSize: 13,
                                    // ),
                                    // labelStyle: GoogleFonts.nunito(
                                    //   fontSize: 1.sp,
                                    //   color: Colors.black38,
                                    // ),
                                    border: UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            kHeight(20.h),
                          ],
                        ),
                      ),
                      kHeight(20.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              gradient: ColorConstants.greenGradient,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 20.r,
                            ),
                          ),
                          kWidth(10.w),
                          Expanded(
                            child: kText(
                              text:
                                  'Your wallet balance is ₹125, you can redeem ₹10 in this order.',
                              maxLines: 2,
                              fontSize: 12,
                              color: const Color(0xff929292),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      kHeight(20.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 1.r),
                          borderRadius: BorderRadius.circular(11.r),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF000000).withOpacity(0.1),
                              offset: Offset(0, 0),
                              blurRadius: 14,
                              spreadRadius: -1,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                ),
                                color: Colors.black12,
                              ),
                              child: kText(
                                text: 'Bill Details',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xff444444),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.w, vertical: 20.h),
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i < productsInCart.length;
                                      i++)
                                    CartPageWidgets.billTextItem(
                                      name: productsInCart[i].title,
                                      price:
                                          '${productsInCart[i].price * productsInCart[i].counts}',
                                    ),
                                  // CartPageWidgets.billTextItem(
                                  //   name: 'Fan Cleaning',
                                  //   price: '499',
                                  // ),
                                  CartPageWidgets.billTextItem(
                                    name: 'Taxes and Fees',
                                    price: '${productsInCart.isEmpty ? 0 : 50}',
                                  ),
                                  CartPageWidgets.billTextItem(
                                    name: 'Coupon Code',
                                    price:
                                        '${productsInCart.isEmpty ? 0 : 150}',
                                    isCoupon: true,
                                  ),
                                  kHeight(10.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (int i = 0; i < 30; i++)
                                        Container(
                                          height: 1.h,
                                          width: 5.w,
                                          color: const Color(0xff555555),
                                        ),
                                    ],
                                  ),
                                  kHeight(10.h),
                                  Row(
                                    children: [
                                      kText(
                                        text: 'Total',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      const Spacer(),
                                      kText(
                                        text:
                                            '₹${productsInCart.isEmpty ? 0 : totalAmount + 100}',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      kHeight(150.h),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 25.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF000000).withOpacity(0.3),
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
                          text: 'Grand Total  |  ₹ ${totalAmount + 100}',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: ColorConstants.greenGradient,
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
                              text: 'Book Slot',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
