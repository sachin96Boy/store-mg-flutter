class AuthResponse {
  final String token;
  final String? refreshToken;
  final Map<String, dynamic>? user;
  String status;
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
      user: json['user'],
      status: json['status'] ?? 'success',
      message: json['message'] ?? '',
    );
  }
}
