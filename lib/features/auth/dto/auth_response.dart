import 'package:store_mg_fl/features/auth/models/user_model.dart';

class AuthResponse {
  final String token;
  String status;
  final String? refreshToken;
  final UserModel? user;
  String? message;

  AuthResponse(
      {required this.token,
      this.refreshToken,
      this.user,
      this.status = 'success',
      this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['jwt'] ?? '',
      refreshToken: json['refreshToken'],
      user: UserModel.fromJson(json['user']),
      status: json['status'] ?? 'success',
      message: json['message'] ?? '',
    );
  }
}
