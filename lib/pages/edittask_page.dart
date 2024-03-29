import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/widgets/paste_button.dart';

import '../providers/tasks_provider.dart';
import '../widgets/email_button.dart';

class EditTaskPage extends StatelessWidget {
  static const String routeName = "/edittask";
  static const String title = "Edit Task";
  static const String _saveButtonName = "Save";

  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;
    final String taskName = Provider.of<Tasks>(context).items[index].name;
    final _teController = TextEditingController();

    String _title;
    _teController.text = taskName;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          PasteButton(
            teController: _teController,
          ),
          EmailButton(
            teController: _teController,
            pageRoute: EditTaskPage.routeName,
          ),
          SizedBox(width: 15)
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              controller: _teController,
              onChanged: (title) {
                _title = title;
              },
            ),
            ElevatedButton(
              child: Text(_saveButtonName),
              onPressed: () {
                if (_title != null) {
                  Provider.of<Tasks>(context).editTask(index, _title.trim());
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
