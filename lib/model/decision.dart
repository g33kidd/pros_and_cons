class Decision {
  bool singleObjective = true;
  String objective = "";
  List<String> objectives = [];
  Mood mood = Mood.HAPPY;
  List<Option> pros = [];
  List<Option> cons = [];
  double proScore = 0;
  double conScore = 0;

  Map<String, double> buildScore() {
    double pscore = 0;
    double cscore = 0;

    pros.forEach((p) {
      pscore += p.importance;
    });
    cons.forEach((p) {
      cscore += p.importance;
    });

    proScore = pscore;
    conScore = cscore;

    return {
      "pro": pscore,
      "con": cscore,
    };
  }
}

class Option {
  String title = "";
  double importance = 0;

  Option({this.title, this.importance});
}

enum Mood {
  HAPPY,
  MEH,
  SAD,
}
