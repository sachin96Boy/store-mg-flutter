import 'package:store_mg_fl/features/auth/dto/auth_dto.dart';
import 'package:store_mg_fl/features/auth/dto/auth_response.dart';
import 'package:store_mg_fl/features/auth/repository/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;
  AuthService({
    required this.authRepository,
  });

  Future<AuthResponse> signInWithEmailAndPassword(
      String email, String password) async {
    final authDto = AuthDto(email: email, password: password);
    final response = await authRepository.signInWithEmailAndPassword(authDto);

    return response;
  }

  Future<AuthResponse> signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    final authDto =
        AuthDto(email: email, password: password, username: userName);
    final response = await authRepository.signUpWithEmailAndPassword(authDto);

    return response;
  }
}
