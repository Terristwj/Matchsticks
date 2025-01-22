import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matchsticks/screens/welcome_screen.dart';
import 'services/firebase_options.dart';

import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:matchsticks/.secrets.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Gemini.init(apiKey: geminiAPIKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matchsticks: EduTrekker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
    );
  }
}
