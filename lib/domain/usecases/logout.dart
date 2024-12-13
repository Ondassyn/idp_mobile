import 'package:dartz/dartz.dart';
import 'package:idp/core/usecase/usecase.dart';
import 'package:idp/domain/repository/auth.dart';
import 'package:idp/service_locator.dart';

class LogoutUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({param}) async {
    return await sl<AuthRepository>().logout();
  }
}
