import 'package:firsstapp/FitnessApp/bloc/blog_state.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:firsstapp/FitnessApp/repository/blog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blog_event.dart';

class BlogBloc extends Bloc<PostEvent, PostState> {
  final BlogRepository blogRepository;

  BlogBloc({required this.blogRepository})
      : assert(blogRepository != null),
        super(BlogInProgress());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is BlogEvent) {
      yield BlogInProgress();
      try {
        List<Blog> posts = await blogRepository.getPosts();
        String message = event.message;
        if (message == '') {
          yield LoadBlog(posts: posts);
        } else {
          yield LoadBlog(posts: posts, message: message);
        }
      } catch (e) {
        yield BlogFailure('$e');
      }
    }

    if (event is CreateEvent) {
      yield CreationInProgress();
      try {
        Blog? post = await blogRepository.createPost(event.body);
        yield CreationSuccess(post: post!);
      } catch (e) {
        yield CreationFailure();
      }
    }
    if (event is DeleteEvent) {
      yield DeleteInProgress();
      try {
        await blogRepository.deletePost(event.post);
        yield DeleteSuccess();
      } catch (e) {
        yield DeleteFailure('$e');
      }
    }
    if (event is RequestEvent) {
      yield RequestLoad(index: event.index);
      try {
        await blogRepository.makeRequest(event.trid);
        yield RequestSuccess(index: event.index);
      } catch (e) {
        yield RequestFail(message: '$e', index: event.index);
      }
    }
    if (event is RequestInit) {
      yield RequestInitState();
    }
  }
}
