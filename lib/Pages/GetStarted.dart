import 'package:flutter/material.dart';
import 'package:myforestnew/Pages/Login.dart';

class Getstarted extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<Getstarted> {
  PageController _pageController = PageController();
  int currentIndex = 0;

  // List of onboarding screens data
  final List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    // Initialize the onboarding pages, passing the same PageController
    pages.addAll([
      OnboardingPage(
        title: 'New To Hike Community',
        description: '',
        image: 'assets/getstartedbg.jpg', // Replace with your image
        showSkip: true,
        pageController: _pageController, // Pass the controller
      ),
      OnboardingPage(
        title: 'Trail',
        description: 'Map Navigation',
        image: 'assets/getstartedbg.jpg', // Replace with your image
        showSkip: true,
        pageController: _pageController, // Pass the controller
      ),
      OnboardingPage(
        title: 'Permit',
        description: 'Apply Selangor Permit',
        image: 'assets/getstartedbg.jpg', // Replace with your image
        showSkip: false,
        showButton: true,
        pageController: _pageController, // Pass the controller
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView for sliding between pages
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return pages[index];
            },
          ),
          // Dots indicator
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                    (index) => buildDot(index, context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 10,
      width: currentIndex == index ? 12 : 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.white : Colors.white70,
        shape: BoxShape.circle,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String? description;
  final String image;
  final bool showSkip;
  final bool showButton;
  final PageController pageController;

  OnboardingPage({
    required this.title,
    this.description,
    required this.image,
    this.showSkip = false,
    this.showButton = false,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center text horizontally
              ),
              if (description != null) ...[
                SizedBox(height: 10),
                Text(
                  description!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center, // Center text horizontally
                ),
              ],
            ],
          ),
        ),
        // Skip button (optional)
        if (showSkip)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: TextButton(
                onPressed: () {
                  pageController.animateToPage(
                    2,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        if (showButton)
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );
                },
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

