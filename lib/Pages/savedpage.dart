import 'package:flutter/material.dart';
import 'package:myforestnew/Pages/HomPage.dart';
import 'package:myforestnew/permit/Permit.dart';
import 'package:myforestnew/Pages/profile.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Map<String, String>> listItems = [
    {'title': 'Bukit Guling Ayam', 'distance': '1KM', 'image': 'assets/ayam/ayam2.jpg'},
    {'title': 'Another Place', 'distance': '5KM', 'image': 'assets/ayam/ayam1.jpg'},
  ];

  List<Map<String, String>> downloadItems = [
    {'title': 'Bukit Lagong', 'distance': '4.3KM', 'image': 'assets/ayam/ayam1.jpg'},
    {'title': 'Mount Nuang', 'distance': '17.9KM', 'image': 'assets/ayam/ayam2.jpg'},
  ];

  TextEditingController listSearchController = TextEditingController();
  TextEditingController downloadSearchController = TextEditingController();

  List<Map<String, String>> filteredListItems = [];
  List<Map<String, String>> filteredDownloadItems = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    filteredListItems = listItems;
    filteredDownloadItems = downloadItems;
  }

  @override
  void dispose() {
    _tabController.dispose();
    listSearchController.dispose();
    downloadSearchController.dispose();
    super.dispose();
  }

  void searchList(String query) {
    setState(() {
      filteredListItems = listItems.where((item) {
        return item['title']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void searchDownload(String query) {
    setState(() {
      filteredDownloadItems = downloadItems.where((item) {
        return item['title']!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark, // Black/dark theme
        primaryColor: Colors.white, // Set primary color to white
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white, // Tab label text color
          unselectedLabelColor: Colors.grey, // Unselected tab text color
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white, width: 2), // Tab underline in white
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Saved', style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Lists'),
              Tab(text: 'Download'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: listSearchController,
                    decoration: InputDecoration(
                      labelText: 'Search Lists',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: searchList,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: filteredListItems.length + 1, // Add 1 for SizedBox
                    itemBuilder: (context, index) {
                      if (index == filteredListItems.length) {
                        return SizedBox(height: 85.0); // Add some space at the bottom
                      }
                      var item = filteredListItems[index];
                      return buildImageCard(
                        item['title']!,
                        item['distance']!,
                        item['image']!,
                      );
                    },
                  ),
                ),

              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: downloadSearchController,
                    decoration: InputDecoration(
                      labelText: 'Search Downloads',
                      labelStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onChanged: searchDownload,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: filteredDownloadItems.length + 1, // Add 1 for SizedBox
                    itemBuilder: (context, index) {
                      if (index == filteredDownloadItems.length) {
                        return SizedBox(height: 85.0); // Add some space at the bottom
                      }
                      var item = filteredDownloadItems[index];
                      return buildDownloadCard(
                        item['title']!,
                        item['distance']!,
                        item['image']!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget buildImageCard(String title, String distance, String imagePath) {
    return Card(
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(imagePath),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              distance,
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDownloadCard(String title, String distance, String mapPath) {
    return Card(
      color: Colors.grey[850],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(mapPath),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              distance,
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }
}