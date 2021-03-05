import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/components/new_decision_button.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/widgets/history_item.dart';
import 'package:pros_cons/widgets/no_history.dart';

class DecisionsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider);
    final query = FirebaseFirestore.instance
        .collection('decisions')
        .where('uid', isEqualTo: user.uid)
        .orderBy('created', descending: true)
        .snapshots();

    final decisions = useStream(query);

    if (decisions.hasError) {
      return PageScaffold(
        child: Center(
          child: Text("Whoops... there was an error!"),
        ),
      );
    } else if (decisions.hasData) {
      return PageScaffold(
        child: HistoryList(
          documents: decisions.data.docs,
        ),
      );
    } else {
      return PageScaffold(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}

class HistoryList extends HookWidget {
  final List<DocumentSnapshot> documents;

  HistoryList({Key key, this.documents}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (documents.length > 0)
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              left: 12.0,
              right: 12.0,
            ),
            child: NewDecisionButton(
              onPressed: () {
                logEvent("new_decision", {'position': "history_list"});
                Navigator.pushNamed(context, "/create");
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.0),
              shrinkWrap: true,
              itemCount: documents.length,
              itemBuilder: (context, index) => HistoryItem(
                snapshot: documents[index],
                onDelete: () async {
                  Navigator.pop(context, true);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: purple,
                      duration: Duration(
                        milliseconds: 800,
                      ),
                      content: Text(
                        "Successfully deleted the decision!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                  await documents[index].reference.delete();
                },
              ),
            ),
          ),
        ],
      );

    return NoHistory();
  }
}
