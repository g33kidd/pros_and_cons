import 'package:flutter/material.dart';

class NoItemsAdded extends StatelessWidget {
  final Function onPressed;

  NoItemsAdded({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.view_list,
            size: 150.0,
            color: Colors.blueGrey[50],
          ),
          FittedBox(
            child: Text(
              "Add some Pros & Cons.",
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.blueGrey[200],
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            "Use the slider to change the importance.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey[200],
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            "Start deciding with the button below!",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.blueGrey[200],
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => onPressed(),
              child: Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Colors.pinkAccent,
                ),
                child: Center(
                  child: Text(
                    "ADD ARGUMENT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
