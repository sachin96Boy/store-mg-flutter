import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/auth/dto/auth_dto.dart';
import 'package:store_mg_fl/features/auth/dto/auth_response.dart';
import 'package:store_mg_fl/features/auth/repository/auth_repository.dart';

class AuthService extends Notifier<AsyncValue<dynamic>> {
  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    final authDto = AuthDto(email: email, password: password);
    try {
      final response = await ref
          .read(authRepositoryProvider.notifier)
          .signInWithEmailAndPassword(authDto);

      return response;
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    final authDto =
        AuthDto(email: email, password: password, username: userName);
    final response = await ref
        .read(authRepositoryProvider.notifier)
        .signUpWithEmailAndPassword(authDto);

    return response;
  }

  @override
  AsyncValue build() {
    // TODO: implement build
    throw AsyncData(null);
  }
}

final authServiceProvider =
    NotifierProvider<AuthService, AsyncValue<dynamic>>(() {
  return AuthService();
});
