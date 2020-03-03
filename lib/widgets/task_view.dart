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
          background: Container(
              alignment: AlignmentDirectional.centerStart,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Icon(Icons.cancel, color: Colors.white),
              )),
          child: TaskTile(taskName: taskName, index: index),
          secondaryBackground: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                child: Icon(Icons.cancel, color: Colors.white),
              )),
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
    Map<String, List<String>> recipientList;
    return IconButton(
      icon: Icon(Icons.email),
      onPressed: () async {
        LineSplitter ls = new LineSplitter();
        String subject = ls.convert(msg)[0];
        if (subject.length > emailSubjectMaxLen) {
          subject = subject.substring(0, emailSubjectMaxLen - 1);
        }
        recipientList = await _buildRecipientList();
        email.sendemail(
            to: recipientList['to'],
            cc: recipientList['cc'],
            subject: subject,
            body: msg);
      },
    );
  }

  Future<Map<String, List<String>>> _buildRecipientList() async {
    List<String> sendTo = List();
    List<String> sendCc = List();
    String email1;
    String email2;
    String email3;
    bool to1;
    bool to2;
    bool to3;
    bool cc1;
    bool cc2;
    bool cc3;

    email1 = await settings.loadString(settingEmail1, defaultValue: '');
    email2 = await settings.loadString(settingEmail2, defaultValue: '');
    email3 = await settings.loadString(settingEmail3, defaultValue: '');
    to1 = await settings.loadBool(settingTo1, defaultValue: false);
    to2 = await settings.loadBool(settingTo2, defaultValue: false);
    to3 = await settings.loadBool(settingTo3, defaultValue: false);
    cc1 = await settings.loadBool(settingCc1, defaultValue: false);
    cc2 = await settings.loadBool(settingCc2, defaultValue: false);
    cc3 = await settings.loadBool(settingCc3, defaultValue: false);

    if (to1 && email1 != '') {
      sendTo.add(email1);
    }
    if (to2 && email2 != '') {
      sendTo.add(email2);
    }
    if (to3 && email3 != '') {
      sendTo.add(email3);
    }

    if (cc1 && email1 != '') {
      sendCc.add(email1);
    }
    if (cc2 && email2 != '') {
      sendCc.add(email2);
    }
    if (cc3 && email3 != '') {
      sendCc.add(email3);
    }

    return {'to': sendTo, 'cc': sendCc};
  }
}
