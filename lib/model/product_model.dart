import 'package:flutter/material.dart';
import 'package:matchsticks/screens/lucky_screen.dart';
import 'package:matchsticks/screens/notes/notes_screen.dart';
import 'package:matchsticks/screens/quizzes/quiz.dart';

class Product {
  final String image, title, description;
  final int id;
  final Color color;
  final Widget page;
  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.id,
    required this.page,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: "Notes",
    image: "assets/images/categories/notes.png",
    color: const Color(0xFF71b8ff),
    description: "Make your own notes",
    page: const NotesScreen(),
  ),
  Product(
    id: 2,
    title: "Quizzes",
    image: "assets/images/categories/quiz.png",
    color: const Color(0xFFff6374),
    description: "Test your knowledge",
    page: const Quiz(),
  ),
  Product(
    id: 3,
    title: "Lucky",
    image: "assets/images/categories/lucky.png",
    color: const Color(0xFFffaa5b),
    description: "Are you lucky today?",
    page: const LuckyScreen(),
  ),
  Product(
    id: 4,
    title: "Chat with Pam",
    image: "assets/images/categories/chat.png",
    color: const Color(0xFF9ba0fc),
    description: "Ask Pam for help!",
    page: const NotesScreen(),
  ),
];
