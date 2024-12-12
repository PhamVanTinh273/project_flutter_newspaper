import 'package:flutter/material.dart';
import 'package:page_login/pages/home_page.dart';

class ScreenCategories extends StatefulWidget {
  const ScreenCategories({super.key});

  @override
  State<ScreenCategories> createState() => _CategoriesState();
}

class _CategoriesState extends State<ScreenCategories> {
  final List<String> _categories = [
    "Nóng",
    "Mới",
    "Bóng đá VN",
    "Bóng đá QT",
    "Độc & Lạ",
    "Tình yêu",
    "Giải trí",
    "Thế giới",
    "Pháp luật",
    "Xe 360",
    "Công nghệ",
    "Ẩm thực",
    "Làm đẹp",
    "Sức khỏe",
    "Du lịch",
    "+ Thêm chuyên mục"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tiêu đề và nút quay lại
            Container(
              height: 50,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 26, 159, 150),
                  Color.fromARGB(255, 24, 92, 165)
                ], begin: Alignment.bottomLeft, end: Alignment.topRight),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(children: [
                  Container(
                    margin: const EdgeInsets.only(left: 200),
                    child: const Text(
                      'Chuyên mục',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 145),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ),
            ),
            // Nội dung chính
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        'CHỌN CHẾ ĐỘ HỌC',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Phần chế độ học
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Chế độ đơn giản',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 3, top: 2),
                            height: 15,
                            width: 15,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  // Nút chọn danh sách
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(5),
                          height: 30,
                          width: 230,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 26, 159, 150),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Danh sách to',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100),
                            ),
                          )),
                      Container(
                          padding: const EdgeInsets.all(5),
                          height: 30,
                          width: 230,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Danh sách nhỏ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w100),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Phần thay đổi
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Thay đổi',
                        style: TextStyle(
                          color: Color.fromARGB(255, 26, 159, 150),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _showCategoryList(context);
                        },
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 300,
                    child: GridView.count(
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: List.generate(_categories.length, (index) {
                        return Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 250,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Text(
                            _categories[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Nguồn báo nổi bật
            Container(
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "NGUỒN BÁO NỔI BẬT",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image1.png'),
                              radius: 30,
                            ),
                            Text("VietnamNet"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image2.jpg'),
                              radius: 30,
                            ),
                            Text("TTXVN"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image3.png'),
                              radius: 30,
                            ),
                            Text("VTC News"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image4.jpg'),
                              radius: 30,
                            ),
                            Text("VOV"),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image5.jpg'),
                              radius: 30,
                            ),
                            Text("VietnamPlus"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image6.png'),
                              radius: 30,
                            ),
                            Text("PLO"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image7.png'),
                              radius: 30,
                            ),
                            Text("NLĐ"),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/image8.png'),
                              radius: 30,
                            ),
                            Text("Saostar"),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: Colors.grey[300],
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Xem tất cả',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }

  void _showCategoryList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn chuyên mục'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _categories.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_categories[index]),
                  onTap: () {
                    // Hành động khi nhấn vào chuyên mục
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// Định nghĩa ListCategories (Ví dụ đơn giản)
class ListCategories extends StatelessWidget {
  const ListCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách chuyên mục')),
      body: Center(
        child: const Text('Nội dung danh sách chuyên mục ở đây'),
      ),
    );
  }
}
