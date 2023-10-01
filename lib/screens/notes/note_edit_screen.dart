import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matchsticks/style/app_style.dart';
import 'package:intl/intl.dart';

class NoteEditScreen extends StatefulWidget {
  NoteEditScreen(this.doc, {super.key});

  final QueryDocumentSnapshot doc;

  @override
  State<NoteEditScreen> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteEditScreen> {
  @override
  Widget build(BuildContext context) {
    int hour = int.parse(
      DateFormat('kk').format(DateTime.now()),
    );
    String hourSymbol = "AM";

    if (hour > 12) {
      hour = hour - 12;
      hourSymbol = "PM";
    }

    String dateFull = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String minute = DateFormat('mm').format(DateTime.now());

    String date = "$dateFull ${hour.toString()}:$minute $hourSymbol";

    TextEditingController titleController = TextEditingController();
    titleController.text = widget.doc['note_title'];

    TextEditingController mainController = TextEditingController();
    mainController.text = widget.doc['note_content'];

    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
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
              controller: titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Note Title",
              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.doc['creation_date_str'],
              style: AppStyle.dateTitle,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: mainController,
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
          var newData = {
            "note_title": titleController.text,
            "note_content": mainController.text,
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
            // ignore: invalid_return_type_for_catch_error, avoid_print
          }).catchError((error) => print('Update failed: $error'));
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
