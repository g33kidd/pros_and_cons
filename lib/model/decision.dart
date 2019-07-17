import 'package:flutter/foundation.dart';

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

  Map<String, dynamic> toMap() {
    return {
      'objective': objective,
      'mood': describeEnum(mood),
      'arguments': arguments.map
    };
  }

  static Decision fromMap(Map<String, dynamic> map) {
    Decision decision = Decision();
    decision.objective = map['objective'];
    decision.mood = getMoodFromString(map['mood']);
    decision.arguments = map['arguments'];
    return decision;
  }
}

Mood getMoodFromString(String value) {
  return Mood.values.firstWhere((f) => describeEnum(f) == value.toLowerCase());
}

OptionType getOptionTypeFromString(String value) {
  return OptionType.values.firstWhere(
    (f) => describeEnum(f) == value.toLowerCase(),
  );
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
