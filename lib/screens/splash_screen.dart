import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 2),
              child: Image.asset('assets/logo.png', height: 120),
            ),
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
