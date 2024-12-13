import 'package:get_it/get_it.dart';
import 'package:idp/core/network/dio_client.dart';
import 'package:idp/data/repository/auth.dart';
import 'package:idp/data/source/auth_api_service.dart';
import 'package:idp/data/source/auth_local_service.dart';
import 'package:idp/domain/repository/auth.dart';
import 'package:idp/domain/usecases/get_user.dart';
import 'package:idp/domain/usecases/is_logged_in.dart';
import 'package:idp/domain/usecases/logout.dart';
import 'package:idp/domain/usecases/signin.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
}
