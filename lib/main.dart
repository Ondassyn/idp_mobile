import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp/common/bloc/auth/auth_state.dart';
import 'package:idp/common/bloc/auth/auth_state_cubit.dart';
import 'package:idp/core/configs/theme/app_theme.dart';
import 'package:idp/presentation/auth/pages/signin.dart';
import 'package:idp/presentation/home/pages/home.dart';
import 'package:idp/service_locator.dart';
import 'package:logger/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black));
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return BlocProvider(
      create: (context) => AuthStateCubit()..appStarted(),
      child: MaterialApp(
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthStateCubit, AuthState>(
          builder: (context, state) {
            var logger = Logger();
            logger.log(Level.trace, 'STATE: $state');
            if (state is Authenticated) {
              return const HomePage();
            }
            if (state is UnAuthenticated) {
              return SigninPage();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
