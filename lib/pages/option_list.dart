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
          options.add(Option(title: "Edit me", importance: 0));
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {});
          listController.animateTo(
            listController.position.maxScrollExtent,
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          );
          widget.onChanged(options);
        },
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
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
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              onChanged: (s) {
                                setState(() {
                                  options[index].title = s;
                                });
                                widget.onChanged(options);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Edit me!",
                                fillColor: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.red[500],
                            ),
                            onPressed: () {
                              setState(() {
                                options.removeAt(index);
                              });
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: <Widget>[
                          Text(
                            "${options[index].importance.toInt()}",
                          ),
                          Flexible(
                            child: Slider(
                              value: options[index].importance,
                              divisions: 10,
                              onChanged: (i) {
                                setState(() {
                                  options[index].importance = i;
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
              child: Text("Next"),
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
