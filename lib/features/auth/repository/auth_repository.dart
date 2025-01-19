import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/utils/apis.dart';

import 'package:http/http.dart' as http;
import 'package:store_mg_fl/features/auth/dto/auth_dto.dart';
import 'package:store_mg_fl/features/auth/dto/auth_response.dart';
import 'package:store_mg_fl/features/auth/providers/auth_provider.dart';

class AuthRepository extends Notifier<AsyncValue<dynamic>> {
  Future<AuthResponse> signInWithEmailAndPassword(AuthDto authDto) async {
    try {
      final loginUrl = Uri.parse(Api.login);

      final response = await http.post(loginUrl,
          body: {'identifier': authDto.email, 'password': authDto.password});

      final body = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(body);

        ref.read(authResponseProvider.notifier).setResponse(authResponse);

        authResponse.message = 'Login Successful';

        return authResponse;
      }

      final authResponse = AuthResponse(token: '');

      ref.read(authResponseProvider.notifier).setResponse(authResponse);

      authResponse.status = 'error';
      authResponse.message = body['error']['message'];
      return authResponse;
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
      // return AuthResponse(status: 'error', token: '', message: e.toString());
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

        ref.read(authResponseProvider.notifier).setResponse(authResponse);

        authResponse.message = 'Registration Successful';

        return authResponse;
      }

      final authResponse = AuthResponse(token: '');

      ref.read(authResponseProvider.notifier).setResponse(authResponse);

      authResponse.status = 'error';
      authResponse.message = body['error']['message'] as String;
      return authResponse;
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
      // return AuthResponse(status: 'error', token: '', message: e.toString());
    }
  }

  @override
  AsyncValue build() {
    // TODO: implement build
    return AsyncValue.data(null);
  }
}

final authRepositoryProvider =
    NotifierProvider<AuthRepository, AsyncValue<dynamic>>(() {
  return AuthRepository();
});
