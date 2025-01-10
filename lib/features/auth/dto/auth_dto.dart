class AuthDto {
  final String email;
  final String password;
  final String? username;

  AuthDto({required this.email, required this.password, this.username});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
