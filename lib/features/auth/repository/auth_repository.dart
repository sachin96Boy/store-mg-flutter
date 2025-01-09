import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_mg_fl/common/utils/api_interceptor.dart';
import 'package:store_mg_fl/common/utils/apis.dart';

import 'package:http/http.dart' as http;

class AuthRepository {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final loginUrl = Uri.parse(Api.login);

      final response = await http
          .post(loginUrl, body: {'identifier': email, 'password': password});

      print(response.body);

      final body = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        // Save token to shared pref

        final asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setString('token', body['jwt']);

        // Save refresh token
        // await asyncPrefs.setString('refreshToken', body['refreshToken']);

        // Save user data
        await asyncPrefs.setString('user', body['user']['documentId']);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      final regUrl = Uri.parse(Api.register);

      final response = await http.post(regUrl,
          body: {'email': email, 'password': password, 'username': userName});

      print(response.body);
      final body = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        // Save token to shared pref

        final asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setString('token', body['jwt']);

        // Save refresh token
        // await asyncPrefs.setString('refreshToken', body['refreshToken']);

        // Save user data
        await asyncPrefs.setString('user', body['user']['documentId']);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
