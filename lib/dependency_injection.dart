import 'package:clean_app/core/network/dio_client.dart';
import 'package:clean_app/core/secure_storage/token_storage.dart';
import 'package:clean_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:clean_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:clean_app/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_app/features/auth/domain/usecases/auth_usecases.dart';
import 'package:clean_app/features/auth/view/bloc/auth_bloc.dart';
import 'package:clean_app/features/products/data/datasource/product_datasource.dart';
import 'package:clean_app/features/products/data/repository/product_repository_impl.dart';
import 'package:clean_app/features/products/domain/repository/product_repository.dart';
import 'package:clean_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:clean_app/features/products/view/bloc/products_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {

  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(const FlutterSecureStorage()));
  sl.registerLazySingleton<Dio>(() => createDio(sl()));

  sl.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => CheckAuthUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl()));

  sl.registerLazySingleton<ProductDatasource>(
    () => ProductDatasourceImpl(sl())
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl())
  );

  sl.registerLazySingleton(() => GetProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetProductsByIdUsecase(sl()));

  sl.registerFactory(() => ProductsBloc(sl()));
}
