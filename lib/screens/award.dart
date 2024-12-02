import 'package:flutter/material.dart';

import '../const/color.dart';

class Award extends StatefulWidget {
  const Award({super.key});

  @override
  State<Award> createState() => _AwardState();
}

class _AwardState extends State<Award> {
  // Example user points
  int userPoints = 60; // You can replace this with the actual points from your data source

  @override
  Widget build(BuildContext context) {
    String awardMessage;
    String awardImageUrl;
    String nextAwardMessage;
    int pointsNeeded;

    // Determine the award based on user points
    if (userPoints >= 100) {
      awardMessage = 'You have earned a Gold Award!';
      awardImageUrl = 'https://png.pngtree.com/png-vector/20240204/ourmid/pngtree-gold-trophy-symbol-png-image_11611530.png'; // Replace with actual image URL
      nextAwardMessage = 'You have reached the highest award!';
      pointsNeeded = 0;
    } else if (userPoints >= 50) {
      awardMessage = 'You have earned a Silver Award!';
      awardImageUrl = 'https://static.vecteezy.com/system/resources/previews/041/856/368/non_2x/ai-generated-silver-trophy-isolated-on-white-background-free-png.png'; // Replace with actual image URL
      nextAwardMessage = 'Next award: Gold Award';
      pointsNeeded = 100 - userPoints;
    } else {
      awardMessage = 'You have earned a Bronze Award!';
      awardImageUrl = 'https://static.tiktokemoji.com/202410/20/v58Wd9yX.webp'; // Replace with actual image URL
      nextAwardMessage = 'Next award: Silver Award';
      pointsNeeded = 50 - userPoints;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Award'),
        backgroundColor: Colors.green[400],
      ),
      backgroundColor: Colors.green[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animated Trophy Image
            AnimatedContainer(
              duration: const Duration(seconds: 2),
              curve: Curves.elasticOut,
              height: 150,
              width: 150,
              child: Image.network(awardImageUrl),
            ),
            const SizedBox(height: 20),
            // Congratulations Text with Shadow Effect
            Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
                shadows: const [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black45,
                    offset: Offset(3.0, 3.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              awardMessage,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.green[600],
              ),
            ),
            const SizedBox(height: 30),
            // Award Message with Icon and Animation
            AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(seconds: 3),
              child: const Text(
                'Keep up the great work!',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Next Award Information
            Text(
              nextAwardMessage,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.green[600],
              ),
            ),
            if (pointsNeeded > 0)
              Text(
                'Points needed: $pointsNeeded',
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: Colors.green[400],
                ),
              ),
          ],
        ),
      ),
    );
  }
}