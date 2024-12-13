import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:idp/core/constants/api_urls.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This interceptor is used to show request and response logs
class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true));

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request ==> $requestPath'); //Error log
    logger.d('Error type: ${err.error} \n '
        'Error message: ${err.message}'); //Debug log
    handler.next(err); //Continue with the Error
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request ==> $requestPath'); //Info log
    handler.next(options); // continue with the Request
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('STATUSCODE: ${response.statusCode} \n '
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'HEADERS: ${response.headers} \n'
        'Data: ${response.data}'); // Debug log
    handler.next(response); // continue with the Response
  }
}

class TokenInterceptor extends Interceptor {
  Dio dio = Dio(BaseOptions(baseUrl: ApiUrls.baseURL));

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('access');

    if (token != null) {
      options.headers.addAll({
        "Authorization": "Bearer $token",
      });
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      await refreshToken();
      try {
        handler.resolve(await _retry(err.requestOptions));
      } on DioException catch (e) {
        handler.next(e);
      }
      return;
    }
    handler.next(err);
  }

  Future<Response<dynamic>> refreshToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('refresh');

    // var response = await sl<DioClient>().get(
    //     ApiUrls.refreshTokenUrl,
    //     options: Options(
    //       headers: {
    //         'Authorization' : 'Bearer $token'
    //       }
    //     )
    //   );

    var response = await dio.post(ApiUrls.refreshTokenUrl,
        data: jsonEncode({'refresh': token}));

    if (response.statusCode == 200) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('access', response.data['access']);
      sharedPreferences.setString('refresh', response.data['refresh']);
    }
    return response;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString('token');

    final options = Options(
      method: requestOptions.method,
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
