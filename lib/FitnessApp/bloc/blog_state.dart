import 'package:equatable/equatable.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';

class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class LoadBlog extends PostState {
  final List<Blog> posts;
  final String message;
  LoadBlog({required this.posts, this.message = ''});
}

class BlogFailure extends PostState {
  final String message;
  BlogFailure([this.message = '']);
}

class BlogInProgress extends PostState {}

class CreationInProgress extends PostState {}

class CreationSuccess extends PostState {
  final Blog post;
  CreationSuccess({required this.post});
}

class CreationFailure extends PostState {
  final String message;
  CreationFailure([this.message = '']);
}

class DeleteInProgress extends PostState {}

class DeleteSuccess extends PostState {}

class DeleteFailure extends PostState {
  final String message;
  DeleteFailure([this.message = '']);
}

class RequestLoad extends PostState {
  int index;
  RequestLoad({required this.index});
}

class RequestFail extends PostState {
  final String message;
  int index;
  RequestFail({required this.message, required this.index});
}

class RequestSuccess extends PostState {
  int index;
  RequestSuccess({required this.index});
}

class RequestInitState extends PostState {}
