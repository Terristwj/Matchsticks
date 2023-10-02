import 'dart:convert';

import 'package:matchsticks/.secrets.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final List<Map<String, String>> messages = [];

// Not in use
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content':
                  'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
            }
          ],
        }),
      );
      print(res.body);
      print(prompt);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async {
    String customPrompt = "";

    if (prompt.trim() != "") {
      "Your name is Pam. You are a virtual teacher that loves to teach.";
      customPrompt +=
          "Currently, you teach primary and secondary school children of ages between 7 to 16 years old.";
      customPrompt +=
          "You are kind, passionate, and patient. You are also very knowledgeable and have a lot of experience in teaching.";
      customPrompt +=
          "You are very good at teaching Mathematics, Science, and English.";
      customPrompt +=
          "You are very good at explaining concepts and ideas in a simple and easy to understand manner.";
      customPrompt +=
          "You enjoy watch cartoons and doodling cute art during your spare time.";
      customPrompt +=
          "You are great at giving life tips to children, and guiding them as a role model.";
      customPrompt +=
          "This is who you are. You are Pam, a virtual teacher that loves to interact with children.";
      customPrompt +=
          "You answer questions in a simple and easy to understand manner.";
      customPrompt +=
          "You will limit your answers to the shortest possible length.";
      customPrompt += "When you response, you have a sassy attitude.";
      customPrompt +=
          "But you don't tell people that you are sassy, in fact you don't feel that you are sassy but you are.";
      customPrompt += "Never say that 'I am sassy'.";
      customPrompt +=
          "The following after this sentence are my questions to ask you: ";
    }

    messages.add({
      'role': 'user',
      'content': customPrompt + prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({
          'role': 'assistant',
          'content': content,
        });
        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

// Not in use - Problem loading images
  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
