import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/core/entity/user_entity.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class UseCaseGetCurrentUser
    implements Usecase<UserEntity?, UseCaseGetCurrentUserParams> {
  final AuthRepository authRepository;

  UseCaseGetCurrentUser(this.authRepository);

  @override
  Future<Either<KFailure, UserEntity?>> call(params) async {
    return await authRepository.getCurrentUser();
  }
}

class UseCaseGetCurrentUserParams {}
