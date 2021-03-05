import 'package:hooks_riverpod/all.dart';
import 'package:pros_cons/imports.dart';
import 'package:pros_cons/providers/notice_provider.dart';

class Notice extends HookWidget {
  final Color color;
  final bool centered;
  final Function onClose;
  final String notice;

  Notice(
    this.notice, {
    this.color = Colors.black,
    this.centered = false,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final luminance = color.computeLuminance();
    final textColor = luminance > 0.5 ? Colors.black : Colors.white;

    final crossAxisAlignment =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    final appNotice = useProvider(noticeProvider).notice(this.notice);
    print("notice: ${appNotice.path}");

    if (appNotice == null) {
      return Offstage();
    }

    return Container(
      width: double.infinity,
      color: color,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: SpacedRow(
        spacing: 24,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            appNotice.category,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          Flexible(
            child: Text(
              appNotice.title,
              style: TextStyle(
                color: textColor,
              ),
            ),
          ),
          if (onClose != null)
            GestureDetector(
              onTap: onClose,
              child: Icon(
                Icons.close,
                color: textColor.withOpacity(0.7),
                size: 18,
              ),
            )
        ],
      ),
    );
  }
}
