class Category {
  final String title;
  final int categoryId;
  bool isCategorySelected;

  Category(Map<String, dynamic> jsonMap)
      : title = jsonMap['name'],
        isCategorySelected = jsonMap['userId'] != null,
        categoryId = jsonMap['categoryId'];
}
