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
  TextStyle _headerText = TextStyle(
    color: Colors.white,
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
  );

  TextStyle _subHeaderText = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  final listController = ScrollController();

  final List<Option> options = [
    Option(title: "Make new friends", importance: 3),
    Option(title: "Make new friends", importance: 3),
    Option(title: "Make new friends", importance: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          options.add(Option(title: "Edit me", importance: 0));
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
            Text(
              "${widget.description}",
              style: _subHeaderText,
            ),
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
                              color: Colors.red,
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
                            style: TextStyle(
                              color: Colors.white,
                            ),
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
