import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class UseCaseLoginWithGoogle
    implements Usecase<void, UseCaseLoginWithGoogleParams> {
  final AuthRepository authRepository;

  UseCaseLoginWithGoogle(this.authRepository);

  @override
  Future<Either<KFailure, void>> call(params) async {
    return await authRepository.loginWithGoogle();
  }
}

class UseCaseLoginWithGoogleParams {}
