import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/exception.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/features/auth/data/data%20source/remote_data_source.dart';
import 'package:klean/features/auth/data/models/user_model.dart';
import 'package:klean/core/entity/user_entity.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<KFailure, void>> loginWithGoogle() async {
    try {
      final user = await authRemoteDataSource.loginWithGoogle();
      final userModel = UserModel(
          name: user.user!.displayName ?? 'User',
          email: user.user!.email ?? '',
          phoneNo: user.user!.phoneNumber ?? '',
          uid: user.user!.uid);

      if (await authRemoteDataSource.getCurrentUser() == null) {
        await authRemoteDataSource.registerUser(userModel);
      }
      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, String>> loginWithPhone(String phoneNo) async {
    try {
      final verificationId = await authRemoteDataSource.loginWithPhone(phoneNo);
      return right(verificationId);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, UserEntity?>> getCurrentUser() async {
    try {
      final response = await authRemoteDataSource.getCurrentUser();
      if (response == null) {
        return right(null);
      } else {
        return right(response);
      }
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> logOut() async {
    try {
      await authRemoteDataSource.logOut();
      return right(null);
    } on KustomException catch (e) {
      log(e.error);
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> verifyOtp(
      {required String otp, required String verificationId}) async {
    try {
      final user = await authRemoteDataSource.verifyOtp(
          otp: otp, verificationId: verificationId);

      await authRemoteDataSource.registerUser(UserModel(
          name: '',
          email: user.user!.email ?? '',
          phoneNo: user.user!.phoneNumber ?? '',
          uid: user.user == null
              ? DateTime.now().millisecondsSinceEpoch.toString()
              : user.user!.uid));
      return right(null);
    } on KustomException catch (e) {
      log(e.error);
      return left(KFailure(e.error));
    }
  }

  @override
  Future<Either<KFailure, void>> updateBio(
      {required String name, String email = '', String phoneNo = ''}) async {
    try {
      await authRemoteDataSource.updateBio(
          name: name, email: email, phoneNo: phoneNo);

      return right(null);
    } on KustomException catch (e) {
      return left(KFailure(e.error));
    }
  }
}
