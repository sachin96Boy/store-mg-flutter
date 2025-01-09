import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_mg_fl/common/utils/api_interceptor.dart';
import 'package:store_mg_fl/common/utils/apis.dart';

class AuthRepository {
  Client client = InterceptedClient.build(interceptors: [
    ApiInterceptor(),
  ]);

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final loginUrl = Uri.parse(Api.login);

      final response = await client
          .post(loginUrl, body: {'identifier': email, 'password': password});

      final body = response.body as Map<String, dynamic>;

      if (response.statusCode == 200) {
        // Save token to shared pref

        final asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setString('token', body['jwt']);

        // Save refresh token
        await asyncPrefs.setString('refreshToken', body['refreshToken']);

        // Save user data
        await asyncPrefs.setString('user', body['user']);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    try {
      final regUrl = Uri.parse(Api.register);

      final response = await client.post(regUrl,
          body: {'email': email, 'password': password, 'username': userName});

      final body = response.body as Map<String, dynamic>;

      if (response.statusCode == 200) {
        // Save token to shared pref

        final asyncPrefs = SharedPreferencesAsync();
        await asyncPrefs.setString('token', body['jwt']);

        // Save refresh token
        await asyncPrefs.setString('refreshToken', body['refreshToken']);

        // Save user data
        await asyncPrefs.setString('user', body['user']);
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
