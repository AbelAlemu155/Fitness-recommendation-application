import 'dart:convert';
import 'dart:io';

import 'package:firsstapp/FitnessApp/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class AuthDataProvider {
  final _baseUrl = 'http://10.0.2.2:8080';
  final http.Client httpClient;

  AuthDataProvider({required this.httpClient}) : assert(httpClient != null);

  Future<void> loginUser(String username, String password) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/isconfirmed/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode == 401) {
      throw Exception('Invalid credential');
    } else if (response.statusCode == 403) {
      throw Exception('Credentials are not enough to access resource');
    } else if (response.statusCode != 200) {
      throw Exception('Unable to authenticate');
    }
  }

  Future<bool> updateToken(User user, String username, String password) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode(user.token));
    String basicAuth2 =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/verify_token/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: basicAuth
        });
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 401) {
      final tokenResponse = await httpClient.post(
          Uri.http('10.0.2.2:8080', '/api/v1/tokens/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            HttpHeaders.authorizationHeader: basicAuth2
          });

      if (tokenResponse.statusCode == 200) {
        String token = jsonDecode(response.body)['token'];
        user.token = token;
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> registerUser(
      {required String username,
      required String password,
      required String email}) async {
    final response =
        await httpClient.post(Uri.http('10.0.2.2:8080', '/api/v1/register'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'username': username,
              'password': password,
              'email': email,
            }));

    if (response.statusCode != 201) {
      throw Exception('Unable to create user');
    }
  }

  Future<void> validateForm(
      {required String username, required String email}) async {
    final response =
        await httpClient.post(Uri.http('10.0.2.2:8080', '/api/v1/validator'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{'email': email}));
    if (response.statusCode != 200) {
      throw Exception('Unable to validate Email');
    }
    bool emailVal = jsonDecode(response.body)['email'];

    if (!emailVal) {
      throw Exception('Email address already exists in the system');
    }
  }

  Future<void> validateForm2({required String email}) async {
    final response =
        await httpClient.post(Uri.http('10.0.2.2:8080', '/api/v1/validator'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{'email': email}));
    if (response.statusCode != 200) {
      throw Exception('Unable to validate Email');
    }
    bool emailVal = jsonDecode(response.body)['email'];

    if (emailVal) {
      throw Exception('Email address is not known');
    }
  }

  Future<String> sendEmail(String email) async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.post(
        Uri.http('10.0.2.2:8080', '/api/v1/sendemail'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        },
        body: jsonEncode(<String, dynamic>{'email': email}));

    if (response.statusCode != 200) {
      throw Exception('Unable to send confirmation email, check connection');
    }
    String cToken = jsonDecode(response.body)['token'];
    return cToken;
  }

  Future<bool> isConfirmed() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/isconfirmed/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to confirm user');
    }
    bool isConfirmed = jsonDecode(response.body)['isconfirmed'];
    if (isConfirmed) {
      return true;
    }
    return false;
  }

  Future<void> finalConfirmation() async {
    final username = LoginScreen.box.read('username');
    final password = LoginScreen.box.read('password');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    final response = await httpClient.get(
        Uri.http('10.0.2.2:8080', '/api/v1/confirm/$username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'authorization': basicAuth
        });
    if (response.statusCode != 200) {
      throw Exception('Unable to confirm user');
    }
  }

  Future<void> changePassword(String email, String password) async {
    final response = await httpClient.put(
        Uri.http('10.0.2.2:8080', '/api/v1/change/user/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{'password': password}));

    if (response.statusCode != 200) {
      throw Exception('Unable to change password');
    }
  }
}
