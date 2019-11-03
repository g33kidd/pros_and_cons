import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../display.dart';
import 'button_base.dart';

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonBase(
      onPressed: () async {
        FirebaseAnalytics().logEvent(name: "social_share");
        await Share.share(
          "I just weighed my pros and cons for a decision on this app. Checkout PROS & CONS on the Play Store! http://bit.ly/32sRgb9",
          subject: "PROS & CONS",
        );
      },
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: Colors.pinkAccent,
      ),
      child: Center(
        child: Text(
          "Helpful? Share app with Friends",
          style: Display.buttonStyle.copyWith(fontSize: 16.0),
        ),
      ),
    );
  }
}
