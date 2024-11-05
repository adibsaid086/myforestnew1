import 'package:flutter/material.dart';
import 'package:myforestnew/Pages/ForgetPass.dart';
import 'package:myforestnew/Pages/HomPage.dart';
import 'package:myforestnew/Pages/SignUp.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background color to match the design
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tree icon or logo (placeholder for now)
            Center(
              child: Image.asset(
                'assets/myforestlogo.jpg',
                height: 150,
              ),
            ),
            SizedBox(height: 20),
            // Title
            Text(
              'MyForest',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 40),
            // Username input field
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Username',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            SizedBox(height: 20),
            // Password input field
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                hintText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            // Forgot password link
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => forgetPass()
                    ),
                  );
                },
                child: Text(
                  'Forget Password?',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
              ),
            ),
            SizedBox(height: 30),
            // Login button (arrow icon)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                backgroundColor: Colors.white,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.black,
                size: 30,
              ),
            ),
            SizedBox(height: 40),
            // Signup prompt
            Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.white70),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ),
                );
              },
              child: Text(
                'Sign up now',
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}