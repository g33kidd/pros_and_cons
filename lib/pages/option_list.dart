import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

class OptionListPage extends StatefulWidget {
  Decision decision;
  PageController pageController;
  String title;
  String description;
  Function onChanged;

  OptionListPage({
    Key key,
    this.decision,
    @required this.pageController,
    @required this.title,
    @required this.description,
    @required this.onChanged,
  }) : super(key: key);

  @override
  _OptionListPageState createState() => _OptionListPageState();
}

class _OptionListPageState extends State<OptionListPage> {
  final listController = ScrollController();

  final List<Option> options = [
    Option(title: "", importance: 8),
    Option(title: "", importance: 5),
    Option(title: "", importance: 2),
  ];

  final List<TextEditingController> _textControllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options.forEach((f) {
      final controller = TextEditingController();
      controller.text = f.title;
      controller.addListener(() {
        f.title = controller.text;
      });
      _textControllers.add(controller);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textControllers.forEach((f) => f.dispose());
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _headerText = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
    );

    TextStyle _subHeaderText = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          options.add(Option(title: "", importance: 2));
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {});
          listController.animateTo(
            listController.position.maxScrollExtent,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
          Option option = options.last;
          final controller = TextEditingController();
          controller.addListener(() {
            option.title = controller.text;
          });
          _textControllers.add(controller);
          widget.onChanged(options);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text("${widget.title}", style: _headerText),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                controller: listController,
                itemCount: options.length,
                itemBuilder: (ctx, index) {
                  final option = options[index];
                  final controller = _textControllers[index];
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (s) {
                                controller.value = controller.value.copyWith(
                                  text: s,
                                );
                                widget.onChanged(options);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Edit me!",
                                fillColor: Colors.white,
                              ),
                              controller: controller,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red[500],
                            ),
                            onPressed: () {
                              setState(() {
                                options.remove(option);
                                _textControllers.remove(controller);
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          Text("${option.importance.toInt()}"),
                          Flexible(
                            child: Slider(
                              value: option.importance,
                              divisions: 10,
                              onChanged: (i) {
                                setState(() {
                                  option.importance = i;
                                });
                                widget.onChanged(options);
                              },
                              min: 0,
                              max: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            RaisedButton(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              color: Color(0xFF7665E6),
              onPressed: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                widget.pageController.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.ease,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
