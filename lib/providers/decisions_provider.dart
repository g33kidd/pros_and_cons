import 'package:flutter/foundation.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/decision.dart';

class DecisionsProvider extends ChangeNotifier {
  final String uid;

  DecisionsProvider({this.uid}) {
    _createDecision = new Decision();
    _createDecision.addListener(() {
      notifyListeners();
    });
  }

  ChangeNotifier _createDecision;

  // Decision _viewingDecision;
  // Decision _editingDecision;

  // Decision get editingDecision => _editingDecision;
  // Decision get viewingDecision => _viewingDecision;

  Decision get createDecision {
    if (_createDecision == null) {
      _createDecision = new Decision();
      return _createDecision;
    }

    return _createDecision;
  }

  // This was for after updating the document rules on FB.
  Future<List<Decision>> getMyDecisions() async {
    final decisions =
        await Decision.collection.where('user_id', isEqualTo: this.uid).get();
    return decisions.docs.map(
      (e) => Decision.fromSnapshot(e),
    );
  }

  set decision(val) {
    this._createDecision = val;
    notifyListeners();
  }

  Future<void> create() async {
    await Decision.insert({
      'objective': createDecision.objective,
      'mood': describeEnum(createDecision.mood),
      'user_id': this.uid,
      'arguments': createDecision.argumentsList,
      'created': createDecision.created.toUtc(),
    });
  }
}
