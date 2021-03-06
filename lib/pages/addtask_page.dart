import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/widgets/email_button.dart';
import 'package:todo/widgets/paste_button.dart';

class AddTaskPage extends StatelessWidget {
  static const String routeName = "/addtask";
  static const String title = "Add Task";
  static const String _addButtonName = "Add";

  @override
  Widget build(BuildContext context) {
    String _title;
    final _teController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          PasteButton(
            teController: _teController,
          ),
          EmailButton(
            teController: _teController,
            pageRoute: AddTaskPage.routeName,
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
              onPressed: () {
                _title = _teController.text ?? "";
                if (_title.length > 0) {
                  Provider.of<Tasks>(context, listen: false)
                      .addTask(Task(name: _title.trim()));
                }
                Navigator.pop(context);
              },
              child: Text(_addButtonName),
            ),
          ],
        ),
      ),
    );
  }
}
