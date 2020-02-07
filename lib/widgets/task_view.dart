import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart';

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<Tasks>(context);
    return ListView.builder(
      itemCount: tasks.items.length,
      itemBuilder: (context, index) {
        final taskName = tasks.items[index].name;
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            tasks.removeTask(index);
          },
          background: Container(color: Colors.red),
          child: TaskTile(taskName: taskName),
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key key,
    @required this.taskName,
  }) : super(key: key);

  final String taskName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$taskName'),
      onTap: () {
        Navigator.pushNamed(context, '/addtask');
      },
    );
  }
}
