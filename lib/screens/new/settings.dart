import 'package:hooks_riverpod/all.dart';
import 'package:preferences/preferences.dart';
import 'package:pros_cons/imports.dart';

/// TODO actually implement settings that are needed for the app to function.
/// this is all just an example at this point.
///
///
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// TODO I actually don't like PreferencePage, gonna just use the new
/// Preferences provider.
///

class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme = useProvider(themeProvider);
    final profile = useProvider(userProvider);
    final prefs = useProvider(prefsProvider);

    return PageScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
