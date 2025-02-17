import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  List<String> questions = [
    'Sigirni pastga tushirish mumkin, lekin yuqoriga olib chiqish imkonsiz.',
    'Odam tanasidagi suyaklarning taxminan chorak qismi oyoqlarda joylashgan.',
    "Shilliq qurtning qoni yashil rangda bo‘ladi.",
    'Quyosh Quyosh tizimidagi eng katta sayyoradir.',
    'Yer sayyorasida eng issiq harorat 56,7°C bo‘lgan.',
    'Timsohlar tilda nafas oladi.',
    'Yashil choy tarkibida qahva bor.',
    'Koinotda faqat bitta galaktika mavjud.',
    'Tog‘lar asosan suyuq metallardan iborat.',
    'Dunyoning eng katta okeani Tinch okeani hisoblanadi.',
  ];

  List<bool> answers = [
    false,
    true,
    true,
    false,
    true,
    false,
    true,
    false,
    false,
    true
  ];

  int questionNumber = 0;
  bool isQuizFinished = false;
  int score = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = answers[questionNumber];

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.greenAccent));
        score++;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.redAccent));
      }

      if (questionNumber < questions.length - 1) {
        questionNumber++;
      } else {
        isQuizFinished = true;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      questionNumber = 0;
      scoreKeeper.clear();
      isQuizFinished = false;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                isQuizFinished
                    ? "Test tugadi! 🎉\nSiz $score ta to‘g‘ri javob berdingiz!"
                    : questions[questionNumber],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        if (!isQuizFinished) ...[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                child: Text(
                  'To‘g‘ri',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () => checkAnswer(true),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  'Noto‘g‘ri',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                onPressed: () => checkAnswer(false),
              ),
            ),
          ),
        ] else ...[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: restartQuiz,
                child: Text(
                  'Qayta boshlash 🔄',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ),
        ],
        Wrap(
          alignment: WrapAlignment.center,
          children: scoreKeeper,
        ),
      ],
    );
  }
}
