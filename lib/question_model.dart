class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestion() {
  List<Question> list = [];

  // Add questions and answer here

  list.add(Question("Who is the owner of Flutter?", [
    Answer("Nokia", false),
    Answer("Samsung", false),
    Answer("Google", true),
    Answer("Apple", false),
  ]));

  list.add(Question("Who ows Iphone?", [
    Answer("Apple", true),
    Answer("Microsoft", false),
    Answer("Google", true),
    Answer("Apple", false),
  ]));

  list.add(Question("Youtube is _______ platform?", [
    Answer("Music Sharing", true),
    Answer("Video Sharing", false),
    Answer("Live Streaming", true),
    Answer("All of the above", true),
  ]));

  list.add(Question("Flutter user dart as a language?", [
    Answer("True", true),
    Answer("False", false),
  ]));

  return list;
}
