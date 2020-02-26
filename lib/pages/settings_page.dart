import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  static const String title = 'Settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingsPage.title),
      ),
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
            title: const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 10.0),
                child: Text(
                  'Email Recipients',
                  style: captionStyle,
                ))),
        _buildEmailRecipient(context, 1),
        ListTile(
          title: const Text('6 digits'),
          leading: Radio(),
        ),
        ListTile(
          title: const Text('8 digits'),
          leading: Radio(),
        ),
      ],
    );
  }

  Widget _buildEmailRecipient(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Text(index.toString()),
      ],
    );
  }
}
