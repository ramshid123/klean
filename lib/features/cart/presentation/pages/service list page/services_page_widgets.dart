
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/entity/product_entity.dart';
import 'package:klean/core/theme/palette.dart';
import 'package:klean/core/widgets/common.dart';
import 'package:klean/features/cart/presentation/provider/cart_provider.dart';

class ServicesPageWidgets {
  static Widget filterSelectorItem({
    required String text,
    bool isSelected = false,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: isSelected
            ? ColorConstants.greenGradient
            : const LinearGradient(
                colors: [Colors.transparent, Colors.transparent]),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: kText(
        text: text,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }

  static Widget itemContainer({
    required ProductEntity product,
    // int numInCart = 0,
    required String uid,
    required WidgetRef ref,
    required List<CartEntity> productsInCart,
  }) {
    final cartItem = productsInCart.where((p) => p.id == product.id).isEmpty
        ? CartEntity.fromProduct(product)
        : productsInCart.where((p) => p.id == product.id).first;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.1),
            offset: const Offset(0, 0),
            blurRadius: 14,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    // 'assets/images/services images/service3.png',
                    product.imageUrl,
                    fit: BoxFit.cover,
                    height: 80.h,
                    width: 85.w,
                  ),
                ),
                kWidth(15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 15.r,
                        ),
                        kText(
                          text:
                              '(${product.rating}/5) ${product.orders} Orders',
                          color: Colors.black45,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    kText(
                      text: product.title,
                      fontWeight: FontWeight.w600,
                    ),
                    kText(
                      text: '${product.minutes} Minutes',
                      fontSize: 12,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                    kText(
                      text: '₹ ${product.price}',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
            decoration: BoxDecoration(
              // color: Colors.black12,
              gradient: cartItem.counts > 0
                  ? const LinearGradient(colors: [Colors.black12, Colors.black12])
                  : ColorConstants.greenGradient,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(13.r),
                topLeft: Radius.circular(13.r),
              ),
            ),
            child: cartItem.counts > 0
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () =>
                            ref.read(cartNotifierProvider.notifier).updateKarts(
                                  cartList: productsInCart
                                          .map((p) => p.id)
                                          .toList()
                                          .contains(cartItem.id)
                                      ? productsInCart
                                      : [...productsInCart, cartItem],
                                  count: cartItem.counts > 0
                                      ? cartItem.counts - 1
                                      : 0,
                                  id: cartItem.id,
                                  uid: uid,
                                ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: Icon(
                            Icons.remove,
                            size: 15.r,
                            color: ColorConstants.greenColor,
                          ),
                        ),
                      ),
                      kText(
                        text: cartItem.counts.toString(),
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.greenColor,
                      ),
                      GestureDetector(
                        onTap: () =>
                            ref.read(cartNotifierProvider.notifier).updateKarts(
                                  cartList: ref.watch(cartNotifierProvider),
                                  count: cartItem.counts + 1,
                                  id: cartItem.id,
                                  uid: uid,
                                ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Icon(
                            Icons.add,
                            size: 15.r,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  )
                : GestureDetector(
                    onTap: () =>
                        ref.read(cartNotifierProvider.notifier).updateKarts(
                              cartList: productsInCart
                                      .map((p) => p.id)
                                      .toList()
                                      .contains(cartItem.id)
                                  ? productsInCart
                                  : [...productsInCart, cartItem],
                              count: cartItem.counts + 1,
                              id: cartItem.id,
                              uid: uid,
                            ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        kText(
                          text: 'Add',
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                        kWidth(5.w),
                        Icon(
                          Icons.add,
                          size: 15.r,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
