import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/providers/tasks_provider.dart';

class AddTaskPage extends StatelessWidget {
  static const String routeName = "/addtask";
  static const String title = "Add Task";
  static const String _addButtonName = "Add";

  @override
  Widget build(BuildContext context) {
    String _title;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              onChanged: (title) {
                _title = title;
              },
            ),
            RaisedButton(
              child: Text(_addButtonName),
              onPressed: () {
                Provider.of<Tasks>(context).addTask(Task(name: _title.trim()));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
