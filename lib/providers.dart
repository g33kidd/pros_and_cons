import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/model/decisions_model.dart';
import 'package:pros_cons/providers/decisions_provider.dart';
import 'package:pros_cons/providers/notice_provider.dart';
import 'package:pros_cons/providers/preferences_provider.dart';

import 'providers/chat_provider.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/app_provider.dart';

// idk what other prefs TODO
final defaultPreferences = {
  'theme:darkmode': true,
  // Pref(
  //   'theme:darkmode',
  //   defaultValue: false,
  //   block: 'theme',
  //   label: "Dark Mode"
  // ),
};

final defaultNotices = [
  AppNotice(
    "self-destruct",
    title: "This app is gonna self destruct...",
    category: "DANGER",
  ),
  AppNotice(
    "christmas-sale",
    title: "There is a 30% discount because of Christmas!!",
    category: "SALE",
  ),
  AppNotice(
    "chat:saves",
    title: "This chatroom only saves up to 24 hours worth of messages.",
    category: "NOTE",
  ),
  AppNotice(
    "social-linking",
    title: "You can link your social accounts in our app.",
    category: "HINT",
  )
];

//  provides general app information.
final appProvider = ChangeNotifierProvider((ref) => AppProvider());

// provides theme switching and helpers.
final themeProvider = ChangeNotifierProvider((ref) {
  final preferences = ref.watch(prefsProvider);
  return ThemeProvider(
    defaultMode: preferences.read<bool>("theme:darkmode", false),
    preferences: preferences,
  );
});

// provides access to user information and auth state.
final userProvider = ChangeNotifierProvider((_) => UserProvider());

// provides access to chat features.
final chatProvider = ChangeNotifierProvider((_) => ChatProvider());

// create decision provider.
final decisionProvider = ChangeNotifierProvider((_) => DecisionsModel());

// Prefs
final prefsProvider = ChangeNotifierProvider((_) => PreferencesProvider());

// Decisions provider
final decisionsProvider = ChangeNotifierProvider((ref) {
  final uid = ref.watch(userProvider).uid;
  return DecisionsProvider(uid: uid);
});

// Notices Provider
final noticeProvider = StateNotifierProvider(
  (ref) => TNoticeProvider(
    defaultNotices,
    preferences: ref.watch(prefsProvider),
  ),
);
