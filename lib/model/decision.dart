import 'package:flutter/foundation.dart';

enum OptionType { PRO, CON }
enum Mood { HAPPY, MEH, SAD }

Mood getMoodFromString(String value) {
  return Mood.values.firstWhere((f) => describeEnum(f) == value.toLowerCase());
}

OptionType getOptionTypeFromString(String value) {
  return OptionType.values.firstWhere(
    (f) => describeEnum(f).toLowerCase() == value.toLowerCase(),
  );
}

class Decision {
  DateTime created;
  String objective = "";
  Mood mood = Mood.HAPPY;

  List<Option> arguments = [];
  List<Option> pros = [];
  List<Option> cons = [];
  double proScore = 0;
  double conScore = 0;
  double totalScore = 0;

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
    totalScore = proScore - conScore;

    return {
      "pro": pscore,
      "con": cscore,
      "total": totalScore,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'objective': objective,
      'mood': describeEnum(mood),
      'arguments': arguments.map((a) => a.toMap())
    };
  }

  static Decision fromMap(Map<String, dynamic> doc) {
    Decision decision = Decision();
    decision.objective = doc['objective'];
    // decision.mood = getMoodFromString(doc['mood']);
    decision.conScore = doc['score']['con'];
    decision.proScore = doc['score']['pro'];
    decision.totalScore = doc['score']['total'];
    doc['arguments'].forEach((f) {
      decision.arguments.add(Option(
        title: f['title'],
        type: getOptionTypeFromString(f['type']),
        importance: f['importance'],
      ));
    });
    return decision;
  }
}

class Option {
  OptionType type = OptionType.PRO;
  String title = "";
  double importance = 0;

  Option({this.title, this.importance, this.type});

  Map<String, dynamic> toMap() {
    return {
      'type': describeEnum(type),
      'title': title,
      'importance': importance,
    };
  }

  static Option fromMap(Map<String, dynamic> map) {
    return Option(
      title: map['title'],
      importance: map['importance'],
      type: getOptionTypeFromString(map['type']),
    );
  }
}
