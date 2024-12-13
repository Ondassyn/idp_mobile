import 'package:dartz/dartz.dart';
import 'package:idp/core/usecase/usecase.dart';
import 'package:idp/data/models/signin_req_params.dart';
import 'package:idp/domain/repository/auth.dart';
import 'package:idp/service_locator.dart';

class SigninUseCase implements UseCase<Either, SigninReqParams> {
  @override
  Future<Either> call({SigninReqParams? param}) {
    return sl<AuthRepository>().signin(param!);
  }
}
