part of 'injection_container.imports.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _cacheAndImagePickerInit();
  _authInit();
}

Future<void> _cacheAndImagePickerInit() async {
  final preferences = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => CacheHelper(sl()))
    ..registerLazySingleton(() => preferences)
    ..registerLazySingleton(ImagePicker.new);
}

void _authInit() {
  // bloc
  sl
    ..registerFactory(
      () => AuthBloc(
        registerUser: sl(),
        login: sl(),
        verifyOtp: sl(),
        sendForgotPasswordRequest: sl(),
        changePasswordForgot: sl(),
        getNewTokens: sl(),
      ),
    )
    // usecase
    ..registerLazySingleton(() => RegisterUser(sl()))
    ..registerLazySingleton(() => Login(sl()))
    ..registerLazySingleton(() => VerifyOtp(sl()))
    ..registerLazySingleton(() => SendForgotPasswordRequest(sl()))
    ..registerLazySingleton(() => ChangePasswordForgot(sl()))
    ..registerLazySingleton(() => GetNewTokens(sl()))
    //repository
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()))
    // datasources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDatasourceImpl(sl()),
    )
    // external dependencies
    ..registerLazySingleton(Dio.new);
}
