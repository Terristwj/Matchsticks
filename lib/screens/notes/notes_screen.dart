import 'package:flutter/material.dart';
import 'package:matchsticks/screens/notes/note_add_screen.dart';
import 'package:matchsticks/screens/notes/note_reader_screen.dart';
import 'package:matchsticks/style/app_style.dart';
import 'package:matchsticks/widgets/home_screen/appbar.dart';
import 'package:matchsticks/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      // appBar: AppBar(
      //   elevation: 0.0,
      //   title: Text(
      //     'Matchsticks',
      //     style: GoogleFonts.nunito(color: Colors.white),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: AppStyle.mainColor,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(isHome: false),
          const SizedBox(height: 10.0),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Text(
              'Your recent Notes',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    var myData = snapshot.data!.docs.map((note) {
                      return note.data();
                    }).toList();

                    if (myData.isNotEmpty) {
                      // sort myData by creation_date
                      myData.sort((a, b) {
                        var adate = a is Map<String, dynamic>
                            ? a['creation_datetime']
                            : null;
                        var bdate = b is Map<String, dynamic>
                            ? b['creation_datetime']
                            : null;
                        return adate.compareTo(
                            bdate); //to get the order other way just switch `adate & bdate`
                      });

                      return GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        children: snapshot.data!.docs
                            .map((note) => noteCard(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            NoteReaderScreen(note),
                                      ));
                                }, note))
                            .toList(),
                      );
                    }
                  }
                  return Text(
                    "There's no Notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NoteAddScreen(),
              ));
        },
        label: const Text("Add Note"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
