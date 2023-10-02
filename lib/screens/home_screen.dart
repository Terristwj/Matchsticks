import 'dart:math';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:matchsticks/style/constraints.dart';
import 'package:flutter/material.dart';

import '../widgets/home_screen/appbar.dart';
import '../widgets/home_screen/category.dart';

final randomizer = Random();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = randomizer.nextInt(4);

  void randomizeFooter() {
    int random = randomizer.nextInt(4);
    while (random == _selectedIndex) {
      random = randomizer.nextInt(4);
    }

    setState(() {
      _selectedIndex = random;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            CustomAppBar(isHome: true, randomizeFooter: randomizeFooter),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello Student!",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Everyday is a great day\nto learn something new!",
                              style: TextStyle(
                                color: Colors.black54,
                                wordSpacing: 2.5,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                  color: kpurple,
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Image.asset(
                                "assets/images/profile.png",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //category list
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CategoryList(),
                ],
              ),
            )
          ],
        ),
      ),
      //bottom bar
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _selectedIndex,
        showElevation: true, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: const Icon(Icons.emoji_emotions),
              title: const Text('Happy'),
              activeColor: kpink,
              inactiveColor: Colors.grey[300]),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.local_florist),
            title: const Text('Pretty'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.icecream),
            textAlign: TextAlign.center,
            title: const Text('Sweet'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
          BottomNavyBarItem(
            textAlign: TextAlign.center,
            icon: const Icon(Icons.lunch_dining),
            title: const Text('Yummy!'),
            inactiveColor: Colors.grey[300],
            activeColor: kpink,
          ),
        ],
      ),
    );
  }
}
