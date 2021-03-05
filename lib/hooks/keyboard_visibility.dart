import 'package:pros_cons/imports.dart';

class KeyboardVisibility {
  final BuildContext context;

  KeyboardVisibility(this.context);

  // Checks to see if the keyboard is visible using ViewInsets.
  // however I have learned this might not be the best way.
  bool get isVisible => MediaQuery.of(context).viewInsets.bottom > 0.0;

  // Hides the keyboard from view.
  void unfocus() => FocusScope.of(context).unfocus();
}

// class KeyboardVisibility extends

KeyboardVisibility useKeyboardVisibility() {
  return use(_KeyboardVisibilityHook());
}

class _KeyboardVisibilityHook extends Hook<KeyboardVisibility> {
  const _KeyboardVisibilityHook();

  @override
  HookState<KeyboardVisibility, Hook<KeyboardVisibility>> createState() =>
      _KeyboardVisibilityHookState();
}

class _KeyboardVisibilityHookState
    extends HookState<KeyboardVisibility, _KeyboardVisibilityHook> {
  @override
  KeyboardVisibility build(BuildContext context) {
    return KeyboardVisibility(context);
  }
}
