import 'package:flutter/material.dart';
import 'package:pros_cons/model/app_model.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/util.dart';
import 'package:provider/provider.dart';

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
    final darkMode = Provider.of<AppModel>(context).darkMode;
    final TextStyle _style = TextStyle(
      fontSize: 23.5,
      color: Colors.white,
      fontWeight: FontWeight.w800,
    );

    final padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);

    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => onTap(OptionType.CON),
            child: Container(
              padding: padding,
              color: isCon ? red : Colors.grey,
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
              color: isPro ? green : Colors.grey,
              child: FittedBox(
                child: Text("P", style: _style),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onTap(OptionType type) => widget.onChanged(type);
}
