import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';

final Color red = Color(0xFFAE6363);
final Color green = Color(0xFF63AE72);
final Color grey = Color(0xFFBABABA);

class Switcher extends StatefulWidget {
  final void Function(OptionType) onChanged;
  final OptionType type;

  Switcher({
    Key key,
    this.onChanged,
    this.type,
  }) : super(key: key);

  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool get isPro => widget.type == OptionType.PRO;

  bool get isCon => widget.type == OptionType.CON;

  @override
  Widget build(BuildContext context) {
    final TextStyle _style = TextStyle(
      fontSize: 24.0,
      color: Colors.white,
    );

    final padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(3.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => onTap(OptionType.CON),
            child: Container(
              padding: padding,
              color: isCon ? red : grey,
              child: FittedBox(
                child: Text("C", style: _style),
              ),
            ),
          ),
          SizedBox(width: 2.5),
          GestureDetector(
            onTap: () => onTap(OptionType.PRO),
            child: Container(
              padding: padding,
              color: isPro ? green : grey,
              child: FittedBox(
                child: Text("P", style: _style),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTap(OptionType type) {
    print("$type");
    widget.onChanged(type);
  }
}
