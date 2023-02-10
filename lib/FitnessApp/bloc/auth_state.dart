import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/user.dart';
import 'package:firsstapp/FitnessApp/screens/confirmation_screen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitializer extends AuthState {}

class LoginInProgress extends AuthState {}

class LoginSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class LoginFailure extends AuthState {
  String message;
  LoginFailure([this.message = '']);
}

class SignupInProgress extends AuthState {}

class SignupSuccess extends AuthState {}

class SignupFailure extends AuthState {
  final String message;
  SignupFailure([this.message = '']);
}

class ValidationInProgress extends AuthState {}

class ValidationSuccess extends AuthState {}

class ValidationFailure extends AuthState {
  final String message;
  ValidationFailure([this.message = '']);
}

class ValidationSuccess2 extends AuthState {}

class EmailInProgress extends AuthState {}

class EmailFailure extends AuthState {
  final String message;
  EmailFailure([this.message = '']);
}

class EmailSuccess extends AuthState {
  final String token;
  EmailSuccess({required this.token});
}

class ConfirmationSuccess extends AuthState {
  final bool isConfirmed;
  ConfirmationSuccess({required this.isConfirmed});
}

class ConfirmationFailure extends AuthState {
  final String message;
  ConfirmationFailure([this.message = '']);
}

class ConfirmationRight extends AuthState {
  final ConfirmationScreen cscreen;
  ConfirmationRight({required this.cscreen});
}

class ConfirmationWrong extends AuthState {
  final ConfirmationScreen cscreen;
  ConfirmationWrong({required this.cscreen});
}

class ConfirmationValidationProgress extends AuthState {
  final ConfirmationScreen cscreen;
  ConfirmationValidationProgress({required this.cscreen});
}

class FinalConfirmation extends AuthState {}

class FinalConfirmationFailure extends AuthState {
  final String message;
  ConfirmationScreen cscreen;
  FinalConfirmationFailure({required this.cscreen, this.message = ''});
}

class ChangePasswordSuccess extends AuthState {}

class ChangePasswordFailure extends AuthState {
  final String message;
  ChangePasswordFailure({required this.message});
}

class ChangeInProgress extends AuthState {}
