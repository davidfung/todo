import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context, "Buy eggs");
          },
          child: Text('Add'),
        ),
      ),
    );
  }
}
