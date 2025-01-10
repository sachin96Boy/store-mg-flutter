import 'dart:convert';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_mg_fl/common/utils/api_interceptor.dart';
import 'package:store_mg_fl/common/utils/apis.dart';

import 'package:http/http.dart' as http;
import 'package:store_mg_fl/features/auth/dto/auth_dto.dart';
import 'package:store_mg_fl/features/auth/dto/auth_response.dart';

class AuthRepository {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<AuthResponse> signInWithEmailAndPassword(AuthDto authDto) async {
    try {
      final loginUrl = Uri.parse(Api.login);

      final response = await http.post(loginUrl,
          body: {'identifier': authDto.email, 'password': authDto.password});

      final body = json.decode(response.body) as Map<String, dynamic>;

      print(body);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(body);
        // Save token to shared pref

        final asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setString('token', body['jwt']);

        // Save refresh token
        // await asyncPrefs.setString('refreshToken', body['refreshToken']);

        // Save user data
        await asyncPrefs.setString('user', body['user']['documentId']);

        authResponse.message = 'Login Successful';

        return authResponse;
      }

      final authResponse = AuthResponse.fromJson(body);

      authResponse.status = 'error';
      authResponse.message = 'Invalid Credentials';
      return authResponse;
    } on Exception catch (e) {
      print(e);
      return AuthResponse(status: 'error', token: '', message: e.toString());
    }
  }

  Future<AuthResponse> signUpWithEmailAndPassword(AuthDto authDto) async {
    try {
      final regUrl = Uri.parse(Api.register);

      final response = await http.post(regUrl, body: {
        'email': authDto.email,
        'password': authDto.password,
        'username': authDto.username
      });

      final body = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(body);
        // Save token to shared pref

        final asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setString('token', body['jwt']);

        // Save refresh token
        // await asyncPrefs.setString('refreshToken', body['refreshToken']);

        // Save user data
        await asyncPrefs.setString('user', body['user']['documentId']);

        authResponse.message = 'Registration Successful';

        return authResponse;
      }

      final authResponse = AuthResponse.fromJson(body);

      authResponse.status = 'error';
      authResponse.message = 'Invalid Credentials';
      return authResponse;
    } on Exception catch (e) {
      print(e);
      return AuthResponse(status: 'error', token: '', message: e.toString());
    }
  }
}
