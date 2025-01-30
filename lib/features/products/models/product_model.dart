class ProductModel {
  final int id;
  final String documentId;
  final String name;
  final String description;
  final double price;
  final String pictureURL;

  ProductModel(
      {required this.id,
      required this.documentId,
      required this.name,
      required this.description,
      required this.price,
      required this.pictureURL});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      documentId: json['documentId'],
      name: json['name'],
      description: json['description'],
      pictureURL: json['picture']['url'] ?? "",
      price: double.parse(json['price'].toString()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "documntId": documentId,
        "name": name,
        "description": description,
        "price": price,
        "picture": pictureURL,
      };
}
