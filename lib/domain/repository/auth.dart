import 'package:dartz/dartz.dart';
import 'package:idp/data/models/signin_req_params.dart';

abstract class AuthRepository {
  Future<Either> signin(SigninReqParams signinReq);
  Future<bool> isLoggedIn();
  Future<Either> getUser();
  Future<Either> logout();
}
