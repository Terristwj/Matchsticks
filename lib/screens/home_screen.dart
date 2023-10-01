import 'package:flutter/material.dart';
import 'package:flutter_learnings/screens/note_add_screen.dart';
import 'package:flutter_learnings/screens/note_reader_screen.dart';
import 'package:flutter_learnings/style/app_style.dart';
import 'package:flutter_learnings/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Matchsticks',
          style: GoogleFonts.nunito(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppStyle.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your recent Notes',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Notes")
                      .snapshots(),
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
                        print(myData);

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
            )
          ],
        ),
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
