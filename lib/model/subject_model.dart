import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int id;
  final Color color;
  Product({
    required this.image,
    required this.title,
    required this.description,
    required this.color,
    required this.id,
  });
}

List<Product> subjects = [
  Product(
    id: 1,
    title: "Maths",
    image: "assets/images/categories/notes.png",
    color: const Color(0xFF71b8ff),
    description: "Make your own notes",
  ),
  Product(
    id: 2,
    title: "Sciences",
    image: "assets/images/categories/quiz.png",
    color: const Color(0xFFff6374),
    description: "Test your knowledge",
  ),
  Product(
    id: 3,
    title: "History",
    image: "assets/images/categories/lucky.png",
    color: const Color(0xFFffaa5b),
    description: "Are you lucky today?",
  ),
  Product(
    id: 4,
    title: "Arts",
    image: "assets/images/categories/chat.png",
    color: const Color(0xFF9ba0fc),
    description: "Ask Pam for help!",
  ),
];
