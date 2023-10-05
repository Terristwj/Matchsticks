import 'dart:convert';
import 'dart:math';

import 'package:matchsticks/.secrets.dart';
import 'package:http/http.dart' as http;

class PaLMService {
  Future<String> generateQuestionAndAnswers() async {
    int questionCount = 1;

    List<String> subjects = ["Mathematics", "Science", "Art", "Flutter"];
    String chosenSubject = subjects[Random().nextInt(subjects.length)];

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
              ...mathExamples,
              ...scienceExamples,
              ...artExamples,
              ...flutterExamples,
            ],
            "messages": [
              {
                "content":
                    "Come up with a question for $chosenSubject. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
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
          questionSet += decodedResponse['candidates'][i]['content'];
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

final mathExamples = [
  {
    "input": {
      "content":
          "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: A fair coin is flipped twice. What is the probability of getting at least one tails? Options: 3/4, 1/2, 1/4, 2/5 Answer: 3/4"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Find the lowest common multiple of 3 and 6. Options: 6, 3, 9, 1 Answer: 6"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Expand and simplify 4(x+3) + 4(x+5). Options: 8x+32, 5x+13, 4x+21, 8x+21 Answer: 8x+32"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Find the nth term for the sequence: 8, 6, 11, 18... Options: n^2 + 2, n^3 + 6, n^3 + 2, n^2 + 5 Answer: n^2 + 2"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Find the mean of: 11, 26, 25, 18. Options: 45, 20, 65, 25 Answer: 45"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Mathematics. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Find the highest common factor of 160, 240 and 16. Options: 16, 20, 10, 24 Answer: 16"
    }
  }
];

final scienceExamples = [
  {
    "input": {
      "content":
          "Come up with a question for Science. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Which animal lays eggs? Options: Duck, Dog, Cat, Sheep Answer: Duck"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Science. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: A male cow is called? Options: Ox, Dog, Sheep, Monkey Answer: Ox"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Science. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: All animals need food, air, and ____ to survive. Options: Water, House, Chocolate, Fruits Answer: Water"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Science. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Which one is a fur-bearing animal? Options: Cat, Crocodile, Tortoise, Fish Answer: Cat"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Science. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: What is Earth\'s only natural satellite? Options: Moon, Mars, Sun, Venus Answer: Moon"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Science. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: What part of the body helps you move? Options: Muscles, Pancreas, Lungs, Eyes Answer: Muscles"
    }
  }
];

final artExamples = [
  {
    "input": {
      "content":
          "Come up with a question for Art. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: This is the lightness or darkness of a color. Options: Value, Texture, Color, Shape Answer: Value"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Art. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: When lines meet to form an enclosed area, this is ___. Options: Shape, Line, Space, Form Answer: Shape"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Art. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: What has height, width, and thickness. Options: Form, Shape, Color, Value Answer: Form"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Art. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Which of these is not an element of art? Options: Balance, Texture, Line, Color Answer: Balance"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Art. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Pink is an example of which element? Options: Color, Line, Texture, Value Answer: Color"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Art. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Rough is an example of which element? Options: Texture, Color, Shape, Value Answer: Texture"
    }
  }
];

final flutterExamples = [
  {
    "input": {
      "content":
          "Come up with a question for Flutter. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Google just turned ___. Options: 25!, Purple, 26!, 24! Answer: 25!"
    }
  },
  {
    "input": {
      "content":
          "Come up with a question for Flutter. Format your response as follows: Question: <question> Options: <option1>, <option2>, <option3>, <option4> Answer: <answer> Explanation: <explanation>"
    },
    "output": {
      "content":
          "Question: Flutter\'s mascot name is ___. Options: Dash, Blue, Hummingbird, Flutter Answer: Dash"
    }
  },
];
