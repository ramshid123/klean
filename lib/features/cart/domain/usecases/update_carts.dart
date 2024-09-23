import 'package:fpdart/src/either.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/cart/data/models/cart_model.dart';
import 'package:klean/features/cart/domain/repository/repository.dart';

class UseCaseUpdateCarts implements Usecase<void, UseCaseUpdateCartsParams> {
  final CartRepository cartRepository;

  UseCaseUpdateCarts(this.cartRepository);

  @override
  Future<Either<KFailure, void>> call(UseCaseUpdateCartsParams params) async {
    return await cartRepository.updateCarts(
        uid: params.uid, cartList: params.cartList);
  }
}

class UseCaseUpdateCartsParams {
  final String uid;
  final List<CartEntity> cartList;

  UseCaseUpdateCartsParams({required this.uid, required this.cartList});
}
