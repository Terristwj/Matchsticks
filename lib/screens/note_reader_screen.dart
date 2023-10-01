import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learnings/screens/note_edit_screen.dart';
import 'package:flutter_learnings/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {super.key});

  final QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              padding: const EdgeInsets.all(16.0),
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              FirebaseFirestore.instance
                  .collection("Notes")
                  .doc(widget.doc.id)
                  .delete()
                  .then((_) => Navigator.pop(context))
                  .catchError((error) => print('Delete failed: $error'));
            },
            child: Row(
              children: [
                Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                ),
                Text(
                  'Delete',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 4.0),
            Text(
              widget.doc["creation_date_str"],
              style: AppStyle.mainTitle,
            ),
            SizedBox(height: 28.0),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditScreen(widget.doc),
              ));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
