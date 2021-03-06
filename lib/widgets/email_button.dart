import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/constants.dart';
import 'package:todo/pages/addtask_page.dart';
import 'package:todo/pages/edittask_page.dart';
import 'package:todo/utils/email.dart' as email;
import 'package:todo/utils/settings.dart';

enum Department {
  treasury,
  state,
}

class EmailButton extends StatelessWidget {
  final TextEditingController teController;
  final String msg;
  final String pageRoute;

  EmailButton({
    this.teController,
    this.msg = '',
    this.pageRoute = '',
  });

  final List<String> routeNameList = [
    AddTaskPage.routeName,
    EditTaskPage.routeName,
  ];

  String getMsg() {
    return this.teController?.text ?? this.msg;
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _askRecipient() async {
      final recipient1 = await loadString(settingEmail1);
      final recipient2 = await loadString(settingEmail2);
      final recipient3 = await loadString(settingEmail3);
      var recipient = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Select recipient:'),
              children: <Widget>[
                if (recipient1.isNotEmpty)
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, recipient1);
                    },
                    child: Text(recipient1),
                  ),
                if (recipient2.isNotEmpty)
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, recipient2);
                    },
                    child: Text(recipient2),
                  ),
                if (recipient3.isNotEmpty)
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, recipient3);
                    },
                    child: Text(recipient3),
                  ),
              ],
            );
          });
      if (recipient?.isNotEmpty ?? false) {
        _sendemail(recipient: recipient);
      }
    }

    Color color = routeNameList.contains(this.pageRoute)
        ? Colors.white //.grey[400]
        : Colors.grey;

    return GestureDetector(
      child: IconButton(
        icon: Icon(
          Icons.email,
          color: color,
        ),
        onPressed: () {
          _sendemail();
        },
      ),
      onLongPress: () {
        print('long pressed ' * 10);
        _askRecipient();
      },
    );
  }

  void _sendemail({String recipient = ''}) async {
    List<String> toList = [];
    List<String> ccList = [];
    String email1;
    String email2;
    String email3;
    bool to1;
    bool to2;
    bool to3;
    bool cc1;
    bool cc2;
    bool cc3;
    String msg;
    String prefix;

    msg = getMsg();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // subject
    prefix = prefs.getString(settingEmailPrefix);
    LineSplitter ls = LineSplitter();
    String subject = ls.convert(msg)[0];
    subject = prefix + subject;
    if (subject.length > emailSubjectMaxLen) {
      subject = subject.substring(0, emailSubjectMaxLen - 1);
    }

    // recipients
    if (recipient?.isNotEmpty ?? false) {
      toList.add(recipient);
    } else {
      email1 = prefs.getString(settingEmail1);
      email2 = prefs.getString(settingEmail2);
      email3 = prefs.getString(settingEmail3);
      to1 = prefs.getBool(settingTo1);
      to2 = prefs.getBool(settingTo2);
      to3 = prefs.getBool(settingTo3);
      cc1 = prefs.getBool(settingCc1);
      cc2 = prefs.getBool(settingCc2);
      cc3 = prefs.getBool(settingCc3);

      if (to1 && email1 != '') {
        toList.add(email1);
      }
      if (to2 && email2 != '') {
        toList.add(email2);
      }
      if (to3 && email3 != '') {
        toList.add(email3);
      }

      if (cc1 && email1 != '') {
        ccList.add(email1);
      }
      if (cc2 && email2 != '') {
        ccList.add(email2);
      }
      if (cc3 && email3 != '') {
        ccList.add(email3);
      }
    }
    email.sendemail(to: toList, cc: ccList, subject: subject, body: msg);
  }
}
