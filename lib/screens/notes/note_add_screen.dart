import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matchsticks/style/app_style.dart';
import 'package:intl/intl.dart';

class NoteAddScreen extends StatefulWidget {
  const NoteAddScreen({super.key});

  @override
  State<NoteAddScreen> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteAddScreen> {
  int colorId = Random().nextInt(AppStyle.cardsColor.length);

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int hour = int.parse(
      DateFormat('kk').format(DateTime.now()),
    );
    String hourSymbol = "AM";

    if (hour >= 12) {
      if (hour > 12) {
        hour = hour - 12;
      }
      hourSymbol = "PM";
    }

    String dateFull = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String minute = DateFormat('mm').format(DateTime.now());

    String date = "$dateFull ${hour.toString()}:$minute $hourSymbol";

    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Add a new Note",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 8.0),
            Text(
              date,
              style: AppStyle.dateTitle,
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Content",
              ),
              style: AppStyle.mainContent,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "note_title": _titleController.text,
            "note_content": _mainController.text,
            "creation_date_str": date,
            "creation_datetime": DateTime.now().toString(),
            "color_id": colorId,
          }).then((value) {
            Navigator.pop(context);
          }).catchError(
              // ignore: invalid_return_type_for_catch_error, avoid_print
              (error) => print("Failed to add new Note due to $error"));
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
