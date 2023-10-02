import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subject {
  final String image, title, description;
  final int id;
  final Color color;
  Subject({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.id,
  });
}

class StartScreen extends StatelessWidget {
  const StartScreen({
    super.key,
    required this.onExit,
  });

  final void Function() onExit;

  @override
  Widget build(context) {
    List<Subject> subjects = [
      Subject(
        id: 1,
        title: "Mathematics",
        image: "assets/images/categories/notes.png",
        color: const Color(0xFF71b8ff),
        description: "Make your own notes",
      ),
      Subject(
        id: 2,
        title: "Science",
        image: "assets/images/categories/quiz.png",
        color: const Color(0xFFff6374),
        description: "Test your knowledge",
      ),
      Subject(
        id: 3,
        title: "History",
        image: "assets/images/categories/lucky.png",
        color: const Color(0xFFffaa5b),
        description: "Are you lucky today?",
      ),
      Subject(
        id: 4,
        title: "Art",
        image: "assets/images/categories/chat.png",
        color: const Color(0xFF9ba0fc),
        description: "Ask Pam for help!",
      )
    ];
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Chose a Subject!',
            style: GoogleFonts.lato(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(onExit: onExit, subject: subjects[0]),
                    CategoryCard(onExit: onExit,subject: subjects[1])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(onExit: onExit,subject: subjects[2]),
                    CategoryCard(onExit: onExit,subject: subjects[3]),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: onExit,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              padding: const EdgeInsets.all(20),
              shape: const StadiumBorder(),
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.onExit,
    required this.subject,
  });
  final Subject subject;
  final void Function() onExit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.1,
      height: 275,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 5.0,
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              onExit();
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: subject.color,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Image.asset(
                    subject.image,
                    height: 100,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subject.title,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    subject.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
