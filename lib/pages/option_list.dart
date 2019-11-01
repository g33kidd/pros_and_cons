import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/widgets/argument_editor.dart';
import 'package:pros_cons/widgets/no_items_added.dart';
import 'package:provider/provider.dart';

class OptionListPage extends StatefulWidget {
  final Function onChanged;

  OptionListPage({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  _OptionListPageState createState() => _OptionListPageState();
}

class _OptionListPageState extends State<OptionListPage> {
  final List<FocusNode> focusNodes = <FocusNode>[];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addOption(decisions) {
    decisions.addOption();
    final newNode = FocusNode();
    focusNodes.add(newNode);
    Future.delayed(
      Duration(milliseconds: 200),
      () {
        newNode.requestFocus();
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(
            milliseconds: 200,
          ),
          curve: Curves.easeInOutQuart,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DecisionsModel>(builder: (context, decisions, child) {
      final options = decisions.options;

      if (options.length == 0)
        return NoItemsAdded(onPressed: () => addOption(decisions));

      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                // reverse: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final f = options[index];
                  return ArgumentEditor(
                    option: f,
                    firstItem: index == 0,
                    lastItem: index == options.length - 1,
                    focusNode: focusNodes[index],
                    onImportanceUpdate: (double value) {
                      f.importance = value;
                      decisions.updateOption(index, f);
                    },
                    onDeletePressed: () {
                      decisions.deleteOptionAt(index);
                    },
                    onTextChanged: (String value) {
                      f.title = value;
                      decisions.updateOption(index, f);
                    },
                    onTypeChanged: (OptionType type) {
                      f.type = type;
                      decisions.updateOption(index, f);
                    },
                  );
                },
              ),
            ),
            Center(
              child: FlatButton.icon(
                icon: Icon(
                  Icons.add_box,
                  size: 28.0,
                ),
                label: Text("ADD ARGUMENT", style: TextStyle(fontSize: 20.0)),
                onPressed: () => addOption(decisions),
              ),
            ),
          ],
        ),
      );
    });
  }
}
