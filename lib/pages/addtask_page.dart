import 'package:flutter/material.dart';

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
              onPressed: () {
                Navigator.pop(context, _title?.trim());
              },
              child: Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
