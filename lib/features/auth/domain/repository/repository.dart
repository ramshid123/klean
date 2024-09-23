import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/entity/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<KFailure, void>> loginWithGoogle();

  Future<Either<KFailure, String>> loginWithPhone(String phoneNo);

  Future<Either<KFailure, UserEntity?>> getCurrentUser();

  Future<Either<KFailure, void>> verifyOtp(
      {required String otp, required String verificationId});

  Future<Either<KFailure, void>> logOut();

  Future<Either<KFailure, void>> updateBio(
      {required String name, String email = '', String phoneNo = ''});
}
