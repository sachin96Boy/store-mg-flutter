class CartModel {
  final int id;
  final String title;
  final String description;
  final int quantity;
  final String imageUrl;
  final double price;

  CartModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final cartItems = json['cartItems'] as List<dynamic>;
    return CartModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      quantity: int.parse(json['quantity']),
      price: double.parse(json['description']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "quantity": quantity,
        "price": price,
        "imageUrl": imageUrl,
      };
}
