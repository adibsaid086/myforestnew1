import 'package:flutter/material.dart';
import 'package:myforestnew/Pages/profile.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}
class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildTextField('First Name'),
            SizedBox(height: 16),
            _buildTextField('Last Name'),
            SizedBox(height: 16),
            _buildTextField('Email'),
            SizedBox(height: 16),
            _buildDropdownField('Age'),
            SizedBox(height: 32),
            Text(
              'Location',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildTextField('City'),
            SizedBox(height: 32),
            Text(
              'Privacy',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildSwitch('Notifications'),
            _buildSwitch('Turn On Location'),
            SizedBox(height: 32),

            // Account Section
            Text(
              'Account',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildPressableArrowSection('Account', 'Delete Account', context),
            SizedBox(height: 32),

            // Legal Section
            Text(
              'Legal',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildPressableArrowSection('Legal', 'Terms & Conditions', context),
            _buildPressableArrowSection('Legal', 'About MyForest', context),

            // Save button aligned to the right
            SizedBox(height: 32),
            _buildSaveButtonAlignedRight(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String labelText) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.black,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      items: List.generate(100, (index) => (index + 1).toString())
          .map((age) => DropdownMenuItem(
        child: Text(age),
        value: age,
      ))
          .toList(),
      onChanged: (value) {
        // Handle age selection
      },
    );
  }

  Widget _buildSwitch(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          Switch(
            value: false,
            onChanged: (value) {
              // Handle switch state change
            },
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildPressableArrowSection(String sectionTitle, String optionText, BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle tap (Navigate to corresponding page or action)
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              optionText,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSaveButtonAlignedRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
  },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          'Save',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}

