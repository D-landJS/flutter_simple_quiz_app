import 'package:flutter/material.dart';
import 'package:flutter_simple_quiz_app/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // define the datas
  List<Question> questList = getQuestion();
  int currentQuestIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            'Simple Quiz App',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          _questionWidget(),
          _answerList(),
          _nextBtn()
        ]),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Question ${currentQuestIndex + 1}/${questList.length.toString()}",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(16)),
          child: Text(questList[currentQuestIndex].questionText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  _answerList() {
    return Column(
      children: questList[currentQuestIndex]
          .answerList
          .map((e) => _answerButton(e))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: isSelected ? Colors.orange : Colors.white,
            onPrimary: isSelected ? Colors.white : Colors.black),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }
          }
          setState(() {
            selectedAnswer = answer;
          });
        },
        child: Text(answer.answerText),
      ),
    );
  }

  _nextBtn() {
    bool isLastQuestion = false;
    if (currentQuestIndex == questList.length - 1) {
      isLastQuestion = true;
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: Colors.blueAccent,
            onPrimary: Colors.white),
        onPressed: () {
          if (selectedAnswer == null) {
            showSnackBar(context);
            return;
          }
          if (isLastQuestion) {
            //display score
            showDialog(context: context, builder: (_) => _showScoreDialog());
          } else {
            setState(() {
              selectedAnswer = null;
              currentQuestIndex++;
            });
          }
        },
        child: Text(isLastQuestion ? 'Submit' : 'Next'),
      ),
    );
  }

  _showScoreDialog() {
    bool isPassed = false;

    if (score >= questList.length * 0.6) {
      //pass if 60%
      isPassed = true;
    }

    String title = isPassed ? 'Passed' : 'Failed';
    return AlertDialog(
      title: Text(
        "$title | Score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: ElevatedButton(
        child: const Text('Restart'),
        onPressed: () {
          Navigator.pop(context);
          setState(() {
            currentQuestIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      duration: const Duration(milliseconds: 1000),
      content: const Text(
        'Please select an answer',
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.teal,
      shape: const StadiumBorder(),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: Colors.yellow,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
