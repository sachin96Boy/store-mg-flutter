import 'package:store_mg_fl/features/products/models/product_model.dart';

class CartModel {
  final int id;
  final String userId;
  final List<ProductModel> cartItems;

  CartModel({
    required this.id,
    required this.userId,
    this.cartItems = const [],
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final cartItems = json['cartItems'] as List<dynamic>;
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      cartItems: cartItems.map((element) {
        return ProductModel.fromJson(element);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "cartItems": cartItems.map((element) {
          return element.toJson();
        }).toList(),
      };
}
