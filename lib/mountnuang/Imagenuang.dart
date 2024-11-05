import 'package:flutter/material.dart';


class ImageNuang extends StatefulWidget {
  @override
  _ImageGalleryPageState createState() => _ImageGalleryPageState();
}

class _ImageGalleryPageState extends State<ImageNuang> {
  // List of images (hardcoded within this page)
  final List<String> imgList = [
    'assets/nuang/nuang1.png',
    'assets/nuang/nuang2.jpeg',
    'assets/nuang/nuang3.jpg',
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize the PageController to start from the first image
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
      ),
      body: PageView.builder(
        controller: _pageController, // Start at the first image
        itemCount: imgList.length, // Total number of images
        itemBuilder: (context, index) {
          return Center(
            child: Image.asset(
              imgList[index], // Display each image
              fit: BoxFit.contain, // Ensure the image fits within the available space
            ),
          );
        },
      ),
    );
  }
}

