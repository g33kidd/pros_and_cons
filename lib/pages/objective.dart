import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/model/decision.dart';
import 'package:pros_cons/widgets/mood_selection.dart';

// class ObjectivePage extends StatefulWidget {
//   @override
//   _ObjectivePageState createState() => _ObjectivePageState();
// }

// class _ObjectivePageState extends State<ObjectivePage> {
//   bool suicidalSentiment = false;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final darkMode = Provider.of<AppModel>(context).darkMode;
//     TextStyle _headerText = TextStyle(
//       fontSize: 22.0,
//       fontWeight: FontWeight.w600,
//       color: darkMode ? Colors.white : Colors.grey[900],
//     );

//     TextStyle _subHeaderText = TextStyle(
//       fontSize: 18.0,
//       fontWeight: FontWeight.w400,
//       color: darkMode ? Colors.grey : Colors.grey[900],
//     );

//     return Consumer<DecisionsModel>(builder: (context, decisions, snapshot) {
//       return GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
//         child: Container(
//           padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
//           child: ListView(
//             children: <Widget>[
//               Text("Let's start with an objective.", style: _headerText),
//               SizedBox(height: 6.0),
//               Text("What are you making a decision on?", style: _subHeaderText),
//               SizedBox(height: 24.0),
//               TextField(
//                 textCapitalization: TextCapitalization.sentences,
//                 maxLength: 300,
//                 maxLines: 4,
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   color: darkMode ? Colors.white : Colors.black,
//                 ),
//                 onChanged: (s) {
//                   // Not super effective, but POC..
//                   if (s.trim().contains(RegExp(r'(kill)|(die)'))) {
//                     setState(() {
//                       suicidalSentiment = true;
//                     });
//                   } else {
//                     setState(() {
//                       suicidalSentiment = false;
//                     });
//                   }
//                   decisions.updateObjective(s);
//                 },
//               ),
//               SizedBox(height: 16.0),
//               if (suicidalSentiment)
//                 Container(
//                   padding: EdgeInsets.all(16.0),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5.0),
//                     color: Colors.green[100],
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         "SuicidePreventionLifeline.org",
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.w800,
//                         ),
//                       ),
//                       SizedBox(height: 16.0),
//                       Text(
//                         "If you’re in crisis, there are options available to help you cope. You can also call the Lifeline at any time to speak to someone and get support. For confidential support available 24/7 for everyone in the United States, call 1-800-273-8255.",
//                         style: TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//               SizedBox(height: 16.0),
//               Text("How are you feeling about it?", style: _headerText),
//               SizedBox(height: 6.0),
//               Text("This will come in handy later.", style: _subHeaderText),
//               // TODO convert into an emoji picker instead of a "Mood".
//               // mood should still be a thing "happy" "sad" "angry" etc.. but should be set based on the emoji.
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 23.0),
//                 child: MoodSelection(
//                   onChanged: (m) {
//                     decisions.decision.mood = m;
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

class ObjectivePageNew extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final decision = useProvider(decisionsProvider).createDecision;
    final suicidalSentiment = useState(false);
    final darkMode = useProvider(themeProvider).dark;

    TextStyle _headerText = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.w600,
      color: darkMode ? Colors.white : Colors.grey[900],
    );

    TextStyle _subHeaderText = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: darkMode ? Colors.grey : Colors.grey[900],
    );

    return Container(
      padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0),
      child: ListView(
        children: <Widget>[
          Text("Let's start with an objective.", style: _headerText),
          SizedBox(height: 6.0),
          Text("What are you making a decision on?", style: _subHeaderText),
          SizedBox(height: 24.0),
          TextField(
            textCapitalization: TextCapitalization.sentences,
            maxLength: 300,
            maxLines: 4,
            style: TextStyle(
              fontSize: 18.0,
              color: darkMode ? Colors.white : Colors.black,
            ),
            onChanged: (s) {
              // Not super effective, but POC..
              if (s.trim().contains(RegExp(r'(kill)|(die)'))) {
                suicidalSentiment.value = true;
              } else {
                suicidalSentiment.value = false;
              }

              decision.objective = s;
            },
          ),
          SizedBox(height: 16.0),
          if (suicidalSentiment.value)
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.green[100],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "SuicidePreventionLifeline.org",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    "If you’re in crisis, there are options available to help you cope. You can also call the Lifeline at any time to speak to someone and get support. For confidential support available 24/7 for everyone in the United States, call 1-800-273-8255.",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

          SizedBox(height: 16.0),
          Text("How are you feeling about it?", style: _headerText),
          SizedBox(height: 6.0),
          Text("This will come in handy later.", style: _subHeaderText),
          // TODO convert into an emoji picker instead of a "Mood".
          // mood should still be a thing "happy" "sad" "angry" etc.. but should be set based on the emoji.
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 23.0),
            child: MoodSelection(
              onChanged: (m) {
                decision.mood = m;
              },
            ),
          ),
        ],
      ),
    );
  }
}
