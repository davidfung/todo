import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/about';
  static const String title = 'About';
  static const String aboutUrl = 'https://amg99.com';

  @override
  Widget build(BuildContext context) {
    TextStyle _captionStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    TextStyle _bodyStyle = TextStyle(fontSize: 16);
    TextStyle _linkStyle = TextStyle(fontSize: 18, color: Colors.blue);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        children: <Widget>[
          Text('WHY', style: _captionStyle),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          Text(
              'If you use your email inbox as a master to-do list, this app is for you.',
              style: _bodyStyle),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text('TODO', style: _captionStyle),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          Text(
              'By adding an item to this to-do list, you can email yourself a copy with a click of a button.  You can use this feature to quickly consolidate to-do items from different sources and keep them neatly in your email inbox as a reminder.',
              style: _bodyStyle),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text('FEEDBACK', style: _captionStyle),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          InkWell(
              onTap: () {
                _launchURL();
              },
              child: Text('Visit amg99.com', style: _linkStyle)),
        ],
      ),
    );
  }

  void _launchURL() async {
    const url = aboutUrl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
