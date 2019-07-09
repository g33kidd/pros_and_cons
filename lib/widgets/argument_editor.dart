import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/switcher.dart';

class ArgumentEditor extends StatefulWidget {
  final Option option;
  final void Function(String) onTextChanged;
  final void Function(OptionType) onTypeChanged;
  final void Function(double) onImportanceUpdate;
  final Function onDeletePressed;

  ArgumentEditor({
    Key key,
    this.option,
    this.onDeletePressed,
    this.onTextChanged,
    this.onImportanceUpdate,
    this.onTypeChanged,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(13.0),
                    hintText: "Edit here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
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
          Slider(
            value: option.importance,
            divisions: 10,
            onChanged: (i) => widget.onImportanceUpdate(i),
            min: 0,
            max: 10,
            label: "${option.importance.toInt()} Importance",
          ),
        ],
      ),
    );
  }

  void onTextChanged(String value) {
    _textEditingController.value =
        _textEditingController.value.copyWith(text: value);

    // TODO idk if needed yet
    widget.onTextChanged(_textEditingController.value.text);
  }

  void onDeletePressed() => widget.onDeletePressed();

  void onTypeSwitched(OptionType type) => widget.onTypeChanged(type);
}
