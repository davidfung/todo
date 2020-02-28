import 'package:flutter/material.dart';
import 'package:todo/constants.dart';
import 'package:todo/utils/settings.dart';

const capEmailRecipients = 'Email Recipients';
const capTo = 'To';
const capCc = 'Cc';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  static const String title = 'Settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String email1 = "";
  bool to1 = false;
  bool cc1 = false;

  @override
  void initState() {
    loadSettings();
    super.initState();
  }

  Future<void> loadSettings() async {
    this.email1 = await loadString(settingEmail1, defaultValue: "");
    this.to1 = await loadBool(settingTo1, defaultValue: true);
    this.cc1 = await loadBool(settingCc1, defaultValue: false);
    print("loaded $settingTo1=$to1");
    print("loaded $settingCc1=$cc1");
    setState(() {});
  }

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
        //_buildEmailRecipient(context),
        //_buildEmailRecipient(context),
      ],
    );
  }

  Widget _buildSectionHead(BuildContext context) {
    return ListTile(
        title: Text(
      capEmailRecipients,
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
              title: const Text(capTo),
              value: this.to1,
              onChanged: (bool value) {
                setState(() {
                  this.to1 = value;
                  print("saving $settingTo1=$value");
                  saveBool(settingTo1, value);
                });
              },
            )),
            Flexible(
                child: SwitchListTile(
              title: const Text(capCc),
              value: this.cc1,
              onChanged: (bool value) {
                setState(() {
                  this.cc1 = value;
                  print("saving $settingCc1=$value");
                  saveBool(settingCc1, value);
                });
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
