import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myforestnew/Pages/HomPage.dart';
import 'package:myforestnew/Pages/navigation.dart';
import 'package:myforestnew/permit/Permit.dart';
import 'package:myforestnew/Pages/savedpage.dart';
import 'package:myforestnew/Pages/setting.dart';
import 'package:myforestnew/permit/permitPending.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4; // Set initial index to "Profile" tab
  final PageController _pageController = PageController(initialPage: 4);

  // User data variables
  String userName = "Loading...";
  String userEmail = "Loading...";
  String userCity = "Loading...";
  int userAge = 0;
  String userImage = "assets/profile.jpg";

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentSnapshot profileSnapshot = await FirebaseFirestore.instance
            .collection('profile')
            .doc(user.uid)
            .get();

        if (profileSnapshot.exists) {
          final profileData = profileSnapshot.data() as Map<String, dynamic>;

          setState(() {
            userName = "${profileData['first_name']} ${profileData['last_name']}";
            userEmail = profileData['email'] ?? "No email provided";
            userCity = profileData['city'] ?? "Unknown";
            userAge = int.tryParse(profileData['age'].toString()) ?? 0;
            userImage = profileData['profile_image'] ?? "assets/profile.jpg";
          });
        }
      }
    } catch (e) {
      print("Error fetching profile data: $e");
    }
  }

  void _onNavItemTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => _onNavItemTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? Color(0xFFFFFFFF) : Color(0xFFB0B0B0),
            size: 30,
          ),
          if (isSelected)
            Text(
              label,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF1F1F1F),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomePage(),
              Permit(),
              Navigation(),
              SavedPage(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 95.0),
                        Center(
                          child: CircleAvatar(
                            radius: 130,
                            backgroundImage: AssetImage(userImage),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(color: Colors.white, fontSize: 30 ,fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: Icon(Icons.settings, color: Colors.white),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Setting()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            '$userAge Years Old',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            userEmail,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                userCity,
                                style: TextStyle(color: Colors.white, fontSize: 15),
                              ),
                              SizedBox(width: 8.0),
                              Image.asset(
                                'assets/my.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PermitStatus()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Permit Status',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Icon(Icons.arrow_forward,
                                        color: Colors.black),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            left: 16,
            right: 16,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF2B2B2B),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    icon: Icons.home,
                    label: 'Home',
                    isSelected: _currentIndex == 0,
                    index: 0,
                  ),
                  _buildNavItem(
                    icon: Icons.insert_drive_file,
                    label: 'Permit',
                    isSelected: _currentIndex == 1,
                    index: 1,
                  ),
                  _buildNavItem(
                    icon: Icons.navigation,
                    label: 'Navigation',
                    isSelected: _currentIndex == 2,
                    index: 2,
                  ),
                  _buildNavItem(
                    icon: Icons.bookmark,
                    label: 'Saved',
                    isSelected: _currentIndex == 3,
                    index: 3,
                  ),
                  _buildNavItem(
                    icon: Icons.person,
                    label: 'Profile',
                    isSelected: _currentIndex == 4,
                    index: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
