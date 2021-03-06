import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../util.dart';

enum OptionType { PRO, CON }
enum Mood { HAPPY, MEH, SAD }

Mood getMoodFromString(String value) {
  return Mood.values.firstWhere(
    (f) => describeEnum(f).toLowerCase() == value.toLowerCase(),
  );
}

OptionType getOptionTypeFromString(String value) {
  return OptionType.values.firstWhere(
    (f) => describeEnum(f).toLowerCase() == value.toLowerCase(),
  );
}

class Decision {
  String documentID;
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

  Color get scoreTextColor => totalScore < 0 ? red : green;
  Color get moodTextColor =>
      (mood != Mood.MEH) ? (mood == Mood.HAPPY ? green : red) : Colors.orange;

  List<Option> get getPros =>
      arguments.where((o) => o.type == OptionType.PRO).toList();

  List<Option> get getCons =>
      arguments.where((o) => o.type == OptionType.CON).toList();

  List<Map<String, dynamic>> get argumentsList => arguments.map((a) {
        return {
          'title': a.title,
          'importance': a.importance,
          'type': describeEnum(a.type)
        };
      }).toList();

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

  // static Stream<DocumentSnapshot> all() {
  //   return Firestore.instance
  //       .collection('decisions')
  //       .where('udid', isEqualTo: app.udid)
  //       .orderBy('created', descending: true)
  //       .snapshots()
  // }

  static Future<DocumentReference> update(Map<String, dynamic> data) async {}

  static Future<DocumentReference> insert(Map<String, dynamic> data) async {
    return await FirebaseFirestore.instance.collection('decisions').add(data);
  }

  static Decision fromSnapshot(DocumentSnapshot snapshot) {
    var decision = fromMap(snapshot.data());
    decision.documentID = snapshot.id;
    return decision;
  }

  static Decision fromMap(Map<String, dynamic> doc) {
    Decision decision = Decision();
    decision.objective = doc['objective'];
    decision.mood = getMoodFromString(doc['mood']);
    decision.conScore = doc['score']['con'];
    decision.proScore = doc['score']['pro'];
    decision.totalScore = doc['score']['total'];
    decision.created = (doc['created'] as Timestamp).toDate();
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
