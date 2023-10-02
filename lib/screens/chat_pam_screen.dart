import 'package:matchsticks/screens/home_screen.dart';
import 'package:matchsticks/widgets/feature_box.dart';
import 'package:matchsticks/services/openai_service.dart';
import 'package:matchsticks/style/pallete.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:matchsticks/widgets/home_screen/appbar.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatPamScreen extends StatefulWidget {
  const ChatPamScreen({super.key});

  @override
  State<ChatPamScreen> createState() => _HomePageState();
}

class _HomePageState extends State<ChatPamScreen> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(1.05);
    await flutterTts.setPitch(1.2);

    List<Map<String, String>> voices = [
      // {"name": "Microsoft Zira - English (United States)", "locale": "en-US"},
      {"name": "Google UK English Female", "locale": "en-GB"},
      // {"name": "Google français", "locale": "fr-FR"},
      // {"name": "Google हिन्दी", "locale": "hi-IN"},
      // {"name": "Google 日本語", "locale": "ja-JP"},
      // {"name": "Google 한국의", "locale": "ko-KR"},
      // {"name": "國語（臺灣）", "locale": "zh-TW"},
    ];
    Map<String, String> voiceNow = voices[randomizer.nextInt(voices.length)];
    await flutterTts.setVoice(voiceNow);

    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: BounceInDown(
      //     child: const Text('Allen'),
      //   ),
      //   leading: const Icon(Icons.menu),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(isHome: false),
            SingleChildScrollView(
              child: Column(
                children: [
                  // virtual assistant picture
                  ZoomIn(
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 120,
                            width: 120,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: const BoxDecoration(
                              color: Pallete.assistantCircleColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Container(
                          height: 123,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/chat/images/virtualAssistant.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Pam",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  // chat bubble
                  FadeInRight(
                    child: Visibility(
                      visible: generatedImageUrl == null,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        margin:
                            const EdgeInsets.symmetric(horizontal: 40).copyWith(
                          top: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Pallete.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(20).copyWith(
                            topLeft: Radius.zero,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            generatedContent == null
                                ? 'Hi! I am Pam, ready to help!'
                                : generatedContent!,
                            style: TextStyle(
                              fontFamily: 'Cera Pro',
                              color: Pallete.mainFontColor,
                              fontSize: generatedContent == null ? 25 : 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (generatedImageUrl != null)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"),
                      ),
                    ),

                  // features list
                  Center(
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      child: Column(
                        children: [
                          SlideInLeft(
                            child: Visibility(
                              visible: generatedContent == null &&
                                  generatedImageUrl == null,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                margin:
                                    const EdgeInsets.only(top: 10, left: 22),
                                child: const Text(
                                  'Here\'s what I can do:',
                                  style: TextStyle(
                                    fontFamily: 'Cera Pro',
                                    color: Pallete.mainFontColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: generatedContent == null &&
                                generatedImageUrl == null,
                            child: Column(
                              children: [
                                SlideInLeft(
                                  delay: Duration(milliseconds: start),
                                  child: const FeatureBox(
                                    color: Pallete.firstSuggestionBoxColor,
                                    headerText: 'Need someone to talk to?',
                                    descriptionText:
                                        'I am all ears! Just speak to me when your\'re ready! I am here to listen and help you out!',
                                  ),
                                ),
                                SlideInLeft(
                                  delay: Duration(milliseconds: start + delay),
                                  child: const FeatureBox(
                                    color: Pallete.secondSuggestionBoxColor,
                                    headerText: 'Need help with homework?',
                                    descriptionText:
                                        'No problem! I can help with any subject! Solutions, explanations, you name it, I got it.',
                                  ),
                                ),
                                SlideInLeft(
                                  delay:
                                      Duration(milliseconds: start + 2 * delay),
                                  child: const FeatureBox(
                                    color: Pallete.thirdSuggestionBoxColor,
                                    headerText: 'How to start?',
                                    descriptionText:
                                        'Click on the microphone and start talking to me! I promise to listen to you!',
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        delay: Duration(milliseconds: start + 3 * delay),
        child: FloatingActionButton(
          backgroundColor: Pallete.firstSuggestionBoxColor,
          onPressed: () async {
            if (await speechToText.hasPermission &&
                speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.chatGPTAPI(lastWords);
              // Not in use
              if (1 == 2) {
                // print(speech);
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          child: Icon(
            speechToText.isListening ? Icons.stop : Icons.mic,
          ),
        ),
      ),
    );
  }
}
