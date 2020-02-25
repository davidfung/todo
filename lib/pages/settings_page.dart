import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';
  static const String title = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('Settings Page'),
          ],
        ),
      ),
    );
  }
}
