import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/auth/dto/auth_response.dart';
import 'package:store_mg_fl/features/auth/models/user_model.dart';
import 'package:store_mg_fl/features/auth/providers/common_providers.dart';

class AuthResponseNotifier extends AutoDisposeAsyncNotifier<AuthResponse> {
  static const USER = 'user';
  static const TOKEN = 'token';

  @override
  Future<AuthResponse> build() async {
    // TODO: implement build

    final authresponse = await handleInitialAuth();
    return authresponse;
  }

  Future<AuthResponse> handleInitialAuth() async {
    final pref = ref.read(sharedPrefLocalProvider);

    final token = await pref.asyncPrefs.getString(TOKEN) ?? '';
    final userjson = await pref.asyncPrefs.getString(USER);

    final user =
        userjson != null ? UserModel.fromJson(json.decode(userjson)) : null;

    return AuthResponse(token: token, user: user);
  }

  Future<void> setResponse(AuthResponse response) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await setAuthenticatedUser(response);
      await setToken(response);

      final newResponse = await handleInitialAuth();
      return newResponse;
    });
  }

  Future<void> setAuthenticatedUser(AuthResponse response) async {
    final pref = ref.read(sharedPrefLocalProvider);
    await pref.asyncPrefs.setString(USER, json.encode(response.user?.toJson()));
  }

  Future<void> setToken(AuthResponse response) async {
    final pref = ref.read(sharedPrefLocalProvider);
    await pref.asyncPrefs.setString(TOKEN, response.token);
  }

  Future<UserModel?> getAuthenticatedUser() async {
    final pref = ref.read(sharedPrefLocalProvider);

    try {
      final user = await pref.asyncPrefs.getString(USER);
      if (user != null) {
        final userModel = UserModel.fromJson(json.decode(user));
        return userModel;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getToken() async {
    final pref = ref.read(sharedPrefLocalProvider);

    final token = await pref.asyncPrefs.getString(TOKEN);
    return token;
  }

  Future<void> logOut() async {
    final pref = ref.read(sharedPrefLocalProvider);

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await pref.asyncPrefs.clear();

      final newResponse = await handleInitialAuth();
      return newResponse;
    });
  }
}

final authResponseProvider =
    AutoDisposeAsyncNotifierProvider<AuthResponseNotifier, AuthResponse>(() {
  return AuthResponseNotifier();
});
