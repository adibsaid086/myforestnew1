import 'package:flutter/material.dart';

class PermitsListPage extends StatefulWidget {
  @override
  _PermitsListPageState createState() => _PermitsListPageState();
}

class _PermitsListPageState extends State<PermitsListPage> {
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> permits = [
    {
      'name': 'Adib said',
      'details': 'Mount Nuang',
    },
    {
      'name': 'Iqbal ishak',
      'details': 'Mount Hitam',
    },
    {
      'name': 'Tengku Zarul',
      'details': 'Mount Hitam',
    },
    {
      'name': 'Syafiy',
      'details': 'Mount Nuang',
    }
  ];
  List<Map<String, dynamic>> filteredPermits = [];

  @override
  void initState() {
    super.initState();
    filteredPermits = permits;
  }

  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPermits = permits;
      } else {
        filteredPermits = permits
            .where((permit) =>
            permit['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Permits List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search permit',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                      ),
                      onChanged: filterSearch,
                    ),
                  ),
                  Icon(Icons.search, color: Colors.white),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Permits List
            Expanded(
              child: ListView.builder(
                itemCount: filteredPermits.length,
                itemBuilder: (context, index) {
                  final permit = filteredPermits[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: Row(
                      children: [
                        // Placeholder for the icon
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.green[200],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.green[800],
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.0),
                        // Name and details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                permit['name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                permit['details'],
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14.0,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.0),
                        // Accept and reject icons
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red),
                              onPressed: () {
                                // Handle reject action
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                // Handle accept action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

