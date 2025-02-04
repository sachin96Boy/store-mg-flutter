import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  final int id;
  final String userName;
  final String email;
  final String provider;
  final String cartId;
  final bool confirmed;
  final bool blocked;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel(
      {required this.id,
      required this.userName,
      required this.email,
      required this.provider,
      required this.cartId,
      required this.confirmed,
      required this.blocked,
      required this.createdAt,
      required this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userName: json["username"],
        email: json["email"],
        provider: json["provider"],
        cartId: json["cart_id"] ?? '',
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": userName,
        "email": email,
        "provider": provider,
        "cart_id": cartId,
        "confirmed": confirmed,
        "blocked": blocked,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
