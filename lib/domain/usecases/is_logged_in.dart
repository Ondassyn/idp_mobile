import 'package:idp/core/usecase/usecase.dart';
import 'package:idp/domain/repository/auth.dart';
import 'package:idp/service_locator.dart';

class IsLoggedInUseCase implements UseCase<bool, dynamic> {
  @override
  Future<bool> call({dynamic param}) async {
    return sl<AuthRepository>().isLoggedIn();
  }
}
