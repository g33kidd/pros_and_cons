import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/argument_editor.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Consumer<AppModel>(
              builder: (context, app, child) {
                final options = app.options;
                return ListView(
                  shrinkWrap: true,
                  // reverse: true,
                  children: <Widget>[
                    SizedBox(height: 24),
                    ...options.map((f) {
                      final index = options.indexOf(f);

                      return ArgumentEditor(
                        option: f,
                        focusNode: focusNodes[index],
                        onImportanceUpdate: (double value) {
                          f.importance = value;
                          app.updateOption(index, f);
                        },
                        onDeletePressed: () {
                          app.deleteOptionAt(index);
                        },
                        onTextChanged: (String value) {
                          f.title = value;
                          app.updateOption(index, f);
                        },
                        onTypeChanged: (OptionType type) {
                          f.type = type;
                          app.updateOption(index, f);
                        },
                      );
                    }).toList(),
                    // TODO make this better
                    SizedBox(height: 12.0),

                    FlatButton.icon(
                      icon: Icon(
                        Icons.add_box,
                        size: 32.0,
                      ),
                      label: Text("Add Argument",
                          style: TextStyle(fontSize: 22.0)),
                      onPressed: () {
                        final newNode = FocusNode();
                        focusNodes.add(newNode);
                        app.addOption();
                        Future.delayed(
                          Duration(milliseconds: 200),
                          () => newNode.requestFocus(),
                        );
                      },
                    ),
                    SizedBox(height: 25.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
