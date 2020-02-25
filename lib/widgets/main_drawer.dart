import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import '../pages/settings_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Text(SettingsPage.title),
            onTap: () {
              Navigator.of(context).popAndPushNamed(SettingsPage.routeName);
            },
          ),
          ListTile(
            title: Text(AboutPage.title),
            onTap: () {
              Navigator.of(context).popAndPushNamed(AboutPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
