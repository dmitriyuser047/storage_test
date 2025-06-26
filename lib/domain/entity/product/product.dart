class Product {
  final int productId;
  final String title;
  final String productDescription;
  final int price;
  final double? rating;
  final String imageUrl;
  final List<String> images;
  final bool isAvailableForSale;

  Product({
    required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.images,
    required this.isAvailableForSale,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      title: json['title'],
      productDescription: json['productDescription'],
      price: json['price'],
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      imageUrl: json['imageUrl'],
      images: List<String>.from(json['images']),
      isAvailableForSale: json['isAvailableForSale'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'productDescription': productDescription,
      'price': price,
      'rating': rating,
      'imageUrl': imageUrl,
      'images': images,
      'isAvailableForSale': isAvailableForSale ? 1 : 0,
    };
  }
}