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
  bool loaded = false;

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
    loaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (loaded) {
      body = _buildPage(context);
    } else {
      body = Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(SettingsPage.title),
      ),
      body: body,
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
    final _teController = TextEditingController();
    _teController.text = email1;

    return Column(
      children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _teController,
                  onChanged: (value) {
                    this.email1 = value;
                    print("saving $settingEmail1=$value");
                    saveString(settingEmail1, value);
                  }),
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
