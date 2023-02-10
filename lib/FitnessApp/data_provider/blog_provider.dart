import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BlogProvider {
  final http.Client httpClient;

  BlogProvider({required this.httpClient}) : assert(httpClient != null);

  Future<List<Blog>> getPosts() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/posts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Unable to get posts, check your connection');
    }

    List<dynamic> l = json.decode(response.body)['posts'];

    //print(post);

    List<Blog> posts = l.map((e) => Blog.fromJson(e)).toList();
    // print(posts);
    return posts;
  }

  Future<Blog?> createPost(String body) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    // final response = await httpClient.post(
    //     Uri.http('.
    //     ', '/api/v1/posts/'),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'authorization': basicAuth
    //     },
    //     body: jsonEncode(<String, dynamic>{'body': body}));

    // if (response == 403) {
    //   throw Exception('lacks the permission to write posts');
    // }
    // if (response.statusCode != 201) {
    //   throw Exception('Unable to create Posts');
    // }
    return null;
    //  return Blog.fromJson(jsonDecode(response.body));
  }

  Future<void> deletePost(Blog post) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.delete(
      Uri.http('10.0.2.2:8080', post.url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to delete post');
    }
  }

  Future<void> makeRequest(int trid) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
      Uri.http('10.0.2.2:8080', '/api/v1/makerequest/$username/$trid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to make request');
    }
  }
}
