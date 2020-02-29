import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../pages/edittask_page.dart';
import '../providers/tasks_provider.dart';
import '../utils/email.dart' as email;
import '../utils/settings.dart' as settings;

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
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 0.5, color: Colors.grey))),
      child: ListTile(
        title: Text('$taskName'),
        trailing: EmailButton(taskName),
        onTap: () {
          Navigator.pushNamed(context, EditTaskPage.routeName,
              arguments: index);
        },
      ),
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
    String recipient;
    return IconButton(
      icon: Icon(Icons.email),
      onPressed: () async {
        LineSplitter ls = new LineSplitter();
        String subject = ls.convert(msg)[0];
        if (subject.length > emailSubjectMaxLen) {
          subject = subject.substring(0, emailSubjectMaxLen - 1);
        }
        recipient = await settings.loadString(settingEmail1, defaultValue: '');
        email.sendemail(recipients: [recipient], subject: subject, body: msg);
      },
    );
  }
}
