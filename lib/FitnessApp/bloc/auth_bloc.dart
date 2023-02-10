import 'dart:io';

import 'package:firsstapp/FitnessApp/bloc/auth_event.dart';
import 'package:firsstapp/FitnessApp/bloc/auth_state.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';
import 'package:firsstapp/FitnessApp/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : assert(authRepository != null),
        super(AuthInitializer());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield LoginInProgress();

      try {
        await authRepository.loginUser(event.username, event.password);
        yield LoginSuccess();
      } on SocketException catch (e) {
        yield LoginFailure('Connection is not available');
      } catch (e) {
        yield LoginFailure('$e');
      }
    }
    if (event is SignupEvent) {
      yield SignupInProgress();
      try {
        await authRepository.registerUser(
            username: event.username,
            password: event.password,
            email: event.email);
        yield SignupSuccess();
      } on SocketException catch (e) {
        yield SignupFailure('Connection is not available');
      } catch (e) {
        yield SignupFailure('$e');
      }
    }
    if (event is ValidationEvent) {
      yield ValidationInProgress();
      try {
        await authRepository.validateForm(
            username: event.username, email: event.email);
        yield ValidationSuccess();
      } on SocketException catch (e) {
        yield ValidationFailure('Connection is not available');
      } catch (e) {
        yield ValidationFailure('$e');
      }
    }
    if (event is ValidationEvent2) {
      yield ValidationInProgress();
      try {
        await authRepository.validateForm2(email: event.email);
        yield ValidationSuccess2();
      } on SocketException catch (e) {
        yield ValidationFailure('Connection is not available');
      } catch (e) {
        yield ValidationFailure('$e');
      }
    }
    if (event is EmailEvent) {
      yield EmailInProgress();
      try {
        String token = await authRepository.sendEmail(event.email);
        yield EmailSuccess(token: token);
      } on SocketException catch (e) {
        yield EmailFailure('Connection is not available');
      } catch (e) {
        yield EmailFailure('$e');
      }
    }

    if (event is ConfirmationEvent) {
      try {
        bool isConfirmed = await authRepository.isConfirmed();
        yield ConfirmationSuccess(isConfirmed: isConfirmed);
      } on SocketException catch (e) {
        yield ConfirmationFailure('Connection is not available');
      } catch (e) {
        yield ConfirmationFailure('$e');
      }
    }
    if (event is ConfirmationValidation) {
      yield ConfirmationValidationProgress(cscreen: event.cscreen);

      final cscreen = event.cscreen;
      if (!cscreen.controller1.text.isEmpty &&
          cscreen.controller2.text.isEmpty &&
          cscreen.controller3.text.isEmpty &&
          cscreen.controller4.text.isEmpty) {
        cscreen.focusNode1.requestFocus();
      } else if (!cscreen.controller1.text.isEmpty &&
          !cscreen.controller2.text.isEmpty &&
          cscreen.controller3.text.isEmpty &&
          cscreen.controller4.text.isEmpty) {
        cscreen.focusNode2.requestFocus();
      } else if (!cscreen.controller1.text.isEmpty &&
          !cscreen.controller2.text.isEmpty &&
          !cscreen.controller3.text.isEmpty &&
          cscreen.controller4.text.isEmpty) {
        cscreen.focusNode3.requestFocus();
      } else if (cscreen.controller1.text.isEmpty ||
          cscreen.controller2.text.isEmpty ||
          cscreen.controller3.text.isEmpty ||
          cscreen.controller4.text.isEmpty) {
      } else {
        String val = cscreen.controller1.text +
            cscreen.controller2.text +
            cscreen.controller3.text +
            cscreen.controller4.text;
        if (val == event.token) {
          yield ConfirmationRight(cscreen: event.cscreen);
        } else {
          yield ConfirmationWrong(cscreen: event.cscreen);
        }
      }
    }
    if (event is FinalConfirmationEvent) {
      try {
        await authRepository.finalConfirmation();
        yield FinalConfirmation();
      } on SocketException catch (e) {
        yield FinalConfirmationFailure(
            cscreen: event.cscreen, message: 'Connection is not available');
      } catch (e) {
        yield FinalConfirmationFailure(cscreen: event.cscreen, message: '$e');
      }
    }
    if (event is ChangePasswordEvent) {
      yield ChangeInProgress();
      try {
        await authRepository.changePassword(event.email, event.password);
        yield ChangePasswordSuccess();
      } on SocketException catch (e) {
        yield ChangePasswordFailure(message: 'Connection is not available');
      } catch (e) {
        yield ChangePasswordFailure(message: '$e');
      }
    }
  }
}
