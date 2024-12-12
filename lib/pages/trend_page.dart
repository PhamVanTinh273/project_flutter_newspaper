import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrendPage extends StatefulWidget {
  @override
  _TrendPageState createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header cố định
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
              ),
            ),
            child: Center(
              child: Text(
                "Xu hướng",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Phần "Đang được quan tâm"
                    buildTrendingSection("Đang được quan tâm", "trending"),
                    SizedBox(height: 20),

                    // Phần "Nóng 24h"
                    buildTrendingSection("Nóng 24h", "hot"),
                    SizedBox(height: 20),

                    // Phần "Góc nhìn phân tích"
                    buildTrendingSection("Góc nhìn phân tích", "analysis"),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build a section with trending articles from Firestore
  Widget buildTrendingSection(String title, String collection) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800]),
          ),
        ),
        FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection(collection).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Lỗi khi tải dữ liệu'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Không có bài viết nào'));
            }

            var documents = snapshot.data!.docs;

            return Column(
              children: List.generate(documents.length, (index) {
                var data = documents[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: trendingCard(data),
                );
              }),
            );
          },
        ),
        Center(child: Text("Đọc thêm", style: TextStyle(color: Colors.blue))),
      ],
    );
  }

  // Create a trending card from the document data
  Widget trendingCard(DocumentSnapshot data) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Column 1: Image
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(data['imageUrl']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Column 2: Title and Source
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Nguồn: ${data['source']}",
                          style: TextStyle(color: Colors.grey[600])),
                      Text("${data['timeAgo']} trước",
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Navigation Bar Item
  Widget navBarItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
