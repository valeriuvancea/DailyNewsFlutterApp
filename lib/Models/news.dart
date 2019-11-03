class News {
  final String category;
  final String title;
  final String publicationDate;
  final String link;

  News(Map<String, dynamic> jsonMap)
      : category = jsonMap["category"],
        title = jsonMap["title"],
        publicationDate = jsonMap["pubDate"],
        link = jsonMap["link"];
}
