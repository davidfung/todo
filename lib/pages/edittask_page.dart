import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/tasks_provider.dart';

class EditTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int index = ModalRoute.of(context).settings.arguments;
    final String taskName = Provider.of<Tasks>(context).items[index].name;
    final _teController = TextEditingController();

    String _title;
    _teController.text = taskName;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Task"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              controller: _teController,
              onChanged: (title) {
                _title = title;
              },
            ),
            RaisedButton(
              child: Text('Save'),
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
