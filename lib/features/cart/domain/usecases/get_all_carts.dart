import 'package:fpdart/fpdart.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/cart/domain/repository/repository.dart';

class UseCaseGetAllCarts
    implements Usecase<List<CartEntity>, UseCaseGetAllCartsParams> {
  final CartRepository cartRepository;

  UseCaseGetAllCarts(this.cartRepository);

  @override
  Future<Either<KFailure, List<CartEntity>>> call(
      UseCaseGetAllCartsParams params) async {
    return await cartRepository.getCartsList(params.uid);
  }
}

class UseCaseGetAllCartsParams {
  final String uid;

  UseCaseGetAllCartsParams({required this.uid});
}
