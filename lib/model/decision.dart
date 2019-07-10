enum OptionType { PRO, CON }
enum Mood { HAPPY, MEH, SAD }

class Decision {
  DateTime created;
  String objective = "";
  Mood mood = Mood.HAPPY;

  List<Option> arguments = [];
  List<Option> pros = [];
  List<Option> cons = [];
  double proScore = 0;
  double conScore = 0;

  String get key => created.toIso8601String();

  List<Option> get getPros =>
      arguments.where((o) => o.type == OptionType.PRO).toList();
  List<Option> get getCons =>
      arguments.where((o) => o.type == OptionType.CON).toList();

  Decision() {
    created = DateTime.now();
  }

  Map<String, double> buildScore() {
    double pscore = 0;
    double cscore = 0;

    getPros.forEach((p) {
      pscore += p.importance;
    });
    getCons.forEach((p) {
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
  OptionType type = OptionType.PRO;
  String title = "";
  double importance = 0;

  Option({this.title, this.importance, this.type});
}
