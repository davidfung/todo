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
      child: Column(
        children: <Widget>[
          Container(
            height: 90,
            color: Theme.of(context).accentColor,
          ),
          buildListTile(SettingsPage.title, Icons.settings, () {
            Navigator.of(context).popAndPushNamed(SettingsPage.routeName);
          }),
          buildListTile(AboutPage.title, Icons.info_outline, () {
            Navigator.of(context).popAndPushNamed(AboutPage.routeName);
          }),
        ],
      ),
    );
  }

  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      onTap: tapHandler,
    );
  }
}
