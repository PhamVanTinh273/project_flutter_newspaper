import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_login/pages/login_page.dart';
import 'saved_articles.dart'; // Import lớp quản lý bài viết đã lưu

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    setState(() {
      currentUser = FirebaseAuth.instance.currentUser;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(onTap: () {}),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đăng xuất thất bại: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              title: Center(
                child: Text(
                  "Cá nhân",
                  style: TextStyle(color: Colors.black, fontSize: 24),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                currentUser?.photoURL ??
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWH_Z82RlxjBaKOycJb25ssQbJ1lbeVRWfJA&s',
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              currentUser?.displayName ??
                                  currentUser?.email ??
                                  "Người dùng",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _gridItem(Icons.bookmark, "Đã lưu", () {
                                  _showSavedArticles();
                                }),
                                _gridItem(Icons.rule_folder_outlined,
                                    "Đang theo dõi"),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _gridItem(Icons.download, "Tin đã tải"),
                                _gridItem(Icons.history, "Đọc gần đây"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Cài đặt",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      _settingRow(Icons.menu_book_rounded, "Chế độ đọc"),
                      _settingRow(Icons.color_lens, "Giao diện",
                          icon2: Icons.fiber_manual_record),
                      _settingRow(Icons.volume_up, "Giọng đọc",
                          text: "Mặc định"),
                      _settingRow(Icons.location_on, "Tin địa phương",
                          text: "Chọn địa phương"),
                      _settingRow(Icons.settings, "Nâng cao"),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tiện ích",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            _utilityRow(Icons.calendar_today, "Lịch việt"),
                            SizedBox(height: 16),
                            _utilityRow(Icons.wb_sunny, "Thời tiết"),
                            SizedBox(height: 16),
                            _utilityRow(Icons.sports_esports, "Kết quả xổ số"),
                            SizedBox(height: 16),
                            _utilityRow(
                                Icons.monetization_on, "Giá vàng & Ngoại tệ"),
                            SizedBox(height: 16),
                            _utilityRow(Icons.sports_soccer, "Tỷ số bóng đá"),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sản phẩm",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Column(
                          children: [
                            _productRow("Liên hệ"),
                            SizedBox(height: 16),
                            _productRow("Đối tác chính thức"),
                            SizedBox(height: 16),
                            _productRow("Kiểm tra phiên bản mới (24.11.02)"),
                            SizedBox(height: 16),
                            _productRow("Điều khoản sử dụng"),
                            SizedBox(height: 16),
                            _productRow("Chính sách bảo mật"),
                            SizedBox(height: 16),
                            _productRow("Bình chọn cho báo mới"),
                            SizedBox(height: 16),
                            _productRow("Email góp ý, báo lỗi"),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                            onPressed: logout,
                            icon: Icon(Icons.logout),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Hiển thị danh sách bài viết đã lưu
  void _showSavedArticles() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Bài viết đã lưu"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: SavedArticles.articles.length,
              itemBuilder: (context, index) {
                final article = SavedArticles.articles[index];
                return Column(
                  children: [
                    ListTile(
                      leading: Image.network(article.imageUrl),
                      title: Text(article.title),
                      subtitle: Text(article.description),
                    ),
                    Divider(), // Thêm Divider để ngăn cách giữa các bài viết
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper Widget cho các item trong GridView
  Widget _gridItem(IconData icon, String label, [VoidCallback? onTap]) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24, color: const Color.fromARGB(255, 69, 190, 193)),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Helper Widget cho mỗi row trong phần Cài đặt
  Widget _settingRow(IconData icon, String label,
      {IconData? icon2, String? text, Color? iconColor}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon,
              size: 30,
              color: iconColor ?? const Color.fromARGB(255, 112, 112, 112)),
          SizedBox(width: 16),
          Text(label, style: TextStyle(fontSize: 16)),
          Spacer(),
          if (icon2 != null)
            Icon(icon2, size: 20, color: iconColor ?? Colors.black),
          if (text != null)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text,
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ),
        ],
      ),
    );
  }

  // Helper Widget cho mỗi row trong phần Tiện ích
  Widget _utilityRow(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 30, color: const Color.fromARGB(255, 143, 148, 152)),
        SizedBox(width: 16),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  // Helper Widget cho mỗi row trong phần Sản phẩm
  Widget _productRow(String label) {
    return Row(
      children: [
        Icon(Icons.arrow_right, size: 20, color: Colors.grey),
        SizedBox(width: 16),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
