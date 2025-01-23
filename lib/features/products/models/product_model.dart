class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String pictureURL;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.pictureURL});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureURL: json['picture'] ?? "",
      price: double.parse(json['price'].toString()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "picture": pictureURL,
      };
}
