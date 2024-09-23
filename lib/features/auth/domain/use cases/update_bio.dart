import 'package:fpdart/src/either.dart';
import 'package:klean/core/error/failure.dart';
import 'package:klean/core/use%20case/usecase.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';

class UseCaseUpdateBio implements Usecase<void, UseCaseUpdateBioParams> {
  final AuthRepository authRepository;

  UseCaseUpdateBio(this.authRepository);

  @override
  Future<Either<KFailure, void>> call(UseCaseUpdateBioParams params) async {
    return await authRepository.updateBio(
        name: params.name, email: params.email, phoneNo: params.phoneNo);
  }
}

class UseCaseUpdateBioParams {
  final String name;
  final String email;
  final String phoneNo;

  UseCaseUpdateBioParams(
      {required this.name, this.email = '', this.phoneNo = ''});
}
