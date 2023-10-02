import 'package:flutter/material.dart';
import 'package:matchsticks/data/questions.dart';
import 'package:matchsticks/model/quiz_question.dart';

class Subject {
  final String image, title, description;
  final int id;
  final Color color;
  final List<QuizQuestion> questions;
  Subject({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.id,
    required this.questions,
  });
}

List<Subject> subjects = [
  Subject(
    id: 1,
    title: "Mathematics",
    image: "assets/images/subjects/pythagoras.jpg",
    color: const Color(0xFF71b8ff),
    description: "a² + b² = c²",
    questions: questionsMath,
  ),
  Subject(
    id: 2,
    title: "Science",
    image: "assets/images/subjects/newton.jpg",
    color: const Color(0xFFff6374),
    description: "Falling apples?",
    questions: questionsScience,
  ),
  Subject(
    id: 3,
    title: "Arts & Design",
    image: "assets/images/subjects/ross.jpg",
    color: const Color.fromARGB(255, 86, 178, 184),
    description: "Tree as a friend.",
    questions: questionsArt,
  ),
  Subject(
    id: 4,
    title: "Everything",
    image: "assets/images/subjects/globe.png",
    color: const Color(0xFF9ba0fc),
    description: "Lets take on the world!",
    questions: questionsAll,
  ),
];
