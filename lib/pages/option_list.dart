import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/argument_editor.dart';
import 'package:provider/provider.dart';

class OptionListPage extends StatefulWidget {
  final PageController pageController;
  final Function onChanged;

  OptionListPage({
    Key key,
    @required this.pageController,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _OptionListPageState createState() => _OptionListPageState();
}

class _OptionListPageState extends State<OptionListPage> {
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
                  children: <Widget>[
                    SizedBox(height: 24),
                    ...options.map((f) {
                      final index = options.indexOf(f);
                      return ArgumentEditor(
                        option: f,
                        onImportanceUpdate: (double value) {},
                        onDeletePressed: () {
                          app.deleteOptionAt(index);
                        },
                        onTextChanged: (String value) {},
                        onTypeChanged: (OptionType type) {
                          f.type = type;
                          app.updateOption(index, f);
                        },
                      );
                    }).toList(),
                    // TODO make this better
                    IconButton(
                      icon: Icon(
                        Icons.add_box,
                        size: 32.0,
                      ),
                      onPressed: () => app.addOption(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: Colors.transparent,
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.add),
    //     onPressed: () {
    //       options.add(Option(title: "", importance: 2));
    //       FocusScope.of(context).requestFocus(new FocusNode());
    //       setState(() {});
    //       listController.animateTo(
    //         listController.position.maxScrollExtent,
    //         duration: Duration(milliseconds: 400),
    //         curve: Curves.ease,
    //       );
    //       Option option = options.last;
    //       final controller = TextEditingController();
    //       controller.addListener(() {
    //         option.title = controller.text;
    //       });
    //       _textControllers.add(controller);
    //       widget.onChanged(options);
    //     },
    //   ),
    //   body: ,
    // );
  }
}
