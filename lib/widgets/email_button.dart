import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/edittask_page.dart';

import '../constants.dart';
import '../utils/email.dart' as email;

class EmailButton extends StatelessWidget {
  final String msg;
  final String pageRoute;

  const EmailButton(
    this.msg, {
    this.pageRoute = '',
  });

  @override
  Widget build(BuildContext context) {
    Color color = (this.pageRoute == EditTaskPage.routeName)
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

    // subject
    LineSplitter ls = new LineSplitter();
    String subject = ls.convert(msg)[0];
    if (subject.length > emailSubjectMaxLen) {
      subject = subject.substring(0, emailSubjectMaxLen - 1);
    }

    // recipients
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email1 = prefs.getString('email1');
    email2 = prefs.getString('email2');
    email3 = prefs.getString('email3');
    to1 = prefs.getBool('to1');
    to2 = prefs.getBool('to2');
    to3 = prefs.getBool('to3');
    cc1 = prefs.getBool('cc1');
    cc2 = prefs.getBool('cc2');
    cc3 = prefs.getBool('cc3');

    print("email1=$email1");
    print("email2=$email2");
    print("email3=$email3");
    print("to1=$to1");
    print("to2=$to2");
    print("to3=$to3");
    print("cc1=$cc1");
    print("cc2=$cc2");
    print("cc3=$cc3");

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
