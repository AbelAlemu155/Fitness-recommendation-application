import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/screens/confirmation_screen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  LoginEvent({required this.username, required this.password});
  @override
  List<Object> get props => [this.username, this.password];
}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  SignupEvent(
      {required this.email, required this.username, required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [username, email, password];
}

class ValidationEvent extends AuthEvent {
  String username = '';
  final String email;
  ValidationEvent({this.username = '', required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [username, email];
}

class ValidationEvent2 extends AuthEvent {
  final String email;
  ValidationEvent2({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class EmailEvent extends AuthEvent {
  final String email;
  EmailEvent({required this.email});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
}

class ConfirmationEvent extends AuthEvent {
  const ConfirmationEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConfirmationValidation extends AuthEvent {
  final ConfirmationScreen cscreen;
  final String token;
  ConfirmationValidation({required this.cscreen, required this.token});
  List<Object?> get props => [cscreen, token];
}

class FinalConfirmationEvent extends AuthEvent {
  final ConfirmationScreen cscreen;
  FinalConfirmationEvent({required this.cscreen});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChangePasswordEvent extends AuthEvent {
  final String email;
  final String password;
  ChangePasswordEvent({required this.email, required this.password});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
