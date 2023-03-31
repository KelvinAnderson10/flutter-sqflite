class ProductModel{
  int? id;
  String? name;
  String? category;
  String? createdAt;
  int? price;

  ProductModel({this.id, this.name, this.category, this.createdAt, this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      createdAt: json['created_at'],
      price: json['price']
    );
  }
}