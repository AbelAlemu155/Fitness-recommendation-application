import 'package:firsstapp/FitnessApp/data_provider/blog_provider.dart';
import 'package:firsstapp/FitnessApp/models/Blog.dart';

class BlogRepository {
  final BlogProvider dataProvider;

  BlogRepository({required this.dataProvider}) : assert(dataProvider != null);

  Future<List<Blog>> getPosts() async {
    return await dataProvider.getPosts();
  }

  Future<Blog?> createPost(String body) async {
    return await dataProvider.createPost(body);
  }

  Future<void> deletePost(Blog post) async {
    await dataProvider.deletePost(post);
  }

  Future<void> makeRequest(int trid) async {
    await dataProvider.makeRequest(trid);
  }
}
