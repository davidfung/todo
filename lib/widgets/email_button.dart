import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants.dart';
import '../utils/email.dart' as email;
import '../utils/settings.dart' as settings;

const msg_ack_email = 'Email sent!';

class EmailButton extends StatelessWidget {
  final String msg;

  const EmailButton(
    this.msg,
  );

  @override
  Widget build(BuildContext context) {
    Map<String, List<String>> recipientList;
    return IconButton(
      icon: Icon(
        Icons.email,
      ),
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
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(msg_ack_email),
        ));
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
