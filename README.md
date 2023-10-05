# Team Matchsticks🔥

> **Women in Tech - Google Ignite 2023 Hackathon**

### Team Members

| Terris | Anna | Tanisha | Hyin Ki | Julian |
| ------ | ---- | ------- | ------- | ------ |

## Running The Project

### Pre-requisites & Tools

|       Android Studio       |    Visual Studio    |   GitHub Desktop    |
| :------------------------: | :-----------------: | :-----------------: |
|       For Emulators        | Coding for desktops | Git Version Control |
| Coding for Android devices | Coding for websites |                     |

<hr/>

| (Mac) XCode installed  | (Optional) Visual Studio Code |
| :--------------------: | :---------------------------: |
| Coding for IOS devices |     Preferred coding IDE      |
|                        |    Can use Android Studio     |

### Working/ Running the Project

> In this tutorial, I am using **Visual Studio Code**

1. Select your **connected device**
    - E.g. Windows, Chrome, Emulator
2. Run **'void main() {...}'** with either:
    1. Default Methods:
        - Ctrl + F5 (Will run the default `main.dart`)
        - Top-left -> `Run` -> `Without Debugging`
    2. For specific project samples
        1. Locate any **'void main() {...}'**
            - Mostly located in main.dart files
        2. Above `void main...`, click `Run | Debug | Profile`

### Working/ Running the Project

> Must have already successfully connected and logged into Firebase

Type the following codes into the project terminal:

1.  `flutter build web`
    -   Build the project within project folder
2.  `firebase deploy --only hosting`
    -   Update the hosting server with latest build

## Project Business

### Project Idea

Matchsticks: EduTrekker

-   A Flutter App to promote self-learning for kids and teens.
-   To tackle the 17 UN SDG.
    -   (Goal 4) Ensure inclusive and equitable quality education and promote lifelong learning opportunities for all
    -   (Goal 4.1) By 2030, ensure that all girls and boys complete free, equitable and quality primary and secondary education leading to relevant and effective learning outcomes

### Main Features

1. Note taking
2. Quizzes
3. AI generated practices
4. Converse with Pam AI

### Techstack

1. Flutter (Dart)
2. Pub dependencies (Only important are shown here)
    1. flutter_tts
    2. speech_to_text
3. Firebase
    - Firestore Database
    - Firebase Hosting
4. PaLM API (Google AI)
5. OpenAI API (OpenAI)

### Guides/ References

1. [Connect Flutter and Firebase](https://www.youtube.com/watch?v=SFBLNf0tYKs)
2. [Flutter Note App](https://www.youtube.com/watch?v=fL8Ujzh5DQc)
3. [Flutter eLearn Homepage](https://www.youtube.com/watch?v=djcD2NZwXAc)
4. [Flutter Voice Assistant w/ OpenAI](https://www.youtube.com/watch?v=Q_pz4xFow3Q)
5. [Flutter with PaLM AI](https://codelabs.developers.google.com/haiku-generator#0)
6. [Deploying Flutter project with Firebase Hosting](https://quickcoder.org/firebase-hosting/)
