import 'package:equatable/equatable.dart';

class UserEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class UserLoadEvent extends UserEvent {
  String url;
  int idx;
  UserLoadEvent({required this.url, required this.idx});
}

class UserByEmail extends UserEvent {
  String email;
  UserByEmail({required this.email});
}

class TrainerLoadEvent extends UserEvent {}

class getWgoal extends UserEvent {}
