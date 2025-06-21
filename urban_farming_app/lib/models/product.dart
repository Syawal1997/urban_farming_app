class Product {
  String? id;
  String name;
  String description;
  double price;
  String imageUrl;
  String sellerId;
  String sellerName;
  DateTime createdAt;
  int stock;
  String category;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.sellerId,
    required this.sellerName,
    required this.createdAt,
    required this.stock,
    required this.category,
  });

  factory Product.fromMap(Map<String, dynamic> map, String id) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      sellerId: map['sellerId'] ?? '',
      sellerName: map['sellerName'] ?? '',
      createdAt: map['createdAt']?.toDate() ?? DateTime.now(),
      stock: map['stock']?.toInt() ?? 0,
      category: map['category'] ?? 'Other',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'sellerId': sellerId,
      'sellerName': sellerName,
      'createdAt': createdAt,
      'stock': stock,
      'category': category,
    };
  }
}