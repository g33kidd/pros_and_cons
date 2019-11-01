import 'package:flutter/material.dart';

class CreateScreenNavigation extends StatelessWidget {
  final PageController pageController;
  final Function onAction;

  CreateScreenNavigation({
    Key key,
    this.pageController,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData buttonIcon = Icons.arrow_forward;
    String buttonLabel = "NEXT";

    if (pageController.page != null) {
      switch (pageController.page.round()) {
        case 0:
          buttonIcon = Icons.arrow_forward;
          buttonLabel = "NEXT";
          break;

        case 1:
          buttonIcon = Icons.save;
          buttonLabel = "SAVE & FINISH";
          break;

        case 2:
          buttonIcon = Icons.done_outline;
          buttonLabel = "FINISH";
          break;

        default:
          buttonIcon = Icons.done_outline;
          buttonLabel = "FINISH";
      }
    }

    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton.icon(
            icon: Icon(buttonIcon, color: Colors.white, size: 20.0),
            label: Text(
              buttonLabel,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            onPressed: () => onAction(),
          )
        ],
      ),
    );
  }
}
