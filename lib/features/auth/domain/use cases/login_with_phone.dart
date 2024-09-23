import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class UseCaseLoginWithPhone
    implements Usecase<String, UseCaseLoginWithPhoneParams> {
  final AuthRepository authRepository;

  UseCaseLoginWithPhone(this.authRepository);

  @override
  Future<Either<KFailure, String>> call(params) async {
    return await authRepository.loginWithPhone(params.phoneNo);
  }
}

class UseCaseLoginWithPhoneParams {
  final String phoneNo;

  UseCaseLoginWithPhoneParams({required this.phoneNo});
}
