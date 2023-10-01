import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learnings/style/app_style.dart';
import 'package:intl/intl.dart';

class NoteEditScreen extends StatefulWidget {
  NoteEditScreen(this.doc, {super.key});

  final QueryDocumentSnapshot doc;

  @override
  State<NoteEditScreen> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteEditScreen> {
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    _titleController..text = widget.doc['note_title'];
    var date = widget.doc['creation_date_str'];
    TextEditingController _mainController = TextEditingController();
    _mainController..text = widget.doc['note_content'];

    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Editting Note",
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
              decoration: InputDecoration(
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
              decoration: InputDecoration(
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
          var newData = {
            "note_title": _titleController.text,
            "note_content": _mainController.text,
            "creation_date_str": date,
            "creation_datetime": widget.doc['creation_datetime'],
            "color_id": colorId,
          };
          var collection = FirebaseFirestore.instance.collection('Notes');
          collection
              .doc(widget.doc.id) // <-- Doc ID where data should be updated.
              .update(newData)
              .then((_) {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 2);
          }).catchError((error) => print('Update failed: $error'));
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
