import 'package:fpdart/fpdart.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/features/cart/data/models/cart_model.dart';

abstract interface class CartRepository {
  Future<Either<KFailure, CartEntity>> getOneCart(
      {required String id, required String uid});

  Future<Either<KFailure, List<CartEntity>>> getCartsList(String uid);

  Future<Either<KFailure, void>> updateCarts({required String uid, required List<CartEntity> cartList});
}
