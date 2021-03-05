import 'package:pros_cons/imports.dart';
import 'package:pros_cons/widgets/button_base.dart';

class Button extends HookWidget {
  final Function onPressed;
  final String text;
  final IconData leading;
  final Color color;
  final bool fullWidth;
  final bool textCenter;

  Button({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.color,
    this.leading,
    this.fullWidth = true,
    this.textCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor;

    if (this.color == null) {
      textColor = Colors.white;
    } else {
      final luminance = color.computeLuminance();
      textColor = luminance > 0.5 ? Colors.black : Colors.white;
    }

    return Container(
      width: double.infinity,
      child: ButtonBase(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        onPressed: onPressed,
        decoration: BoxDecoration(
          color: this.color ?? purple,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          this.text,
          textAlign: textCenter ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
