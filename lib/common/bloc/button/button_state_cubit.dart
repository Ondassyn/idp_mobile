import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idp/common/bloc/button/button_state.dart';
import 'package:logger/logger.dart';

import '../../../core/usecase/usecase.dart';

class ButtonStateCubit extends Cubit<ButtonState> {
  ButtonStateCubit() : super(ButtonInitialState());

  void execute({dynamic params, required UseCase usecase}) async {
    emit(ButtonLoadingState());
    try {
      Either result = await usecase.call(param: params);

      result.fold((error) {
        emit(ButtonFailureState(errorMessage: error));
      }, (data) {
        emit(ButtonSuccessState());
      });
    } catch (e) {
      var logger = Logger();
      logger.log(Level.trace, 'BUTTON ERROR: ${e.toString()}');
      emit(ButtonFailureState(errorMessage: e.toString()));
    }
  }
}
