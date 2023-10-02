import 'dart:convert';

import 'package:matchsticks/.secrets.dart';
import 'package:http/http.dart' as http;

class PaLMService {
  Future<String> generateQuestionAndAnswers(String subject) async {
    int questionCount = 1;

    try {
      final response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta2/models/chat-bison-001:generateMessage?key=$palmAPIKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "prompt": {
            "context":
                "You are a primary school teacher, teaching children of ages 6 to 12 years old. Your task is to create a question for a given subject. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>",
            "examples": [
              {
                "input": {
                  "content":
                      "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
                },
                "output": {
                  "content":
                      "Question: A fair coin is flipped twice. What is the probability of getting at least one tails? Options: 3/4, 1/2, 1/4, 2/5"
                }
              },
              {
                "input": {
                  "content":
                      "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
                },
                "output": {
                  "content":
                      "Question: Find the lowest common multiple of 3 and 6. Options: 6, 3, 9, 1"
                }
              },
              {
                "input": {
                  "content":
                      "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
                },
                "output": {
                  "content":
                      "Question: Expand and simplify 4(x+3) + 4(x+5). Options: 8x+32, 5x+13, 4x+21, 8x+21"
                }
              },
              {
                "input": {
                  "content":
                      "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
                },
                "output": {
                  "content":
                      "Question: Find the nth term for the sequence: 8, 6, 11, 18... Options: n^2 + 2, n^3 + 6, n^3 + 2, n^2 + 5"
                }
              },
              {
                "input": {
                  "content":
                      "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
                },
                "output": {
                  "content":
                      "Question: Find the highest common factor of 160, 240 and 16. Options: 16, 20, 10, 24"
                }
              }
            ],
            "messages": [
              {
                "content":
                    "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
              }
            ]
          },
          "candidate_count": questionCount,
          "temperature": 1,
        }),
      );
      print(response.body);
      if (response.statusCode == 200) {
        final decodedResponse = json.decode(response.body);

        String questionSet = "";
        for (var i = 0; i < questionCount; i++) {
          questionSet += '${i + 1}.\n';
          questionSet += decodedResponse['candidates'][i]['content'] + '\n\n';
        }
        return questionSet;
      } else {
        return 'Request failed with status: ${response.statusCode}.\n\n${response.body}';
      }
    } catch (error) {
      throw Exception('Error sending POST request: $error');
    }
  }
}
