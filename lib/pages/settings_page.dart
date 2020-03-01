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
  String email2 = "";
  String email3 = "";
  bool to1 = false;
  bool to2 = false;
  bool to3 = false;
  bool cc1 = false;
  bool cc2 = false;
  bool cc3 = false;
  bool loaded = false;

  @override
  void initState() {
    _loadSettings();
    super.initState();
  }

  Future<void> _loadSettings() async {
    this.email1 = await loadString(settingEmail1, defaultValue: "");
    this.email2 = await loadString(settingEmail2, defaultValue: "");
    this.email3 = await loadString(settingEmail3, defaultValue: "");
    this.to1 = await loadBool(settingTo1, defaultValue: true);
    this.to2 = await loadBool(settingTo2, defaultValue: true);
    this.to3 = await loadBool(settingTo3, defaultValue: true);
    this.cc1 = await loadBool(settingCc1, defaultValue: false);
    this.cc2 = await loadBool(settingCc2, defaultValue: false);
    this.cc3 = await loadBool(settingCc3, defaultValue: false);
    print("loaded $settingTo1=$to1");
    print("loaded $settingCc1=$cc1");
    loaded = true;
    setState(() {});
  }

  List _getRecipientInfo(int index) {
    List info;
    switch (index) {
      case 1:
        info = [this.email1, this.to1, this.cc1];
        break;
      case 2:
        info = [this.email2, this.to2, this.cc2];
        break;
      case 3:
        info = [this.email3, this.to2, this.cc3];
        break;
    }
    return info;
  }

  void _updateEmail(int index, String value) {
    switch (index) {
      case 1:
        this.email1 = value;
        saveString(settingEmail1, value);
        break;
      case 2:
        this.email2 = value;
        saveString(settingEmail2, value);
        break;
      case 3:
        this.email3 = value;
        saveString(settingEmail3, value);
        break;
    }
    print("saving settingEmail$index=$value");
  }

  void _updateTo(int index, bool value) {
    switch (index) {
      case 1:
        this.to1 = value;
        saveBool(settingTo1, value);
        break;
      case 2:
        this.to2 = value;
        saveBool(settingTo2, value);
        break;
      case 3:
        this.to3 = value;
        saveBool(settingTo3, value);
        break;
    }
    print("saving settingTo$index=$value");
  }

  void _updateCc(int index, bool value) {
    switch (index) {
      case 1:
        this.cc1 = value;
        saveBool(settingCc1, value);
        break;
      case 2:
        this.cc2 = value;
        saveBool(settingCc2, value);
        break;
      case 3:
        this.cc3 = value;
        saveBool(settingCc3, value);
        break;
    }
    print("saving settingCc$index=$value");
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
        _buildEmailRecipient(context, 1),
        _buildEmailRecipient(context, 2),
        _buildEmailRecipient(context, 3),
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

  Widget _buildEmailRecipient(BuildContext context, int index) {
    final List info = _getRecipientInfo(index);
    String email = info[0];
    bool sendTo = info[1];
    bool sendCc = info[2];

    final _teController = TextEditingController();
    _teController.text = email;

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
                    _updateEmail(index, value);
                  }),
            ),
          ),
        ]),
        Row(
          children: <Widget>[
            Flexible(
                child: SwitchListTile(
              title: const Text(capTo),
              value: sendTo,
              onChanged: (bool value) {
                setState(() {
                  _updateTo(index, value);
                });
              },
            )),
            Flexible(
                child: SwitchListTile(
              title: const Text(capCc),
              value: sendCc,
              onChanged: (bool value) {
                setState(() {
                  _updateCc(index, value);
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
