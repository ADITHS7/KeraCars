import "package:dio/dio.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:get_it/get_it.dart";
import "package:hive/hive.dart";
import "package:keracars_app/core/network/interceptors/exception_interceptor.dart";
import "package:keracars_app/core/network/interceptors/token_interceptor.dart";
import "package:keracars_app/core/network/service/services.dart";
import "package:keracars_app/core/security/token_service.dart";
import "package:keracars_app/core/storage/hive/hive_storage_service.dart";
import "package:keracars_app/core/storage/storage_service.dart";
import "package:keracars_app/features/app_start/presentation/cubit/app_start_cubit.dart";
import "package:keracars_app/features/auth/data/datasources/datasources.dart";
import "package:keracars_app/features/auth/data/repositories/auth_repository_impl.dart";
import "package:keracars_app/features/auth/domain/repositories/auth_repository.dart";
import "package:keracars_app/features/auth/domain/usecases/usecases.dart";
import "package:keracars_app/features/auth/presentation/blocs/blocs.dart";

Future<void> initDependencies() async {
  await initDio();

  Box box = await Hive.openBox("__main__");

  // storage
  GetIt.I.registerSingleton<StorageService>(HiveStorageService(box: box));

  // data sources
  GetIt.I.registerSingleton<AuthService>(AuthService(GetIt.I()));

  // repositories
  GetIt.I.registerSingleton<AuthRepository>(AuthRepositoryImpl(authService: GetIt.I()));

  await setupDio();

  // usecases
  GetIt.I.registerLazySingleton<GetOTPUseCase>(() => GetOTPUseCase(authRepository: GetIt.I()));
  GetIt.I.registerLazySingleton<LoginOTPUseCase>(() => LoginOTPUseCase(authRepository: GetIt.I()));
  GetIt.I.registerLazySingleton<CheckAuthenticationUseCase>(() => CheckAuthenticationUseCase(tokenService: GetIt.I()));
  GetIt.I.registerSingleton<AddAuthenticationUseCase>(AddAuthenticationUseCase(tokenService: GetIt.I()));
  GetIt.I.registerSingleton<RemoveAuthenticationUseCase>(RemoveAuthenticationUseCase(tokenService: GetIt.I(), authRepository: GetIt.I()));
  GetIt.I.registerLazySingleton<RegisterUserUseCase>(() => RegisterUserUseCase(authRepository: GetIt.I()));

  // blocs
  GetIt.I.registerFactory<AppStartCubit>(() => AppStartCubit());
  GetIt.I.registerSingleton<AuthBloc>(AuthBloc(GetIt.I(), GetIt.I(), GetIt.I()));
  GetIt.I.registerFactory<LoginBloc>(() => LoginBloc(GetIt.I()));
  GetIt.I.registerFactory<VerifyOtpBloc>(() => VerifyOtpBloc(GetIt.I()));
  GetIt.I.registerFactory<RegisterBloc>(() => RegisterBloc(GetIt.I()));
}

/// main dio
Future<void> initDio() async {
  DioService dioService = DioService(
    baseUrl: dotenv.get("API_SERVER_BASE_URL"),
    contentType: Headers.jsonContentType,
  );

  GetIt.I.registerSingleton<DioService>(dioService);
  GetIt.I.registerSingleton<Dio>(dioService.dio);
}

Future<void> setupDio() async {
  DioService dioService = GetIt.I<DioService>();

  // custom token storage
  Box box = await Hive.openBox("___TOKEN\$\$\$___");

  GetIt.I.registerSingleton<TokenService>(TokenService(
    dioService: dioService,
    authRepository: GetIt.I(),
    storageService: HiveStorageService(box: box),
  ));

  dioService.dio.interceptors.addAll([
    TokenInterceptor(
      dio: GetIt.I<Dio>(),
      tokenService: GetIt.I<TokenService>(),
    ),
    ExceptionInterceptor(dio: dioService.dio),
  ]);

  await GetIt.I.unregister<DioService>();
}
