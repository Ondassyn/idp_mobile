import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:idp/core/constants/api_urls.dart';
import 'package:idp/core/network/dio_client.dart';
import 'package:idp/data/models/signin_req_params.dart';
import 'package:idp/service_locator.dart';

abstract class AuthApiService {
  Future<Either> signin(SigninReqParams signinReq);
  Future<Either> getUser();
}

class AuthApiServiceImpl extends AuthApiService {
  @override
  Future<Either> signin(SigninReqParams signinReq) async {
    try {
      var response =
          await sl<DioClient>().post(ApiUrls.signin, data: signinReq.toMap());

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      var response = await sl<DioClient>().get(
        ApiUrls.userAccount,
      );

      return Right(response);
    } on DioException catch (e) {
      return Left(e.response!.data['message']);
    }
  }
}
