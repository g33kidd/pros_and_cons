import 'package:flutter/cupertino.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class EditDecisionScreen extends StatefulWidget {
  final Decision decision;

  EditDecisionScreen({Key key, @required this.decision}) : super(key: key);

  @override
  _EditDecisionScreenState createState() => _EditDecisionScreenState();
}

class _EditDecisionScreenState extends State<EditDecisionScreen> {
  Decision get decision => widget.decision;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        Provider.of<DecisionsModel>(context).setDecision(decision);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: "Editing Decision",
      body: OptionListPage(),
    );
  }
}
