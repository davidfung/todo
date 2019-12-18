import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/tasks.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context).items;
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final taskName = tasks[index].name;
        return Dismissible(
            key: Key(taskName),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$taskName dismissed")));
            },
            background: Container(color: Colors.red),
            child: ListTile(title: Text('$taskName')));
      },
    );
  }
}
