import 'package:flutter_email_sender/flutter_email_sender.dart';

Future<void> sendemail(
    {List<String> recipients,
    String subject,
    String body,
    List<String> cc,
    List<String> bcc,
    String attachmentPath,
    bool isHTML}) async {
  final Email email = Email(
    recipients: recipients,
    cc: cc,
    bcc: bcc,
    subject: subject,
    body: body,
    attachmentPath: attachmentPath,
    isHTML: false,
  );
  await FlutterEmailSender.send(email);
}
