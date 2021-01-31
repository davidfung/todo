import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/addtask_page.dart';
import 'package:todo/pages/edittask_page.dart';

import '../constants.dart';
import '../utils/email.dart' as email;

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
    Color color = routeNameList.contains(this.pageRoute)
        ? Colors.white //.grey[400]
        : Colors.grey;
    return IconButton(
      icon: Icon(
        Icons.email,
        color: color,
      ),
      onPressed: () {
        _sendemail();
      },
    );
  }

  void _sendemail() async {
    List<String> toList = List();
    List<String> ccList = List();
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
    email1 = prefs.getString(settingEmail1);
    email2 = prefs.getString(settingEmail2);
    email3 = prefs.getString(settingEmail3);
    to1 = prefs.getBool(settingTo1);
    to2 = prefs.getBool(settingTo2);
    to3 = prefs.getBool(settingTo3);
    cc1 = prefs.getBool(settingCc1);
    cc2 = prefs.getBool(settingCc2);
    cc3 = prefs.getBool(settingCc3);

    // print("email1=$email1");
    // print("email2=$email2");
    // print("email3=$email3");
    // print("to1=$to1");
    // print("to2=$to2");
    // print("to3=$to3");
    // print("cc1=$cc1");
    // print("cc2=$cc2");
    // print("cc3=$cc3");

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

    email.sendemail(to: toList, cc: ccList, subject: subject, body: msg);
  }
}
