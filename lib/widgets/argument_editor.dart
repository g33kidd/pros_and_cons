import 'package:flutter/material.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/switcher.dart';
import 'package:pros_cons/util.dart';

class ArgumentEditor extends StatefulWidget {
  final bool firstItem;
  final bool lastItem;
  final Option option;
  final void Function(String) onTextChanged;
  final void Function(OptionType) onTypeChanged;
  final void Function(double) onImportanceUpdate;
  final Function onDeletePressed;
  final FocusNode focusNode;

  ArgumentEditor({
    Key key,
    this.firstItem,
    this.lastItem,
    this.option,
    this.onDeletePressed,
    this.onTextChanged,
    this.onImportanceUpdate,
    this.onTypeChanged,
    this.focusNode,
  }) : super(key: ObjectKey(option));

  @override
  _ArgumentEditorState createState() => _ArgumentEditorState(option);
}

class _ArgumentEditorState extends State<ArgumentEditor> {
  Option option;
  TextEditingController _textEditingController;

  _ArgumentEditorState(this.option) {
    _textEditingController = TextEditingController(text: option.title);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = EdgeInsets.only(
      left: 16.0,
      right: 16.0,
      top: widget.firstItem ? 16.0 : 0.0,
      bottom: widget.lastItem ? 16.0 : 0.0,
    );

    final sliderLabelStyle = TextStyle(
      fontSize: 12.0,
      color: Colors.blueGrey[400],
      fontWeight: FontWeight.w600,
    );

    return Padding(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Switcher(
                onChanged: onTypeSwitched,
                type: option.type,
              ),
              SizedBox(width: 4.0),
              Flexible(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _textEditingController,
                  focusNode: widget.focusNode,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.5),
                    hintText: "Edit me...",
                  ),
                  onChanged: onTextChanged,
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline),
                color: red,
                onPressed: onDeletePressed,
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Slider(
            value: option.importance,
            divisions: 10,
            onChanged: (i) => widget.onImportanceUpdate(i),
            min: 0,
            max: 10,
            label: "${option.importance.toInt()} Importance",
          ),
          SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (option.type == OptionType.PRO) ...[
                Text("Not Important", style: sliderLabelStyle),
                Text("Very Important", style: sliderLabelStyle),
              ],
              if (option.type == OptionType.CON) ...[
                Text("Not Bad", style: sliderLabelStyle),
                Text("Very Bad", style: sliderLabelStyle),
              ],
            ],
          ),
          SizedBox(height: 22.0),
        ],
      ),
    );
  }

  void onTextChanged(String value) {
    _textEditingController.value =
        _textEditingController.value.copyWith(text: value);

    widget.onTextChanged(_textEditingController.value.text);
  }

  void onDeletePressed() => widget.onDeletePressed();

  void onTypeSwitched(OptionType type) => widget.onTypeChanged(type);
}
