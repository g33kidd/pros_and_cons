import 'package:flutter/material.dart';

class ResultsCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final List<Widget> children;
  final bool row;
  final bool column;
  final EdgeInsetsGeometry padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  ResultsCard({
    Key key,
    this.child,
    this.children,
    this.color,
    this.column,
    this.padding,
    this.row,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.mainAxisSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rowContainer = Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: children,
    );

    final colContainer = Column(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      mainAxisSize: mainAxisSize ?? MainAxisSize.max,
      children: children,
    );

    // Figure out which child to actually use.
    var realChild = child;

    if (row != null) if (row) realChild = rowContainer;
    if (column != null) if (column) realChild = colContainer;

    return Container(
      padding: padding ?? EdgeInsets.all(16.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: realChild,
    );
  }
}
