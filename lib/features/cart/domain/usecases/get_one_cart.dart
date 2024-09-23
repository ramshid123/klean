import 'package:fpdart/fpdart.dart';
import 'package:klean/core/entity/cart_entity.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/cart/domain/repository/repository.dart';

class UseCaseGetOneCart
    implements Usecase<CartEntity, UseCaseGetOneCartParams> {
  final CartRepository cartRepository;

  UseCaseGetOneCart(this.cartRepository);

  @override
  Future<Either<KFailure, CartEntity>> call(
      UseCaseGetOneCartParams params) async {
    return await cartRepository.getOneCart(id: params.id, uid: params.uid);
  }
}

class UseCaseGetOneCartParams {
  final String id;
  final String uid;

  UseCaseGetOneCartParams({required this.uid, required this.id});
}
