import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/components/button.dart';
import 'package:pros_cons/imports.dart';

// !!! TODO why am I made to import `as exo`??
import 'package:exo/exo.dart' as exo;

class OnBoard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider);
    final emailText = useTextEditingController();
    final passwordText = useTextEditingController();
    final usernameText = useTextEditingController();
    final keyboard = exo.useKeyboardVisibility();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Opacity(
                  opacity: keyboard.isVisible ? 0.0 : 1.0,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PROS & CONS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoCondensed(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "A community to help you make the right decision & tools to help you decide.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.white60,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SpacedColumn(
                  spacing: 12,
                  children: [
                    // TextField(
                    //   controller: usernameText,
                    //   decoration: InputDecoration(
                    //     labelText: "Username",
                    //     floatingLabelBehavior: FloatingLabelBehavior.never,
                    //   ),
                    // ),
                    TextField(
                      controller: emailText,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    TextField(
                      controller: passwordText,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    Button(
                      text: "Login / Signup",
                      textCenter: true,
                      onPressed: () {
                        user.authenticate(emailText.text, passwordText.text);
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "Already have an account? Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
