import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsSummary extends StatelessWidget {
  const ResultsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(
        minWidth: 300,
        maxWidth: 500,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: summaryData.map((question) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Index

                Container(
                  width: 30,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: question["correct_answer"] == question["user_answer"]
                        ? Colors.lightGreenAccent
                        : Colors.redAccent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    ((question["index"] as int) + 1).toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Summary
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question["question"] as String,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        question["correct_answer"] as String,
                        style: GoogleFonts.lato(
                          color: Colors.pink[100],
                        ),
                      ),
                      Text(
                        question["user_answer"] as String,
                        style: GoogleFonts.lato(
                          color: Colors.blue[100],
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
