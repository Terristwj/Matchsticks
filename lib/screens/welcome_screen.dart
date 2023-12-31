// ignore_for_file: prefer_const_constructors

import 'package:matchsticks/style/constraints.dart';
import 'package:matchsticks/screens/home_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: kblue,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50))),
                  child: Column(
                    children: [
                      Expanded(child: Image.asset("assets/images/welcome.png"))
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  color: kblue,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Spacer(),
                          Tooltip(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 10.0,
                            ),
                            textAlign: TextAlign.center,
                            message:
                                "Team members:\nJulian Maximillian,\nAnna Lim, Tanisha,\nHyin Ki!, Terris Tan,",
                            child: Text(
                              "Matchsticks: EduTrekker",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Google Ignite 2023 Hackathon",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              wordSpacing: 2.5,
                              height: 1.5,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Tooltip(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.0,
                              vertical: 10.0,
                            ),
                            textAlign: TextAlign.center,
                            message:
                                "(Goal 4.1) By 2030, ensure that\nall girls and boys complete free,\nequitable and quality primary\nand secondary education\nleading to relevant and effective\nlearning outcomes",
                            child: Text(
                              "A Flutter App\nto promote self-learning\nfor kids and teens.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                wordSpacing: 5,
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Row(
                            //button position
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                height: 60,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                color: kpink,
                                onPressed: () {
                                  //home screen path
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                },
                                child: Text(
                                  "Demo Login",
                                  style: TextStyle(
                                      wordSpacing: 5,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
