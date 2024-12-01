import 'package:flutter/material.dart';
import 'package:moodmap/const/color.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBGColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/logo.jpeg', height: 250),
            SizedBox(height: 20),
            Text(
              "Your daily guide to emotional well-being",
              style: TextStyle(fontSize: 18, fontFamily: 'Nunito'),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: Text("Get Started"),
            ),
          ],
        ),
      ),
    );
  }
}
