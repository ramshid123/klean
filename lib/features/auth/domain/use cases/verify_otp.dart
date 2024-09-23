import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class UseCaseVerifyOtp implements Usecase<void, UseCaseVerifyOtpParams> {
  final AuthRepository authRepository;

  UseCaseVerifyOtp(this.authRepository);

  @override
  Future<Either<KFailure, void>> call(params) async {
    return await authRepository.verifyOtp(
        otp: params.otp, verificationId: params.verificationId);
  }
}

class UseCaseVerifyOtpParams {
  final String otp;
  final String verificationId;

  UseCaseVerifyOtpParams({required this.verificationId, required this.otp});
}
