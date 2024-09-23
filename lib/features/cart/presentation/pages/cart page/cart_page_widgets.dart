import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/entity/product_entity.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/cart/presentation/provider/cart_provider.dart';

class CartPageWidgets {
  static Widget cartItem({
    required int index,
    required List<CartEntity> productsInCart,
    required String uid,
    required WidgetRef ref,
  }) {
    final cartItem = productsInCart[index];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          kText(
            text: '${index + 1}.',
            color: const Color(0xff444444),
            fontWeight: FontWeight.w600,
          ),
          kWidth(8.w),
          Expanded(
            flex: 7,
            child: kText(
              text: cartItem.title,
              color: const Color(0xff444444),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => ref
                      .read(cartNotifierProvider.notifier)
                      .updateKarts(
                        cartList: productsInCart
                                .map((p) => p.id)
                                .toList()
                                .contains(cartItem.id)
                            ? productsInCart
                            : [...productsInCart, cartItem],
                        count: cartItem.counts > 0 ? cartItem.counts - 1 : 0,
                        id: cartItem.id,
                        uid: uid,
                      ),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 14.r,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.r),
                  child: kText(
                    text: '${cartItem.counts}',
                    color: Colors.black45,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      ref.read(cartNotifierProvider.notifier).updateKarts(
                            cartList: ref.watch(cartNotifierProvider),
                            count: cartItem.counts + 1,
                            id: cartItem.id,
                            uid: uid,
                          ),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 14.r,
                    ),
                  ),
                ),
              ],
            ),
          ),
          kWidth(20.w),
          Expanded(
            flex: 3,
            child: kText(
              text: '₹${(cartItem.counts * cartItem.price).toInt()}',
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: const Color(0xff444444),
            ),
          ),
        ],
      ),
    );
  }

  static Widget frequentServiceItem({
    required List<CartEntity> productsInCart,
    required String uid,
    required WidgetRef ref,
    required ProductEntity product,
  }) {
    return Container(
      margin: EdgeInsets.only(right: 15.w),
      width: 130.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 14,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            child: Image.asset(
              product.imageUrl,
              height: 125.h,
              width: 130.w,
              fit: BoxFit.cover,
            ),
          ),
          kHeight(5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kText(
                  // text: 'Bathroom Cleaning',
                  text: product.title,
                  fontSize: 12,
                  maxLines: 2,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff333333),
                ),
                kHeight(5.h),
                Row(
                  children: [
                    kText(
                      text: '₹${product.price.toInt()}',
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () =>
                      ref.read(cartNotifierProvider.notifier).updateKarts(
                            cartList: ref.watch(cartNotifierProvider),
                            count:  1,
                            id: product.id,
                            uid: uid,
                          ),
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        decoration: const BoxDecoration(
                          gradient: ColorConstants.greenGradient,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 15.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          kHeight(10.h),
        ],
      ),
    );
  }

  static Widget billTextItem({
    required String name,
    required String price,
    bool isCoupon = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        children: [
          kText(
            text: name,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: const Color(0xff444444),
          ),
          const Spacer(),
          kText(
            text: isCoupon ? '- ₹$price' : '₹$price',
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color:
                isCoupon ? ColorConstants.greenColor : const Color(0xff444444),
          ),
        ],
      ),
    );
  }
}
