import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/hooks/page_controller.dart';

import 'package:pros_cons/imports.dart';
import 'package:pros_cons/pages/objective.dart';
import 'package:pros_cons/pages/option_list.dart';
import 'package:pros_cons/pages/results.dart';
import 'package:pros_cons/widgets/app_scaffold.dart';

// TODO ahhh
// import 'package:exo/exo.dart' as exo;

class CreateScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final decisions = useProvider(decisionsProvider);
    final currentIndex = useState(0);
    final pageController = usePageController(initialPage: 0);

    pageController.addListener(() {
      currentIndex.value = pageController.page.toInt();
    });

    void nextPage() {
      FocusScope.of(context).requestFocus(new FocusNode());
      if (currentIndex.value < 2) {
        pageController.nextPage(
          duration: Duration(milliseconds: 350),
          curve: Curves.easeInOutExpo,
        );
      }
    }

    void handleAction() async {
      nextPage();
      if (currentIndex.value == 1) {
        decisions.create();
      } else if (currentIndex.value == 2) {
        logEvent("finish", {});
        Navigator.pop(context);
      } else {}
    }

    // Dynamic button properties based on the page.
    IconData icon = Icons.arrow_forward;
    String label = "Next";

    switch (currentIndex.value) {
      case 0:
        icon = Icons.arrow_forward;
        label = "NEXT";
        break;

      case 1:
        icon = Icons.save_alt;
        label = "Save & Finish";
        break;

      case 2:
        icon = Icons.done_outline;
        label = "Finish";
        break;

      default:
        icon = Icons.done_outline;
        label = "Finish";
    }

    return AppScaffold(
      title: "Create a Decision",
      centerTitle: true,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (currentIndex.value == 1)
                FlatButton.icon(
                  onPressed: () => decisions.createDecision.addOption(),
                  icon: Icon(Icons.add, color: Colors.white, size: 20.0),
                  label: Text(
                    "Option",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ),
              FlatButton.icon(
                onPressed: handleAction,
                icon: Icon(icon, color: darkPurple, size: 20.0),
                label: Text(
                  label,
                  style: TextStyle(color: darkPurple, fontSize: 18.0),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Row(
      //     children: [
      //       FlatButton.icon(
      //         onPressed: () => handleAction(),
      //         icon: Icon(icon, color: Colors.white, size: 20.0),
      //         label: Text(
      //           label,
      //           style: TextStyle(color: Colors.white, fontSize: 18.0),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      body: Container(
        child: PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            ObjectivePageNew(),
            OptionListPage(),
            ResultsPage(),
          ],
        ),
      ),
    );
  }
}
