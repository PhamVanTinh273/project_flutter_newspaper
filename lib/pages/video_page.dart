import 'package:flutter/material.dart';
import 'package:page_login/pages/personal_page.dart';
import 'package:page_login/pages/trend_page.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoPlayerApp extends StatefulWidget {
  @override
  _VideoPlayerAppState createState() => _VideoPlayerAppState();
}

// --- Biến trạng thái --- Thích ,không thích, bình luận.
class _VideoPlayerAppState extends State<VideoPlayerApp> {
  late VideoPlayerController _controller;
  int _currentIndex = 0;
  int _likeCount = 6600;
  int _dislikeCount = 1200;
  int _commentCount = 238;
  bool _isLiked = false;
  bool _isDisliked = false;
  bool _areCommentsVisible = false;
//lấy dữ liệu video player
  final List<Map<String, String>> _videos = [
    {
      'name': "Big Buck Bunny",
      'url':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    },
    {
      'name': "Tears of Steel",
      'url':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4",
    },
    {
      'name': "Elephant Dream",
      'url':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    },
    {
      "name": "Sintel",
      "url":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4",
    },
    {
      "name": "For Bigger Blazes",
      "url":
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    },
  ];
//quản lý danh sách các bình luận và kiểm soát đầu vào văn bản từ người dùng.
  List<String> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  //khởi tạo trình phát video với URL của video
  void initState() {
    super.initState();
    _initializeVideoPlayer(_videos[_currentIndex]['url']!);
  }

  void _initializeVideoPlayer(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
        });
      });
  }

//Dọn dẹp tài nguyên của VideoPlayerController khi không còn cần thiết
  void _disposeVideoController() {
    _controller.pause();
    _controller.dispose();
  }

//được sử dụng để chuyển đổi video trong danh sách
  void _changeVideo(int index) {
    setState(() {
      _disposeVideoController();
      _currentIndex = index;
      _initializeVideoPlayer(_videos[_currentIndex]['url']!);
    });
  }

//sử dụng để quản lý trạng thái "like" (thích) và "dislike" (không thích)
  void _toggleLike() {
    setState(() {
      if (_isLiked) {
        _likeCount--;
      } else {
        _likeCount++;
        if (_isDisliked) {
          _dislikeCount--;
          _isDisliked = false;
        }
      }
      _isLiked = !_isLiked;
    });
  }

  void _toggleDislike() {
    setState(() {
      if (_isDisliked) {
        _dislikeCount--;
      } else {
        _dislikeCount++;
        if (_isLiked) {
          _likeCount--;
          _isLiked = false;
        }
      }
      _isDisliked = !_isDisliked;
    });
  }

//sử dụng để chia sẻ liên kết của một video trong danh sách
  Future<void> _shareVideo() async {
    try {
      String videoName = _videos[_currentIndex]['name']!;
      String videoUrl = _videos[_currentIndex]['url']!;
      await Share.share("Watch \"$videoName\" at: $videoUrl");
    } catch (e) {
      print("Share failed: $e");
    }
  }

  @override
  //sử dụng để dọn dẹp các tài nguyên và bộ điều khiển (controllers) khi widget không còn cần thiết hoặc khi widget bị hủy
  void dispose() {
    _disposeVideoController();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (_controller.value.isInitialized)
              AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: IconButton(
                        icon: Icon(
                          //xét điều kiện kiểm tra trạng thái volume
                          _controller.value.volume > 0
                              ? Icons.volume_up
                              : Icons.volume_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          ///làm thay đổi biểu tượng âm lượng
                          setState(() {
                            _controller.setVolume(
                                _controller.value.volume > 0 ? 0 : 1);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            //Tạo một khoảng cách dọc cố định và tạo v hiển thị các nút hành động.
            const SizedBox(height: 16),
            _buildActionButtons(),
            const Divider(color: Colors.white),
            if (_areCommentsVisible) _buildCommentsSection(),
            const SizedBox(height: 16),
            _buildNavigationButtons(),
          ],
        ),
      ),
      //thanh điều hướng cúa áp
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildActionButton(Icons.thumb_up,
            "${(_likeCount / 15).toStringAsFixed(1)}K", _toggleLike,
            isActive: _isLiked),
        _buildActionButton(Icons.thumb_down,
            "${(_dislikeCount / 20).toStringAsFixed(1)}K", _toggleDislike,
            isActive: _isDisliked),
        _buildActionButton(Icons.comment, "$_commentCount", () {
          setState(() {
            _areCommentsVisible = !_areCommentsVisible;
          });
        }),
        _buildActionButton(Icons.share, "Share", _shareVideo),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed,
      {bool isActive = false}) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: isActive ? Colors.red : Colors.white),
          iconSize: 32,
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "Enter a comment...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: Colors.teal[700]),
                onPressed: () {
                  setState(() {
                    if (_commentController.text.isNotEmpty) {
                      _comments.add(_commentController.text);
                      _commentController.clear();
                      _commentCount++;
                    }
                  });
                },
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _comments.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                _comments[index],
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ],
    );
  }

  ///Tạo thanh chức năng của video
  Widget _buildNavigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            if (_currentIndex > 0) _changeVideo(_currentIndex - 1);
          },
          icon: const Icon(Icons.arrow_back),
          label: const Text("Previous"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            _controller.pause();
          },
          icon: const Icon(Icons.stop),
          label: const Text("Stop"),
        ),
        ElevatedButton.icon(
          onPressed: () {
            if (_currentIndex < _videos.length - 1)
              _changeVideo(_currentIndex + 1);
          },
          icon: const Icon(Icons.arrow_forward),
          label: const Text("Next"),
        ),
      ],
    );
  }
}
