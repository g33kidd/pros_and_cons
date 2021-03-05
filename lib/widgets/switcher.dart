import 'package:flutter/material.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/util.dart';

class Switcher extends HookWidget {
  final void Function(OptionType) onChange;
  final OptionType type;

  Switcher({
    Key key,
    this.onChange,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPro = type == OptionType.PRO;
    final isCon = type == OptionType.CON;

    final TextStyle _style = TextStyle(
      fontSize: 23.5,
      color: Colors.white,
      fontWeight: FontWeight.w800,
    );

    void onTap(OptionType type) => onChange(type);

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
}
