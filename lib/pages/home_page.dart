import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_login/pages/category_page.dart';
import 'package:page_login/pages/detail_page.dart';
import 'package:page_login/pages/trend_page.dart';
import 'package:page_login/pages/video_page.dart';
import 'personal_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePageContent(
        searchController: _searchController,
        onSearchChanged: _onSearchChanged,
        searchQuery: _searchQuery,
      ),
      VideoPlayerApp(), // Trang Video
      // TrendPage(), // Trang Xu hướng
      PersonalPage(), // Trang Cá nhân
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.trim();
      // Update the HomePageContent to reflect the search query change
      _pages[0] = HomePageContent(
        searchController: _searchController,
        onSearchChanged: _onSearchChanged,
        searchQuery: _searchQuery,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages, // Các trang khác nhau
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final String searchQuery;

  const HomePageContent({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
    required this.searchQuery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: const Color.fromARGB(255, 86, 180, 242),
          floating: false,
          pinned: true,
          expandedHeight: 200.0,
          flexibleSpace: HeaderSection(
            searchController: searchController,
            onSearchChanged: onSearchChanged,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Đọc nhiều",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: FutureBuilder<QuerySnapshot>(
                    future:
                        FirebaseFirestore.instance.collection('category').get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text('Lỗi khi tải dữ liệu'));
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('Không có dữ liệu hiển thị'));
                      }

                      var documents = snapshot.data!.docs;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: documents.length > 5 ? 5 : documents.length,
                        itemBuilder: (context, index) {
                          var data = documents[index];
                          return CategoryCard(
                            imageUrl: data['imageUrl'],
                            title: data['title'],
                            source: data['source'],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection('homePage')
                    .where('title', isGreaterThanOrEqualTo: searchQuery)
                    .where('title', isLessThan: '$searchQuery\uf8ff')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Lỗi khi tải dữ liệu'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('Không có kết quả tìm kiếm'));
                  }

                  var documents = snapshot.data!.docs;

                  // Hiển thị dữ liệu tìm kiếm
                  return ListCard(
                    imagePath: documents[index]['imageUrl'],
                    title: documents[index]['title'],
                    description: documents[index]
                        ['description'], // Truyền description
                  );
                },
              );
            },
            childCount: 7,
          ),
        ),
      ],
    );
  }
}

class HeaderSection extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const HeaderSection({
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // Điều hướng đến ScreenCategories
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScreenCategories()),
                    );
                  },
                  child: Icon(Icons.menu, color: Colors.white),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HeaderCategory(title: "Nóng"),
                        HeaderCategory(title: "Bóng đá VN"),
                        HeaderCategory(title: "Bóng đá QT"),
                        HeaderCategory(title: "Độc & Lạ"),
                        HeaderCategory(title: "Tình yêu"),
                        HeaderCategory(title: "Giải trí"),
                        HeaderCategory(title: "Thế Giới"),
                        HeaderCategory(title: "Pháp luật"),
                        HeaderCategory(title: "Xe 360"),
                        HeaderCategory(title: "Công nghệ"),
                        HeaderCategory(title: "Ẩm thực"),
                        HeaderCategory(title: "Làm đẹp"),
                        HeaderCategory(title: "Sức khỏe"),
                        HeaderCategory(title: "Du lịch"),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.search, color: Colors.white),
                    SizedBox(width: 16),
                    Icon(Icons.person, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: "Tìm kiếm...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.white),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderCategory extends StatelessWidget {
  final String title;

  const HeaderCategory({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String source;

  const CategoryCard({
    required this.imageUrl,
    required this.title,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      elevation: 4,
      child: Container(
        width: 150,
        child: Column(
          children: [
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$source | 2 giờ",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description; // Thêm description

  const ListCard({
    required this.imagePath,
    required this.title,
    required this.description, // Thêm description vào constructor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          // Nhấn vào sẽ mở DetailPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                imageUrl: imagePath,
                title: title,
                description: description, // Truyền description
              ),
            ),
          );
        },
        child: Card(
          elevation: 4,
          child: Row(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const NavigationBar({
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavigationItem(
            icon: Icons.article,
            label: "Tin tức",
            isSelected: selectedIndex == 0,
            onTap: () => onItemTapped(0),
          ),
          NavigationItem(
            icon: Icons.video_library,
            label: "Video",
            isSelected: selectedIndex == 1,
            onTap: () => onItemTapped(1),
          ),
          NavigationItem(
            icon: Icons.trending_up,
            label: "Xu hướng",
            isSelected: selectedIndex == 2,
            onTap: () => onItemTapped(2),
          ),
          NavigationItem(
            icon: Icons.person,
            label: "Cá nhân",
            isSelected: selectedIndex == 3,
            onTap: () => onItemTapped(3),
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const NavigationItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
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
