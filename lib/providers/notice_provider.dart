import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/providers/preferences_provider.dart';

/// TODO actions
///
///
/// AppNotice(
///   title: "Theres a sale! Go there!"
///   category: "SALE",
///   action: () {
///      Navigator.pushNamed("Christmas Sale")
///   }
/// )
///
/// CUSTOM WIDGET
/// instead of using the default style, just use a custom widget.
///  AppNotice(
///   child: Container(....)
///   action: () {}
/// )

class AppNotice {
  String _path;
  String title;
  String category;
  List<String> screens;
  bool dismissed;
  bool seen;

  AppNotice(
    thisPath, {
    @required this.title,
    this.category,
    this.seen,
    this.dismissed,
    this.screens,
  }) {
    this._path = thisPath;
  }

  String get path => "notices:$_path";
}

class TNoticeProvider extends StateNotifier<List<AppNotice>> {
  final PreferencesProvider preferences;

  TNoticeProvider(state, {this.preferences}) : super(state) {
    // we needed to listen to prefs here for some reason...
    preferences.addListener(() {
      print("Is it working in this class?");
    });
  }

  AppNotice notice(String noticePath) {
    return this.state.firstWhere(
      (element) => element.path == noticePath,
      orElse: () {
        return null;
      },
    );
  }

  void add(AppNotice notice) => state.add(notice);

  void seen(String path) {
    final notice = state.where((element) => element.path == path) as AppNotice;
    notice.seen = true;
  }
}

class NoticeProvider extends ChangeNotifier {
  final PreferencesProvider preferences;
  List<AppNotice> notices = [];

  NoticeProvider(List<AppNotice> defaults, {this.preferences}) {
    // why does this keep showing up??
    // PREFERENCES
    preferences.addListener(() {
      print("Is it working here in this class?");
    });
  }
}
