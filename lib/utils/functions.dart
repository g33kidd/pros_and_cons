// Log Firebase Analytics events.
// This just makes it simpler to call this function throughout the codebase.
import 'package:firebase_analytics/firebase_analytics.dart';

void logEvent(String name, Map<String, dynamic> data) async {
  await FirebaseAnalytics().logEvent(name: name, parameters: data);
}
