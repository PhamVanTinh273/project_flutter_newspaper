class SavedArticles {
  static List<SavedArticle> articles = [];

  static void saveArticle(String title, String description, String imageUrl) {
    articles.add(SavedArticle(title: title, description: description, imageUrl: imageUrl));
  }
}

class SavedArticle {
  final String title;
  final String description;
  final String imageUrl;

  SavedArticle({required this.title, required this.description, required this.imageUrl});
}