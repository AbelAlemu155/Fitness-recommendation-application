import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class BlogEvent extends PostEvent {
  final String message;
  BlogEvent([this.message = '']);
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CreateEvent extends PostEvent {
  final String body;

  CreateEvent({required this.body});
  @override
  // TODO: implement props
  List<Object?> get props => [body];
}

class DeleteEvent extends PostEvent {
  final Blog post;
  DeleteEvent({required this.post});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RequestEvent extends PostEvent {
  int index;
  int trid;

  RequestEvent({required this.index, required this.trid});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class RequestInit extends PostEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
