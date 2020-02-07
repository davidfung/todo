import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:todo/models/task.dart';
import 'package:todo/providers/tasks_provider.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              onChanged: (title) {
                _title = title;
              },
            ),
            RaisedButton(
              child: Text('Add'),
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
