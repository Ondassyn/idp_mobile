import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp/common/bloc/button/button_state.dart';
import 'package:idp/common/bloc/button/button_state_cubit.dart';
import 'package:idp/common/widgets/button/basic_app_button.dart';
import 'package:idp/data/models/signin_req_params.dart';
import 'package:idp/presentation/home/pages/home.dart';
import 'package:idp/domain/usecases/signin.dart';
import 'package:idp/service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _usernameCon = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ButtonStateCubit(),
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            }
            if (state is ButtonFailureState) {
              var snackBar = SnackBar(content: Text(state.errorMessage));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: SafeArea(
            minimum: const EdgeInsets.only(top: 100, right: 16, left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _signin(),
                const SizedBox(
                  height: 50,
                ),
                _usernameField(),
                const SizedBox(
                  height: 20,
                ),
                _password(),
                const SizedBox(
                  height: 60,
                ),
                _createAccountButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signin() {
    return const Text(
      'Sign In',
      style: TextStyle(
          color: Color(0xff2A4ECA), fontWeight: FontWeight.bold, fontSize: 32),
    );
  }

  Widget _usernameField() {
    return TextField(
      controller: _usernameCon,
      decoration: const InputDecoration(hintText: 'Email'),
    );
  }

  Widget _password() {
    return TextField(
      controller: _passwordCon,
      decoration: const InputDecoration(hintText: 'Password'),
    );
  }

  Widget _createAccountButton(BuildContext context) {
    return Builder(builder: (context) {
      return BasicAppButton(
          title: 'Login',
          onPressed: () {
            context.read<ButtonStateCubit>().execute(
                usecase: sl<SigninUseCase>(),
                params: SigninReqParams(
                    username: _usernameCon.text, password: _passwordCon.text));
          });
    });
  }
}
