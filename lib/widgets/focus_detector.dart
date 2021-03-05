import 'package:pros_cons/imports.dart';
import 'package:flutter/services.dart';

class FocusDetector extends HookWidget {
  final Widget child;

  FocusDetector({@required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Unfocus from any and all nodes.
        FocusScope.of(context).requestFocus(new FocusNode());
        FocusScope.of(context).unfocus();
        // Then hide the keyboard since we don't need it anymore.
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: child,
    );
  }
}
