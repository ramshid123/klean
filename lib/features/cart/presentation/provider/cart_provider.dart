import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/features/cart/domain/usecases/get_all_carts.dart';
import 'package:klean/features/cart/domain/usecases/get_one_cart.dart';
import 'package:klean/features/cart/domain/usecases/update_carts.dart';
import 'package:klean/init_dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_provider.g.dart';

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, List<CartEntity>>(
        (ref) => serviceLocator());

class CartNotifier extends StateNotifier<List<CartEntity>> {
  final UseCaseGetOneCart _useCaseGetOneCart;
  final UseCaseGetAllCarts _useCaseGetAllCarts;
  final UseCaseUpdateCarts _useCaseUpdateCarts;

  CartNotifier({
    required UseCaseGetOneCart usecaseGetOneCart,
    required UseCaseGetAllCarts useCaseGetAllCarts,
    required UseCaseUpdateCarts useCaseUpdateCarts,
  })  : _useCaseGetOneCart = usecaseGetOneCart,
        _useCaseGetAllCarts = useCaseGetAllCarts,
        _useCaseUpdateCarts = useCaseUpdateCarts,
        super(<CartEntity>[]);

  Future<CartEntity?> getEachCart({
    required String uid,
    required String id,
  }) async {
    final response =
        await _useCaseGetOneCart(UseCaseGetOneCartParams(id: id, uid: uid));
    CartEntity? product;

    response.fold(
      (l) {
        product = null;
      },
      (r) {
        product = r;
      },
    );
    return product;
  }

  void getAllKarts({required String uid}) async {
    final response =
        await _useCaseGetAllCarts(UseCaseGetAllCartsParams(uid: uid));

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        state = r;
      },
    );
  }

  Future updateKarts({
    required String uid,
    required List<CartEntity> cartList,
    required String id,
    required int count,
  }) async {
    final carts = cartList.map(
      (cart) {
        if (cart.id == id) {
          return cart.copyWith(counts: count);
        } else {
          return cart;
        }
      },
    ).toList();

    final response = await _useCaseUpdateCarts(
        UseCaseUpdateCartsParams(uid: uid, cartList: carts));

    response.fold(
      (l) {
        log(l.message);
      },
      (r) {
        state = [
          ...carts,
        ];
      },
    );
  }
}

@riverpod
int cartTotal(ref) {
  List<CartEntity> cartProducts = ref.watch(cartNotifierProvider);
  int total = 0;
  for (var product in cartProducts) {
    total += (product.price * product.counts).toInt();
  }
  return total;
}
