import 'package:firsstapp/FitnessApp/models/Blog.dart';
import 'package:firsstapp/FitnessApp/models/approval.dart';
import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UploadProvider {
  final http.Client httpClient;
  String _baseurl = '10.0.2.2:8080';
  UploadProvider({required this.httpClient}) : assert(httpClient != null);

  Future<Blog> uploadPost(List<int> str, String title, String body) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http(_baseurl, '/api/v1/createpost'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(
            <String, dynamic>{'bytes': str, 'title': title, 'body': body}));
    if (response.statusCode != 200) {
      throw Exception('Unable to upload');
    }
    return Blog.fromJson(jsonDecode(response.body));
  }

  Future<Approval> checkApproval(int trid) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
      Uri.http(_baseurl, '/api/v1/clientapproval/$username/$trid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'authorization': basicAuth
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Unable to check approval');
    }
    Approval ap = Approval.fromJson(jsonDecode(response.body));
    return ap;
  }
}
