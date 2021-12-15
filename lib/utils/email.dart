import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> sendemail(
    {List<String> to,
    String subject,
    String body,
    List<String> cc,
    List<String> bcc,
    List<String> attachmentPaths,
    bool isHTML}) async {
  final Email email = Email(
    recipients: to,
    cc: cc,
    bcc: bcc,
    subject: subject,
    body: body,
    attachmentPaths: attachmentPaths,
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
}
