import 'package:flutter/material.dart';
import 'package:matchsticks/screens/home_screen.dart';
import 'package:matchsticks/screens/welcome_screen.dart';
import 'package:matchsticks/style/constraints.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.isHome,
  });

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              if (!isHome) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            },
            icon: const Icon(
              Icons.home,
              color: kblue,
            ),
            tooltip: "To Home",
          ),
          Container(
            child: TextButton.icon(
              label: Text("Matchsticks"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
              icon: const Icon(Icons.local_fire_department),
              style: TextButton.styleFrom(),
            ),
          ),
        ],
      ),
    );
  }
}
