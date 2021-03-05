import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/argument_editor.dart';
import 'package:pros_cons/widgets/no_items_added.dart';

class OptionListPage extends HookWidget {
  final Function onChanged;

  OptionListPage({
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final decision = useProvider(decisionsProvider);
    final scrollController = useScrollController();
    final darkMode = useProvider(themeProvider).dark;
    final options = decision.createDecision.arguments;

    void addOption() {
      decision.createDecision.addOption();
      decision.createDecision.addListener(() {
        // TODO FIX it definitely shouldn't scroll all the way to the bottom of the list
        // when deleting something.
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent + 156,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOutQuad,
          );
        }
      });
    }

    if (options.length == 0)
      return NoItemsAdded(
        onPressed: () => addOption(),
      );

    return Container(
      child: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        // reverse: true,
        itemCount: options.length,
        itemBuilder: (context, index) {
          final f = options[index];
          return ArgumentEditor(
            option: f,
            firstItem: index == 0,
            lastItem: index == options.length - 1,
            // focusNode: focusNodes.value[index],
            onImportanceUpdate: (double value) {
              f.importance = value;
              decision.createDecision.updateOption(index, f);
            },
            onDeletePressed: () {
              decision.createDecision.deleteOptionAt(index);
            },
            onTextChanged: (String value) {
              f.title = value;
              decision.createDecision.updateOption(index, f);
            },
            onTypeChanged: (OptionType type) {
              f.type = type;
              decision.createDecision.updateOption(index, f);
            },
          );
        },
      ),
    );
  }
}
