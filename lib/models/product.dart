class Product {
  final int id;
  final String name;
  final int price;
  final String image;
  int qty;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.qty = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      qty: json['qty'] ?? 1,
    );
  }
}
