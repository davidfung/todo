import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasteButton extends StatelessWidget {
  const PasteButton({Key key, this.tecontroller}) : super(key: key);
  final TextEditingController tecontroller;

  @override
  Widget build(BuildContext context) {
//    Color color = Colors.grey[400];
    Color color = Colors.white;
    return IconButton(
      icon: Icon(
        Icons.content_paste,
        color: color,
      ),
      onPressed: () async {
        //TODO paste current clipboard content at the insertion point
        final ClipboardData clipdata =
            await Clipboard.getData(Clipboard.kTextPlain);
        tecontroller.text = clipdata.text ?? "";
      },
    );
  }
}
