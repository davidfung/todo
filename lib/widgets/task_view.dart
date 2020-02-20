import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart';
import '../utils/email.dart' as email;

const RECIPIENTS = ['admin@pmpgmbc.ca'];
const SUBJECT_MAXLEN = 80;

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
          child: TaskTile(taskName: taskName, index: index),
        );
      },
    );
  }
}

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key key,
    @required this.taskName,
    @required this.index,
  }) : super(key: key);

  final String taskName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('$taskName'),
      trailing: EmailButton(taskName),
      onTap: () {
        Navigator.pushNamed(context, '/edittask', arguments: index);
      },
    );
  }
}

class EmailButton extends StatelessWidget {
  final String msg;

  const EmailButton(
    this.msg,
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.email),
      onPressed: () {
        LineSplitter ls = new LineSplitter();
        String subject = ls.convert(msg)[0];
        if (subject.length > SUBJECT_MAXLEN) {
          subject = subject.substring(0, SUBJECT_MAXLEN - 1);
        }
        email.sendemail(recipients: RECIPIENTS, subject: subject, body: msg);
      },
    );
  }
}
