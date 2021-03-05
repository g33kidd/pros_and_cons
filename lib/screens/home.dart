import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pros_cons/hooks/page_controller.dart';
import 'package:pros_cons/screens/new/chat.dart';
import 'package:pros_cons/screens/new/decisions.dart';
import 'package:pros_cons/screens/new/home.dart';
import 'package:pros_cons/screens/new/journal.dart';
import 'package:pros_cons/screens/new/settings.dart';
import 'package:pros_cons/util.dart';

class NewHome extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final currentIndex = useState(2);
    final pageController = usePageController(initialPage: 2);

    return Scaffold(
      // TODO this drawer is for selecting channels,
      // however, might have more drawers for other pages.
      // drawer: currentIndex.value == 4 ? Offstage() : Drawer(),
      body: SizedBox.expand(
        child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            currentIndex.value = index;
          },
          children: <Widget>[
            HomePage(),
            JournalPage(),
            DecisionsPage(),
            ChatPage(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: purple,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        showElevation: false,
        itemCornerRadius: 6,
        animationDuration: Duration(milliseconds: 250),
        curve: Curves.easeInOutExpo,
        selectedIndex: currentIndex.value,
        onItemSelected: (index) {
          currentIndex.value = index;
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOutQuad,
          );
        },
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Posts'),
            activeColor: Colors.white,
            textAlign: TextAlign.center,
            inactiveColor: darkPurple,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.mode_edit),
            title: Text('Journal'),
            textAlign: TextAlign.center,
            activeColor: Colors.white,
            inactiveColor: darkPurple,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.lightbulb_outline),
            textAlign: TextAlign.center,
            title: Text('Decisions'),
            activeColor: Colors.white,
            inactiveColor: darkPurple,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            title: Text('Chat'),
            textAlign: TextAlign.center,
            inactiveColor: darkPurple,
            activeColor: Colors.white,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            textAlign: TextAlign.center,
            inactiveColor: darkPurple,
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
