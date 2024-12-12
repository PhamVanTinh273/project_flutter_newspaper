import 'package:flutter/material.dart';
import 'saved_articles.dart'; // Import lớp quản lý bài viết đã lưu

class DetailPage extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  const DetailPage({
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_upward, color: Colors.blue),
                  SizedBox(width: 8),
                  Text("25", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_downward, color: Colors.blue),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.volume_up, color: Colors.blue),
                    onPressed: () {
                      // Xử lý sự kiện Nghe tin
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark, color: Colors.blue),
                    onPressed: () {
                      // Lưu bài viết
                      SavedArticles.saveArticle(title, description, imageUrl);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Đã lưu bài viết')),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.share, color: Colors.blue),
                    onPressed: () {
                      // Xử lý sự kiện Chia sẻ
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
