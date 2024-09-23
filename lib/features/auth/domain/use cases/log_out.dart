import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class UseCaseLogout implements Usecase<void, UseCaseLogoutParams> {
  final AuthRepository authRepository;

  UseCaseLogout(this.authRepository);

  @override
  Future<Either<KFailure, void>> call(params) async {
    return await authRepository.logOut();
  }
}

class UseCaseLogoutParams {}
