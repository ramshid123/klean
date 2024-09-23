
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:klean/features/auth/data/data%20source/remote_data_source.dart';
import 'package:klean/features/auth/data/repository/repository.dart';
import 'package:klean/features/auth/domain/repository/repository.dart';
import 'package:klean/features/auth/domain/use%20cases/get_current_user.dart';
import 'package:klean/features/auth/domain/use%20cases/log_out.dart';
import 'package:klean/features/auth/domain/use%20cases/login_with_google.dart';
import 'package:klean/features/auth/domain/use%20cases/login_with_phone.dart';
import 'package:klean/features/auth/domain/use%20cases/update_bio.dart';
import 'package:klean/features/auth/domain/use%20cases/verify_otp.dart';
import 'package:klean/features/auth/presentation/provider/usecase_providers.dart';
import 'package:klean/features/cart/data/data%20source/cart_remote_datasource.dart';
import 'package:klean/features/cart/data/repository/repository.dart';
import 'package:klean/features/cart/domain/repository/repository.dart';
import 'package:klean/features/cart/domain/usecases/get_all_carts.dart';
import 'package:klean/features/cart/domain/usecases/get_one_cart.dart';
import 'package:klean/features/cart/domain/usecases/update_carts.dart';
import 'package:klean/features/cart/presentation/provider/cart_provider.dart';

final serviceLocator = GetIt.instance;

Future initDependencies() async {
  final firestoreInstance = FirebaseFirestore.instance;
  final authInstance = FirebaseAuth.instance;

  serviceLocator.registerLazySingleton(() => firestoreInstance);
  serviceLocator.registerLazySingleton(() => authInstance);

  initAuth();
  initCart();


}

void initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
        authInstance: serviceLocator(), firestoreInstance: serviceLocator()))
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UseCaseLoginWithGoogle(serviceLocator()))
    ..registerFactory(() => UseCaseLoginWithPhone(serviceLocator()))
    ..registerFactory(() => UseCaseGetCurrentUser(serviceLocator()))
    ..registerFactory(() => UseCaseLogout(serviceLocator()))
    ..registerFactory(() => UseCaseUpdateBio(serviceLocator()))
    ..registerFactory(() => UseCaseVerifyOtp(serviceLocator()))
    ..registerLazySingleton(() => LoginPageNotifier(
          useCaseGetCurrentUser: serviceLocator(),
          useCaseVerifyOtp: serviceLocator(),
          useCaseUpdateBio: serviceLocator(),
          useCaseLoginWithGoogle: serviceLocator(),
          useCaseLoginWithPhone: serviceLocator(),
          useCaseLogout: serviceLocator(),
        ));
}

void initCart() {
  serviceLocator
    ..registerFactory<CartRemoteDatasource>(
        () => CartRemoteDatasourceImpl(serviceLocator()))
    ..registerFactory<CartRepository>(
        () => CartRepositoryImpl(serviceLocator()))
    ..registerFactory(() => UseCaseGetOneCart(serviceLocator()))
    ..registerFactory(() => UseCaseGetAllCarts(serviceLocator()))
    ..registerFactory(() => UseCaseUpdateCarts(serviceLocator()))
    ..registerLazySingleton(() => CartNotifier(
          useCaseGetAllCarts: serviceLocator(),
          useCaseUpdateCarts: serviceLocator(),
          usecaseGetOneCart: serviceLocator(),
        ));
}
