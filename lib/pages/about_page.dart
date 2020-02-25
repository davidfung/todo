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
    TextStyle _linkStyle = TextStyle(fontStyle: FontStyle.italic, fontSize: 18);

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
              'If you frequently need to generate pin numbers for various types of reason, this app can help you.',
              style: _bodyStyle),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text('GEN PIN', style: _captionStyle),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          Text(
              'It generates pin numbers for you instead of you think of some "not-so-random" random pin numbers.',
              style: _bodyStyle),
          Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          Text('WARNING', style: _captionStyle),
          Padding(
            padding: EdgeInsets.only(top: 7),
          ),
          Text(
              'These pin numbers are not secure enough to be used as passwords.',
              style: _bodyStyle),
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          InkWell(
              onTap: () {
                _launchURL();
              },
              child: Text('amg99.com', style: _linkStyle)),
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
