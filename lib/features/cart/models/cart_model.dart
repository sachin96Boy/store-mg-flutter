class CartModel {
  final int id;
  final String userId;
  final String title;
  final String description;
  final int quantity;
  final String imageUrl;
  final double price;

  CartModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.quantity,
      required this.price,
      required this.imageUrl});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      quantity: int.parse(json['quantity']),
      price: double.parse(json['description']),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "title": title,
        "description": description,
        "quantity": quantity,
        "price": price,
        "imageUrl": imageUrl,
      };
}
