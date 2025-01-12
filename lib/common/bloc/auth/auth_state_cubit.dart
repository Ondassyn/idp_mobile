import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp/common/bloc/auth/auth_state.dart';
import 'package:idp/domain/usecases/is_logged_in.dart';
import 'package:idp/service_locator.dart';

class AuthStateCubit extends Cubit<AuthState> {
  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }
}
