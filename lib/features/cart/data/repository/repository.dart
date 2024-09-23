import 'package:fpdart/fpdart.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/error/exception.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/features/cart/data/data%20source/cart_remote_datasource.dart';
import 'package:klean/features/cart/data/models/cart_model.dart';
import 'package:klean/features/cart/domain/repository/repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartRemoteDatasource cartRemoteDatasource;

  CartRepositoryImpl(this.cartRemoteDatasource);

  @override
  Future<Either<KFailure, CartModel>> getOneCart(
      {required String id, required String uid}) async {
    try {
      final response = await cartRemoteDatasource.getOneCart(id: id, uid: uid);

      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, List<CartModel>>> getCartsList(String uid) async {
    try {
      final response = await cartRemoteDatasource.getCarts(uid: uid);
      return right(response);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> updateCarts(
      {required String uid, required List<CartEntity> cartList}) async {
    try {
      final cartModelList =
          cartList.map((cart) => CartModel.fromEntity(cart)).toList();
      await cartRemoteDatasource.updateCarts(uid: uid, carts: cartModelList);
      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }
}
