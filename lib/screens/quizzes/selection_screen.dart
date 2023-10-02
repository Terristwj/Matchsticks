import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matchsticks/model/quiz_question.dart';
import 'package:matchsticks/model/subject_model.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({
    super.key,
    required this.onSubjectSelection,
  });

  final void Function(List<QuizQuestion>, Color color) onSubjectSelection;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose a Subject!',
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
                    CategoryCard(
                      onExit: onSubjectSelection,
                      subject: subjects[0],
                    ),
                    CategoryCard(
                      onExit: onSubjectSelection,
                      subject: subjects[1],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CategoryCard(
                      onExit: onSubjectSelection,
                      subject: subjects[2],
                    ),
                    CategoryCard(
                      onExit: onSubjectSelection,
                      subject: subjects[3],
                    ),
                  ],
                ),
              ],
            ),
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
  final void Function(List<QuizQuestion>, Color color) onExit;

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
              onExit(subject.questions, subject.color);
            },
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: subject.color,
                  borderRadius: BorderRadius.circular(15.0)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      subject.image,
                      height: 150,
                    ),
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
