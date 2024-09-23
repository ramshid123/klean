import 'package:fpdart/fpdart.dart';
import 'package:klean/core/error/failure.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<KFailure, SuccessType>> call(Params params);
}
