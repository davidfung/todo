import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasteButton extends StatelessWidget {
  const PasteButton({Key key, this.teController}) : super(key: key);
  final TextEditingController teController;

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
        final ClipboardData clipData =
            await Clipboard.getData(Clipboard.kTextPlain);
        final String clipText = clipData.text ?? "";

        final String oldText = teController.text;
        final TextSelection oldTextSelection = teController.selection;
        final String newText = oldText.replaceRange(
            oldTextSelection.start, oldTextSelection.end, clipText);
        teController.text = newText;
        teController.selection = oldTextSelection.copyWith(
          baseOffset: oldTextSelection.start + clipText.length,
          extentOffset: oldTextSelection.start + clipText.length,
        );
      },
    );
  }
}
