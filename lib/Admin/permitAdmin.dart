import 'package:flutter/material.dart';
import 'package:myforestnew/Admin/ApprovalPage.dart';

class PermitAdmin extends StatefulWidget {
  @override
  _PermitAdminFormState createState() => _PermitAdminFormState();
}

class _PermitAdminFormState extends State<PermitAdmin> {
  String selectedMountain = 'Mount Nuang';
  int numberOfParticipants = 1;
  DateTimeRange? selectedDateRange;
  List<Map<String, String>> participants = [];
  String guideNo = ''; // Variable to hold the guide number

  final List<String> mountains = [
    'Mount Nuang',
    'Mount Hitam',
    'Bukit Lagong',
    'Bukit Pau',
    'Bukit Sri Bintang',
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    participants = List.generate(numberOfParticipants, (index) => {
      "name": "",
      "phone": "",
      "emergency": ""
    });
  }

  void updateParticipants(int count) {
    setState(() {
      numberOfParticipants = count;
      participants = List.generate(
          count, (index) => {"name": "", "phone": "", "emergency": ""});
    });
  }

  void _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.white, // Header background color
              onPrimary: Colors.black, // Header text color
              surface: Colors.black, // Background of the calendar
              onSurface: Colors.white, // Text color of the days
            ),
            dialogBackgroundColor: Colors.black,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  InputDecoration _buildRoundedInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.black,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.0), // More rounded corners
        borderSide: BorderSide(color: Colors.white), // White border
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(7.0),
        borderSide: BorderSide(
            color: Colors.white, width: 2.0), // Blue border when focused
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // White back arrow
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            'Permit Application Form',
            style: TextStyle(
              fontSize: 19,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PermitsListPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25), // Rounded corners
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text('Permit List'),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Mountain Dropdown
                      DropdownButtonFormField<String>(
                        value: selectedMountain,
                        dropdownColor: Colors.black,
                        decoration: _buildRoundedInputDecoration('Mountain/Hill'),
                        items: mountains.map((String mountain) {
                          return DropdownMenuItem<String>(
                            value: mountain,
                            child: Text(mountain,
                                style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMountain = newValue!;
                          });
                        },
                      ),

                      SizedBox(height: 8), // Smaller space below the dropdown

                      // Guide No field (conditional)
                      if (selectedMountain.contains('Mount')) // Show only for mountains
                        TextFormField(
                          decoration: _buildRoundedInputDecoration('Guide No'),
                          onChanged: (value) {
                            guideNo = value; // Update guide number
                          },
                        ),

                      SizedBox(height: 16), // Space before the date range

                      // Date Range Picker
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: _buildRoundedInputDecoration('From:'),
                              readOnly: true,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: TextEditingController(
                                  text: selectedDateRange != null
                                      ? "${selectedDateRange?.start.toString().split(' ')[0]}"
                                      : ''),
                              onTap: _selectDateRange,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              decoration: _buildRoundedInputDecoration('To:'),
                              readOnly: true,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              controller: TextEditingController(
                                  text: selectedDateRange != null
                                      ? "${selectedDateRange?.end.toString().split(' ')[0]}"
                                      : ''),
                              onTap: _selectDateRange,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // Number of Participants
                      DropdownButtonFormField<int>(
                        value: numberOfParticipants,
                        dropdownColor: Colors.black,
                        decoration: _buildRoundedInputDecoration('No. of Participants'),
                        items: List.generate(10, (index) => index + 1).map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString(),
                                style: TextStyle(color: Colors.white)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          updateParticipants(newValue!);
                        },
                      ),

                      SizedBox(height: 16),

                      // Participants Details
                      Text('Participants Details',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 16), // Added space between label and input box
                      for (int i = 0; i < numberOfParticipants; i++)
                        Column(
                          children: [
                            TextFormField(
                              decoration: _buildRoundedInputDecoration('Full Name'),
                              onChanged: (value) {
                                participants[i]["name"] = value;
                              },
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    decoration: _buildRoundedInputDecoration('Phone Number'),
                                    onChanged: (value) {
                                      participants[i]["phone"] = value;
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    decoration: _buildRoundedInputDecoration('Emergency Number'),
                                    onChanged: (value) {
                                      participants[i]["emergency"] = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),

                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),

            // Submit Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    print("Mountain: $selectedMountain");
                    print("Date Range: ${selectedDateRange?.start} to ${selectedDateRange?.end}");
                    for (var participant in participants) {
                      print("Participant: ${participant['name']}, Phone: ${participant['phone']}, Emergency: ${participant['emergency']}");
                    }
                    if (selectedMountain.contains('Mount')) {
                      print("Guide No: $guideNo"); // Output guide number only if applicable
                    }
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // White background for button
                  foregroundColor: Colors.black, // Black text on button
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25), // More rounded button
                  ),
                  minimumSize: Size(double.infinity, 50), // Full width button
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


