class Category {
  final int categoryId;
  final String title;
  final String imageUrl;
  final bool hasSubcategories;
  final String fullName;
  final String categoryDescription;

  Category({
    required this.categoryId,
    required this.title,
    required this.imageUrl,
    required this.hasSubcategories,
    required this.fullName,
    required this.categoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'] as int,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      hasSubcategories: (json['hasSubcategories'] as int) == 1,
      fullName: json['fullName'] as String,
      categoryDescription: json['categoryDescription'] as String,
    );
  }
}