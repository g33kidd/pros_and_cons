import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pros_cons/util.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _titleTween = TextStyleTween(
    begin: TextStyle(color: Colors.white, fontSize: 50.0),
    end: TextStyle(color: Colors.white, fontSize: 30.0),
  );

  final double buttonSize = 70.0;

  final _buttonHeightTween = IntTween(begin: 60, end: 50);
  final _buttonWidthTween = IntTween(begin: 300, end: 50);

  final _testTween = SizeTween(begin: Size(360.0, 60.0), end: Size(50.0, 50.0));

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  double titleScrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(50, 100)
        .toDouble();
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = shrinkOffset / maxExtent;

    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);

    final titleStyle = _titleTween.lerp(progress);
    final buttonHeight = _buttonHeightTween.lerp(progress);
    final buttonWidth = _buttonWidthTween.lerp(progress);
    final btnSize = _testTween.lerp(progress);

    return Container(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[purple, Color(0xFF5E5194)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.0,
            1.0,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: <Widget>[
            /// New decision button, this should animate.
            AnimatedPositioned(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeInOutQuad,
              right: 0,
              bottom: -buttonSize / 1.8,
              child: Container(
                width: btnSize.width,
                height: btnSize.height,
                decoration: BoxDecoration(
                  color: Color(0xFFEB79AE),
                  borderRadius: BorderRadius.circular(6.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      spreadRadius: 1.3,
                    ),
                  ],
                ),
              ),
            ),

            /// TODO fix the text scaling issue.
            /// This totally works, but this will eventually overlap the Drawer menu button.
            /// Text needs to actually scale rather than be fitted into a box...
            /// I really don't know how to do the math for animating the text value based on the
            /// extent of the scrollView.
            Center(
              child: Text(
                "PROS & CONS",
                style: titleStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 260.0;

  @override
  double get minExtent => 80.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(),
            ),
            // SliverAppBar(
            //   backgroundColor: purple,
            //   floating: false,
            //   pinned: true,
            //   expandedHeight: 200.0,
            //   flexibleSpace: FlexibleSpaceBar(
            //     title: Text("PROS & CONS"),
            //     centerTitle: true,
            //   ),
            // ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                  Text("Whatever..."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
