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
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        _buildSectionHead(context),
        _buildEmailRecipient(context),
        _buildEmailRecipient(context),
        _buildEmailRecipient(context),
      ],
    );
  }

  Widget _buildSectionHead(BuildContext context) {
    return ListTile(
        title: Text(
      'Email Recipients',
      style: captionStyle,
    ));
  }

  Widget _buildEmailRecipient(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(),
            ),
          ),
        ]),
        Row(
          children: <Widget>[
            Flexible(
                child: SwitchListTile(
              title: const Text('To'),
              value: true,
              onChanged: (bool value) {
                setState(() {});
              },
            )),
            Flexible(
                child: SwitchListTile(
              title: const Text('Cc'),
              value: false,
              onChanged: (bool value) {
                setState(() {});
              },
            )),
            Flexible(
              child: SizedBox(),
            ),
          ],
        )
      ],
    );
  }
}
