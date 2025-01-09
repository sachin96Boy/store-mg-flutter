import 'package:store_mg_fl/features/auth/repository/auth_repository.dart';

class AuthService {
  final AuthRepository authRepository;
  AuthService({
    required this.authRepository,
  });

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await authRepository.signInWithEmailAndPassword(email, password);
  }

  Future<void> signUpWithEmailAndPassword(
      String email, String password, String userName) async {
    await authRepository.signUpWithEmailAndPassword(email, password, userName);

    // redirect user to otp screen
  }
}
