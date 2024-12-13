import 'package:dartz/dartz.dart';
import 'package:idp/core/usecase/usecase.dart';
import 'package:idp/domain/repository/auth.dart';
import 'package:idp/service_locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic param}) {
    return sl<AuthRepository>().getUser();
  }
}
