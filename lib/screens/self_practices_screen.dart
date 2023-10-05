import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:matchsticks/services/palm_service.dart";
import "package:matchsticks/widgets/home_screen/appbar.dart";

// Container Widget
class SelfPracticesScreen extends StatefulWidget {
  const SelfPracticesScreen({super.key});

  @override
  State<SelfPracticesScreen> createState() {
    return _SelfPracticesScreen();
  }
}

class _SelfPracticesScreen extends State<SelfPracticesScreen> {
  final PaLMService palmAIService = PaLMService();
  String aiResponse = "Click the button!";
  bool hasLoaded = false;
  bool isLoading = false;
  double fontSize = 22.0;

  @override
  Widget build(BuildContext context) {
    void isThinking() {
      setState(() {
        hasLoaded = false;
        isLoading = true;
        fontSize = 22.0;
        aiResponse = "Sing like no one is listening.";
      });
    }

    Future getQuestion() async {
      setState(() {
        aiResponse = "Sing like no one is listening.";
      });
      await palmAIService.generateQuestionAndAnswers().then(
        (value) {
          setState(() {
            hasLoaded = true;
            isLoading = false;
            fontSize = 16.0;
            aiResponse = value;
          });
          // print(value);
          // print(aiResponse);
        },
      );
    }

    void thinkingOfQuestion() {
      isThinking();
      getQuestion();
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 240, 226),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(isHome: false),
          const SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25.0,
                top: 10.0,
                bottom: 75.0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasLoaded)
                        Flexible(
                          child: Text(
                            aiResponse,
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      if (!hasLoaded)
                        Flexible(
                          child: Text(
                            aiResponse,
                            style: GoogleFonts.roboto(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      if (isLoading)
                        const Row(
                          children: [
                            SizedBox(width: 15.0),
                            CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          thinkingOfQuestion();
        },
        label: const Text("Practice!"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
